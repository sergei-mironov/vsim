package com.prosoft.glue.gen;

import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import com.prosoft.vhdl.fs.*;
import com.prosoft.common.TextCoord;
import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.GenDesc;
import com.prosoft.glue.HDLAssoc;
import com.prosoft.glue.HDLExpr;
import com.prosoft.glue.HDLKind;
import com.prosoft.glue.HDLType;
import com.prosoft.glue.PortDesc;
import com.prosoft.verilog.gen.vir.GenVTypes;
import com.prosoft.verilog.ir.VModule;
import com.prosoft.vhdl.gen.Scope;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.gen.vir.GenTypes;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IRPort;

public class GenGlue {
	
	public static boolean extendGenerateStatements = false;
	
	public GenTypes vhdlGen;
	public GenVTypes verilogGen;

	public TextOut funcsOut;
	public TextOut typesOut;
	public TextOut cnstsOut;
	
	HashMap<String, ArrayList<String>> sources = new HashMap<String, ArrayList<String>>();
	
	ArrayList<String> getFile( String fileName ) throws IOException {
		ArrayList<String> res = sources.get(fileName);
		if( res != null ) return res;
		res = new ArrayList<String>();
		LineNumberReader li = /*new LineNumberReader*/(FileSystem.openRead(fileName) );
//		LineInputStream li = new LineInputStream( new FileInputStream(fileName) );
		while(li.ready()) {
			String line = li.readLine();
			if (line == null)
				break;
			res.add(line);
		}
		sources.put(fileName, res);
		return res;
	}
	
	private TextCoord prevComment;
	
	void generateVHDLSource( TextCoord coord, TextOut out ) {
		if( coord == null || coord.getFile() == null ) return;
		if( prevComment != null && prevComment.getFile().equalsIgnoreCase(coord.getFile()) 
				&& prevComment.getLine() == coord.getLine() ) return;
		ArrayList<String> lines = null;
		try {
			lines = getFile(coord.getFile());
		} catch (IOException e) {
			e.printStackTrace();
		}
		if( lines == null ) return;
		int index = coord.getLine() - 1;
		if( index >= lines.size() ) return;
		out.nlAdd(";; " + lines.get(index));
		prevComment = coord;
	}
	
	public void forceLowerCase( boolean force, TextOut out ) {
		if( out != null ) out.forceLowerCase(force);
		funcsOut.forceLowerCase(force);
		typesOut.forceLowerCase(force);
		cnstsOut.forceLowerCase(force);
	}
	
    public void generateLocation( TextCoord coord, TextOut out ) {
        if ( coord == null )
        {
            out.nlTabAdd("(# null location ");
        }
        else
        {
            out.nlTabAdd("(# \"" + coord.getFile() + "\" "
                         + coord.getLine() + " " + coord.getColumn());
            generateVHDLSource(coord, out);
        }
    }
    
    public void generate( HDLType type, boolean extendType, TextOut out ) {
		forceLowerCase( type.getKind() == HDLKind.VHDL, out);
    	if( type.getKind() == HDLKind.VHDL ) {
    		vhdlGen.generate(type.getVhdlType(), extendType, null, out);
    	} else {
    		verilogGen.generate(type.getVerilogType(), extendType, out);
    	}
    }
    
    public void generateExpression( HDLExpr expr, String parentName, TextOut out ) {
		forceLowerCase( expr.getKind() == HDLKind.VHDL, out);
    	if( expr.getKind() == HDLKind.VHDL ) {
    		vhdlGen.generateExpression(expr.getVhdlOper(), parentName, out);
    	} else {
    		verilogGen.generateExpression(expr.getVerilogOper(), parentName, out);
    	}
    }
    
    public void generatePendingItems() {
		forceLowerCase( true, null );
    	vhdlGen.generatePendingItems();
		forceLowerCase( false, null );
    	verilogGen.generatePendingItems();
    }
	
	public void generateComponent( HDLKind externalEnv, ComponentImplementation comp, HDLAssoc[] wires, HDLAssoc[] gens, String parentName, String archName, TextOut out ) {
		forceLowerCase( comp.getKind() == HDLKind.VHDL, out);
		if( comp.getKind() == HDLKind.VHDL ) {
			IRArchitecture arch = comp.getEntity().getArchitecture(archName);
			out.nlTabAdd( ";; entity " + arch.getEntity().getFullName() );
		} else {
			VModule module = comp.getModule();
			out.nlTabAdd( ";; module " + module.getFullName() );
		}
		
		String dir = "";
		if( comp.getKind() != externalEnv ) {
			dir = externalEnv + "->" + comp.getKind() + " ";
			dir = dir.toLowerCase();
		}
		
		ArrayList<PortDesc> ports = comp.getPortList();
		for( int pi = 0; pi < ports.size(); pi++ ) {
			PortDesc port = ports.get(pi);
            generateLocation(port.getBegin(), out);
			out.nlTabAdd("(" + dir + "port " + parentName + "." + port.getName() + " " );
			generate( port.getType(), false, out );
			
			if( wires != null ) {
				out.pushScope(new Scope());
				for( int wi = 0; wi < wires.length; wi++ ) {
					HDLExpr src = wires[wi].getDst();
					HDLExpr dst = null;
//					if( src instanceof IRName ) {
//						IRName name = (IRName) src;
					String name = src.getName();
					if( name.equalsIgnoreCase("M103C") ) {
						int a = 0;
						a++;
					}
						if( name.equalsIgnoreCase(port.getName()) ) {
							dst = wires[wi].getSrc();
						}
//					}
					if( dst != null ) {
                        generateLocation(dst.getBegin(), out);
						out.nlTabAdd("(");
						out.add(parentName + ".");
						generateExpression( src, parentName, out );
						out.add(" ");
						generateExpression( dst, parentName, out );
						out.add("))");
					}
				}
				out.popScope();
			}
			
			out.nlTabAdd("))");

		}
		{
			ArrayList<GenDesc> generatedGens = new ArrayList<GenDesc>();
			out.pushScope(new Scope());
			for( int i = 0; i < gens.length; i++ ) {
				HDLAssoc assoc = gens[i];
				String name = assoc.getDst().getName();
				GenDesc gen = comp.getGeneric(name);
				generatedGens.add(gen);
				if( gen.getKind() == HDLKind.VHDL ) {
					vhdlGen.generate(gen.getGeneric(), parentName, assoc.getSrc().getVhdlOper(), out);
				} else {
					verilogGen.generate(gen.getParameter(), parentName, assoc.getSrc().getVerilogOper(),out);
				}
//				IRGeneric gen = (IRGeneric) arch.getEntity().resolve(name);
//				generate( gen, parentName, assoc.getSrc().getVhdlOper(), out );
			}
			for( int i = 0; i < comp.getGenList().size(); i++ ) {
				GenDesc gen = comp.getGenList().get(i);
				if( !generatedGens.contains(gen) ) {
					if( gen.getKind() == HDLKind.VHDL ) {
						vhdlGen.generate(gen.getGeneric(), parentName, gen.getDefaultValue().getVhdlOper(), out);
					} else {
						verilogGen.generate(gen.getParameter(), parentName, gen.getDefaultValue().getVerilogOper(),out);
					}
				}
			}
			
//			ArrayList<IRGeneric> gens = arch.getEntity().getGenerics();
//			for( int i = 0; i < gens.size(); i++ ) {
//				IRGeneric gen = gens.get(i);
//				generate( gen, parentName, out );
//			}
			out.popScope();
		}
		
		if( comp.getKind() == HDLKind.VHDL ) {
			vhdlGen.generateComponentImplementation(parentName, comp.getEntity(), archName, out);
		} else {
			verilogGen.generateComponentImplementation(parentName, comp.getModule(), out);
		}
	}
	
//	public void generate( String parentName, IRComponentInstance comp, HDLAssoc[] wires, HDLAssoc[] gens, TextOut out ) {
//		if( comp.getComponent().getKind() == HDLKind.VHDL ) {
//			vhdlGen.generate(parentName, comp, wires, gens, out);
//		} else {
////			verilogGen.generate(parentName, comp, wires, gens, out);
//		}
//	}
}
