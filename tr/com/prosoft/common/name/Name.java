package com.prosoft.common.name;

public class Name {

	String[] parts;
	
	public Name( String[] parts ) {
		this.parts = (String[]) parts.clone();
	}
	
	Name( String[] parts, boolean dontCopy ) {
		if( dontCopy ) {
			this.parts = parts;
		} else {
			this.parts = (String[]) parts.clone();
		}
	}
	
	public String toString() {
		StringBuffer res = new StringBuffer();
		for( int i = 0; i < parts.length; i++ ) {
			res.append(parts[i]);
			if( i + 1 < parts.length ) res.append('.');
		}
		return res.toString();
	}
	
	public int length() {
		return parts.length;
	}
	
	public String part(int index) {
		return parts[index];
	}
	
	public String first() {
		return parts[0];
	}
	
	public Name append(String part) {
		String[] res = new String[parts.length+1];
		System.arraycopy(parts, 0, res, 0, parts.length);
		res[res.length-1] = part;
		return new Name(res, false);
	}
	
	public Name getCommonPart( Name other ) {
		int len = Math.min(parts.length, other.parts.length);
		int last = 0;
		for( int i = 0; i < len; i++ ) {
			if( parts[i].equals(other.parts[i]) ) {
				last++;
			} else {
				break;
			}
		}
		String[] res = new String[last];
		System.arraycopy(parts, 0, res, 0, last);
		return new Name(res, false);
	}
	
	public Name removeHead() {
		String[] res = new String[parts.length-1];
		System.arraycopy(parts, 1, res, 0, parts.length-1);
		return new Name(res, false);
	}
	
}
