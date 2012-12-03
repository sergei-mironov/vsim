package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IREternalLoop extends IRLoopStatement {
	
	public IREternalLoop(String label) {
		super(label);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ETERNAL_LOOP;
	}

	@Override
	public IROper dup() {
		IREternalLoop res = (IREternalLoop) new IREternalLoop(label).dupChildrenAndCoordAndType(this);
		res.body = body;
		return res;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		body.getAccessedObjects(write, read);
	}

}
