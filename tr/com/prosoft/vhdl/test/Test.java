package com.prosoft.vhdl.test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.StringTokenizer;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.HDLAssoc;
import com.prosoft.glue.HDLKind;
import com.prosoft.glue.gen.GenGlue;
import com.prosoft.verilog.gen.vir.GenVTypes;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.vhdl.gen.OutputEnvironment;
import com.prosoft.vhdl.gen.OutputStage;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.gen.vir.GenSymbols;
import com.prosoft.vhdl.gen.vir.GenTypes;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponent;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.parser.VhdlParser;
import com.prosoft.vhdl.sim.ClockGenerator;
import com.prosoft.vhdl.sim.Entity;
import com.prosoft.vhdl.sim.InterpreterEntity;
import com.prosoft.vhdl.sim.ScalarSignal;
import com.prosoft.vhdl.sim.Simulator;

public class Test {
	
	static boolean generateVIR = true;
	static boolean useCFGFile = true;
//	public static String filename = "C:\\temp\\VHDL\\Iop_mod.vhd";
//	public static String filename = "c:\\My_Designs\\test\\test\\src\\test.vhd";
	
	public static String path = "c:\\My_Designs\\test\\test\\src";
	public static String[] files = new String[] {
		"test.vhd",
	};

	public static String pathLPM = "C:\\temp\\VHDL";
	public static String[] filesLPM = new String[] {
		"lpm.vhd",
	};

	public static String pathAMF = "C:\\temp\\VHDL";
	public static String[] filesAMF = new String[] {
		"altera_mf.vhd",
	};

	public static String path1 = "C:\\temp\\VHDL";
	public static String[] files1 = new String[] {
		"amba.vhd",
		"config.vhd",
		"mlite_pack.vhd",
		"pc_next.vhd",
		"pipeline.vhd",
		"mem_ctrl.vhd",
		"ram.vhd",
		"control.vhd",
		"lpm.vhd",
		"alu.vhd",
		"mult.vhd",
		"bus_mux.vhd",
		"reg_bank.vhd",
		"shifter.vhd",
		"mlite_cpu.vhd",
		"plasma.vhd",
	};

	public static String path2 = "C:\\temp\\VHDL";
	public static String[] files2 = new String[] {
		"atmega16p.vhd",
		"AvrComponents.vhd",
		"apb_iface.vhd",
		"Timer0.vhd",
		"Timer1.vhd",
		"Timer2.vhd",
		"Spi.vhd",
		"Twi.vhd",
		"Usart.vhd",
		"intctrlr.vhd",
		"Iop.vhd",
		"soc.vhd"
	};
	
	public static void main( String[] args ) throws Exception {
		test(true, args);
	}
	
	static String outVir = "C:\\Eclipse\\3_4\\VHDL\\VHDL\\src\\com\\prosoft\\vhdl\\test\\Iop.vir";
	static String outSim = "C:\\Eclipse\\3_4\\VHDL\\VHDL\\src\\com\\prosoft\\vhdl\\test\\Soc.sym";
	static String libToGen = "work";
	static String entityToGen = "soc";
	static String archToGen;

    public static void errorExit( String message )
    {
        System.err.println( message );
        System.exit( 1 );                    
    }

	public static Simulator test(boolean startSimulation, String[] args) throws Exception {
		
//		VhdlParser ch = new VhdlParser(new FileInputStream("C:\\temp\\VHDL\\std\\character.vhd"));
//		IRDesignFile fake = new IRDesignFile();
//		ch.stack.push(fake);
//		ch.enumeration_type_definition("CHARACTER");
		
		final IRErrorFactory err = new IRErrorFactory();
		
		long started = System.currentTimeMillis();
		
		LibEnvironment libEnv = new LibEnvironment(err);
        boolean noSymbols = false;
        boolean doSim = false;
		
		if( useCFGFile ) {
            int l = args.length;
            if ( l < 3 )
            {
                errorExit("Usage: Test <lib.cfg>+ Library.Entity output.vir");
            }
            for ( int i = 0; i < l - 2; i++ )
            {
                String arg = args[i];
                if ( arg.endsWith(".vhd") || arg.endsWith(".vhdl") || arg.endsWith(".v") )
                {
                    libEnv.readFileIntoWorkLibrary(
                        null, new String[]{ arg }, new IRGeneric[]{} );
                }
                else if ( arg.endsWith( ".cfg" ) )
                {
                    LibEnvironment.readFromFile(arg, libEnv);
                }
                else if ( arg.equals("--quiet") )
                {
                    TextOut.out2 = null;
                }
                else if ( arg.equals("--no-symbols") )
                {
                    noSymbols = true;
                }
                else if( arg.equals("--sim") ) {
                	doSim = true;
                }
                else
                {
                    errorExit("Don't know what to do with " + arg);
                }
            }
            int e = l - 2;
            String target = args[e];
            
            StringTokenizer tok = new StringTokenizer(target, ".");
            libToGen = tok.nextToken();
            if( tok.hasMoreTokens() )
            	entityToGen = tok.nextToken();
            if( tok.hasMoreTokens() )
            	archToGen = tok.nextToken();
            if( tok.hasMoreTokens() ) {
            	errorExit("Incorrect entity/architecture " + target);
            }
            
			outVir = args[l-1];
			outSim = outVir.substring(0, outVir.lastIndexOf(".")) + ".sym";
			
		} else {
			libEnv = LibEnvironment.readFromCFG(err/*"C:\\temp\\VHDL\\vhdl.lib"*/);
			
			libEnv.getLibrary("IEEE");
			
			IRGeneric[] eg = new IRGeneric[0];
			
			libEnv.readFileIntoWorkLibrary(path, files, eg);
			if( generateVIR ) {
				libEnv.readFileIntoWorkLibrary(pathAMF, filesAMF, eg, "altera_mf");
				libEnv.readFileIntoWorkLibrary(pathLPM, filesLPM, eg, "lpm");
				libEnv.readFileIntoWorkLibrary(path1, files1, eg);
				libEnv.readFileIntoWorkLibrary(path2, files2, eg);
			}
		}
		
		Library llib = libEnv.getLibrary(libToGen);
        if ( llib == null )
        {
            errorExit("No library " + libToGen + " found");
        }
        ComponentImplementation impl = llib.getComponentImplementation(entityToGen);
//		IREntity soc = (IREntity) llib.getElement(entityToGen);
        if( impl == null )
//        if ( soc == null )
        {
        	/*
            System.out.println();
            for( int i = 0; i < llib.getElements().length; i++ ) {
            	if( llib.getElements()[i] instanceof IREntity ) {
            		System.out.print(llib.getElements()[i].getName() + " - ");
            	}
            }
            System.out.flush();
            */
            errorExit("No entity " + entityToGen + " found in " + libToGen);
        }
        if( archToGen != null ) {
        	if( impl.getKind() != HDLKind.VHDL || impl.getEntity() == null ) {
            	errorExit("No architecture " + archToGen + " found in " + entityToGen);
        	}
        }
//        if( archToGen != null && soc.getArchitecture(archToGen) == null ) {
//        	errorExit("No architecture " + archToGen + " found in " + entityToGen);
//        }
        
//        if( impl.getKind() == HDLKind.VHDL ) {
//			VhdlParser p = soc.getDesignFile().parser;
//			
//	//		VhdlParser p = new VhdlParser(new FileInputStream(filename));
//			p.design_file();
//			
//			p.err.parser = p;
//			Library ieee = libEnv.getLibrary("IEEE");
//	        if ( ieee != null )
//	        {
//	            ieee.semanticCheck(p.err);
//	        }
//			libEnv.getLibrary("work").semanticCheck(p.err);
//        }
        
        virContent(libEnv, libToGen, entityToGen, archToGen, outVir);
		
		FileOutputStream virOS = new FileOutputStream(outVir);
		OutputEnvironment env = new OutputEnvironment( virOS );
		OutputEnvironment symEnv = new OutputEnvironment( new FileOutputStream(outSim) );
		
		long ended = System.currentTimeMillis();
		System.out.println("Compilation process took " + (ended-started) + " ms");
		
		if( err.getErrorCount() > 0 ) return null;
		
		System.out.println("Generating output...");
//		p.archs.get(0).semanticCheck(p.err);
		
//		new GenEntity().generate( env.getTextOut(OutputStage.TYPE_DEFINITION, "iop"), p.archs.get(0), "com.prosoft.vhdl.test");

		Simulator sim = null;
		
//		if( !generateVIR ) {
//			IRDesignFile df = (IRDesignFile) p.stack.elementAt(0);
////			GenTypes gen = new GenTypes(p.err);
////			TextOut out = env.getTextOut(OutputStage.TYPE_DEFINITION, "adad");
//			
//			Library lib = libEnv.getLibrary(libToGen);
//			
////			TextOut symOut = symEnv.getTextOut(OutputStage.DESCRIPTION, "soc");
////			GenSymbols syms = new GenSymbols();
////			syms.generate(arch, symOut);
//			
////			if( true ) {
////				gen.generate( df.getTypes(), out );
////				IRComponentInstance comp = new IRComponentInstance(lib, el.getName(), el);
////				comp.setFullName(en.getName());
////				gen.generate(null, comp, out);
////				gen.generateSubprograms(out);
////				gen.generateConstants(out);
////			}
//			
//			
////			IRNamedElement els[] = lib.getElements();
////			for( int i = 0; i < els.length; i++ ) {
////				if( els[i] instanceof IREntity ) {
////					IREntity en = (IREntity) els[i];
////					IRArchitecture arch = en.getArchitectures()[0];
////					gen.generate( arch.getName(), arch, out );
////				}
////			}
////			gen.generate( p.archs.get(0).getName(), p.archs.get(0), out );
//			
////			symEnv.generate();
////			env.generate();
//			
//			/*Simulator */ sim = new Simulator(p.err);
//			IREntity sub = (IREntity) lib.getElement("sub");
//			sub.semanticCheck(p.err);
////			InterpreterEntity inst = new InterpreterEntity(sim, "soc", en);
//			InterpreterEntity inst = new InterpreterEntity(sim, "sub", sub);
//			inst.createComponents();
//			inst.createWires();
//			ScalarSignal sig = (ScalarSignal) inst.getData("clk");
//			sig.getValue();
//			
//			Entity clkGen = new ClockGenerator(sim, "clk_gen", 100, ((IRTypeEnum)sig.getType()) );
//			ScalarSignal clkOut = (ScalarSignal) clkGen.getData("clk");
//			clkGen.wireSignals(clkOut, sig);
//			if( startSimulation ) {
//				sim.resume();
//				sim.simulate();
//			}
//		}
                
//		IRDesignFile df = (IRDesignFile) p.stack.elementAt(0);
		GenTypes gen = new GenTypes(err);//p.err);
		GenVTypes genV = new GenVTypes(new VErrorFactory());
		GenGlue glue = new GenGlue();
		gen.glue = glue;
		genV.glue = glue;
		glue.verilogGen = genV;
		glue.vhdlGen = gen;
		TextOut out = env.getTextOut(OutputStage.IMPLEMENTATION, "main");
		glue.funcsOut = env.getTextOut(OutputStage.FUNCTIONS_PROTOTYPES, "main");
		glue.typesOut = env.getTextOut(OutputStage.TYPE_DEFINITION, entityToGen);
		glue.cnstsOut = env.getTextOut(OutputStage.CONST_DECL, entityToGen);
			
		Library lib = libEnv.getLibrary(libToGen);
			
//		IRNamedElement el = lib.getElement(entityToGen);
		if( impl.getKind() == HDLKind.VHDL ) {
				IREntity en = impl.getEntity();
                if ( !noSymbols )
                {
                		IRArchitecture arch;
                		if( archToGen != null ) {
                			arch = en.getArchitecture(archToGen);
                		} else {
                			arch = en.getArchitectures()[0];
                		}
                        TextOut symOut = symEnv.getTextOut(OutputStage.DESCRIPTION, entityToGen);
                        GenSymbols syms = new GenSymbols();
                        syms.generate(arch, symOut);
                }
                if ( en.getArchitectures().length == 0 )
                {
                        errorExit("No architecture found for " + libToGen + "." + entityToGen);
                }

//			try {
//				gen.generate( df.getTypes(), out );
//				gen.generate( libEnv.getTypes(), out );
//            IRComponentInstance comp = new IRComponentInstance(lib, lib, impl.getEntity().getName(), impl.getEntity(), archToGen);
//    		comp.setName(/*arch*/en.getFullName());
//    		gen.generate(null, comp, out, funcsOut, typesOut, cnstsOut);
		} else {
			impl.getModule().check();
		}
		
		IRComponent comp = new IRComponent(null, impl.getComponentName());
		comp.setImplementation(impl);
		IRComponentInstance compInst = new IRComponentInstance(lib, lib, impl.getComponentName(), comp, null);
	
		glue.vhdlGen.generate(null, compInst, out, glue.funcsOut, glue.typesOut, glue.cnstsOut);
//		glue.generateComponent(impl.getKind(), impl, new HDLAssoc[0], new HDLAssoc[0], null, archToGen, out);
		
		//comp.setFullName(en.getName());
                while ( true )
                {
                    int prevWritesCount = out.writesCount;
                    gen.generateSubprograms(out);
                    gen.generateObjects(out);
                    gen.generateTypes(out);
                    if ( prevWritesCount == out.writesCount )
                        break;
                } 
//			}
		
        long genEnded = System.currentTimeMillis();
        System.out.println("Output generation took " + (genEnded-ended) + " ms");
			
//			IRNamedElement els[] = lib.getElements();
//			for( int i = 0; i < els.length; i++ ) {
//				if( els[i] instanceof IREntity ) {
//					IREntity en = (IREntity) els[i];
//					IRArchitecture arch = en.getArchitectures()[0];
//					gen.generate( arch.getName(), arch, out );
//				}
//			}
//			gen.generate( p.archs.get(0).getName(), p.archs.get(0), out );
//			finally
                {
                        // Ð² Ð»ÑŽÐ±Ð¾Ð¼ ÑÐ»ÑƒÑ‡Ð°Ðµ Ð³ÐµÐ½ÐµÑ€Ð¸Ð¼ Ð²Ñ‹Ð²Ð¾Ð´, Ñ‡Ñ‚Ð¾Ð±Ñ‹ Ð½Ð°Ð¹Ñ‚Ð¸, Ð³Ð´Ðµ ÑƒÐ¿Ð°Ð»Ð¾
                        symEnv.generate();
                        env.generate();
                }

        virOS.close();
                
        if( doSim ) {
        	String simCmd = "simtest standard.vir " + outVir;
        	System.out.println("> " + simCmd);
        	Process pr = Runtime.getRuntime().exec(simCmd, null, null);
            BufferedReader br;
            String line;

            br = new BufferedReader( new InputStreamReader( pr.getInputStream() ) );
            line = br.readLine();
            while( line != null )
            {
              System.out.println( ":" + line );
              line = br.readLine();
            }
            
            br = new BufferedReader( new InputStreamReader( pr.getErrorStream() ) );
            line = br.readLine();
            while( line != null )
            {
              System.out.println( ":" + line );
              line = br.readLine();
            }
        }
                return sim;
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	static String virContent(LibEnvironment libEnv, String library, String entity, String archToGen,
			String fileName) throws Exception {

		GenGlue glue = new GenGlue();

		ByteArrayOutputStream virOS = new ByteArrayOutputStream();

		OutputEnvironment env = new OutputEnvironment(virOS);

		TextOut out = env.getTextOut(OutputStage.IMPLEMENTATION, "main");

		TextOut funcsOut = env.getTextOut(OutputStage.FUNCTIONS_PROTOTYPES,
				"main");

		TextOut typesOut = env.getTextOut(OutputStage.TYPE_DEFINITION, entity);

		TextOut cnstsOut = env.getTextOut(OutputStage.CONST_DECL, entity);

		Library lib = libEnv.getLibrary(library);

		IRNamedElement el = lib.getElement(entity);

		IREntity en = (IREntity) el;

		if (en.getArchitectures().length == 0)

		{

			throw new Exception("No architecture found for " + library + "."
					+ entity);

		}

		IRComponentInstance comp = new IRComponentInstance(lib, lib,
				el.getName(), el, archToGen);

		IREntity soc = (IREntity) lib.getElement(entity);

		VhdlParser p = soc.getDesignFile().parser;

		p.err.parser = p;

		libEnv.semanticCheck(p.err);

		GenTypes gen = new GenTypes(p.err);

		GenVTypes genV = new GenVTypes(new VErrorFactory());

		gen.glue = glue;

		genV.glue = glue;

		glue.verilogGen = genV;

		glue.vhdlGen = gen;

		comp.setName(/* arch */en.getFullName());

//		genMainEntityComponentInstancesInfo(null, comp, library, out);

		// ýòè ñòðîêè ìîæíî èãíîðèðîâàòü.

//		for (MemoryMapRecord memMapRec : memoryMapRecords) {
//
//			memMapRec.findComponentsAndDumpToVIR(comp, out);
//
//		}

		gen.generate(null, comp, out, funcsOut, typesOut, cnstsOut);

		while (true) {

			int prevWritesCount = out.writesCount;

			gen.generateSubprograms(out);

			gen.generateObjects(out);

			gen.generateTypes(out);

			if (prevWritesCount == out.writesCount)

				break;

		}

		env.generate();

		BufferedWriter outFile = new BufferedWriter(new FileWriter(fileName));

		outFile.write(new String(virOS.toByteArray(), Charset.defaultCharset()));

		outFile.close();

		return "";

	}	
	
	
	
	
	
	
	
	
	
	
}
