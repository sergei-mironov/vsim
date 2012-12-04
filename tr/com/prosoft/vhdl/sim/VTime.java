package com.prosoft.vhdl.sim;

public class VTime {

	long time;
	int delta;
	
	public boolean isLessThan( VTime otherTime ) {
		return time < otherTime.time || ( time == otherTime.time && delta < otherTime.delta );
	}
	
	public String toString() {
		return Long.toString(time) + ":" + Integer.toString(delta);
	}
}
