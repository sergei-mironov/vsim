package com.prosoft.glue;

import com.prosoft.verilog.ir.VType;
import com.prosoft.verilog.ir.VTypeKind;
import com.prosoft.vhdl.ir.IRType;

public class HDLType {

	HDLKind kind;
	IRType vhdlType;
	VType verilogType;
	
	public HDLType( IRType type ) {
		vhdlType = type;
		kind = HDLKind.VHDL;
	}
	
	public HDLType( VType type ) {
		verilogType = type;
		kind = HDLKind.VERILOG;
	}
	
	public HDLTypeFamily getFamily() {
		if( vhdlType != null ) {
			if( vhdlType.isBoolean() ) return HDLTypeFamily.BOOLEAN;
			if( vhdlType.isInt() ) return HDLTypeFamily.INT;
			if( vhdlType.isReal() ) return HDLTypeFamily.FLOAT;
			if( vhdlType.isArray() ) return HDLTypeFamily.ARRAY;
			// TODO проверить какие поля входят в структуру
			if( vhdlType.isRecord() ) return HDLTypeFamily.ARRAY;
			return HDLTypeFamily.UNKNOWN;
			
		} else if( verilogType != null ) {
			if( verilogType.getKind() == VTypeKind.REAL ) return HDLTypeFamily.FLOAT;
			if( verilogType.getKind() == VTypeKind.INT ) return HDLTypeFamily.INT;
			if( verilogType.getKind() == VTypeKind.VECTOR ) return HDLTypeFamily.ARRAY;
			return HDLTypeFamily.UNKNOWN;
		} else {
			throw new RuntimeException();
		}
	}

	public HDLKind getKind() {
		return kind;
	}

	public IRType getVhdlType() {
		if( vhdlType == null ) throw new RuntimeException();
		return vhdlType;
	}

	public VType getVerilogType() {
		if( verilogType == null ) throw new RuntimeException();
		return verilogType;
	}

	
}
