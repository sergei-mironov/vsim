package com.prosoft.vhdl.ir;

public class IRTypeFile extends IRType {
	
	IRType typeOfFile;

	public IRTypeFile(IRPackage pack, String name, IRType typeOfFile) {
		super(pack, name);
		this.typeOfFile = typeOfFile;
		setParent(pack);
	}

	public IRType getTypeOfFile() {
		return typeOfFile;
	}

	@Override
	public IRType dup() {
		IRTypeFile res = new IRTypeFile(getPackage(), getName(), typeOfFile);
		res.setFull(getFull());
		return res;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( !(type instanceof IRTypeFile) ) return false;
		IRTypeFile other = ((IRTypeFile)type); 
		return other.typeOfFile.isAssignableFrom(typeOfFile) && typeOfFile.isAssignableFrom( other.typeOfFile );
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return false;
	}

}
