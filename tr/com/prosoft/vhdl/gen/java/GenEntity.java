package com.prosoft.vhdl.gen.java;

import java.util.ArrayList;

import com.prosoft.vhdl.gen.Scope;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.util.IROperVisitor;

public class GenEntity {
	
	TextOut out;
	IRArchitecture arch;
	JavaNameSpace ns = new JavaNameSpace();
	
	protected void generateSignalDecls( IRSignal parent ) {
		for( int i = 0; i < parent.getChildren().length; i++ ) {
			IRSignal signal = parent.getChildren()[i];
			generateSignalDecls(signal);
		}
		out.nlTabAdd("Signal " + ns.getJavaName(parent) + ";");
	}

	public void generate( TextOut out, IRArchitecture arch, String packageName ) {
		this.out = out;
		this.arch = arch;
		out.nlTabAdd("package " + packageName + ";"); out.nl();
		out.nlTabAdd("import com.prosoft.vhdl.ir.*;");
		out.nlTabAdd("import com.prosoft.vhdl.sim.*;"); out.nl();
		out.nlTabAdd("public class " + arch.getName() + " extends Entity {");
		out.pushScope( new Scope(arch) );
		
		ArrayList<IRPort> ports = arch.getEntity().getPorts();
		for( int i = 0; i < ports.size(); i++ ) {
			generateSignalDecls(ports.get(i));
		}
		
		ArrayList<IRSignal> signals = arch.getSignals();
		for( int i = 0; i < signals.size(); i++ ) {
			generateSignalDecls(signals.get(i));
		}
		
		generateCtor();
		
		ArrayList<IRProcess> processes = arch.getProcesses();
		for( int i = 0; i < processes.size(); i++ ) {
			generateProcess(processes.get(i));
		}
		
		out.popScope();
		out.nlTabAdd("}");
	}
	
	protected void generateSignal(IRSignal signal) {
		String[] ch = generateChildSignals(signal);
		boolean isAggregate = signal.getType().isArray() | signal.getType().isRecord();
		boolean isRecord = signal.getType().isRecord();
		String className = isAggregate ? "AggregateSignal" : "ScalarSignal";
		String dir = "IRPortDirection." + (signal instanceof IRPort ? ((IRPort)signal).getDirection().toString() : "NONE");
		out.nlTabAdd(ns.getJavaName(signal) + " = new " + className + "( sim, \"" + signal.getName() + "\", " + dir );
		if( isAggregate ) {
			out.add(", " + (isRecord ? "true" : "false") + ", new Signal[] { ");
			for( int i = 0; i < ch.length; i++ ) {
				out.add(ch[i]);
				if( i + 1 < ch.length ) out.add(", ");
			}
			out.add("}, \"" + signal.getType().getName() + "\"" );
		}
		out.add(" );");
	}
	
	protected String[] generateChildSignals(IRSignal parent) {
		String[] res = new String[parent.getChildren().length];
		for( int i = 0; i < parent.getChildren().length; i++ ) {
			IRSignal signal = parent.getChildren()[i];
			generateSignal(signal);
			res[i] = ns.getElementFullName(signal);
		}
		return res;
	}
	
//	protected void addChildSignals(IRSignal parent, String[] children) {
//		String parName = ns.getElementFullName(parent);
//		for( int i = 0; i < children.length; i++ ) {
//			if( parent.getType().isRecord() )
//			out.nlTabAdd(data)
//		}
//	}
	
	public void generateCtor() {
		out.nlTabAdd("public " + arch.getName() + "(Simulator sim) {");
		out.pushScope(new Scope());
		out.nlTabAdd("super(sim);");
		
		ArrayList<IRPort> ports = arch.getEntity().getPorts();
		for( int i = 0; i < ports.size(); i++ ) {
			IRPort p = ports.get(i);
			generateSignal(p);
//			generateChildSignals(p);
//			out.nlTabAdd(ns.getJavaName(p) + " = new Signal( sim, \"" + p.getName() 
//					+ "\", null, IRPortDirection." + p.getDirection() + ");");
		}

		ArrayList<IRSignal> signals = arch.getSignals();
		for( int i = 0; i < signals.size(); i++ ) {
			IRSignal s = signals.get(i);
			generateSignal(s);
//			generateChildSignals(s);
//			out.nlTabAdd(ns.getJavaName(s) + " = new Signal( sim, \"" + s.getName() 
//					+ "\", IRPortDirection.NONE, null );");
		}
		
		out.popScope();
		out.nlTabAdd("}");
	}
	
	public void generateProcess(IRProcess process) {
		process.getStatements().visitStatement( new IROperVisitor() {

			@Override
			public void visit(IROper parent, int childIndex, IROper child) {
				if( child.isValueRequired() ) {
					//System.out.println(child.toString());
				}
			}
			
		});
	}
	
}
