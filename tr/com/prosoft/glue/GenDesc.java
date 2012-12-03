package com.prosoft.glue;

import com.prosoft.common.TextCoord;
import com.prosoft.verilog.ir.VName;
import com.prosoft.verilog.ir.VParameter;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRName;

public class GenDesc {

	String name;
	HDLType type;
	HDLExpr defaultValue;


	HDLKind kind;
	IRGeneric generic;
	VParameter parameter;
	
	public GenDesc(IRGeneric gen) {
		kind = HDLKind.VHDL;
		generic = gen;
		this.name = gen.getName().toLowerCase();
		this.type = new HDLType(gen.getType());
		this.defaultValue = new HDLExpr( gen.getValue() );
	}

	public GenDesc(VParameter gen) {
		kind = HDLKind.VERILOG;
		parameter = gen;
		this.name = gen.getName().toLowerCase();
		this.type = new HDLType(gen.getType());
		this.defaultValue = new HDLExpr( gen.getExpression() );
	}

	public HDLExpr getExpr(TextCoord coord) {
		HDLExpr res;
		switch(kind) {
		case VHDL:
			res = new HDLExpr(new IRName(generic.getName()));
			break;
		case VERILOG:
			res = new HDLExpr(new VName(parameter.getName()));
			break;
		default:
			throw new RuntimeException();
		}
		res.coord = coord;
		return res;
	}

	public String getName() {
		return name;
	}

	public HDLType getType() {
		return type;
	}

	public HDLKind getKind() {
		return kind;
	}

	public IRGeneric getGeneric() {
		return generic;
	}

	public VParameter getParameter() {
		return parameter;
	}

	public HDLExpr getDefaultValue() {
		return defaultValue;
	}

	
}
