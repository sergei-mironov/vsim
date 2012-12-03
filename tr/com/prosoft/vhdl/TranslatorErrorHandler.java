// -*- coding: cp866 -*-
package com.prosoft.vhdl;

import java.util.*;
import java.io.*;
import java.nio.charset.Charset;

import com.prosoft.glue.gen.GenGlue;
import com.prosoft.verilog.gen.vir.GenVTypes;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.vhdl.gen.OutputEnvironment;
import com.prosoft.vhdl.gen.OutputStage;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.gen.vir.GenSymbols;
import com.prosoft.vhdl.gen.vir.GenTypes;
import com.prosoft.vhdl.VIRException;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRErrorHandler;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.parser.TokenMgrError;
import com.prosoft.vhdl.parser.VhdlParser;
import com.prosoft.vhdl.sim.ClockGenerator;
import com.prosoft.vhdl.sim.Entity;
import com.prosoft.vhdl.sim.InterpreterEntity;
import com.prosoft.vhdl.sim.ScalarSignal;
import com.prosoft.vhdl.sim.Simulator;
import com.prosoft.vhdl.fs.*;

class TranslatorErrorHandler implements IRErrorHandler {
	ArrayList<String> errors = new ArrayList<String>();
	int errorCount = 0;

	@Override
	public void handleError(String str) {
		System.err.println(str);
		System.err.flush();
		errorCount++;
		errors.add(str);
	}

	public int getErrorCount() {
		return errorCount;
	}

	public ArrayList<String> errors () {
		return errors;
	}

	@Override
	public boolean isOkToThrowException() {
		return false;
	}

	public void clear() {
		errors = new ArrayList<String>();
		errorCount = 0;
	}
}

