package com.prosoft.verilog.ir;

public enum NetType {

	supply0 , supply1
	, tri , triand , trior , tri0 , tri1
	, wire , wand , wor;
	
	public static NetType fromString( String id ) {
		for( int i = 0; i < values().length; i++ ) {
			if( id.equals(values()[i].toString()) ) return values()[i];
		}
		throw new RuntimeException();
	}
}
