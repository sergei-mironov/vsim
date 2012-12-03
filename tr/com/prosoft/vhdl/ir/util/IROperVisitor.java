package com.prosoft.vhdl.ir.util;

import com.prosoft.vhdl.ir.IROper;

public interface IROperVisitor {

	public void visit( IROper parent, int childIndex, IROper child );
}
