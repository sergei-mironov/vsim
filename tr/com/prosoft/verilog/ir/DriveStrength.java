package com.prosoft.verilog.ir;

public enum DriveStrength {

	supply, strong, pull, weak;

	public DriveStrength fromString( String id ) {
		for( int i = 0; i < values().length; i++ ) {
			if( id.equals(values()[i].toString()) ) return values()[i];
		}
		throw new RuntimeException();
	}
}
