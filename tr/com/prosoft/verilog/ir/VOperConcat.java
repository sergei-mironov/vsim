package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VOperConcat extends VOper {
	
	public VOperConcat(ArrayList<VOper> args) {
		for( int i = 0; i < args.size(); i++ ) {
			setChildAt(i, args.get(i));
		}
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.CONCAT;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		long size = 0;
		for( int i = 0; i < getChildNum(); i++ ) {
			VOper ch = getChild(i);
			if( !env.ensureType(VTypeKind.vector, ch, false) ) { return null; }
			size += ch.getType().getSize();
		}
		return new VTypeVector( VOperRange.range(size-1, 0), false );
	}

}
