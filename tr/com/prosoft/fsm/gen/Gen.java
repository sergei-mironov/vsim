package com.prosoft.fsm.gen;

import java.util.ArrayList;

import com.prosoft.common.name.Name;
import com.prosoft.fsm.Action;
import com.prosoft.fsm.ActionKind;
import com.prosoft.fsm.FSM;
import com.prosoft.fsm.Oper;
import com.prosoft.fsm.State;
import com.prosoft.fsm.StateHolder;
import com.prosoft.fsm.Statement;
import com.prosoft.fsm.Transition;
import com.prosoft.fsm.parser.Token;
import com.prosoft.vhdl.gen.Scope;
import com.prosoft.vhdl.gen.TextOut;

public class Gen {

	public void generate( FSM fsm, TextOut out ) {
		new DumbIDGenerator().generateIDs(fsm);
		generateStates(fsm, out);
	}
	
	protected void generate( Oper oper, TextOut out ) {
		generate( oper.getTokens(), out );
	}
	
	protected void generate( Action act, TextOut out ) {
		out.nlTabAdd("-- action " + act.getState().getName() + " " + act.getKind() );
		generate( act.getStatement(), out );
	}
	
	protected void generate( ArrayList<Action> acts, TextOut out ) {
		for( int i = 0; i < acts.size(); i++ ) {
			generate( acts.get(i), out );
		}
	}
	
	protected void generate( Transition t, State source, TextOut out ) {
		out.pushScope(new Scope());
		out.nlTabAdd("if ");
		generate(t.getCondition(), out);
		out.add( " then begin " + "-- going from " + source.getFullName() + " to " + t.getTarget().getFullName() );
		out.pushScope(new Scope());
		
		Name topName = t.getTarget().getFullName().getCommonPart( source.getFullName() );
		StateHolder top = source.getFSM().resolve(topName);
		ArrayList<Action> acts = new ArrayList<Action>();
		source.getActions(acts, ActionKind.OUT, top, false);
		generate(acts, out);
		
		generate( t.getStatement(), out );
		
		acts.clear();
		t.getTarget().getActions(acts, ActionKind.IN, top, true);
		generate(acts, out);
		
		out.nlTabAdd("fsm_state = " + t.getTarget().getStateID().getTag() + ";");
		
		out.popScope();
		out.nlTabAdd( "end;" );
		out.popScope();
	}
	
	protected void generateStates( FSM fsm, TextOut out ) {
		ArrayList<State> states = fsm.getAllStates();
		out.nlTabAdd("case fsm_state is");
		for( int si = 0; si < states.size(); si++ ) {
			State state = states.get(si);
			out.nlTabAdd( "when " + state.getStateID().getTag() + " => ");
			
			// transitions
			ArrayList<Transition> trans = state.getTransitions(true);
			for( int ti = 0; ti < trans.size(); ti++ ) {
				generate(trans.get(ti), state, out);
			}
		}
		out.nlTabAdd("endcase;");
	}
	
	protected void generate( Token[] tokens, TextOut out ) {
		for( int i = 0; i < tokens.length; i++ ) {
			out.add( tokens[i].image + " " );
//			if( tokens[i].image.equals(";") ) out.add("\r\n");
		}
	}
	
	protected void generate( Statement stat, TextOut out ) {
		out.nlTab();
		generate(stat.getTokens(), out);
	}
	
}
