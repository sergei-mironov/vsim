package com.prosoft.vhdl.ir;

public enum IRAttribCode {

	ARRAY,
	TYPE,
	SIGNAL,
	ENTITY,
	TYPE_ARRAY // для случая когда у значения тип TYPE_TYPE, а само значение константы - тип массив  
}
