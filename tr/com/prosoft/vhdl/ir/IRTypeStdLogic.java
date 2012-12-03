package com.prosoft.vhdl.ir;

public class IRTypeStdLogic extends IRTypeEnum {
	
	public static final IRTypeStdLogic std_logic = new IRTypeStdLogic(null, "std_logic", false);
	public static final IRTypeStdLogic std_ulogic = new IRTypeStdLogic(null, "std_ulogic", true);
	
	boolean isUnresolved;

	@Override
	public boolean isStdLogic() {
		return true;
	}

	private IRTypeStdLogic(IRPackage pack, String name, boolean isUnresolved) {
		super(pack, name);
		this.isUnresolved = isUnresolved;
	}

}
