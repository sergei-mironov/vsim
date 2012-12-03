package com.prosoft.glue;

import com.prosoft.verilog.ir.VNamedAssign;
import com.prosoft.vhdl.ir.IROperAssoc;

public class HDLAssoc {

	HDLExpr dst, src;

	public HDLAssoc(HDLExpr dst, HDLExpr src) {
		this.dst = dst;
		this.src = src;
	}
	
	public HDLAssoc( IROperAssoc assoc ) {
		this.dst = new HDLExpr(assoc.getChild(0));
		this.src = new HDLExpr(assoc.getChild(1));
	}
	
	public HDLAssoc( VNamedAssign assoc ) {
		this.dst = new HDLExpr(assoc.getChild(0));
		this.src = new HDLExpr(assoc.getChild(1));
	}

	public HDLExpr getDst() {
		return dst;
	}

	public HDLExpr getSrc() {
		return src;
	}
	
	
}
