package com.prosoft.verilog.ir;

public class VValue {
	
	VType type;
	
	public static VValueInteger integer( String value ) {
		long v = Long.parseLong(value);
		return integer(v);
	}
	
	public static VValueInteger integer( long value ) {
		return new VValueInteger(VTypeInteger.TYPE, value);
	}
	
	protected static String getRepresentation( boolean signed, char c, int radix ) {
		if( signed ) {
			throw new RuntimeException("и че делать?");
		}
		int len = 0;
		for( int i = radix; i > 1; i >>= 1 ) len++;
		int val;
		if( c >= '0' && c <= '9' ) {
			val = c - '0';
		} else if(c >= 'a' && c <= 'f' ) {
			val = 10 + c - 'a';
		} else if( c == '?' ) {
			return "?";
		} else {
			throw new RuntimeException(c+"");
		}
		if( val >= radix ) throw new RuntimeException(c+"");
		StringBuffer res = new StringBuffer(Integer.toString(val, 2));
		char pad = '0';
		if( c == 'x' || c == 'z' ) {
			pad = c;
		}
		while( res.length() < len ) {
			res.insert(0, pad);
		}
		return res.toString();
	}
	
	public static VValueVector vector( String value ) {
		value = value.toLowerCase();
		boolean hasQuestion = value.indexOf('?') >= 0;
		int apoIndex = value.indexOf('\'');
		long declLength = -1;
		boolean signed = false;
		boolean radixMet = false;
		int radix = 10;
		if( apoIndex >= 0 ) {
			declLength = Long.parseLong(value.substring(0, apoIndex));
		}
		int imageStart = apoIndex + 1;
		char c = value.charAt(imageStart);
		if( c == 's' ) {
			signed = true;
		} else if( c == 'b' ) {
			radix = 2; radixMet = true;
		} else if( c == 'o' ) {
			radix = 8; radixMet = true;
		} else if( c == 'd' ) {
			radix = 10; radixMet = true;
		} else if( c == 'h' ) {
			radix = 16; radixMet = true;
		} else {
			throw new RuntimeException(value);
		}
		imageStart++;
		if( !radixMet ) {
			c = value.charAt(imageStart);
			if( c == 'b' ) {
				radix = 2; radixMet = true;
			} else if( c == 'o' ) {
				radix = 8; radixMet = true;
			} else if( c == 'd' ) {
				radix = 10; radixMet = true;
			}else if( c == 'h' ) {
				radix = 16; radixMet = true;
			}
			if( radixMet ) {
				imageStart++;
			}
		}
		String image = value.substring(imageStart);
		long longValue = -1;
		if( !hasQuestion ) {
			longValue = Long.parseLong(image, radix);
		}
		StringBuffer res = new StringBuffer();
		for( int i = 0; i < image.length(); i++ ) {
			res.append(getRepresentation(signed, image.charAt(i), radix));
		}
		int symb_len = 0;
		for( int i = radix; i > 1; i >>= 1 ) symb_len++;
		if( declLength > 0 ) {
			while( res.length() /* symb_len */ < declLength ) {
				res.insert(0, '0');
			}
			while( res.length() > declLength ) {
				res.deleteCharAt(0);
			}
		}
		VTypeVector type = new VTypeVector(VOperRange.range(res.length()-1, 0), signed);
		ValueSet[] v = new ValueSet[res.length()];
		for( int i = 0; i < v.length; i++ ) {
			v[i] = ValueSet.fromChar(res.charAt(i));
		}
		return new VValueVector(type, /*longValue,*/ v);
	}
	
//	public static VValueVector vector( ValueSet value ) {
//		VTypeVector type = new VTypeVector(VOperRange.zeroToZero, false);
//		return new VValueVector( type, value == ValueSet.ONE ? 1 : 0, new ValueSet[]{value} );
//	}
	
	public VValue(VType type) {
		this.type = type;
	}
	
	public static class VValueVector extends VValue {
		ValueSet[] values;
//		long longValue;
		public VValueVector(VTypeVector type, /*long longValue, */ValueSet[] values) {
			super(type);
			this.values = values;
//			this.longValue = longValue;
		}
		public ValueSet[] getValues() {
			return values;
		}
//		public long getLongValue() {
//			return longValue;
//		}
		public String toString() {
			StringBuffer buf = new StringBuffer();
			buf.append('\"');
			for( int i = 0; i < values.length; i++ ) {
				buf.append(values[i].toString());
			}
			buf.append('\"');
			return buf.toString();
		}
	}

	public static class VValueInteger extends VValue {
		long value;

		public VValueInteger(VType type, long value) {
			super(type);
			this.value = value;
		}
		
		public String toString() {
			return Long.toString(value);
		}
	}
	
	public static class VValueReal extends VValue {
		double value;

		public VValueReal(VType type, double value) {
			super(type);
			this.value = value;
		}
	}
	
	public static class VValueRealTime extends VValue {
		double value;

		public VValueRealTime(VType type, double value) {
			super(type);
			this.value = value;
		}
	}
	
	public static class VValueTime extends VValue {
		double value;

		public VValueTime(VType type, double value) {
			super(type);
			this.value = value;
		}
	}

	public static class VValueArray extends VValue {
		VValue[] values;

		public VValueArray(VType type, VValue[] values) {
			super(type);
			this.values = values;
		}

		public VValue[] getValues() {
			return values;
		}
	}
	
	public static class VValueType extends VValue {
		VType value;

		public VValueType(VType value) {
			super(VTypeType.type);
			this.value = value;
		}

		public VType getValue() {
			return value;
		}
	}

	public VType getType() {
		return type;
	}
	
	
}
