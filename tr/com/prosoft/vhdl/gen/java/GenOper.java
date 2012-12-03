package com.prosoft.vhdl.gen.java;

import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.IRConst;
import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IRSignalOper;
import com.prosoft.vhdl.sim.EnumSimValue;
import com.prosoft.vhdl.sim.IntValue;
import com.prosoft.vhdl.sim.StdLogic;

public class GenOper {
	
	JavaNameSpace ns;

	public GenOper(JavaNameSpace ns) {
		this.ns = ns;
	}
	
	public String getJavaName(IRNamedElement el) {
		return ns.getJavaName(el);
	}
	
	public String getConstantRepresentaion(IRConst cnst) {
		if( cnst.getConstant() instanceof EnumSimValue ) {
			EnumSimValue v = (EnumSimValue) cnst.getConstant();
			if( v.getType().isStdLogic() ) {
				return StdLogic.fromInt(v.getIntValue()).toString();
			} else {
				return Integer.toString(v.getIntValue());
			}
		} else if( cnst.getConstant().getType().isInt() ) {
			return Integer.toString(((IntValue)cnst.getConstant()).getIntValue());
		} else {
			throw new RuntimeException();
		}
	}
	
	public void generate( IROper oper, TextOut out, GenOption opt ) {
		
		switch( oper.getKind() ) {
		
		case SGNL: {
			IRSignalOper sig = (IRSignalOper) oper;
			String name = getJavaName(sig.getSignal());
			switch(opt) {
				case NONE:
					out.add(name); break;
				case EFF_VALUE:
					out.add(name + ".getEffectiveValue()"); break;
				case DRV_VALUE:
					out.add(name + ".getDrivenValue()"); break;
				default: throw new RuntimeException();
			}
			break;
			}
		
		case DOT: {
			if( opt != GenOption.DRV_VALUE ) opt = GenOption.EFF_VALUE;
			generate(oper.getChild(0), out, opt);
			IRName name = (IRName) oper.getChild(1);
			out.add("." + name);
			break;
			}
		
		case CONST: {
			out.add( getConstantRepresentaion((IRConst) oper) );
			break;
			}
		
		
		}
		
	}
}
