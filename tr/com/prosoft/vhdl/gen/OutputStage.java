package com.prosoft.vhdl.gen;

public enum OutputStage {

	// генерируем тела функций и прочее
	IMPLEMENTATION,

	// обозначаем типы для структур и другие типы, при этом начинку структур пока не обозначаем
	TYPE_DEFINITION,
	
	CONST_DECL,
	
	// обозначаем заголовки функций
	FUNCTIONS_PROTOTYPES,
	
	// обозначаем внутренности структур
	STRUCT_DEFINITION,
	
	// обозначаем инициализированные структуры с описанием блоков и инициализаторов
	DESCRIPTION,
	
}
