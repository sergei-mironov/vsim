package com.prosoft.verilog.ir;

public class VDelayOrEventControl {

	VOper delay;
	VOper event;
	VOper expression;
	
	public VDelayOrEventControl(VOper delay, VOper event, VOper expression) {
		this.delay = delay;
		this.event = event;
		this.expression = expression;
	}

	public VOper getDelay() {
		return delay;
	}

	public VOper getEvent() {
		return event;
	}

	public VOper getExpression() {
		return expression;
	}

	public void inferType(VEnvironment env) {
		if( delay != null ) {
			delay.inferType(env);
		}
		if( event != null ) {
			event.inferType(env);
		}
		if( expression != null ) {
			expression.inferType(env);
		}
	}
	
	
}
