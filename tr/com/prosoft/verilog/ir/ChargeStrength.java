package com.prosoft.verilog.ir;

public enum ChargeStrength {

	small, medium, large;

	public static ChargeStrength fromString( String id ) {
		for( int i = 0; i < values().length; i++ ) {
			if( id.equals(values()[i].toString()) ) return values()[i];
		}
		throw new RuntimeException();
	}
}
