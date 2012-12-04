package com.prosoft.verilog.ir;

public enum VTypeKind {

	INT, // это тоже вектор, только фиксированный
	REAL,
	REALTIME,
	TIME,
	VECTOR,
	MODULE,
	ARRAY,
	SUBPROGRAM,
	TYPE_TYPE;
	
	public boolean isIntOrVector() { return this == INT || this == VECTOR; };
	
	public static VTypeKind[] intAndVector = new VTypeKind[] {INT, VECTOR};
	public static VTypeKind[] vector = new VTypeKind[] {VECTOR};
	public static VTypeKind[] integer = new VTypeKind[] {INT};
	public static VTypeKind[] array = new VTypeKind[] {ARRAY};
	public static VTypeKind[] arrayOrVector = new VTypeKind[] {ARRAY, VECTOR};
	public static VTypeKind[] scalar = new VTypeKind[] {INT, REAL, REALTIME, TIME, VECTOR};
}
