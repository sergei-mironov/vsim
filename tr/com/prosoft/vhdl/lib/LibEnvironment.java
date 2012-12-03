package com.prosoft.vhdl.lib;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.LineNumberReader;
import java.util.*;

import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.ILocalResolver;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRConst;
import com.prosoft.vhdl.ir.IRConstant;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRPhysicalUnits;
import com.prosoft.vhdl.ir.IRSubprogramSearchContext;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.fs.*;

public class LibEnvironment extends IRElement implements ILocalResolver {
	
	public String loadedFile = null;
	
	HashMap<String, IRPhysicalUnits> physicalUnits = new HashMap<String, IRPhysicalUnits>();
	public final IRErrorFactory err;
	
	public LibEnvironment(IRErrorFactory err) {
		super(null);
		this.err = err;
	}

	static IRGeneric intGeneric( String name, int value ) {
		IRConst cnst = IRTypeInteger.createConstant(value);
		return new IRGeneric(null, name, cnst.getType(), cnst);
	}
	
	static IRGeneric[] definedGenerics = new IRGeneric[] {
		intGeneric("CLSEL", 1)
	};
	
	static void getGenerics( IRDesignFile df ) {
		for( int i = 0; i < definedGenerics.length; i++ ) {
			df.addDefinedGeneric(definedGenerics[i]);
		}
	}
	
	static class LibCfg {
		String name;
		String path;
		String[] files;
		public LibCfg(String name, String path, String[] files) {
			super();
			this.name = name;
			this.path = path;
			this.files = files;
		}
	}
	
	static LibCfg[] stdCfg = {
		new LibCfg( "STD", "C:/temp/VHDL/std", new String[]{"standard.vhd"} ),
	};
	
	static LibCfg[] curCfg = {
		new LibCfg( "IEEE", "C:/temp/VHDL/std_logic", new String[] {
				"stdlogic.vhd",
				"arith.vhd",
				"unsigned.vhd",
				"signed.vhd",
				"misc.vhd",
		})
	};
	
	public static void useAll( IRDesignFile df, Library useAll ) {
		IRNamedElement[] elements = useAll.getElements();
		for( int i = 0; i < elements.length; i++ ) {
			if( elements[i] instanceof IRPackage ) {
				df.useAll( (IRPackage) elements[i] );
			}
		}
	}
	
	protected static void read( LibEnvironment res, Library useAll, LibCfg[] cfg, IRGeneric[] generics ) throws Exception {
		for( int li = 0; li < cfg.length; li++ ) {
			String libName = cfg[li].name;
			String path = cfg[li].path;
			Library lib = res.getLibrary(libName);
			if( lib == null ) {
				lib = new Library(res, libName);
				res.putLibrary(lib);
			}
			String[] files = cfg[li].files;
			for( int fi = 0; fi < files.length; fi++ ) {
				IRDesignFile df = new IRDesignFile(lib);
				getGenerics(df);
				for( int gi = 0; gi < generics.length; gi++ ) {
					df.addDefinedGeneric(generics[gi]);
				}
				if( useAll != null ) {
					useAll(df, useAll);
				}
				try {
					lib.loadFile(res, df, path, files[fi]);
				} catch( CompilerError e ) {};
			}
		}
	}
	
	public static LibEnvironment readFromCFG(IRErrorFactory err) throws Exception {
		LibEnvironment res = new LibEnvironment(err);
		read(res, null, stdCfg, new IRGeneric[0]);
		Library std = res.getLibrary("STD");
		read(res, std, curCfg, new IRGeneric[0]);
		return res;
	}
	
	public static LibEnvironment readFromFile( String cfgFile, LibEnvironment res ) throws Exception {
		LineNumberReader rd = FileSystem.openRead(cfgFile);
			//new LineNumberReader(new FileReader(new File(cfgFile)));
		while( rd.ready() ) {
			String libName = rd.readLine();
			//System.out.println("Library " + libName + " found in " + cfgFile);
			if (libName == null)
				break;
			if( libName.length() == 0 ) continue;
			Library lib = res.getLibrary(libName);
			if (lib == null) {
				lib = new Library(res, libName);
				res.putLibrary(lib);
			}
			String libPath = rd.readLine();
			String file;
			while( (file=rd.readLine()) != null && file.length() > 0 ) {
				IRDesignFile df = new IRDesignFile(lib);
//				if( !libName.equalsIgnoreCase("STD") ) {
//					useAll(df, res.getLibrary("STD"));
//				}
				getGenerics(df);
//				for( int gi = 0; gi < generics.length; gi++ ) {
//					df.addDefinedGeneric(generics[gi]);
//				}
//				String cu = libPath.getCanonicalPath() + File.separator + file;
				res.loadedFile = file;
				lib.loadFile(res, df, libPath, file);
			}
		}
		return res;
	}
	
	public void readFileIntoWorkLibrary( String path, String[] files, IRGeneric[] generics ) throws Exception {
		LibCfg[] cur = new LibCfg[] { new LibCfg("work", path, files) };
		Library std = getLibrary("STD");
		read(this, std, cur, generics);
	}
	
	public void readFileIntoWorkLibrary( String path, String[] files, IRGeneric[] generics, String libName ) throws Exception {
		LibCfg[] cur = new LibCfg[] { new LibCfg(libName, path, files) };
		Library std = getLibrary("STD");
		read(this, std, cur, generics);
	}
	
	HashMap<String, Library> libs = new HashMap<String, Library>();

	public Library getLibrary( String name ) {
		return libs.get(name.toLowerCase());
	}
	
	public void putLibrary( Library lib ) {
		libs.put(lib.getName().toLowerCase(), lib);
	}
	
	public IRType[] getTypes() {
		ArrayList<IRType> res = new ArrayList<IRType>();
		Iterator<Library> it = libs.values().iterator();
		while( it.hasNext() ) {
			it.next().getAllTypes(res);
		}
		return res.toArray( new IRType[res.size()] );
	}
	
	public void add( IRPhysicalUnits units ) {
		physicalUnits.put(units.getName().toLowerCase(), units);
	}
	
	public IRPhysicalUnits getPhysicalUnits(String name) {
		return physicalUnits.get(name.toLowerCase());
	}

	public void semanticCheck( IRErrorFactory err ) throws CompilerError {
		for (Library lib : libs.values()) {
			lib.semanticCheck( err );
		}
	}

	public String listEntities( ) {
		StringBuilder result = new StringBuilder(10000);
		for (Map.Entry<String, Library> nameLib : libs.entrySet()) {
			String name = nameLib.getKey();
			Library lib = nameLib.getValue();
			IRNamedElement[] libElements = lib.getElements();
			for (IRNamedElement elem : libElements) {
				if (!(elem instanceof IREntity))
					continue;
				IREntity entity = (IREntity) elem;
				IRArchitecture[] archs = entity.getArchitectures();
				for (IRArchitecture arch : archs) {
					result.append(name);
					result.append('\n');
					result.append(entity.getName());
					result.append('\n');
					result.append(arch.getName());
					result.append('\n');
				}
			}
		}
		return result.toString();
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return libs.containsKey(el.getName().toLowerCase());
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return libs.get(name.toLowerCase());
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

}
