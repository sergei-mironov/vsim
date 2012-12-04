package com.prosoft.verilog.ir;

public class VErrorFactory {
	
	IErrorHandler handler = new IErrorHandler() {

		@Override
		public void handle(String error) {
			System.err.println(error);
		}
		
	};

	public void undefined(String name) {
		handler.handle("undefined " + name);
	}

	public void integerExpected(VOper op, boolean constantExpected) {
		handler.handle("integer " + (constantExpected?"constant":"exression") + " expected:" + op);
	}

	public void typesExpected(VTypeKind[] allowedTypes, VOper op, boolean constantExpected) {
		StringBuffer buf = new StringBuffer();
		for( int i = 0; i < allowedTypes.length; i++ ) {
			buf.append(allowedTypes[i]);
			if( i + 1 < allowedTypes.length ) { buf.append(" or"); }
			buf.append(" ");
		}
		buf.append((constantExpected?"constant":"exression") + " expected: " + op);
		handler.handle(buf.toString());
	}

	public void sizeIsBigger(VType t1, VOper child) {
		handler.handle("Size of " + child + " is bigger than size of " + t1);
	}

	public void netExpected(VOper op) {
		handler.handle("Net expected " + op);
	}

	public void netOrPortExpected(VOper op) {
		handler.handle("Net or port expected " + op);
	}
}
