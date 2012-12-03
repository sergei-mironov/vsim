package com.prosoft.vhdl.ir;

public interface IRComponentTypeHolder {

	void addComponentType( IRComponent comp );
	IRComponent getComponent(String name);
}
