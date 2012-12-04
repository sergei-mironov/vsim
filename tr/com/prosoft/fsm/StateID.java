package com.prosoft.fsm;

import java.math.BigInteger;

public class StateID {

	String tag;
	BigInteger value;
	
	public StateID(String tag, BigInteger value) {
		this.tag = tag;
		this.value = value;
	}

	public String getTag() {
		return tag;
	}

	public BigInteger getValue() {
		return value;
	}
	
	
}
