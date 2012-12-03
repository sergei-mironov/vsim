package com.prosoft.glue;

import com.prosoft.common.TextCoord;
import com.prosoft.verilog.ir.VName;
import com.prosoft.verilog.ir.VOper;
import com.prosoft.vhdl.ir.IRFunctionCall;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IROper;

public class HDLExpr {

	HDLKind kind;
	IROper vhdlOper;
	VOper verilogOper;
	TextCoord coord;
	
	public HDLExpr(IROper oper) {
		vhdlOper = oper;
		kind = HDLKind.VHDL;
	}
	
	public HDLExpr(VOper oper) {
		verilogOper = oper;
		kind = HDLKind.VERILOG;
	}

	public HDLKind getKind() {
		return kind;
	}

	public IROper getVhdlOper() {
		return vhdlOper;
	}

	public VOper getVerilogOper() {
		return verilogOper;
	}

	public String getName() {
		if( vhdlOper != null ) {
			if( vhdlOper instanceof IRFunctionCall ) {
				return ((IRFunctionCall)vhdlOper).getFunctionName();
			}
			return ((IRName)vhdlOper).getName();
		} else {
			return ((VName)verilogOper).getName();
		}
	}
	
	public TextCoord getBegin() {
		if( coord != null ) {
			return coord;
		}
		if( vhdlOper != null ) {
			return vhdlOper.getBegin();
		} else {
			return verilogOper.getBegin();
		}
	}
}
