package com.prosoft.fsm.test;

import java.io.FileInputStream;
import java.io.FileOutputStream;

import com.prosoft.fsm.FSM;
import com.prosoft.fsm.gen.Gen;
import com.prosoft.fsm.parser.FSMParser;
import com.prosoft.vhdl.gen.OutputEnvironment;
import com.prosoft.vhdl.gen.OutputStage;
import com.prosoft.vhdl.gen.TextOut;

public class Test {
	
//	static String file = "C:\\Docs\\vhdl\\tcp\\states_and_actions.fsm";
	static String file = "C:\\Docs\\vhdl\\tcp\\player.fsm";

	public static void main( String[]  args ) throws Exception {
		FSMParser p = new FSMParser( new FileInputStream(file) );
		FSM fsm = p.fsm();
		OutputEnvironment env = new OutputEnvironment( new FileOutputStream("C:\\Temp\\fsm.vhd") );
		TextOut out = env.getTextOut(OutputStage.DESCRIPTION, "fsm");
		new Gen().generate(fsm, out);
		env.generate();
	}
}
