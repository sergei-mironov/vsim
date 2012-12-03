package com.prosoft.vhdl.sim;

import java.util.HashMap;
import java.util.Stack;
import java.util.Vector;

import com.prosoft.common.FullCoord;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.ir.IRAggreg;
import com.prosoft.vhdl.ir.IRArrBound;
import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRAttrib;
import com.prosoft.vhdl.ir.IRBinaryOper;
import com.prosoft.vhdl.ir.IRConst;
import com.prosoft.vhdl.ir.IRConstRead;
import com.prosoft.vhdl.ir.IRDotOper;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREmptyStatement;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRExitOrNextStatement;
import com.prosoft.vhdl.ir.IRFieldOper;
import com.prosoft.vhdl.ir.IRForStatement;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRFunctionCall;
import com.prosoft.vhdl.ir.IRIfStatement;
import com.prosoft.vhdl.ir.IRLogicalOper;
import com.prosoft.vhdl.ir.IRLoopVariable;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IROperAssoc;
import com.prosoft.vhdl.ir.IROperRange;
import com.prosoft.vhdl.ir.IRRecordField;
import com.prosoft.vhdl.ir.IRReturnStatement;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRSignalAssignment;
import com.prosoft.vhdl.ir.IRSignalOper;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRStatements;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeCast;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.ir.IRTypeReal;
import com.prosoft.vhdl.ir.IRTypeRecord;
import com.prosoft.vhdl.ir.IRVarOper;
import com.prosoft.vhdl.ir.IRVariable;
import com.prosoft.vhdl.ir.IRVariableAssignment;
import com.prosoft.vhdl.ir.IRangedElement;

public class Simulator {

	private Vector<Event> events = new Vector<Event>();
	
	IRErrorFactory err;
	
	HashMap<ScalarSignal, Wire> wires = new HashMap<ScalarSignal, Wire>();
	
	Stack<Environment> stack = new Stack<Environment>();
	
	
	public enum SIM_MODE {
		RESUME,
		STEP_IN,
		STEP_OVER,
		STEP_RETURN
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	IRStatement stoppedAt;
	IRStatement prevStoppedAt;
	
//	boolean stepMode = true;
	boolean requestToStop;
//	boolean isStepOver;
	
//	Environment envToStopAt;
	int stackDepthRequiredToStop = Integer.MAX_VALUE;
	
	SIM_MODE simMode = SIM_MODE.STEP_IN;
	private boolean isStepMode() { return simMode == SIM_MODE.STEP_IN || simMode == SIM_MODE.STEP_OVER; }
	
	boolean ignoreBreakPoints;
	
	SimulatorSuspendedListener listener;
	public void setListener(SimulatorSuspendedListener listener) {
		this.listener = listener;
	}

	Object sleepOn = new Object();
	
	protected void stopOn( IRStatement stat ) {
		System.out.println("Stopped mode=" + simMode + ", rqrdStack = " + stackDepthRequiredToStop + ", actStack = " + stack.size());
		requestToStop = false;
		stoppedAt = stat;
		if( listener != null ) listener.suspended(this, stat);
		try {
			synchronized (sleepOn) {
				sleepOn.wait();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		prevStoppedAt = stoppedAt;
		stoppedAt = null;
		if( listener != null ) listener.resumed(this);
	}
	
	private boolean isStepStop( IRStatement cur ) {
		if( cur.getBegin() == null ) return false;
		if( prevStoppedAt == null || prevStoppedAt.getBegin() == null ) return true;
		TextCoord c1 = cur.getBegin(), c2 = prevStoppedAt.getBegin();
		return !( c1.getFile().equalsIgnoreCase(c2.getFile()) && c1.getLine() == c2.getLine() );
	}
	
	
	
	// внешний интерфейс
	public void resume() {
		simMode = SIM_MODE.RESUME;
		synchronized (sleepOn) {
			sleepOn.notifyAll();
		}
	}
	
	public void step(boolean isStepOver) {
		if( isStepOver ) {
//			envToStopAt = stack.peek();
			stackDepthRequiredToStop = stack.size();
		}
		simMode = isStepOver ? SIM_MODE.STEP_OVER : SIM_MODE.STEP_IN;
		synchronized (sleepOn) {
			sleepOn.notifyAll();
		}
	}
	
	public void stepReturn() {
		simMode = SIM_MODE.STEP_RETURN;
		stackDepthRequiredToStop = stack.size() - 1;
//		envToStopAt = getPrevEnvironment();
		synchronized (sleepOn) {
			sleepOn.notifyAll();
		}
	}
	
	public Stack<Environment> getStack() {
		return stack;
	}

	public IRStatement getStoppedAt() {
		return stoppedAt;
	}

	public void stop() {
		requestToStop = true;
	}
	
	public boolean isStopped() {
		return stoppedAt != null;
	}
	
	
	
	
	
	
	
	public Simulator(IRErrorFactory err) {
		this.err = err;
	}
	
	void addEvent( Event event ) {
		for( int i = 0; i < events.size(); i++ ) {
			if( !events.get(i).getTime().isLessThan(event.getTime()) ) {
				events.insertElementAt( event, i );
				return;
			}
		}
		events.add(event);
	}
	
	void insertEventAtHead( Event event ) {
		events.insertElementAt(event, 0);
	}
	
	void insertEventWithDeltaDelay( Event event ) {
		VTime cur = getCurrentTime();
		event.time.time = cur.time;
		event.time.delta = cur.delta+1;
		addEvent(event);
	}
	
	void moveEventToNewTime(Event event) {
		events.remove(event);
		addEvent(event);
	}
	
	public void simulate() {
		while( events.size() > 0 ) {
			Event event = events.firstElement();
			events.remove(0);
			System.out.println("Simulating event " + event);
			event.simulate();
		}
	}
	
	public VTime getCurrentTime() {
		if( events.size() == 0 ) return null;
		return events.get(0).getTime();
	}
	
	void putWire( ScalarSignal sig, Wire wire ) {
		wires.put(sig, wire);
	}
	
	Wire getWire(ScalarSignal sig) {
		return wires.get(sig);
	}
	
	void constantizeData( SimValue data , Environment env ) {
		if( data instanceof ArrayValue ) {
			ArrayValue arr = (ArrayValue) data;
			IRArrayIndex ind = IRTypeArray.getIndex( arr.type, err, null );
			if( !ind.getRange().getRangeHigh().isConst() ) {
				ind.getRange().setRangeHigh( new IRConst( getValue(ind.getRange().getRangeHigh(), env) ) );
			}
			if( !ind.getRange().getRangeLow().isConst() ) {
				ind.getRange().setRangeLow( new IRConst( getValue(ind.getRange().getRangeLow(), env) ) );
			}
			constantizeData(arr.value, env);
		}
	}
	void constantizeData( SimValue[] data , Environment env ) {
		for( int i = 0; i < data.length; i++ ) {
			constantizeData(data[i], env);
		}
	}
	
	public IRTypeEnum getTypeBoolean() {
		return err.parser.getBoolean();
	}
	
	SimValue executeFunction( IRFunction func, SimValue[] args, Environment env ) {
		constantizeData(args, env);
		FunctionInstance inst = new FunctionInstance(this, func);
		inst.initialize(args);
		SimValue res = null;
		stack.push(inst);
		try {
			simulateStatement(func.getBody(), inst);
		} catch (ReturnException e) {
			res = e.returnValue;
		} catch (ExitException e1) {
			throw new RuntimeException();
		}
		if( res == null ) res = inst.returnValue;
		
		if( env != null ) {
			env.setLastReturn(res, func);
		}
		
		// псевдооперация в конце функции
		try {
			simulateStatement(new IREmptyStatement(new FullCoord(func.getEnd(), func.getEnd())), inst);
		} catch (ReturnException e) {
			e.printStackTrace();
		} catch (ExitException e) {
			e.printStackTrace();
		}
		
		stack.pop();
		return res;
	}
	
	Environment getPrevEnvironment() {
		if( stack.size() >= 2 ) {
			return stack.get(stack.size()-2);
		} else if( stack.size() == 1 ) {
			return stack.get(0);
		}
		return null;
	}
	
	Environment getCurrentEnvironment() {
		if( stack.size() > 1 ) {
			return stack.peek();
		}
		return null;
	}
	
	void executeProcess( Process proc ) {
		simMode = SIM_MODE.STEP_IN;
		stack.push(proc);
		proc.simulate();
		stack.pop();
	}
	
	protected AggregateData createRecordData( IRTypeRecord type, String name, IRElement desc, 
			AggregateData parent, Environment env, boolean isSignal ) {
		AggregateData res;
		if( isSignal )
			res = new AggregateSignal(this, parent, name, (IRSignal) desc, type );
		else
			res = new AggregateVariable(this, parent, name, (IRVariable) desc, type );
		Data[] fields = new Data[type.getNumFields()];
		for( int i = 0; i < fields.length; i++ ) {
			IRRecordField f = type.getField(i);
			fields[i] = createData( f.getType(), f.getName(), null, res, env, isSignal );
		}
		res.setFields(fields);
		return res;
	}
	
	protected AggregateData createArrayData( IRArrayIndex type, String name, IRElement desc, AggregateData parent, Environment env,
			boolean isSignal ) {
		AggregateData res;
		int low = getValue(type.getRange().getRangeLow(), env).getIntOrEnumIndex();
		int high = getValue(type.getRange().getRangeHigh(), env).getIntOrEnumIndex();
		type = type.dup();
		type.getRange().setRangeHigh( IRTypeInteger.createConstant(high));
		type.getRange().setRangeLow( IRTypeInteger.createConstant(low));
		if( isSignal )
			res = new AggregateSignal(this, parent, name, (IRSignal) desc, type );
		else
			res = new AggregateVariable(this, parent, name, (IRVariable) desc, type );
		int size = high-low+1;
		Data[] elements = new Data[size];
		IRType elType = type.getNextIndexOrElementType();
		for( int i = 0; i < size; i++ ) {
			String elName;
			if( getValue(type.getRange().isDownTo(), env).getBoolean() ) {
				elName = Integer.toString(elements.length - i - 1 + low);
			} else {
				elName = Integer.toString(i + low);
			}
			elements[i] = createData(elType, elName, null, res, env, isSignal);
		}
		res.setFields(elements);
		return res;
	}
	
	protected AggregateData createArrayData( IRType type, String name, IRElement desc, AggregateData parent, 
			Environment env, boolean isSignal ) {
		IRArrayIndex ind = IRTypeArray.getIndex(type, err, null);
		return createArrayData(ind, name, desc, parent, env, isSignal);
	}
	
	protected ScalarData createScalarData( IRElement desc, IRType type, String name, AggregateData parent, Environment env,
			boolean isSignal ) {
		ScalarData res;
		if( isSignal ) {
			res = new ScalarSignal(this, parent, name, (IRSignal) desc, type);
		} else {
			res =  new ScalarVariable(this, parent, name, (IRVariable) desc, type);
		}
		res.assignValue( getDefaultValue(type), false );
		return res;
	}
	
	protected Data createData( IRType type, String name, IRElement desc, AggregateData parent, Environment env,
			boolean isSignal ) {
		if( type.isRecord() ) {
			return createRecordData((IRTypeRecord) type, name, desc, parent, env, isSignal );
		} else if( type.isArray() ) {
			return createArrayData(type, name, desc, parent, env, isSignal);
		} else {
			return createScalarData(desc, type, name, parent, env, isSignal);
		}
	}
	
	public SimValue getDefaultValue(IRType type) {
		if( type.isInt() ) {
			IRTypeInteger tint = (IRTypeInteger) type;
			if( tint.getRange().getRangeLow() != null ) {
				return ((IRConst)tint.getRange().getRangeLow()).getConstant();
			} else {
				return IRTypeInteger.createConstant(1).getConstant();
			}
		} else if( type.isReal() ) {
			IRTypeReal treal = (IRTypeReal) type;
			if( treal.getRange().getRangeLow() != null ) {
				return IRConst.getConstantValue(treal.getRange().getRangeLow(), null).getConstant();
			} else {
				return IRTypeReal.createConstant(0).getConstant();
			}
		} else if( type.isEnum() ) {
			return ((IRTypeEnum)type).getValue(0).getSimValue().getConstant();
		} else {
			throw new RuntimeException(type.getName());
		}
	}
	
	public int getIntFromIntOrEnum( SimValue v ) {
		if( v.type.isInt() ) {
			return ((IntValue)v).getIntValue();
		} else {
			return ((EnumSimValue)v).getEnumValue().getValue();
		}
	}
	
	public Data createData( IRElement desc, Environment env ) {
		Data res;
		if( desc instanceof IRSignal ) {
			IRSignal sig = (IRSignal) desc;
			res = createData(sig.getType(), sig.getName(), sig, null, env, true);
			if( sig.getInit() != null ) {
				SimValue v = getValue( sig.getInit(), env );
				res.assignValue(v, true);
			}
		} else if( desc instanceof IRVariable ) {
			IRVariable var = (IRVariable) desc;
			res = createData(var.getType(), var.getName(), var, null, env, false);
			if( var.getInit() != null ) {
				SimValue v = getValue( var.getInit(), env );
				res.assignValue(v, true);
			}
		} else {
			throw new RuntimeException();
		}
		return res;
	}
	
	public SimValue getValue( IROper op, Environment env ) {
		switch( op.getKind() ) {
		case CONST:
			return ((IRConst)op).getConstant();
		case VAR:
			IRVarOper var = (IRVarOper) op;
			Data data = env.resolveData(var.getVariable().getName());
			return data.getValue();
		case SGNL:
			IRSignalOper sig = (IRSignalOper) op;
			data = env.resolveData(sig.getSignal().getName());
			return data.getValue();
		case CONST_READ:
		{
			IRConstRead cr = (IRConstRead) op;
			if( cr.getConstant() instanceof IRLoopVariable ) {
				return env.resolveData(cr.getConstant().getName()).getValue();
			} else {
				IROper value = cr.getConstant().getValue();
				if( value instanceof IRConst ) {
					return ((IRConst)value).getConstant();
				} else {
					return getValue( ((IRConstRead)op).getConstant().getValue(), env );
				}
			}
		}
		case AGGREG:
		{
			IRAggreg agg = (IRAggreg) op;
			// может это просто операция в скобках?
			if( agg.getChildNum() == 1 && !(agg.getChild(0) instanceof IROperAssoc) ) {
				return getValue(op.getChild(0), env);
			}
			int size;
			if( agg.getType().isArray() ) {
				IRArrayIndex ind = IRTypeArray.getIndex( agg.getType(), err, agg );
				int low = getValue(ind.getRange().getRangeLow(), env).getIntOrEnumIndex();
				int high = getValue(ind.getRange().getRangeHigh(), env).getIntOrEnumIndex();
				size = high - low + 1;
			} else {
				size = ((IRTypeRecord)agg.getType()).getNumFields();
			}
			SimValue[] res = new SimValue[size];
			
			
			throw new RuntimeException("Uncomment following");
/*			
			for( int i = 0; i < res.length; i++ ) {
				if( agg.getNumMembers() > i ) {
					res[i] = getValue( agg.getMember(i), env );
				} else {
					res[i] = getValue( agg.getOthersInit(), env );
				}
			}
			
			if( agg.getType().isArray() ) {
				return new ArrayValue(agg.getType(), res, res[0].getType());
			} else {
				return new RecordValue(res, (IRTypeRecord) agg.getType());
			}
*/			
		}
		case INDEX:
		{
			IROper arrExpr = op.getChild(0);
			ArrayValue arr = (ArrayValue) getValue(op.getChild(0), env);
			IRArrayIndex ind = IRTypeArray.getIndex( arr.getType(), err, arrExpr );
			int index = getIntFromDescreteValue(op.getChild(1), env);
			int low = getIntFromDescreteValue(ind.getRange().getRangeLow(), env);
			int high = getIntFromDescreteValue(ind.getRange().getRangeHigh(), env);
			int size = high - low + 1;
			if( getValue( ind.getRange().isDownTo(), env ).getBoolean() ) {
				return arr.getComponent(size - (index - low) - 1);
			} else {
				return arr.getComponent(index - low);
			}
//			AggregateData arr = (AggregateData) resolveSignal(op.getChild(0), env)[0];
//			IRArrayIndex ind = IRTypeArray.getIndex( arr.getType(), err, arrExpr );
//			int index = getIntFromDescreteValue(op.getChild(1), env);
//			int low = getIntFromDescreteValue(ind.getRangeLow(), env);
//			int high = getIntFromDescreteValue(ind.getRangeHigh(), env);
//			int size = high - low + 1;
//			if( ind.isDownTo() ) {
//				return arr.fields[size - index - 1].getValue();
//			} else {
//				return arr.fields[index-low].getValue();
//			}
		}
		case RANGE:
		{
			IROperRange range = (IROperRange) op;
			int low = getValue(op.getChild(1), env).getIntValue();
			int high = getValue(op.getChild(2), env).getIntValue();
			boolean isSrcDownTo = getValue( range.isDownTo(), env ).getBoolean();
			int actR = isSrcDownTo ? low : high;
			int actL = isSrcDownTo ? high : low;
			SimValue[] res = new SimValue[high-low+1];
			ArrayValue src = (ArrayValue) getValue(op.getChild(0), env);
			IRArrayIndex ind = IRTypeArray.getIndex(range.getChild(0).getType(), err, range);
			int declLow = getValue( ind.getRange().getRangeLow(), env ).getIntValue();
			int declHigh = getValue( ind.getRange().getRangeHigh(), env ).getIntValue();
			int declR = isSrcDownTo ? declLow : declHigh;
			int declL = isSrcDownTo ? declHigh : declLow;
			boolean isDstDownTo = getValue( ind.getRange().isDownTo(), env ).getBoolean();
			for( int i = 0; i < res.length; i++ ) {
				if( isSrcDownTo ) {
					res[i] = src.value[declHigh-high+i];
				} else {
					res[i] = src.value[low-declLow+i];
				}
			}
//			throw new RuntimeException("доделать выкавыривание слайса");
			ind = ind.dup();
			ind.getRange().setRangeHigh(IRTypeInteger.createConstant(high));
			ind.getRange().setRangeLow(IRTypeInteger.createConstant(low));
			return new ArrayValue(ind, res, ind.getArrayType().getElementType() );
		}
			
		case ARRAY_BOUND:
		{
			IRArrBound bound = (IRArrBound) op;
			Data[] arr = resolveSignal( op.getChild(0), env );
			IRArrayIndex ind = IRTypeArray.getIndex(arr[0].getType(), err, op);
			SimValue sv = getValue(ind.getRange().isDownTo(), env);
			boolean isDownTo = sv.getBoolean();
			switch( bound.getBound() ) {
			case HIGH:
				return getValue( ind.getRange().getRangeHigh(), env );
			case LOW:
				return getValue( ind.getRange().getRangeLow(), env );
			case IS_DOWN_TO:
				return sv;
			case LEFT:
				return isDownTo ? getValue( ind.getRange().getRangeHigh(), env ) : getValue( ind.getRange().getRangeLow(), env );
			case RIGHT:
				return !isDownTo ? getValue( ind.getRange().getRangeHigh(), env ) : getValue( ind.getRange().getRangeLow(), env );
			default:
				throw new RuntimeException();
			}
		}
		case GT:
		case LO:
		case GE:
		case LE:
		case EQ:
		case NEQ:
		{
			IROper l = op.getChild(0), r = op.getChild(1);
			IRType t1 = l.getType(), t2 = r.getType();
			if( t1.isInt() && t2.isInt() ) {
				IntValue v1 = (IntValue) getValue(l, env), v2 = (IntValue) getValue(r, env);
				boolean res;
				switch( op.getKind() ) {
				case GT: res = v1.getIntValue() > v2.getIntValue(); break;
				case LO: res = v1.getIntValue() < v2.getIntValue(); break;
				case GE: res = v1.getIntValue() >= v2.getIntValue(); break;
				case LE: res = v1.getIntValue() <= v2.getIntValue(); break;
				case EQ: res = v1.getIntValue() == v2.getIntValue(); break;
				case NEQ: res = v1.getIntValue() != v2.getIntValue(); break;
				default: throw new RuntimeException();
				}
				return err.parser.getBoolean().getValue(res?1:0).getSimValue().getConstant();
			} else if(t1.isEnum() && t2.isEnum() ) { 
				EnumSimValue v1 = (EnumSimValue) getValue(l, env), v2 = (EnumSimValue) getValue(r, env);
				boolean res;
				switch( op.getKind() ) {
				case EQ: res = v1.getEnumValue() == v2.getEnumValue(); break;
				case NEQ: res = v1.getEnumValue() != v2.getEnumValue(); break;
				default: throw new RuntimeException();
				}
				return err.parser.getBoolean().getValue(res?1:0).getSimValue().getConstant();
			} else {
				throw new RuntimeException();
			}
		}
			
		case ADD:
		case SUB:
		case MUL:
		case DIV:
		case REM:
		case MOD:
		{
			IROper l = op.getChild(0), r = op.getChild(1);
			IRType t1 = l.getType(), t2 = r.getType();
			IRBinaryOper bo = (IRBinaryOper) op;
			if( t1.isInt() && t2.isInt() ) {
				IntValue v1 = (IntValue) getValue(l, env), v2 = (IntValue) getValue(r, env);
				int res;
				switch( op.getKind() ) {
				case ADD: res = v1.getIntValue() + v2.getIntValue(); break;
				case SUB: res = v1.getIntValue() - v2.getIntValue(); break;
				case MUL: res = v1.getIntValue() * v2.getIntValue(); break;
				case DIV: res = v1.getIntValue() / v2.getIntValue(); break;
				case REM: res = v1.getIntValue() % v2.getIntValue(); break;
				case MOD: res = v1.getIntValue() % v2.getIntValue(); 
					res = Math.abs(res); if( v2.getIntValue() < 0 ) res = -res; break;
				default: throw new RuntimeException();
				}
				return IRTypeInteger.createConstant(res).getConstant();
			} else if( bo.getSub() != null ) {
				SimValue[] args = new SimValue[] {
					getValue( bo.getChild(0), env ),	
					getValue( bo.getChild(1), env )	
				};
				return executeFunction( (IRFunction) bo.getSub(), args, env);
			}
			{
				throw new RuntimeException();
			}
		}
		case AND:
		case OR:
		case NAND:
		case NOR:
		case XOR:
		case XNOR:
		{
			IRLogicalOper lo = (IRLogicalOper) op;
			IROper op1 = lo.getChild(0), op2 = lo.getChild(1);
			IRType t1 = op1.getType(), t2 = op2.getType();
			if( t1.isBoolean() && t2.isBoolean() ) {
				boolean v1 = getValue(op1, env).getEnumValue().getValue() != 0;
				boolean v2 = getValue(op2, env).getEnumValue().getValue() != 0;
				boolean res;
				switch(lo.getKind()) {
				case AND:
					res = v1&v2; break;
				case OR:
					res = v1|v2; break;
				case NAND:
					res = !(v1&v2); break;
				case NOR:
					res = !(v1|v2); break;
				case XOR:
					res = v1!=v2; break;
				case XNOR:
					res = !(v1!=v2); break;
				default:
					throw new RuntimeException();
				}
				return ((IRTypeEnum)t1).getValue(res?1:0).getSimValue().getConstant();
			}
			if( lo.getSub() == null ) throw new RuntimeException();
			SimValue[] args = new SimValue[] {
					getValue( lo.getChild(0), env ),	
					getValue( lo.getChild(1), env )	
				};
				return executeFunction( (IRFunction) lo.getSub(), args, env);
		}
		case FCALL:
			IRFunctionCall fcall = (IRFunctionCall) op;
			IROper[] params = fcall.getProcessedParameters();
			SimValue[] values = new SimValue[params.length];
			for( int i = 0; i < params.length; i++ ) {
				values[i] = getValue(params[i], env);
			}
			return executeFunction((IRFunction)fcall.getFunction(), values, env);
			
		case ATTRIB:
			return getAttributeValue((IRAttrib) op, env);
			
		case TYPE_CAST:
		{
			IRTypeCast tc = (IRTypeCast) op;
			SimValue res = getValue( op.getChild(0), env );
			if( res.type.isArray() && op.getType().isArray() ) {
				IRArrayIndex ind = IRTypeArray.getIndex(tc.getTypeToCastTo(), err, op);
				if( ind.getRange().getRangeHigh() != null && ind.getRange().getRangeLow() != null) {
					// просто заменяем тип
					res.type = tc.getTypeToCastTo();
				} else {
					// ничего не делаем, возвращаем как есть
				}
			} else throw new RuntimeException();
			return res;
		}
		
		case QUALIFY:
			return getValue(op.getChild(0), env);
			
		default:
			throw new RuntimeException(op.getKind().toString());
		}
	}
	
	protected SimValue getAttributeValue( IRAttrib attrib, Environment env ) {
		SimValue obj = getValue( attrib.getChild(0), env );
		String name = attrib.getAttributeName();
		if( obj.getType().isArray() ) {
			IRArrayIndex ind = IRTypeArray.getIndex(obj.getType(), err, attrib.getChild(0));
			int high = getValue(ind.getRange().getRangeHigh(), env).getIntValue();
			int low = getValue(ind.getRange().getRangeLow(), env).getIntValue();
			if( name.equalsIgnoreCase("length") ) {
				return IRTypeInteger.createConstant(high-low+1).getConstant();
			} else if( name.equalsIgnoreCase("low") ){
				return IRTypeInteger.createConstant(low).getConstant();
			} else if( name.equalsIgnoreCase("high") ){
				return IRTypeInteger.createConstant(high).getConstant();
			} else if( name.equalsIgnoreCase("left") ) {
				return IRTypeInteger.createConstant(getValue(ind.getRange().isDownTo(), env).getBoolean()?high:low).getConstant();
			} else if( name.equalsIgnoreCase("right") ) {
				return IRTypeInteger.createConstant(!getValue(ind.getRange().isDownTo(), env).getBoolean()?high:low).getConstant();
			}
		}
		throw new RuntimeException(attrib.toString());
	}
	
	public int getIntFromDescreteValue( IROper source, Environment env ) {
		SimValue op = getValue(source, env);
		if( op == null ) {
			err.discreteConstantExpected(source);
			throw new RuntimeException();
		}
		if( op.getType().isInt() ) {
			return op.getIntValue();
		} else if( op.getType().isEnum() ) {
			return op.getEnumValue().getValue();
		} else {
			err.discreteConstantExpected(source);
			throw new RuntimeException();
		}
	}
	
	protected void assignSignal( Signal sig, SimValue value, Environment env ) {
		if( sig instanceof ScalarSignal ) {
			ScalarSignal sc = (ScalarSignal) sig;
			sc.assignAndSendEvent(value);
		} else {
			AggregateSignal agg = (AggregateSignal) sig;
			IRArrayIndex ind = IRTypeArray.getIndex( agg.getType(), err, null );
			for( int i = 0; i < agg.fields.length; i++ ) {
				assignSignal( (Signal) agg.fields[i], value.getComponent(i), env );
			}
		}
	}
	
	FunctionInstance getTopFunction() {
		for( int i = stack.size()-1; i >= 0; i-- ) {
			if( stack.get(i) instanceof FunctionInstance ) return (FunctionInstance) stack.get(i);
		}
		throw new RuntimeException();
	}
	
	LoopEnvironment getLoop( String label ) {
		for( int i = stack.size()-1; i >= 0; i-- ) {
			if( stack.get(i) instanceof LoopEnvironment ) {
				LoopEnvironment loop = (LoopEnvironment) stack.get(i);
				if( label == null || loop.getDescription().getLabel().equalsIgnoreCase(label) ) {
					return loop;
				} 
			}
		}
		throw new RuntimeException();
	}
	
	protected void simulateSignalAssignment( IRSignalAssignment stat, Environment env ) {
		Data[] sig = resolveSignal(stat.getChild(0), env);
		SimValue value = getValue(stat.getChild(1), env);
		if( sig.length == 1 ) {
			assignSignal((Signal) sig[0], value, env);
		} else {
			ArrayValue arr = (ArrayValue) value;
			for( int i = 0; i < sig.length; i++ ) {
				assignSignal((Signal) sig[i], arr.getComponent(i), env);
			}
		}
		System.out.println("Signal " + sig[0].getFullName() + " is assigned to " + value + " at " + stat.getBegin());
	}
	
	protected void simulateVariableAssignment( IRVariableAssignment stat, Environment env ) {
		Data[] var = resolveSignal(stat.getChild(0), env);
		SimValue value = getValue(stat.getChild(1), env);
		if( var.length == 1 ) {
			var[0].assignValue(value, false);
		} else {
			for( int i = 0; i < var.length; i++ ) {
				var[i].assignValue(value.getComponent(i), false);
			}
		}
		System.out.println("Variable " + var[0].getFullName() + " is assigned to " + value + " at " + stat.getBegin());
	}
	
	protected void simulateFor( IRForStatement stat, Environment env ) throws ReturnException, ExitException {
		ForLoopEnvironment loop = new ForLoopEnvironment(this, stat, env);
		stack.push(loop);
		while( loop.hasNext() ) {
			try {
				simulateStatement(stat.getBody(), loop);
				loop.next();
			} catch (ExitException e) {
				if( e.loop != loop ) {
					stack.pop();
					throw e;
				}
				break;
			}
		}
		stack.pop();
	}
	
	protected void simulateReturn( IRReturnStatement stat, Environment env ) throws ReturnException {
		SimValue v = getValue( stat.getChild(0), env );
		getTopFunction().setReturnValue(v);
		throw new ReturnException(v);
	}
	
	protected boolean isCondition( IROper op, Environment env ) {
		SimValue v = getValue(op, env);
		return getIntFromIntOrEnum(v) != 0;
	}
	
	protected void simulateExit( IRExitOrNextStatement stat, Environment env ) throws ExitException {
		if( stat.getCondition() != null ) {
//			SimValue v = getValue(stat.getCondition(), env);
//			if( getIntFromIntOrEnum(v) == 0 ) return;
			if( !isCondition(stat.getCondition(), env) ) return;
		}
		LoopEnvironment loop = getLoop(stat.getLabel());
		throw new ExitException(loop);
	}
	
	protected void simulateIf( IRIfStatement stat, Environment env ) throws ReturnException, ExitException {
		boolean sometingMet = false;
		if( isCondition( stat.getIfTree(), env ) ) {
			sometingMet = true;
			simulateStatement(stat.getIfStatement(), env);
		} else {
			for( int i = 0; i < stat.getElseIfCount(); i++ ) {
				if( isCondition(stat.getElseIfTree(i), env) ) {
					sometingMet = true;
					simulateStatement(stat.getElseIfStatement(i), env);
					return;
				}
			}
		}
		if( !sometingMet && stat.getElseStatement() != null ) {
			// самый последний else
			simulateStatement(stat.getElseStatement(), env);
		}
	}
	
	public void simulateStatement( IRStatement stat, Environment env ) throws ReturnException, ExitException {
		
		env.setCurrentStatement(stat);
		
		boolean isStepOver = simMode == SIM_MODE.STEP_OVER;
		
		if( requestToStop ) {
			stopOn(stat);
		}
		
		if( !ignoreBreakPoints ) {
			if( simMode == SIM_MODE.STEP_OVER && stackDepthRequiredToStop >= stack.size() && isStepStop(stat) ) {
				stopOn(stat);
			} else if( simMode == SIM_MODE.STEP_IN && isStepStop(stat) ) {//stackDepthRequiredToStop >= stack.size() ) {
				stopOn(stat);
			} else if( simMode == SIM_MODE.STEP_RETURN && stackDepthRequiredToStop >= stack.size() ) {//stackDepthRequiredToStop >= stack.size() ) {
				stopOn(stat);
			}
			
		}
		
		switch(stat.getKind()) {
		case SIG_ASGN:
			simulateSignalAssignment((IRSignalAssignment) stat, env);
			break;
		case VAR_ASGN:
			simulateVariableAssignment((IRVariableAssignment) stat, env);
			break;
		case STATS:
			IRStatements stats = (IRStatements) stat;
			for( int i = 0; i < stats.getNumStatements(); i++ ) {
				simulateStatement(stats.getStatement(i), env);
			}
			break;
		case RETURN:
			simulateReturn((IRReturnStatement) stat, env);
			break;
		case FOR:
			simulateFor( (IRForStatement) stat, env );
			break;
		case EXIT:
			simulateExit( (IRExitOrNextStatement) stat, env );
			break;
		case IF:
			simulateIf((IRIfStatement) stat, env);
			break;
		case EMPTY_STATEMENT:
			break;
		default:
			throw new RuntimeException(stat.getKind().toString());
		}
		
	}
	
	public Data[] resolveSignal( IROper op, Environment env ) {
		switch( op.getKind() ) {
		case SGNL:
			IRSignalOper sig = (IRSignalOper) op;
			IRSignal desc = sig.getSignal();
			return new Data[] { env.resolveData(desc.getName()) };
		case NAME:
			return new Data[] { env.resolveData( ((IRName)op).getName() ) };
		case VAR:
			IRVarOper var = (IRVarOper) op;
			IRVariable desc1 = var.getVariable();
			return new Data[] { env.resolveData(desc1.getName()) };
		case DOT:
			IRDotOper dot = (IRDotOper) op;
			IRFieldOper f = (IRFieldOper) dot.getChild(1);
			IROper parentTree = dot.getChild(0);
			Data[] parent = resolveSignal(parentTree, env);
			return new Data[] { ((AggregateData)parent[0]).fields[f.getField().getIndex()] };
		case RANGE:
		{
			IROperRange range = (IROperRange) op;
			int low = getValue(op.getChild(1), env).getIntOrEnumIndex();
			int high = getValue(op.getChild(2), env).getIntOrEnumIndex();
			boolean isSrcDownTo = getValue( range.isDownTo(), env ).getBoolean();
			int actR = isSrcDownTo ? low : high;
			int actL = isSrcDownTo ? high : low;
			Data[] res = new Data[high-low+1];
			Data[] src = ((AggregateData)resolveSignal(range.getChild(0), env)[0]).getFiels();
			IRArrayIndex ind = IRTypeArray.getIndex(range.getChild(0).getType(), err, range);
			int declLow = getValue( ind.getRange().getRangeLow(), env ).getIntOrEnumIndex();
			int declHigh = getValue( ind.getRange().getRangeHigh(), env ).getIntOrEnumIndex();
			int declR = isSrcDownTo ? declLow : declHigh;
			int declL = isSrcDownTo ? declHigh : declLow;
			boolean isDstDownTo = getValue( ind.getRange().isDownTo(), env ).getBoolean();
//			if( isSrcDownTo != isDstDownTo ) {
				for( int i = 0; i < res.length; i++ ) {
					if( isSrcDownTo ) {
						res[i] = src[declHigh-high+i];
					} else {
						res[i] = src[low-declLow+i];
					}
//					int srcIndex = i + (actL - declL)*(isSrcDownTo?-1:+1);
//					int dstIndex = isSrcDownTo != isDstDownTo ? res.length - i - 1 : i;
//					res[dstIndex] = src[srcIndex]; 
//					int srcIndex = i + actL - declL;
//					int dstIndex = isSrcDownTo != isDstDownTo ? res.length - i - 1 : i;
//					res[dstIndex] = src[srcIndex]; 
				}
//			}
//			throw new RuntimeException("доделать выкавыривание слайса");
			return res;
		}
		case CONST:
			IRConst cnst = (IRConst) op;
			Data driver = createData(cnst.getType(), "constant_driver", null, null, env, true);
			driver.assignValue(cnst.getConstant(), true);
			return new Data[] {driver};
		case INDEX:
			SimValue index = getValue(op.getChild(1), env);
			int actIndex = getIntFromIntOrEnum(index);
			IROper arr = op.getChild(0);
			IRArrayIndex ind = IRTypeArray.getIndex(arr.getType(), err, arr);
			IROper arrTree = op.getChild(0);
			Data[] src = resolveSignal(arrTree, env);
			int l = getValue(ind.getRange().getRangeLow(), env).getIntValue();
			int h = getValue(ind.getRange().getRangeHigh(), env).getIntValue();
			int size = h - l + 1;
			AggregateData agg = (AggregateData) src[0];
			Data indexed = getValue( ind.getRange().isDownTo(), env ).getBoolean() ?
					agg.fields[size-actIndex-1-l]
					    : agg.fields[actIndex-l];
			return new Data[] {indexed};
		case OPEN:
			return new Data[0];
		case AGGREG:
			IRAggreg aggreg = (IRAggreg) op;
			driver = createData(aggreg.getType(), "constant_driver", null, null, env, true);
			
			throw new RuntimeException("Uncomment following");
			/*
			for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
				IRConst member = (IRConst) aggreg.getMember(i);
				((AggregateData)driver).fields[i].assignValue(member.getConstant(), true);
			}
			return new Data[]{driver};
			*/
		default:
			throw new RuntimeException(op.getKind().toString());
		}
	}
}
