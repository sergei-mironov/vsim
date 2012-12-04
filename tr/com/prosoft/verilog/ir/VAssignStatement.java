package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VAssignStatement extends VStatement {
	
	VAssignKind assignKind;
	DriveStrength driveStrength;

	public VAssignStatement(VOper target, VAssignKind assignKind, VOper source) {
		setChildAt(0, target);
		this.assignKind = assignKind;
		setChildAt(1, source);
	}

	public VAssignStatement(VOper target, VAssignKind assignKind, VOper source, DriveStrength driveStrength, VOper delay) {
		setChildAt(0, target);
		this.assignKind = assignKind;
		setChildAt(1, source);
		this.driveStrength = driveStrength;
		setChildAt(2, delay);
	}

	@Override
	protected void check(VEnvironment env) {
		VType dst = getChild(0).inferType(env);
		VOper child = getChild(1);
		child.inferType(env);
		setChildAt(1, null);
		child = VOperCast.cast(env, dst, child);
		setChildAt(1, child);
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.ASSIGN;
	}

	public VAssignKind getAssignKind() {
		return assignKind;
	}

	public DriveStrength getDriveStrength() {
		return driveStrength;
	}

	@Override
	protected void getAccessedObjects(ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget) {
		getChild(0).getAccessedObjects(write, read, true);
		getChild(0).getAccessedObjects(write, read, false);
	}

	public VInitialOrAlways generateProcess(VModule owningModule, VErrorFactory err) {
		ArrayList<VOper> sensList = new ArrayList<VOper>();
		getAccessedObjects(new ArrayList<VOper>(), sensList, false);
		VOper sens;
		if( sensList.size() <= 0 ) {
			throw new RuntimeException();
		}
		sens = sensList.get(0);
		for( int i = 1; i < sensList.size(); i++ ) {
			sens = new VOperBinary(sens, VBinaryKind.LOR, sensList.get(i));
		}
		VDelayOrEventControl ctrl = new VDelayOrEventControl(null, sens, null);
		assignKind = VAssignKind.ARROW;
		setControl(ctrl);
		VInitialOrAlways res = new VInitialOrAlways(owningModule, null, this, true);
		res.setFull(getFull());
		return res;
	}

}
