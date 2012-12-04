package com.prosoft.verilog.parser;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Stack;

import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.glue.ComponentImplementation;
import com.prosoft.verilog.ir.Direction;
import com.prosoft.verilog.ir.IElementOper;
import com.prosoft.verilog.ir.IVarHolder;
import com.prosoft.verilog.ir.NetType;
import com.prosoft.verilog.ir.VAssignKind;
import com.prosoft.verilog.ir.VAssignStatement;
import com.prosoft.verilog.ir.VDelayOrEventControl;
import com.prosoft.verilog.ir.VEnvironment;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.verilog.ir.VInitialOrAlways;
import com.prosoft.verilog.ir.VModule;
import com.prosoft.verilog.ir.VModuleInstance;
import com.prosoft.verilog.ir.VName;
import com.prosoft.verilog.ir.VNamedElement;
import com.prosoft.verilog.ir.VNet;
import com.prosoft.verilog.ir.VOper;
import com.prosoft.verilog.ir.VOperRange;
import com.prosoft.verilog.ir.VPort;
import com.prosoft.verilog.ir.VSubParameter;
import com.prosoft.verilog.ir.VSubProgram;
import com.prosoft.verilog.ir.VType;
import com.prosoft.verilog.ir.VVariable;
import com.prosoft.vhdl.lib.Library;

public abstract class VParserBase implements VerilogParserConstants {
	
//	static String file = "C:\\temp\\Verilog\\fpu_double.v";
	static String file = "C:\\temp\\fromZefirov\\atmega128_new\\atmega128\\atmega128\\omsp_timera.v";
//	VEnvironment env;
	public String fileName;
	public File fullName;
	public Library lib;
	
	private VModule curModule;
	protected void setModule(VModule module) {
		curModule = module;
	}
	protected VModule module() { return curModule; }
	
	private Stack<VEnvironment> envs = new Stack<VEnvironment>();
	protected VEnvironment env() { return envs.peek(); }
	protected VEnvironment pop() { return envs.pop(); }
	public void push(VEnvironment env) { envs.push(env); }
	
	protected void putModule( VModule module ) {
		lib.putComponent(new ComponentImplementation(module));
	}
	
	/**
	 *  enables preprocessing for given parser
	 *   
	 *  method is to be called after all initialization but before any parsing
	 */
	public void enablePreprocessing() {
		Preprocessor prep = new Preprocessor(getTokenSource(), (VerilogParser) this);
		setTokenSource(prep);
	}
	
	public void createNet( VNetAttrib attrib, Token name, VOper init ) {
		VNamedElement el = env().get(name.image);
		if( el != null ) {
			if( init != null ) {
				VName target = new VName(name.image);
				target.setBegin(begin(name));
				VAssignStatement asgn = new VAssignStatement(target, VAssignKind.ARROW, init);
				asgn.setBegin(begin(name));
				asgn.setEnd(init.getEnd());
				VInitialOrAlways res = new VInitialOrAlways(module(), null, asgn, true);
				res.setBegin(begin(name));
				res.setEnd(init.getEnd());
				VDelayOrEventControl ctrl = new VDelayOrEventControl(null, null, null);
				res.getStatement().setControl(ctrl);
				res.getStatement().setBegin(begin(name));
				res.setEnd(init.getEnd());
				module().add(res);
			}
			// TODO set element type to wire/net
		} else {
			NetType netType = NetType.fromString(attrib.netType);
			VNet net = new VNet(name.image, attrib.vtype, netType, attrib.scalarity, attrib.drive0, attrib.drive1, attrib.charge, init);
			markBegin(net, name);
			env().put(net);
		}
	}
	
	public void createVar( Token name, VType type, VOper init ) {
		VNamedElement el = env().get(name.image);
		if( el != null ) {
			if( init != null ) {
				throw new RuntimeException("need to generate assignment " + name + " = " + init);
			}
		} else {
			VVariable var = new VVariable(name.image, type, init);
			markBegin(var, name);
			env().put(var);
		}
	}
	
	public void createPort( Token name, VType type, Direction dir ) {
		VPort port = new VPort(module(), name.image, type, dir);
		markBegin(port, name);
		env().put(port);
	}

    public static void main (String [] args) throws IOException, ParseException, Exception {
    	File fullName = new File(file);
    	VerilogParser p = new VerilogParser( new FileInputStream(fullName) );
    	p.fileName = fullName.getCanonicalPath();
    	p.fullName = fullName;
    	VEnvironment env = new VEnvironment(null, new VErrorFactory());
    	p.push(env);
    	p.lib = new Library(null, null);
    	p.enablePreprocessing();
    	p.CompilationUnit();
    	((VModule)env.get("omsp_timerA")).check();
    }
    
    public void createInst(Token moduleName, ArrayList<VOper> params, VOperRange range, Token instName, ArrayList<VOper> connections) {
    	if( range != null ) throw new RuntimeException("unimplemented");
    	VModuleInstance inst = new VModuleInstance(moduleName.image, params, instName.image, connections);
    	markBegin(inst, instName);
    	env().put(inst);
    	module().add(inst);
    }
    
    protected boolean isSubprogramName() {
    	Token t = getToken(1);
    	if( t.kind != IDENTIFIER ) return false;
    	VNamedElement el = resolve(t.image, false);
    	if( el == null ) return false;
    	return el instanceof VSubProgram;
    }
    
    public VNamedElement resolve( String id, boolean generateError ) {
    	return env().resolve(id, false);
    }
    
    public void createParams( VSubProgram sub, VType type, Direction dir, IdentifierList list ) {
    	for( Token t : list.ids ) {
    		sub.add(new VSubParameter(sub, t.image, dir, type));
    	}
    }
    
    public void createVars( IVarHolder holder, VType type, IdentifierList list ) {
    	for( Token t : list.ids ) {
    		holder.add(new VVariable(t.image, type, null));
    	}
    }
    
    public void markAsTop( VOper op ) {
    	((IElementOper)op).setIsTop(true);
    	if( op.getChildNum() <= 0 ) return;
    	VOper child = op.getChild(0);
    	while( child != null ) {
    		if( child instanceof IElementOper ) {
    	    	((IElementOper)child).setIsTop(false);
    		}
    		child = child.getChildNum() > 0 ? child.getChild(0) : null;
    	}
    }
    
    public String getFileName() {
    	VerilogParserTokenManager source = getTokenSource();
    	if( source instanceof Preprocessor ) {
    		return ((Preprocessor) source).getTopFilename();
    	}
    	return fileName;
    }
    
    protected abstract void setTokenSource( VerilogParserTokenManager man );
    protected abstract VerilogParserTokenManager getTokenSource();
    public abstract Token getToken( int i );
/*    
    protected void setTokenSource( VerilogParserTokenManager man ) {
    	token_source = man;
    }
    protected VerilogParserTokenManager getTokenSource() {
    	return token_source;
    }
    */
    
    TextCoord begin() {
    	return begin(getToken(1));
    }
    
    TextCoord end() {
    	return end(getToken(0));
    }
    
    TextCoord begin(Token t) {
    	TextCoord c = new TextCoord(getFileName(), t.beginLine, t.beginColumn);
    	return c;
    }
    
    TextCoord end(Token t) {
    	TextCoord c = new TextCoord(getFileName(), t.endLine, t.endColumn);
    	return c;
    }
    
    void markBegin( ICoordinatedElement el, Token t ) {
    	TextCoord c = new TextCoord(getFileName(), t.beginLine, t.beginColumn);
    	el.setBegin(c);
    }
    
    void markEnd( ICoordinatedElement el ) {
    	el.setEnd(end());
    }
}
