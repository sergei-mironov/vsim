package com.prosoft.vhdl.ir;

public enum IRAttribType {
	
	UNDEFINED,
	CONST, // аттрибут обрезается в константу
	SIM, // требует взаимодействия с симулятором
	FUNC // требует вызова функции

}
