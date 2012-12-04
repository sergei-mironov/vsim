package com.prosoft.verilog.parser;

import com.prosoft.verilog.ir.ChargeStrength;
import com.prosoft.verilog.ir.DriveStrength;
import com.prosoft.verilog.ir.NetType;
import com.prosoft.verilog.ir.VType;
import com.prosoft.verilog.ir.VectorScalarity;

public class VNetAttrib {

	String netType;
	VectorScalarity scalarity;
	DriveStrength drive0, drive1;
	ChargeStrength charge;
	VType vtype;
	
	public VNetAttrib(String netType, VectorScalarity scalarity,
			DriveStrength drive0, DriveStrength drive1, ChargeStrength charge, VType vtype) {
		this.netType = netType;
		this.scalarity = scalarity;
		this.drive0 = drive0;
		this.drive1 = drive1;
		this.charge = charge;
		this.vtype = vtype;
	}
	
	
}
