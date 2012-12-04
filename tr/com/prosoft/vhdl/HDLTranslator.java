// -*- coding: cp866 -*-
package com.prosoft.vhdl;

import java.util.*;
import java.io.*;
import java.nio.charset.Charset;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.gen.GenGlue;
import com.prosoft.verilog.gen.vir.GenVTypes;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.vhdl.gen.OutputEnvironment;
import com.prosoft.vhdl.gen.OutputStage;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.gen.vir.GenSymbols;
import com.prosoft.vhdl.gen.vir.GenTypes;
import com.prosoft.vhdl.VIRException;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRErrorHandler;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.parser.TokenMgrError;
import com.prosoft.vhdl.parser.VhdlParser;
import com.prosoft.vhdl.sim.ClockGenerator;
import com.prosoft.vhdl.sim.Entity;
import com.prosoft.vhdl.sim.InterpreterEntity;
import com.prosoft.vhdl.sim.ScalarSignal;
import com.prosoft.vhdl.sim.Simulator;
import com.prosoft.vhdl.fs.*;
import com.prosoft.vhdl.MemoryMapRecord;

public class HDLTranslator {
	// ­®¬Ґа ўҐабЁЁ.
	static String version = "v0.90";

	// ЃЁЎ«Ё®вҐЄЁ:
	static LibEnvironment libEnv = null;
	static TranslatorErrorHandler handler = null;

	// ђҐ§г«мв в а §Ў®а  Є ав Ї ¬пвЁ.
	static List<MemoryMapRecord> memoryMapRecords = null;

	static void resetLibEnv() {
		libEnv = new LibEnvironment(new IRErrorFactory());
		handler = new TranslatorErrorHandler();
		libEnv.err.pushHandler( handler );
		memoryMapRecords = new ArrayList<MemoryMapRecord>();
	}

	// ®б­®ў­®© жЁЄ«.
	public static void main( String[] args ) throws Exception {
		Library.disableProgress();
		resetLibEnv();
		BufferedReader in
			= new BufferedReader(new InputStreamReader(System.in));
		while (true) {
			System.out.flush();
			String line = in.readLine();
			if ( line == null )
		                return;
			boolean continueFlag = true;
			try {
				continueFlag = dispatch(line,in);
			}
			catch (CompilerError exc) {
				reportError("compiler",null,exc.toString());
			}
			catch (TokenMgrError exc) {
				reportError("lexer",libEnv.loadedFile,exc.toString());
			}
			catch (com.prosoft.vhdl.parser.ParseException exc) {
				reportError("parser",libEnv.loadedFile,exc.toString());
			}
			catch (VIRException exc) {
				reportError("translator", "", exc.msg);
			}
			catch (Throwable exc) {
				System.err.println("Exception: "+exc);
				exc.printStackTrace(System.err);
				reportError("internal error",null,exc.toString());
			}

			if (!continueFlag)
				break;
		}
	}
	static void reportError(String header,String file,String text) {
		System.out.println("error {");
		System.out.println(header);
		if (file == null)
			file = "";
		System.out.println(file);
		System.out.println(text);
		System.out.println("}");
		resetLibEnv();
	}
	
    public static void genArchComponentInstancesInfo(String parentName, IRArchitecture arch, String st, TextOut out )
    {
    	for (int i = 0; i < arch.getComponentInstances().length; i++)
    	{
    		IRComponentInstance irci = arch.getComponentInstances()[i];
		String name = parentName + "." + irci.getName();
       		out.nlAdd("(instanced-by " + name + " " + (st + "." + irci.getComponent().getComponentName()) + ")");
    		genComponentInstancesInfo(name, irci.getComponent(), st, out);
    	}
    }
    
    public static void genComponentInstancesInfo(String parentName, ComponentImplementation impl , String st, TextOut out)
    {
        IREntity ent = impl.getEntity();

        for (int i = 0; i < ent.getArchitectures().length; i++)
        {
        	genArchComponentInstancesInfo(parentName, ent.getArchitectures()[i], st, out);
        }
    }
    
    public static void genMainEntityComponentInstancesInfo(String parentName, IRComponentInstance irci , String st, TextOut out)
    {
		String name;
		if (parentName != null)
			name = parentName + "." + irci.getName();
		else
			name = irci.getName();
   		out.nlAdd("(instanced-by " + name + " " + (st + "." + irci.getComponent().getComponentName()) + ")");
		genComponentInstancesInfo(name, irci.getComponent(), st, out);
    }	
	
	static String virContent(String library, String entity, String archToGen, String fileName) throws Exception {
		GenGlue glue = new GenGlue();
		ByteArrayOutputStream virOS = new ByteArrayOutputStream();
		OutputEnvironment env = new OutputEnvironment( virOS );
		TextOut out = env.getTextOut(OutputStage.IMPLEMENTATION, "main");
		TextOut funcsOut = env.getTextOut(OutputStage.FUNCTIONS_PROTOTYPES, "main");
		TextOut typesOut = env.getTextOut(OutputStage.TYPE_DEFINITION, entity);
		TextOut cnstsOut = env.getTextOut(OutputStage.CONST_DECL, entity);
		Library lib = libEnv.getLibrary(library);
			
		IRNamedElement el = lib.getElement(entity);
		IREntity en = (IREntity) el;
                if ( en.getArchitectures().length == 0 )
                {
                        throw new Exception("No architecture found for " + library + "." + entity);
                }

		IRComponentInstance comp = new IRComponentInstance(lib, lib, el.getName(), el, archToGen);
		IREntity soc = (IREntity) lib.getElement(entity);
		VhdlParser p = soc.getDesignFile().parser;
		p.err.parser = p;
		libEnv.semanticCheck( p.err);
		GenTypes gen = new GenTypes(p.err);
		GenVTypes genV = new GenVTypes(new VErrorFactory());
		gen.glue = glue;
		genV.glue = glue;
		glue.verilogGen = genV;
		glue.vhdlGen = gen;

		comp.setName(/*arch*/en.getFullName());

		genMainEntityComponentInstancesInfo( null, comp, library, out);

		for (MemoryMapRecord memMapRec : memoryMapRecords) {
			memMapRec.findComponentsAndDumpToVIR(comp,out);
		}
        
		gen.generate(null, comp, out, funcsOut, typesOut, cnstsOut);
		while ( true ) {
			int prevWritesCount = out.writesCount;
			gen.generateSubprograms(out);
			gen.generateObjects(out);
			gen.generateTypes(out);
			if ( prevWritesCount == out.writesCount )
				break;
                } 

		env.generate();

		BufferedWriter outFile = new BufferedWriter(new FileWriter(fileName));
		outFile.write(new String( virOS.toByteArray(), Charset.defaultCharset()));
		outFile.close();
		return "";
	}
	static boolean okAnswer(String text) {
		System.out.println("ok {");
		if (text != null)
			System.out.println(text);
		System.out.println("}");
		return true;
	}
	static void dumpString(String s) {
		String[] lines = s.split("\n");
		int count = lines.length;
		System.out.println(count);
		if (s.length() > 0 && s.charAt(s.length()-1) != '\n')
			System.out.println(s);
		else
			System.out.print(s);
	}
	static boolean dispatch(String line,BufferedReader in) throws Exception {
		String[] words = (line.trim()).split("[ \t]+");
		if (words.length == 0 || words[0] == "")
			return true;

		String cmd = words[0].toLowerCase();
		if (cmd.equals("ver")) {
			return okAnswer("hdltranslator "+version);
		}

		if (cmd.equals("exit") || cmd.equals("quit"))
			return false;

		if (cmd.equals("help")) {
			return okAnswer("Commands: ver, help, quit, exit, load, cfg, vir");
		}

		if (cmd.equals("restart")) {
			resetLibEnv();
			return okAnswer("restarted.");
		}

		// "load #lines |filename"
		// "cfg #lines |filename"
		if ((cmd.equals("load") || cmd.equals("cfg")) && words.length > 2) {
			String filename = words[2];
			int i;
			for (i=0;i<line.length();i++)
				if (line.charAt(i) == '|') {
					filename = line.substring(i+1);
					break;
				}
			if (i >= line.length())
				throw new Exception("Invalid format for load/cfg file name");
			int linesCount = Integer.parseInt(words[1]);
			StringBuilder textBuilder = new StringBuilder(1000);
			while (linesCount > 0) {
				String textLine = in.readLine();
				if (textLine == null)
					throw new Exception("Error reading file lines.");
				textBuilder.append(textLine);
				textBuilder.append('\n');
				linesCount --;
			}
			String text = textBuilder.toString();
			FileSystem.setFileContent(filename, text);
			if (cmd.equals("cfg")) {
				System.err.println("Config: "+filename);
				readConfigFile(filename);
			} else if(filename.toLowerCase().endsWith(".memmap")) {
				System.err.println("Memory map: "+filename);
				MemoryMap map = new MemoryMap(filename, text);
				map.parse(memoryMapRecords);
			}
			return okAnswer(null);
		}

		if (cmd.equals("cat") && words.length == 2) {
			LineNumberReader reader = FileSystem.openRead(words[1]);
			String textLine;
			while(true) {
				textLine = reader.readLine();
				if (textLine == null)
					break;
				System.out.println(textLine);
			}
			reader.close();
			return okAnswer(null);
		}

		if (cmd.equals("vir") && words.length == 1) {
			String lib = in.readLine();
			String ent = in.readLine();
			String arch = in.readLine();
			String fn = in.readLine();
			String vir;
			try {
				vir = virContent(
					lib, ent, arch, fn);
				System.err.println("memory maps!!!");
			}
			catch (Exception err) {
				System.err.println("Exception: "+err);
				err.printStackTrace(System.err);
				throw new VIRException("Error getting simulator code for "+lib+"."+ent+"."+arch+"\nInvalid top-level specified.");
			}
			
			return okAnswer(vir);
		}

		if (cmd.equals("entities") && words.length == 2) {
			// lines:
			//  library1
			//  file1
			//  library2
			//  file2
			int linesCount = Integer.parseInt(words[1]);
			String entities = libEnv.listEntities();
			String[] files = new String[linesCount];
			for (int i=0; i < linesCount;i++) {
				String textLine = in.readLine();
				if (textLine == null)
					textLine = "";
				files[i] = textLine;
			}
			return okAnswer(entitiesList(files));
		}

		throw new Exception("Error in translator line '"+line+"'\n\nIt happen when you have spaces in file names.");
		// return true;
	}

	static void readConfigFile(String filename) throws CompilerError {
		Exception exc = null;
		try {
			LibEnvironment.readFromFile(filename, libEnv);
		}
		catch (Exception e1) {
			exc = e1;
		}
		if (handler.getErrorCount() > 0) {
			StringBuilder errs = new StringBuilder(10000);
			for (String s : handler.errors()) {
				errs.append(s);
				errs.append('\n');
			}
			if (exc != null) {
				errs.append(exc.toString());
				errs.append('\n');
			}
			throw new CompilerError(errs.toString());
		}
		handler.clear();
	}

	// List of entities in the listed files.
	static String entitiesList(String[] files) throws Exception {
		return libEnv.listEntities();
	}

}