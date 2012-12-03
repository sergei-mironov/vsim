package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.parser.ParserBase.ImplementationRule;

public interface IRComponentInstanceHolder {

	void add( IRComponentInstance instance );
	IRComponentInstance[] getComponentInstances();
	ArrayList<ImplementationRule> getImplementationRules();
	void addImplementationRule(ImplementationRule rule);
}
