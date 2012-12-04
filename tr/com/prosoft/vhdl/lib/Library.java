package com.prosoft.vhdl.lib;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.HDLKind;
import com.prosoft.verilog.ir.VEnvironment;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.verilog.parser.VerilogParser;
import com.prosoft.vhdl.fs.*;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.ILocalResolver;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponent;
import com.prosoft.vhdl.ir.IRComponentTypeHolder;
import com.prosoft.vhdl.ir.IRContext;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRSubprogramSearchContext;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypes;
import com.prosoft.vhdl.parser.VhdlParser;
import com.prosoft.vhdl.parser.ParseException;

public class Library extends IRNamedElement implements ILocalResolver, IRComponentTypeHolder {

	static boolean progressEnabled = true;
	static public void disableProgress() { progressEnabled = false; }
	
	HashMap<String, IRNamedElement> elements = new HashMap<String, IRNamedElement>();
	HashMap<String, ComponentImplementation> implementations = new HashMap<String, ComponentImplementation>();
	LibEnvironment env;
	HashMap<String, IRComponent> comps = new HashMap<String, IRComponent>();

	public Library(LibEnvironment env, String name) {
		super(env, name);
		this.env = env;
	}

	void loadFile( LibEnvironment env, IRDesignFile df, String path, String name ) throws Exception {
//		Library res = new Library(env, name);
		File f = new File( path, name );
		if (progressEnabled)
			System.out.println("Processing " + f.getPath() + "...");
		if( FileSystem.isFile(f) ) {
			String fname = f.getName().toLowerCase(); 
			if( fname.endsWith("vhd") || fname.endsWith("vhdl") ) {
				readSourceFile(df, f.getPath());
                // Убрал getCanonicalPath(), чтобы имена файлов
                // соответствовали именам, заданным в командной
                // строке (чтобы информация о положении в исходнике
                // совпадала с ghdl-ной)
			} else if( fname.endsWith(".v") ) {
				readVerilogSourceFile(df, f.getPath());
			} else {
				System.err.println("Not a VHDL: " + fname);
				throw new RuntimeException(fname);
			}
		} else {
			throw new Exception("File not found " + f.getPath() + " (" + f.getCanonicalPath() + ")");
		}
	}
	
	public IRNamedElement getElement( String name ) {
		return elements.get(name.toLowerCase());
	}
	
	public LibEnvironment getEnvironment() {
		return (LibEnvironment) getParent();
	}
	
	public void putElement( IRNamedElement el ) {
		IRNamedElement old =  elements.get(el.getName().toLowerCase());
		if( old != null && old instanceof IREntity && el instanceof IRComponent ) return;
		if( el instanceof IREntity ) {
			int a = 0;
			a++;
		}
		
		if( old == null ) {
			String type = null;
			if( el instanceof IREntity ) {
				type = "entity";
			} else if( el instanceof IRArchitecture ) {
				type = "architecture";
			}
			if( type != null ) {
//				System.out.println("  Found " + type + " " + getName() + "." + el.getName());
			}
		}
		
		ComponentImplementation impl;
		if( old == null && el instanceof IRComponent ) {
			IRComponent comp = (IRComponent) el;
			impl = implementations.get(comp.getName().toLowerCase());
			if( impl != null ) {
				comp.setImplementation(impl);
			}
			elements.put( el.getName().toLowerCase(), el );
		} else if( old instanceof IRComponent && el instanceof IREntity ) {
			IRComponent comp = (IRComponent) old;
			IREntity en = (IREntity) el;
			impl = new ComponentImplementation(en);
			implementations.put(impl.getComponentName().toLowerCase(), impl);
			comp.setImplementation(impl);
			// не заменяем на entity, т.е. компонент может использоваться из других языков
		} else if( old == null && el instanceof IREntity ) {
			elements.put( el.getName().toLowerCase(), el );
			impl = new ComponentImplementation((IREntity) el); 
			implementations.put(impl.getComponentName().toLowerCase(), impl);
		} else {
			elements.put( el.getName().toLowerCase(), el );
		}
	}
	
	public void putComponent( ComponentImplementation comp ) {
		implementations.put(comp.getComponentName().toLowerCase(), comp);
		if( comp.getKind() == HDLKind.VHDL ) {
			IRNamedElement el = getElement(comp.getComponentName());
			if( el == null ) {
	//			IRComponent c = new IRComponent(this, comp.getComponentName());
	//			c.setImplementation(comp);
	//			putElement(c);
			} else if( el instanceof IRComponent ) {
				IRComponent c = (IRComponent) el;
				c.setImplementation(comp);
			} else {
				throw new RuntimeException(el.getClass().getCanonicalName());
			}
		} else {
//			IRComponent c = new IRComponent(this, comp.getComponentName());
//			if( c.getName().equalsIgnoreCase("omsp_timerA") ) {
//				int a = 0;
//				a++;
//			}
//			c.setImplementation(comp);
//			addComponentType(c);
//			elements.put(c.getName().toLowerCase(), c);
		}
	}
	
	public ComponentImplementation getComponentImplementation( String name ) {
		return implementations.get(name.toLowerCase());
	}
	
	public void readVerilogSourceFile(IRDesignFile df, String fileName) throws Exception {
		VerilogParser p = new VerilogParser(new FileInputStream(fileName));
		p.fileName = fileName;
		p.fullName = new File(fileName);
    	VEnvironment env = new VEnvironment(null, new VErrorFactory());
    	p.push(env);
    	p.lib = this;
		
    	p.enablePreprocessing();
    	
		p.CompilationUnit();
	}
	
	public void readSourceFile(IRDesignFile df, String fileName) throws Exception {
//		VhdlParser p = new VhdlParser(new FileInputStream(fileName));
		VhdlParser p = new VhdlParser(FileSystem.openRead(fileName));
		p.err = env.err;
		env.err.parser = p;
		df.parser = p;
		p.setDefignFile(df);
		p.env = env;
		p.filename = fileName;
//        try
        {
            p.design_file();
        }
//        catch ( ParseException e )
//        {
//            if ( e.currentToken != null )
//            {
//                System.err.println( fileName + ":" +
//                                    e.currentToken.next.beginLine + ":"
//                                    + e.currentToken.next.beginColumn + ": Parse error" );
//            }
//            System.err.println( e.getMessage() );
//            throw e;
//        }
		IRPackage[] packs = df.getPackages();
		for( int pi = 0; pi < packs.length; pi++ ) {
			putElement(packs[pi]);
			packs[pi].semanticCheck(p.err);
		}
		IRContext[] cs = df.getContexts();
		for( IRContext c : cs ) {
			IREntity[] ents = c.getEntities();
			for( int ei = 0; ei < ents.length; ei++ ) {
				putElement(ents[ei]);
				ents[ei].semanticCheck(p.err);
			}
		}
	}
	
	public IRNamedElement[] getElements() {
		return elements.values().toArray( new IRNamedElement[elements.size()] );
	}
	
	public LibEnvironment getLibEnvironment() {
		return env;
	}

	public void semanticCheck( IRErrorFactory err ) throws CompilerError {
		IRNamedElement[] els = elements.values().toArray( new IRNamedElement[elements.size()] );
		for( int i = 0; i < els.length; i++ ) {
			IRNamedElement el = els[i];
			if( el instanceof IRPackage ) {
				IRPackage pack = (IRPackage) el;
				pack.semanticCheck(err);
			} else if( el instanceof IREntity ) {
				IREntity en = (IREntity) el;
				en.semanticCheck(err);
			} else {
				IRComponent comp = (IRComponent) el;
				comp.semanticCheck(err);
			}
		}
	}
	
	public void getAllTypes(ArrayList<IRType> res) {
		Iterator<IRNamedElement> it = elements.values().iterator();
		while( it.hasNext() ) {
			IRNamedElement el = it.next();
			if( el instanceof IRPackage ) {
				IRPackage pack = (IRPackage) el;
				IRTypes types = pack.getDeclarations().getTypes();
				types.getTypes(res);
				types = pack.getBody().getTypes();
				types.getTypes(res);
			} else if( el instanceof IREntity ) {
				IREntity en = (IREntity) el;
				IRArchitecture arch = en.getArchitectures()[0];
				arch.getTypes().getTypes(res);
			}
		}
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return elements.containsValue(el);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return elements.get(name.toLowerCase());
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

	@Override
	public void addComponentType(IRComponent comp) {
		comps.put(comp.getName().toLowerCase(), comp);
	}

	@Override
	public IRComponent getComponent(String name) {
		return comps.get(name.toLowerCase());
	}
}
