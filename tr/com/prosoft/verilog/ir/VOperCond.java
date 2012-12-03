package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VOperCond extends VOper {
	
	public VOperCond( VOper cond, VOper tOp, VOper fOp) {
		setChildAt(0, cond);
		setChildAt(1, tOp);
		setChildAt(2, fOp);
	}
	
	@Override
	public VOperKind getKind() {
		return VOperKind.COND;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( env.ensureType(VTypeKind.scalar, getChild(0), false) ) {
			getChild(1).inferType(env);
			getChild(2).inferType(env);
			return env.inferBiggestTypeAndMakeCast(new VOper[] {getChild(1), getChild(2)});
//			VType t1 = getChildAt(1).inferType(env);
//			VType t2 = getChildAt(2).inferType(env);
//			if( t1.getSize() > t2.getSize() ) {
//				VOper child = getChildAt(2);
//				setChildAt(2, null);
//				VOper newOp = VOperCast.cast( env, t1, child );
//				setChildAt(2, newOp);
//				return t1;
//			} else {
//				VOper child = getChildAt(1);
//				setChildAt(1, null);
//				VOper newOp = VOperCast.cast( env, t2, child );
//				setChildAt(1, newOp);
//				return t2;
//			}
		}
		return null;
	}

	@Override
	protected void getAccessedObjects(ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget) {
		getChild(0).getAccessedObjects(write, read, false);
		getChild(1).getAccessedObjects(write, read, isWriteTarget);
		getChild(2).getAccessedObjects(write, read, isWriteTarget);
	}

	public VOper getCondition() {
		return getChild(0);
	}
	
	public VOper getTrueExpr() {
		return getChild(1);
	}
	
	public VOper getFalseExpr() {
		return getChild(2);
	}
}
