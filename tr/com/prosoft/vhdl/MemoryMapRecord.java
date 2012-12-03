// -*- coding: cp866 -*-
package com.prosoft.vhdl;

import java.math.BigInteger;
import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.io.*;
import java.nio.charset.Charset;
import java.util.ArrayList;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRErrorHandler;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRSignal;

import com.prosoft.vhdl.ir.CompilerError;

// The memory map record class. Keeps information ofmemory map parts.
public class MemoryMapRecord {
	String filename;
	int line, col;
	String[] processPath;
	String[] signalPath;
	BigInteger start;
	BigInteger end;
	public MemoryMapRecord(String filename, int line, int col, String[] processPath, String[] signalPath, BigInteger start, BigInteger end) throws CompilerError {
		this.filename = filename;
		this.line = line;
		this.col = col;
		this.processPath = processPath;
		this.signalPath = signalPath;
		this.start = start;
		this.end = end;
		if (processPath.length < 1 || signalPath.length < 1)
			compilerError("empty CPU or signal path.");
		if (!processPath[0].equals(signalPath[0]))
			compilerError("CPU and signal paths should have at least one identical path element at start.");
	}


	void compilerError(String msg) throws CompilerError {
		throw new CompilerError(filename + ":" + line + ":" + col + ": " + msg);
	}

	String findSignalName(IRArchitecture arch, int signalPathIndex) {
		if (signalPathIndex == signalPath.length - 1) {
			ArrayList<IRSignal> s = arch.getSignals();
			for (int j = 0; j < s.size(); j++)
				if (s.get(j).getName().equals(signalPath[signalPathIndex]))
					return signalPath[signalPathIndex];
			return null;
		}

		for (int i = 0; i < arch.getComponentInstances().length; i++) {
			IRComponentInstance irci = arch.getComponentInstances()[i];
			IREntity ent = irci.getComponent().getEntity();
			if (signalPath[signalPathIndex].equals(ent.getName())) {
				String res = findSignalName(irci.getComponent(),
						signalPathIndex + 1);
				if (res != null)
					return ent.getName() + "." + res;
				else
					return null;
			}
		}
		return null;
	}

	String findSignalName(ComponentImplementation impl, int signalPathIndex) {
		IREntity ent = impl.getEntity();
		String res = null;
		if (signalPathIndex == signalPath.length - 1) {
			ArrayList<IRSignal> s = ent.getSignals();
			for (int j = 0; j < s.size(); j++)
				if (s.get(j).getName().equals(signalPath[signalPathIndex]))
					return signalPath[signalPathIndex];
			return null;
		}

		for (int i = 0; i < ent.getArchitectures().length; i++) {
			IRArchitecture archi = ent.getArchitectures()[i];
			if (signalPath[signalPathIndex].equals(archi.getName())) {
				res = findSignalName(ent.getArchitectures()[i],
						signalPathIndex + 1);
				if (res != null)
					return archi.getName() + "." + res;
				else
					return null;
			}
		}
		return null;
	}

	String findSignalName(IRComponentInstance irci, String parentName,
			int signalPathIndex) {
		String res = findSignalName(irci.getComponent(), signalPathIndex);
		if (signalPath.length < 2)
			return null;
		if (res != null)
			res = parentName + "." + res;
		return res;
	}

	String findProcessName(IRArchitecture arch, int processPathIndex) {
		if (processPathIndex >= processPath.length - 1) {
			ArrayList<IRProcess> ps = arch.getProcesses();
			for (int j = 0; j < ps.size(); j++)
				if (ps.get(j).getName().equals(processPath[processPathIndex]))
					return processPath[processPathIndex];
			return null;
		}

		for (int i = 0; i < arch.getComponentInstances().length; i++) {
			IRComponentInstance irci = arch.getComponentInstances()[i];
			IREntity ent = irci.getComponent().getEntity();
			if (processPath[processPathIndex].equals(ent.getName())) {
				String res = findProcessName(irci.getComponent(),
						processPathIndex + 1);
				if (res != null)
					return ent.getName() + "." + res;
				else
					return null;
			}
		}
		return null;
	}

	String findProcessName(ComponentImplementation impl, int processPathIndex) {
		IREntity ent = impl.getEntity();
		String res = null;
		if (processPathIndex >= processPath.length - 1) {
			ArrayList<IRProcess> ps = ent.getProcesses();
			for (int j = 0; j < ps.size(); j++)
				if (ps.get(j).getName().equals(processPath[processPathIndex]))
					return processPath[processPathIndex];
			return null;
		}

		for (int i = 0; i < ent.getArchitectures().length; i++) {
			IRArchitecture archi = ent.getArchitectures()[i];
			if (processPath[processPathIndex].equals(archi.getName())) {
				res = findProcessName(ent.getArchitectures()[i],
						processPathIndex + 1);
				if (res != null)
					return archi.getName() + "." + res;
				else
					return null;
			}
		}
		return null;
	}

	String findProcessName(IRComponentInstance irci, String parentName,
			int processPathIndex) {
		String res = findProcessName(irci.getComponent(), processPathIndex);
		if (processPath.length < 2)
			return null;
		if (res != null)
			res = parentName + "." + res;
		return res;
	}

	void findAndDump(String parentName,
		IRComponentInstance irci, TextOut out
	) {
		String iName = irci.getName();
		String commonName = (parentName.length() == 0)
			? iName
			: parentName+"."+iName;
		if (iName.equals(processPath[0])) {	// common prefix, remember?
			String signalName = findSignalName(irci, commonName, 1);
			if (signalName == null)	// no signal found.
				return ;
			String processName = findProcessName(irci, commonName, 1);
			if (processName == null)	// no such process.
				return ;
			out.nlAdd("(memory-map-range "+processName+" "+signalName+" "+start.toString()+" "+end.toString()+")");
			// we do not stop here because there can be same instances in deeper heierarchy levels.
		}
	}
	public void findComponentsAndDumpToVIR(IRComponentInstance irci,
			TextOut out
	) throws CompilerError {
		findAndDump("work", irci, out);
	}
}