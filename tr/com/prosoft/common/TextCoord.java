package com.prosoft.common;

public class TextCoord {

	String file;
	int line;
	int column;
	
	public TextCoord(String file, int line, int column) {
		super();
		this.file = file;
		this.line = line;
		this.column = column;
	}

	public String getFile() {
		return file;
	}

	public int getLine() {
		return line;
	}

	public int getColumn() {
		return column;
	}
	
	public String toString() {
//		return "\"" + file + "\"" + "(" + line + ", " + column + ") ";
		return file + ":" + line + ":" + column + ": ";
//		return "(" + file + ":" + line + ")";
	}
}
