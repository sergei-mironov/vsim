package com.prosoft.glue;

import com.prosoft.common.TextCoord;
import com.prosoft.verilog.ir.VName;
import com.prosoft.verilog.ir.VPort;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRSignalOper;

public class PortDesc {

	String name;
	HDLType type;
	HDLKind kind;
	
	IRPort vhdlPort;
	VPort verilogPort;
	
	public PortDesc(IRPort port) {
		kind = HDLKind.VHDL;
		vhdlPort = port;
		this.name = port.getName().toLowerCase();
		this.type = new HDLType(port.getType());
	}

	public PortDesc(VPort port) {
		kind = HDLKind.VERILOG;
		verilogPort = port;
		this.name = port.getName().toLowerCase();
		this.type = new HDLType(port.getType());
	}
	
	public HDLExpr getExpr(TextCoord coord) {
		HDLExpr res;
		switch(kind) {
		case VHDL:
			res = new HDLExpr(new IRName(vhdlPort.getName()));
			break;
		case VERILOG:
			res = new HDLExpr(new VName(verilogPort.getName()));
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

	public IRPort getVhdlPort() {
		return vhdlPort;
	}

	public VPort getVerilogPort() {
		return verilogPort;
	}

	public TextCoord getBegin() {
		if( vhdlPort != null ) {
			return vhdlPort.getBegin();
		} else if( verilogPort != null ) {
			return verilogPort.getBegin();
		} else {
			throw new RuntimeException();
		}
	}
}
