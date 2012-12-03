package com.prosoft.vhdl.parser;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Stack;

import com.prosoft.common.FullCoord;
import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.IObjectElement;
import com.prosoft.vhdl.ir.IProcessHolder;
import com.prosoft.vhdl.ir.IRAlias;
import com.prosoft.vhdl.ir.IRAliasHolder;
import com.prosoft.vhdl.ir.IRAll;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRAttrib;
import com.prosoft.vhdl.ir.IRBlock;
import com.prosoft.vhdl.ir.IRBlockHolder;
import com.prosoft.vhdl.ir.IRComponent;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRComponentInstanceHolder;
import com.prosoft.vhdl.ir.IRComponentTypeHolder;
import com.prosoft.vhdl.ir.IRConst;
import com.prosoft.vhdl.ir.IRConstant;
import com.prosoft.vhdl.ir.IRConstantHolder;
import com.prosoft.vhdl.ir.IRContext;
import com.prosoft.vhdl.ir.IRDesignFile;
import com.prosoft.vhdl.ir.IRDirection;
import com.prosoft.vhdl.ir.IRDotOper;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IREnumHolder;
import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRFunctionCall;
import com.prosoft.vhdl.ir.IRGenerateStatement;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRGenericHolder;
import com.prosoft.vhdl.ir.IRLoopVariable;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRObjectClass;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IROperError;
import com.prosoft.vhdl.ir.IROperIndex;
import com.prosoft.vhdl.ir.IROperKind;
import com.prosoft.vhdl.ir.IROperRange;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRPhysicalUnits;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRPortHolder;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRRecordField;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRSignalHolder;
import com.prosoft.vhdl.ir.IRSignalKind;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRSubProgram;
import com.prosoft.vhdl.ir.IRSubProgramHolder;
import com.prosoft.vhdl.ir.IRSubprogramSearchContext;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeAny;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeCast;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRTypeHolder;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.ir.IRTypePhysical;
import com.prosoft.vhdl.ir.IRTypeRange;
import com.prosoft.vhdl.ir.IRTypeReal;
import com.prosoft.vhdl.ir.IRTypeRecord;
import com.prosoft.vhdl.ir.IRUseAllObjects;
import com.prosoft.vhdl.ir.IRVarHolder;
import com.prosoft.vhdl.ir.IRVariable;
import com.prosoft.vhdl.ir.IRWhileStatement;
import com.prosoft.vhdl.ir.IRangedElement;
import com.prosoft.vhdl.ir.ILocalResolver;
import com.prosoft.vhdl.ir.ISensivityList;
import com.prosoft.vhdl.ir.IRPackage.Body;
import com.prosoft.vhdl.ir.IRPackage.Declaration;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.sim.RangeValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.TypeValue;

public abstract class ParserBase implements ILocalResolver {
	
	public static final int IFACE_GENERIC = 0;
	public static final int IFACE_PARAMETER_FUNC = 1;
	public static final int IFACE_PARAMETER_PROC = 2;
	public static final int IFACE_PORT = 3;
	
	int temp_type;
	
	public IRErrorFactory err;

	public Stack<IRElement> stack = new Stack<IRElement>();
	
	protected IRElement peek() { return stack.peek(); }
	protected void push( IRElement el ) {
		if( el instanceof ICoordinatedElement ) {
			ICoordinatedElement ic = (ICoordinatedElement) el;
			if( ic.getBegin() == null )
				ic.setBegin(begin());
		}
		stack.push(el); 
	}
	protected IRElement pop() {
		if( peek() instanceof ICoordinatedElement ) {
			ICoordinatedElement ic = (ICoordinatedElement) peek();
			ic.setEnd(end());
		}
		return stack.pop(); 
	}
	
	protected Hashtable<String, IRType> types = new Hashtable<String, IRType>();
	
	public ArrayList<IRArchitecture> archs = new ArrayList<IRArchitecture>();
	
	public LibEnvironment env;
	public IRDesignFile df;
	
	public String filename;
	
	protected IRPackage currentPackage;
	
	protected abstract Token getToken( int token );
	
	ParserBase() {
//		types.put(IRTypeStdLogic.std_logic.getName(), IRTypeStdLogic.std_logic);
//		types.put(IRTypeStdLogic.std_ulogic.getName(), IRTypeStdLogic.std_ulogic);
//		IRTypeStdLogicVector vec = IRTypeStdLogicVector.std_logic_vector();
//		IRTypeStdLogicVector uvec = IRTypeStdLogicVector.std_ulogic_vector();
//		types.put(vec.getName(), vec);
//		types.put(uvec.getName(), uvec);
//		err.parser = this;
	}
	
	public void setDefignFile( IRDesignFile df ) {
		if( stack.size() != 0 ) throw new RuntimeException();
		this.df = df;
		stack.push(df);
	}
	
	private Stack<IRType> contextTypes = new Stack<IRType>();
	
	protected IRTypeRecord getContextRecordType() {
		if( contextTypes.size() < 1 ) return null;
		IRType t = contextTypes.peek();
		if( t instanceof IRTypeRecord ) {
			return (IRTypeRecord) t;
		}
		return null;
	}
	
	protected IRType getFieldType(String fieldName) {
		IRTypeRecord rec = getContextRecordType();
		if( rec == null ) return null;
		IRRecordField f = rec.getField(fieldName);
		if( f != null ) return f.getType();
		return null;
	}
	
	protected IRRecordField getFieldBycontextName() {
		Token t = getToken(1);
		IRTypeRecord rec = getContextRecordType();
		if( rec == null ) return null;
		if( t.kind == VhdlParserConstants.basic_identifier ) {
			IRRecordField f = rec.getField(t.image);
//			System.out.println(t.image + " in " + rec.getFullName());
			return f;
		}
		return null;
	}
	
	protected boolean isContextFieldName() {
		return getFieldBycontextName() != null;
	}
	
	protected void pushContextType(IRType type) {
		contextTypes.push(type);
	}
	
	protected void popContextType() {
		contextTypes.pop();
	}
	
	void add( IRVariable var ) {
		IRElement el = stack.peek();
		if( el instanceof IRVarHolder ) {
			((IRVarHolder)el).add(var);
		} else {
			err.cantAdd( el, var );
		}
	}
	
	void addVariables( boolean shared, IdentifierList ids, IRType type, IROper init ) {
		for( int i = 0; i < ids.list.size(); i++ ) {
			String name = ids.list.get(i).image;
			IRNamedElement old = resolve(name, false);
			IRVariable var = new IRVariable((IRVarHolder) stack.peek(), name, type, IRDirection.NONE, init, shared);
			mark( begin(ids.list.get(i)), var );
			add(var);
			if( old != null ) {
				if( old instanceof IRVariable && old.getParent() instanceof IRPackage.Declaration && var.getParent() instanceof IRPackage.Body ) {
					IRVariable oldVar = (IRVariable) old;
					oldVar.setInit(init);
				}
			}
		}
	}
	
	void add( IRProcess proc ) {
		IRElement el = stack.peek();
		if( el instanceof IProcessHolder ) {
			((IProcessHolder)el).add(proc);
		} else {
			err.cantAdd( el, proc );
		}
	}
	
	void add( IRSignal sig ) {
		IRElement el = stack.peek();
		if( el instanceof IRSignalHolder ) {
			((IRSignalHolder)el).add(sig);
		} else {
			err.cantAdd( el, sig );
		}
	}
	
	void add( IRBlock block ) {
		IRElement el = stack.peek();
		if( el instanceof IRBlockHolder ) {
			((IRBlockHolder)el).add(block);
			block.setParent(el);
		} else {
			err.cantAdd( el, block );
		}
	}
	
	void add( IRAlias alias ) {
		IRElement el = stack.peek();
		if( el instanceof IRAliasHolder ) {
			((IRAliasHolder)el).add(alias);
			alias.setParent(el);
		} else {
			err.cantAdd( el, alias );
		}
	}
	
	public IRWhileStatement eternalWhile(String label) {
		IRWhileStatement res = new IRWhileStatement(label);
		res.setCondition(getBooleanConst(true));
		return res;
	}

	void add( IRComponentInstance inst ) {
//		int index = stack.size() - 1;
		IRElement el = stack.peek();
//		while( index >= 0 ) {
//			el = stack.get(index);
//			if( el instanceof IRGenerateStatement ) {
//				index--;
//			} else {
//				break;
//			}
//		}
		if( el instanceof IRComponentInstanceHolder ) {
			((IRComponentInstanceHolder)el).add(inst);
			inst.setParent(el);
		} else {
			err.cantAdd( el, inst );
		}
	}
	
	void addSignals( IdentifierList ids, IRType type, IRSignalKind kind, IROper init ) {
		for( int i = 0; i < ids.list.size(); i++ ) {
			String name = ids.list.get(i).image;
			IRSignal sig = new IRSignal(stack.peek(), name, type, kind, init);
			mark( begin(ids.list.get(i)), sig );
			add(sig);
		}
	}
	
	void add( IRPackage pack ) {
		df.add(pack);
		df.getLibrary().putElement(pack);
	}
/*	
	void add( CFGNode node ) {
		SequentalNodes nodes = null;
		if( stack.size() > 0 ) {
			for( int i = stack.size() - 1; i >= 0; i-- ) {
				IRElement el = stack.elementAt(i);
				if( el instanceof SequentalNodes ) {
					nodes = (SequentalNodes) el;
					break;
				}
			}
		}
		if( nodes == null ) {
			err.cantAdd( stack.peek(), node );
		} else {
			nodes.add(node);
		}
	}
	
	void add( IRStatement stat ) {
		SequentalNode seq = new SequentalNode();
		seq.add(stat);
		add(seq);
	}
*/	
	
	
	private IRNamedElement resolveInternal( String name ) {
		IRNamedElement res;
		if( stack.size() > 0 ) {
			for( int i = stack.size() - 1; i >= 0; i-- ) {
				IRElement el = stack.elementAt(i);
				if( el instanceof ILocalResolver ) {
					res = ((ILocalResolver) el).localResolve(name);
					if( res != null ) {
						return res;
					}
				}
				if( el instanceof IRTypeHolder ) {
					res = ((IRTypeHolder) el).getType(name);
					if( res != null ) {
						return res;
					}
				}
			}
		}
		Library lib = env.getLibrary(name);
		if( lib != null ) return lib;
		return null;
	}
	
	protected IRGeneric getDefinedGeneric(String name) {
		return df.getDefinedGeneric(name);
	}
	
	protected void processGeneric( IRGeneric gen ) {
		IRGeneric def = getDefinedGeneric(gen.getName());
		if( def == null ) {
//			if( gen.getValue() == null ) err.undefinedGeneric(gen);
//			System.out.println(gen.getValue());
//			return;
		} else {
			gen.setValue( def.getValue() );
		}
		
	}
	
	public IRNamedElement localResolve( String name ) {
		return localResolve(name, true);
	}
	public IRNamedElement localResolve( String name, boolean generateError ) {
		IRNamedElement res = resolveInternal(name);
		if( res == null && generateError ) {
			err.undefinedNoThrow( begin(), name );
		}
		return res;
	}
	
	public void localResolve( IRSubprogramSearchContext cnt ) {
		throw new RuntimeException();
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		throw new RuntimeException();
	}
	
	protected IRNamedElement resolve( String name, boolean generateError ) {
		if( name.equalsIgnoreCase("natural") ) {
			int a = 0;
			a++;
		}
		IRNamedElement res = resolveInternal(name.toLowerCase());
		if( res == null && generateError ) {
			err.undefinedNoThrow( begin(), name );
			resolveInternal(name);
		}
		return res;
	}
	
	protected IRNamedElement resolve( ILocalResolver context, IROper obj ) {
		if( obj instanceof IRName ) {
			IRName name = (IRName) obj;
			IRNamedElement el = context != null ? context.localResolve(name.getName()) : localResolve(name.getName(), false);
			if( el == null ) {
				err.undefinedNoEx(name.getBegin(), name.getName());
			} else {
				return el;
			}
		} else {
			IRDotOper dot = (IRDotOper) obj;
			IRNamedElement el = resolve(context, dot.getChild(0));
			if( el != null ) {
				el = resolve( (ILocalResolver)el, dot.getChild(1));
				return el;
			}
		}
		return null;
	}
	
	protected IRFunctionCall resolveAndCreateCall( IROper obj ) {
		if( obj instanceof IRName ) {
			IRName name = ((IRName)obj);
			IRNamedElement el = resolve(name.getName(), false);
			if( el != null ) {
				return (IRFunctionCall) IROper.create(el);
			} else {
				err.undefinedNoEx(obj.getBegin(), name.getName());
				return null;
			}
		} else if( obj instanceof IRDotOper ) {
			IROper context = obj.getChild(0);
			IRNamedElement el = resolve(null, context);
			if( el == null ) {
				err.undefinedNoEx(obj.getBegin(), context.toString());
				return null;
			}
			if( el instanceof ILocalResolver ) {
				return new IRFunctionCall( (ILocalResolver) el, ((IRName)obj.getChild(1)).getName() );
			} else {
				err.unexpected(context);
			}
		} else {
			obj.reportError();
		}
		return null;
	}
	
	protected IROper resolveAndCreate( IROper obj ) {
		if( obj instanceof IRName ) {
			IRName name = (IRName) obj;
			IRNamedElement el = resolve(name.getName(), false);
			if( el != null ) return mark( IROper.create(el) );
			if( name.getName().equalsIgnoreCase("work") ) {
				return name;
			} else {
				err.undefinedNoThrow( begin(), name.getName() );
				return new IRName(name.getName());
			}
		} else if( obj instanceof IRDotOper ) {
			IROper packOrLibName = obj.getChild(0);
			IRName packName;
			IRNamedElement el;
			if( packOrLibName instanceof IRName ) {
				packName = (IRName) packOrLibName;
				el = resolve( packName.getName(), true);
				if( el == null ) return null;
			} else {
				IRName libName = (IRName) packOrLibName.getChild(0);
				IRNamedElement elLib = resolve(libName.getName(), true);
				if( elLib instanceof Library ) {
					packName = (IRName) packOrLibName.getChild(1);
					Library lib = (Library) elLib;
					el = lib.resolve( packName.getName() );
				} else {
					err.packageOrLibraryExpected(obj.getBegin(), libName);
					return null;
				}
			}
			if( el instanceof IRPackage ) {
				IRPackage pack = (IRPackage) el;
				IRName elName = (IRName) obj.getChild(1);
				IRNamedElement res = pack.localResolve(elName.getName());
				if( res == null ) {
					err.undefinedNoThrow( elName.getBegin(), elName.getName() );
				}
				return IROper.create(res);
			} else {
				while( !(packOrLibName instanceof IRName) && packOrLibName.getChild(0) != null ) {
					packOrLibName = packOrLibName.getChild(0);
				}
				if( !(packOrLibName instanceof IRName) ) packOrLibName = packOrLibName.getChild(1);
				err.packageOrLibraryExpected( obj.getBegin(), (IRName) packOrLibName );
			}
		}
		return null;
	}
	
	protected IROper resolveAndCreate( Token name ) {
		IRNamedElement el = resolve(name.image, false);
		if( el != null ) return mark( IROper.create(el) );
		if( name.image.equalsIgnoreCase("work") ) {
			return mark(new IRName("work"), name);
		} else {
			err.undefinedNoThrow( begin(), name.image );
			return null;
		}
	}
	
	public IRSubProgram getSubProgram( TextCoord coord, String name, IRType[] params ) {
		String canName = IRSubProgram.getCanonicalName(coord, name, params);
		IRSubProgram res = (IRSubProgram) resolve(canName, false);
		return res;
	}
	
	protected String getIdentifierFromOper( IROper op ) {
		if( op instanceof IRName ) {
			return ((IRName)op).getName();
		} else if( op instanceof IRFunctionCall ) {
			return ((IRFunctionCall)op).getFunctionName();
		}
		throw new RuntimeException();
	}
	
	protected IRType getType( IROper name ) {
		
		if( name instanceof IRName ) {
			return getTypeInStack( ((IRName)name).getName() );
		} else if( name instanceof IRDotOper ) {
			IRNamedElement el = resolve(null, name.getChild(0));
			if( el != null ) { 
				if( el instanceof IRTypeHolder ) {
					IRType type = ((IRTypeHolder)el).getType( ((IRName)name.getChild(1)).getName() );
					return type;
				} else if( el instanceof IRPackage ) {
					IRType type = ((IRPackage)el).getDeclarations().getType( ((IRName)name.getChild(1)).getName() );
					return type;
				}
			} 
		}
//		err.undefinedNoEx(name.getBegin(), name.toString());
//		getType(name);
		return null;
		
//		if( name instanceof IRName ) {
//			IRType res;
//			String tname = ((IRName)name).getName();
//			res = getTypeInStack(tname);
//			if( res == null ) {
//				System.err.println("Undefined type " + tname);
//				return getTypeInStack(tname);//null;
//			}
//			return res;
//		} else if( name instanceof IRDotOper ) {
//			String pack = ((IRName)name.getChild(0)).getName();
//			String type = ((IRName)name.getChild(1)).getName();
//			IRPackage p = (IRPackage) df.getLibrary().getElement(pack);
//			if( p == null ) {
////				System.err.println(filename + "(" + getToken(0).beginLine + ") Undefined package " + pack);
//				return null;
//			}
//			IRType res = p.getDeclarations().getType(type);
//			return res;
//		} else {
//			throw new RuntimeException();
//		}
	}
	
	protected void addSens( ISensivityList proc, IROper sig ) {
		if( sig instanceof IObjectElement && ((IObjectElement)sig).getObjectClass() == IRObjectClass.SIGNAL ) {
			proc.addToSensivityList(sig);
		} else {
			err.signalExpected(sig);
		}
	}
	
//	protected IRNamedElement getComponent( String name ) {
//		IRNamedElement el;
//		name = name.toLowerCase();
//		el = getEntity(name, false);
//		if( el != null ) return el;
//		el = df.getLibrary().getElement(name);
//		if( el != null && el instanceof IRComponent ) {
//			return (IRComponent) el;
//		} else {
//			err.undefined(begin(), name);
//			return null;
//		}
//	}
	
	protected void addComponent( IRComponent comp ) {
		if( comp.getName().equals("omsp_timerA") ) {
			int a = 0;
			a++;
		}
		IRElement el = peek();
		if( el instanceof IRComponentTypeHolder ) {
			IRComponentTypeHolder holder = (IRComponentTypeHolder) el;
			holder.addComponentType(comp);
		} else {
			err.cantAdd(el, comp);
		}
	}
	
	protected IRComponent getComponent( Token name, boolean generateError ) {
		IRComponent res = getComponent(name.image);
		if( res != null ) return res;
		err.undefinedNoThrow(begin(name), "component", name.image);
		return null;
	}
	
	private IRComponent getComponent( String name ) {
		IRElement el = peek();
		while( el != null ) {
			if( el instanceof IRComponentTypeHolder ) {
				IRComponentTypeHolder holder = (IRComponentTypeHolder) el;
				IRComponent res = holder.getComponent(name);
				if( res != null ) return res;
			}
			el = el.getParent();
		}
		return null;
	}
	
	protected boolean isTokenReverseRange() {
		Token t = getToken(1);
		boolean res = t.kind == VhdlParserConstants.basic_identifier && t.image.equalsIgnoreCase("REVERSE_RANGE");
		return res;
	}
	
	protected boolean isType( String id ) {
		return getTypeInStack(id) != null;
	}
	
	protected boolean isType() {
		return laType() != null;
//		if( getToken(2).image.equals(".") ) {
//			IROper name = new IRDotOper(new IRName(getToken(1).image), new IRName(getToken(3).image));
//			return getType(name) != null;
//		} else {
//			return getTypeInStack(getToken(1).image) != null;
//		}
	}
	
	protected boolean isTypeAndNoApostrophe() {
		if( getToken(2).image.equals(".") ) {
			if( getToken(4).kind == VhdlParserConstants.APOSTROPHE ) return false;
			IROper name = new IRDotOper(new IRName(getToken(1).image), new IRName(getToken(3).image));
			return getType(name) != null;
		} else {
			if( getToken(2).kind == VhdlParserConstants.APOSTROPHE ) return false;
			return getTypeInStack(getToken(1).image) != null;
		}
	}
	
	protected boolean isPhysicalUnits(String name) {
		if( df.getLibrary().getEnvironment().getPhysicalUnits(name) != null ) {
			return true;
		} else {
			return false;
		}
	}
	
	protected boolean isFunction( String id ) {
		IRNamedElement el = resolve(id, false);
		return el != null && el instanceof IRFunction;
	}
	
	protected boolean isFunction( IROper op ) {
		return op instanceof IRFunctionCall;
	}
	
	protected boolean isIdent(Token t) {
		return t.kind == VhdlParserConstants.basic_identifier || t.kind == VhdlParserConstants.extended_identifier;
	}
	
	protected boolean isIdentOrString(Token t) {
		if( t.image.equalsIgnoreCase("\"mod\"") ) {
			int a = 0;
			a++;
		}
		return t.kind == VhdlParserConstants.basic_identifier || t.kind == VhdlParserConstants.extended_identifier
			|| t.kind == VhdlParserConstants.string_literal;
	}
	
//	protected boolean isFunctionCall() {
//		Token t1 = getToken(1);
//		if( filename.endsWith("ct00247.vhd") && t1.beginLine == 221 ) {
//			int a = 0;
//			a++;
//		}
//		getToken(0);
//		if( !isIdentOrString(t1) ) return false;
//		IRNamedElement el = resolve(t1.image, false);
//		Token t2 = getToken(2);
//		if( el != null && el instanceof IRSubProgram ) {
//			return t2.kind == VhdlParserConstants.OPENBRACE;
//		}
////		el = resolveUseTarget(boolName)
////		el = ((IRDesignFile)stack.get(0)).getLibrary().getElement(t1.image);
//		if( el instanceof IRPackage ) {
//			IRPackage pack = (IRPackage) el;
//			Token t3 = getToken(3);
//			if( t2.image.equals(".") ) {
//				if( !isIdentOrString(t3) ) return false;
//				IRNamedElement res = pack.resolve(t3.image);
//				return res != null && res instanceof IRSubProgram && getToken(4).kind == VhdlParserConstants.OPENBRACE;
//			} else {
//				return false;
//			}
//		} else if( el instanceof Library ) {
//			Library lib = (Library) el;
//			Token t3 = getToken(3);
//			int a = 0;
//			if( t2.image.equals(".") ) {
//				if( !isIdentOrString(t3) ) return false;
//				IRNamedElement el2 = lib.resolve(t3.image);
//				if( el2 instanceof IRPackage ) {
//					IRPackage pack = (IRPackage) el2;
//					Token t4 = getToken(4);
//					Token t5 = getToken(5);
//					if( t4.image.equals(".") ) {
//						if( !isIdentOrString(t5) ) return false;
//						IRNamedElement res = pack.resolve(t5.image);
//						return res != null && res instanceof IRSubProgram /*&& getToken(6).kind == VhdlParserConstants.OPENBRACE*/;
//					} else {
//						return false;
//					}
//				}
//			} else {
//				return false;
//			}
//		}
//		return false;
////		   | LOOKAHEAD( identifier() "(" ) (
////			   		LOOKAHEAD( {resolve(getToken(1).image, false) instanceof IRSubProgram} )
//	}
	
	
	protected boolean isNameAndDot(int token) {
		Token t = getToken(token);
		if( !isIdentOrString(t) ) return false;
		t = getToken(token+1);
		if( !t.image.equals(".") ) return false;
		return true;
	}
	
	protected boolean isFunctionCall() {
		int curTok = 1;
		ILocalResolver context = null;
		while( isNameAndDot(curTok) ) {
			String name = getToken(curTok).image;
			IRNamedElement el = context != null ? context.localResolve(name) : localResolve(name, false);
			if( el == null || !(el instanceof ILocalResolver) ) return false;
			context = (ILocalResolver) el;
			curTok += 2;
		}
		if( getToken(curTok+1).kind == VhdlParserConstants.APOSTROPHE ) return false; // it's attribute
		String name = getToken(curTok).image;
		IRNamedElement el = context != null ? context.localResolve(name) : localResolve(name, false);
		return el != null && el instanceof IRSubProgram;
	}
	
	protected boolean isProcedureCall() {
		int curTok = 1;
		ILocalResolver context = null;
		if( (getToken(curTok).kind == VhdlParserConstants.basic_identifier || getToken(curTok).kind == VhdlParserConstants.extended_identifier)
				&& getToken(curTok+1).image.equals(":") ) {
			// skipping LABEL:
			curTok += 2;
		}
		while( isNameAndDot(curTok) ) {
			String name = getToken(curTok).image;
			IRNamedElement el = context != null ? context.localResolve(name) : localResolve(name, false);
			if( el == null || !(el instanceof ILocalResolver) ) return false;
			context = (ILocalResolver) el;
			curTok += 2;
		}
		if( getToken(curTok+1).kind == VhdlParserConstants.APOSTROPHE ) return false; // it's attribute
		String name = getToken(curTok).image;
		IRNamedElement el = context != null ? context.localResolve(name) : localResolve(name, false);
		return el != null && el instanceof IRSubProgram && !((IRSubProgram)el).isFunction();
	}
	
	protected IRType laType() {
		int curTok = 1;
		ILocalResolver context = null;
		while( isNameAndDot(curTok) ) {
			String name = getToken(curTok).image;
			IRNamedElement el = context != null ? context.localResolve(name) : localResolve(name, false);
			if( el == null || !(el instanceof ILocalResolver) ) return null;
			context = (ILocalResolver) el;
			curTok += 2;
		}
		String name = getToken(curTok).image;
		if( context == null ) {
			return getTypeInStack(name);
		} else if( context instanceof IRTypeHolder ) {
			IRType type = ((IRTypeHolder)context).getType(name);
			return type;
		} else if( context instanceof IRPackage ) {
			IRType type = ((IRPackage)context).getDeclarations().getType(name);
			return type;
		}
		return null;
	}
	
	protected boolean isIdAndType( Token id, Token type ) {
		return id.kind == VhdlParserConstants.basic_identifier && 
		type.kind == VhdlParserConstants.basic_identifier &&
		isType(type.image);
	}
	
	protected IRConst getConstantValue( IROper oper ) {
		try {
			setTempParent(oper);
			oper.semanticCheck(err);
		} catch (CompilerError e) {
			err.constantExpressionRequired(oper);
		}
		IRConst res = IRConst.getConstantValue(oper, err);
//		if( res != null ) {
//			return res;
//		} else {
//			throw new RuntimeException();
//		}
		return res;
	}
	
	protected SimValue getAttributeValue( IROper oper ) {
		IRConst cnst = getConstantValue(oper);
		return cnst != null 
			? cnst.getConstant() 
				: null;
	}
	
	protected void addEntity( IREntity entity ) {
		if( entity.getName().equalsIgnoreCase("pc_next") ) {
			int a = 0;
			a++;
		}
		IRDesignFile df = (IRDesignFile) stack.elementAt(0);
		df.getContext().addEntity(entity);
	}
	
//	protected IRArchitecture getEnclosingArch() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			IRElement el = stack.get(i);
//			if( el instanceof IRArchitecture ) return (IRArchitecture) el;
//		}
//		throw new RuntimeException();
//	}
	
	protected IREntity getEntity(String name) {
		return getEntity(name, true);
	}
	
	protected IREntity getEntity(String name, boolean generateError) {
		IRDesignFile df = (IRDesignFile) stack.elementAt(0);
		IREntity res = df.getContext().getEntity(name);
		if( res == null && generateError ) err.undefinedNoThrow(begin(), name);
		return res;
	}
	
	protected IREntity getEntity( IROper name, boolean generateError ) {
		IRNamedElement el = resolveUseTarget(name);
		if( el == null ) {
			err.undefinedNoThrow(name.getBegin(), name.toString());
			return null;
		}
		if( el instanceof IREntity ) {
			return (IREntity) el;
		} else {
			err.entityExpected( name.getBegin(), name.toString() );
			return null;
		}
	}
	
	protected void add( IRConstant cnst, boolean upSearch ) {
		IRConstantHolder holder = null;
		if( upSearch ) {
			if( stack.size() > 0 ) {
				for( int i = stack.size() - 1; i >= 0; i-- ) {
					IRElement el = stack.elementAt(i);
					if( el instanceof IRConstantHolder ) {
						holder = (IRConstantHolder) el;
						break;
					}
				}
			}
		} else {
			if( stack.peek() instanceof IRConstantHolder ) {
				holder = (IRConstantHolder) stack.peek();
			}
		}
		if( holder == null ) {
			err.cantAdd( stack.peek(), cnst );
		} else {
			holder.add(cnst);
			cnst.setParent((IRElement) holder);
		}
	}
	
//	protected void add( IRSubProgram sub, boolean upSearch ) {
//		IRSubProgramHolder holder = null;
//		if( upSearch ) {
//			if( stack.size() > 0 ) {
//				for( int i = stack.size() - 1; i >= 0; i-- ) {
//					IRElement el = stack.elementAt(i);
//					if( el instanceof IRSubProgramHolder ) {
//						holder = (IRSubProgramHolder) el;
//						break;
//					}
//				}
//			}
//		} else {
//			Object obj = stack.peek();
//			if( obj instanceof IRSubProgramHolder ) {
//				holder = (IRSubProgramHolder) obj;
//			}
//		}
//		if( holder == null ) {
//			err.cantAdd( stack.peek(), sub );
//		} else {
//			holder.add(sub);
//		}
//	}
	
	protected void add( IRSubProgram sub ) {
		IRSubProgramHolder holder = null;
		Object obj = stack.peek();
		if( obj instanceof IRSubProgramHolder ) {
			holder = (IRSubProgramHolder) obj;
		}
		if( holder == null ) {
			err.cantAdd( stack.peek(), sub );
		} else {
			holder.add(sub);
		}
	}
	
//	protected void process( IRSubProgram sub ) {
//		IRNamedElement prevElem = ((IResolver)stack.peek()).resolve(sub.getName());
//		if( prevElem != null ) {
//			if( prevElem instanceof IRSubProgramsFamily ) {
//				IRSubProgramsFamily fam = (IRSubProgramsFamily) prevElem;
//				IRType[] curTypes = sub.getParametersTypes();
//				IRSubProgram prev = fam.getSubProgram(curTypes);
//				if( prev == null ) {
//					add( sub, false );
//				} else {
//					if( prev.getBody() == null && sub.getBody() == null ) {
//						err.subProgramHasNoBody( prev );
//					} else if( prev.getBody() != null && sub.getBody() != null ) {
//						err.redeclaration(prev, sub);
//					} else if( prev.getBody() != null && sub.getBody() == null ) {
//						// TODO: да вроде ничего страшного, для уже заделарированной подпрограммы еще раз написали заголовок
//						// однако ActiveHDL ругается
//						err.subProgramHasNoBody( prev );
//					} else {
//						if( !prev.isDeclarationEqualsTo(sub) ) {
//							err.redeclaration(prev, sub);
//						} else {
//							prev.copyImplementation(sub);
//						}
//					}
//				}
//			} else {
//				err.redeclaration( prevElem, (IRNamedElement)sub );
//			}
//		} else {
//			add( sub, false );
//		}
//	}
	
	protected void addConstants( IdentifierList list, IRType type, IROper init ) {
		for( int i = 0; i < list.list.size(); i++ ) {
			IRNamedElement old = resolve(list.list.get(i).image, false);
			IRConstant cnst = new IRConstant(stack.peek(), list.list.get(i).image, type, /*getConstantValue*/(init) );
			mark( begin(list.list.get(i)), cnst );
			add( cnst, false );
			if( old != null ) {
				if( old instanceof IRConstant && old.getParent() instanceof IRPackage.Declaration && cnst.getParent() instanceof IRPackage.Body ) {
					IRConstant oldCnst = (IRConstant) old;
					oldCnst.setInit(init);
				} else {
//					err.redeclaration(old, cnst);
				}
			}
		}
	}
	
	protected void generateFields( IdentifierList list, IRType type, IRTypeRecord parentType ) {
		for( int i = 0; i < list.list.size(); i++ ) {
			IRRecordField f = new IRRecordField(list.list.get(i).image, type, parentType);
			mark( begin(list.list.get(i)), f, end(list.list.get(i)) );
		}
	}
	
	protected void addType( IRType type ) {
		IRTypeHolder holder = null;
//		if( stack.size() > 0 ) {
//			for( int i = stack.size() - 1; i >= 0; i-- ) {
//				IRElement el = stack.elementAt(i);
//				if( el instanceof IRTypeHolder ) {
//					holder = (IRTypeHolder) el;
//					break;
//				}
//			}
//		}
		if( stack.peek() instanceof IRTypeHolder ) {
			holder = (IRTypeHolder) stack.peek();
		}
		if( holder == null ) {
			err.cantAdd( stack.peek(), type );
		} else {
			holder.addType(type);
			type.setParent((IRElement) holder);
		}
	}
	
	public class ImplementationRule {
		ArrayList<IROper> comps;
		Token compType;
		IREntity entity;
		Token arch;
		public ImplementationRule(ArrayList<IROper> comps, Token compType) {
			this.comps = comps;
			this.compType = compType;
		}
		public boolean isComponentConformes( IRComponentInstance comp ) {
			if( !comp.getComponentType().equalsIgnoreCase(compType.image) ) return false;
			if( comps.size() == 1 && comps.get(0).getKind() == IROperKind.OTHERS ) {
				err.unexpected(comps.get(0));
			} else if( comps.size() == 1 && comps.get(0).getKind() == IROperKind.ALL ) {
				return true;
			} else {
				for( int ni = 0; ni < comps.size(); ni++ ) {
					if( ((IRName)comps.get(ni)).getName().equalsIgnoreCase(comp.getName()) ) {
						return true;
					}
				}
			}
			return false;
		}
		public IREntity getEntity() {
			return entity;
		}
		public void setEntity(IREntity entity) {
			this.entity = entity;
		}
		public Token getArch() {
			return arch;
		}
		public void setArch(Token arch) {
			this.arch = arch;
		}
		public ArrayList<IROper> getComps() {
			return comps;
		}
		public Token getCompType() {
			return compType;
		}
		
	}
	
	/*
	protected ArrayList<IRComponentInstance> getComponents( ArrayList<IROper> comps, Token compType ) {
		ArrayList<IRComponentInstance> res = new ArrayList<IRComponentInstance>();
		IRComponentInstance[] all = ((IRComponentInstanceHolder)peek()).getComponentInstances();
		if( comps.size() == 1 && comps.get(0).getKind() == IROperKind.OTHERS ) {
			err.unexpected(comps.get(0));
		} else if( comps.size() == 1 && comps.get(0).getKind() == IROperKind.ALL ) {
			for( int i = 0; i < all.length; i++ ) {
				IRComponentInstance cur = all[i];
				if( cur.getComponentType().equalsIgnoreCase(compType.image) ) {
					res.add(cur);
				}
			}
		} else {
			for( int ni = 0; ni < comps.size(); ni++ ) {
				for( int ai = 0; ai < all.length; ai++ ) {
					if( all[ai].getName().equalsIgnoreCase( ((IRName)comps.get(ni)).getName() )) {
						IRComponentInstance cur = all[ai];
						if( cur.getComponentType().equalsIgnoreCase(compType.image) ) {
							res.add(cur);
						} else {
							err.incorrentComponent( cur, compType.image );
						}
						break;
					}
				}
			}
		}
		return res;
	}
	*/
	
	protected ImplementationRule createRule( ArrayList<IROper> comps, Token compType ) {
		ImplementationRule res = new ImplementationRule(comps, compType);
		if( !(peek() instanceof IRComponentInstanceHolder) ) {
			// TODO supports global configurations
			if( peek() instanceof IRDesignFile || peek() instanceof IRContext ) return res;
			err.cantAdd(begin(compType), peek(), compType);
		} else {
			((IRComponentInstanceHolder)peek()).addImplementationRule(res);
		}
		return res;
	}
	
	protected void setImplementation( IRComponentInstance comp ) {
		ArrayList<ImplementationRule> rules = ((IRComponentInstanceHolder)peek()).getImplementationRules();
		ArrayList<ImplementationRule> conformed = new ArrayList<ImplementationRule>();
		for( ImplementationRule cur : rules ) {
			if( cur.isComponentConformes(comp) ) {
				conformed.add(cur);
			}
		}
		ImplementationRule rule;
		if( conformed.size() < 1 ) {
			return;
		} else if( conformed.size() > 1 ) {
			err.ambiguousImplementation( comp, conformed.get(0), conformed.get(1) );
			rule = conformed.get(0);
		} else {
			rule = conformed.get(0);
		}
		if( rule.entity == null ) return;
		IRArchitecture a = rule.entity.getArchitecture(rule.arch!=null?rule.arch.image:null);
		if( a == null ) {
			err.undefinedNoThrow(begin(rule.arch), rule.arch!=null?rule.arch.image:"<default_architecture");
		}
		comp.setEntityImplementation(rule.getEntity());
	}
	
	protected IRType getTypeInStack( String name ) {
		if( name.equals("st_rec1") ) {
			int a = 0;
			a++;
		}
		IRTypeHolder holder = null;
		if( stack.size() > 0 ) {
			for( int i = stack.size() - 1; i >= 0; i-- ) {
				IRElement el = stack.elementAt(i);
				if( el instanceof IRTypeHolder ) {
					holder = (IRTypeHolder) el;
					IRType res = holder.getType(name);
					if( res != null ) return res;
				}
			}
		}
		return null;
	}
	
	protected IRTypePhysical getPhysicalTypeByUnits( TextCoord coord, String units ) {
		IRNamedElement el = resolve(units, false);
		if( el != null && el instanceof IRPhysicalUnits ) {
			IRPhysicalUnits u = (IRPhysicalUnits) el;
			return u.getType();
		} else {
			err.invalidPhysicalUnits(coord, units);
			return null;
		}
	}
	
//	protected IRConst createBitStringConst(String str) {
//		str = str.toLowerCase();
//		int radix;
//		if( str.startsWith("x") ) {
//			radix = 16;
//			str = str.substring(1);
//		} else {
//			throw new RuntimeException("can't convert " + str);
//		}
//		int value = Integer.parseInt(str.substring(1, str.length()-1), radix);
//		return new IRConst(new IRTypeInteger(currentPackage, "integer"), IRTypeInteger.createConstant(value).getConstant() );
//	}
	
	protected void add( IREnumValue value ) {
		IREnumHolder holder = null;
		if( stack.size() > 0 ) {
			for( int i = stack.size() - 1; i >= 0; i-- ) {
				IRElement el = stack.elementAt(i);
				if( el instanceof IREnumHolder ) {
					holder = (IREnumHolder) el;
					break;
				}
			}
		}
		if( holder == null ) {
			err.cantAdd( stack.peek(), value );
		} else {
			holder.add(value);
		}

	}
	
	protected void add( IRArchitecture arch ) {
		archs.add(arch);
	}
	
	protected void generatePorts(IdentifierList list, IRDirection dir, IRType type, IROper init) {
		IRPortHolder holder = (IRPortHolder) peek();
		for( int i = 0; i < list.list.size(); i++ ) {
			IRPort port = new IRPort(stack.peek(), list.list.get(i).image, type, dir, init);
			mark( port, list.list.get(i) );
			holder.add( port );
		}
	}

	protected void generateVars(IdentifierList list, IRDirection dir, IRType type, IROper init, int kind) {
		if( kind == IFACE_GENERIC ) {
			IRGenericHolder holder = (IRGenericHolder) peek();
			for( int i = 0; i < list.list.size(); i++ ) {
				IRGeneric gen = new IRGeneric(stack.peek(), list.list.get(i).image, type, init);
				mark( gen, list.list.get(i) );
				processGeneric(gen);
				holder.add( gen );
			}
		} else {
			IRVarHolder holder = (IRVarHolder) peek();
			for( int i = 0; i < list.list.size(); i++ ) {
				IRVariable var = new IRVariable((IRVarHolder) stack.peek(), list.list.get(i).image, type, dir, init, false);
				mark( var, list.list.get(i) );
				holder.add( var );
			}
		}
	}

	protected void generateConstants(IdentifierList list, IRType type, IROper init) {
		if( !(peek() instanceof IRConstantHolder) ) return;
		IRConstantHolder holder = (IRConstantHolder) peek();
//		IRConst cnst = IRConst.getConstantValue(init, err);
//		if( cnst == null ) {
//			err.constantExpressionRequired(init);
//		}
		for( int i = 0; i < list.list.size(); i++ ) {
			IRConstant cur = new IRConstant(stack.peek(), list.list.get(i).image, type, init);
			mark( cur, list.list.get(i) );
			holder.add( cur );
		}
	}

	protected IRTypeEnum createEnum( String name ) {
//		if( name.equalsIgnoreCase(IRTypeStdLogic.std_logic.getName()) ) {
//			return IRTypeStdLogic.std_logic;
//		} else if( name.equalsIgnoreCase(IRTypeStdLogic.std_ulogic.getName()) ) { 
//			return IRTypeStdLogic.std_ulogic;
//		} else {
			return new IRTypeEnum(currentPackage, name);
//		}
	}
	
	protected IRNamedElement resolveUseTarget( IROper op ) {
		if( op.toString().equalsIgnoreCase("WORK.STANDARD_TYPES") ) {
			int a = 0;
			a++;
		}
		if( op instanceof IRName ) {
			IRName name = (IRName) op;
			IRNamedElement el = df.getLibrary().getElement(name.getName());
			return el;
		} else if( op.getChild(0).getChildNum() > 0 ) {
			IRName libName = (IRName) op.getChild(0).getChild(0);
			IRName packageName = (IRName) op.getChild(0).getChild(1);
			Library lib = env.getLibrary(libName.getName());
			if( lib == null ) {
				err.undefinedNoThrow(begin(), libName.getName());
				return null;
			}
			IRNamedElement pack = lib.getElement(packageName.getName());
			if( pack == null ) {
				IRNamedElement[] els = lib.getElements();
				for( int i = 0; i < els.length; i++ ) {
					System.out.print( els[i] + ", " );
				}
			}
			return pack;
		} else {
			IRName p1 = (IRName) op.getChild(0);
			Library lib = env.getLibrary(p1.getName());
			if( lib == null ) {
				IRNamedElement pack = env.getLibrary("work").getElement(p1.getName());
				if( pack != null ) {
					if( pack instanceof IRPackage ) {
						IRPackage p = (IRPackage) pack;
						if( op.getChild(1) instanceof IRAll ) {
							return new IRUseAllObjects(p);
						}
						IRName p2 = (IRName) op.getChild(1);
						IRNamedElement res = p.resolve(p2.getName());
						if( res != null ) return res;
						err.undefinedNoThrow(p2.getBegin(), p2.getName());
						return null;
					} else {
						err.packageOrLibraryExpected(p1.getBegin(), p1);
						return null;
					}
				} else {
					err.undefinedNoThrow(begin(), p1.getName());
					return null;
				}
			}
			if( op.getChild(1) instanceof IRAll ) {
				return new IRUseAllObjects(lib);
			}
			IRName p2 = (IRName) op.getChild(1);
			IRNamedElement el = lib.getElement(p2.getName());
			return el;
		}
	}

	protected void use( IROper op ) {
		IRNamedElement el = null;
		if( filename.endsWith("misc.vhd") ) {
			int a = 0;
			a++;
		}
		if( op.getKind() == IROperKind.DOT ) {
			el = resolveUseTarget(op);
			if( el == null ) {
				err.undefinedNoThrow(op.getBegin(), op.toString());
			}
			IRDesignFile df = (IRDesignFile) stack.get(0);
			if( op.getChild(0).getChildNum() == 0 ) {
				df.use(el);
			} else if( op.getChild(1) instanceof IRName ) {
				IRName name = (IRName) op.getChild(1);
//				if( el instanceof IRPackage ) {
//					throw new RuntimeException();
//				}
				df.use((IRPackage) el, name.getName());
			} else if( op.getChild(1) instanceof IRAll ) {
				el = resolveUseTarget(op.getChild(0));
				df.useAll(el);
			} else {
				throw new RuntimeException();
			}
		} else {
			throw new RuntimeException();
		}
	}
	
	protected IRArrayIndex getNextArrayIndex( IRArrayIndex index, IROper referingOper ) {
		IRTypeArray arr = index.getArrayType();
		IRArrayIndex[] inds = arr.getIndexes();
		if( inds.length <= index.getIndexInArray() ) {
			err.incorrectRange(referingOper, index);
			return null;
		}
		return inds[index.getIndexInArray()+1];
	}
	
	static int autoIntIndex;
	static int autoRealIndex;
	
	protected Object setRangeContraint( Object element, IROper op1, IROper isDownTo, IROper op2 ) {
		IRConst cnst = IRConst.getConstantValue(op1, err);
		if( cnst != null ) op1 = cnst;
		cnst = IRConst.getConstantValue(op2, err);
		if( cnst != null ) op2 = cnst;
		if( element == null ) {
			// по ходу объявляется новый тип
			if( op1.getType().isInt() && op2.getType().isInt() ) {
				element = new IRTypeInteger(currentPackage, false/*currentPackage == null || !currentPackage.isStandard()*/ ? ("AUTOINTEGER" + autoIntIndex) : null);
				autoIntIndex++;
			} else if( op1.getType().isReal() && op2.getType().isReal() ) {
				element = new IRTypeReal(currentPackage, false/*currentPackage == null || !currentPackage.isStandard()*/ ? ("AUTOREAL" + autoRealIndex) : null);
				autoRealIndex++;
			} else {
				throw new RuntimeException();
			}
		}
		if( element instanceof IRTypeArray ) {
			IRTypeArray arr = (IRTypeArray) element;
			IRArrayIndex[] inds = arr.getIndexes();
			if( inds.length != 1 ) {
				int a = 0;
				a++;
			}
			IRArrayIndex index = inds[arr._currentIndex];
			// TODO сделать проверку адекватности новых границ
		  	if(isDownTo.isConst()) {
		  		if(isDownTo.getBooleanValue()) {
			  		index.getRange().setRangeHigh( op1 );
			  		index.getRange().setRangeLow( op2 );
			  	} else {
			  		index.getRange().setRangeHigh( op2 );
			  		index.getRange().setRangeLow( op1 );
			  	}
		  	} else {
		  		index.getRange().setRangeLow(op1);
		  		index.getRange().setRangeHigh(op2);
//		  		index.getRange().setLeftRight(true);
		  	}
		  	index.getRange().setDownTo(isDownTo);
		  	return index;
		} else if( element instanceof IRArrayIndex ) {
			IRArrayIndex index = (IRArrayIndex) element; 
			index = getNextArrayIndex(index, op2);
			if( index == null ) return element;
			// TODO сделать проверку адекватности новых границ
		  	if(isDownTo.getBooleanValue()) {
		  		index.getRange().setRangeHigh( op1 );
		  		index.getRange().setRangeLow( op2 );
		  	} else {
		  		index.getRange().setRangeHigh( op2 );
		  		index.getRange().setRangeLow( op1 );
		  	}
		  	return index;
		} else if( element instanceof IRangedElement ) {
			// TODO сделать проверку адекватности новых границ
			IRangedElement ranged = (IRangedElement) element;
		  	if(isDownTo.getBooleanValue()) {
		  		ranged.getRange().setRangeHigh( op1 );
		  		ranged.getRange().setRangeLow( op2 );
		  	} else {
		  		ranged.getRange().setRangeHigh( op2 );
		  		ranged.getRange().setRangeLow( op1 );
		  	}
		  	ranged.getRange().setDownTo(isDownTo);
		  	return element;
		} else {
			throw new RuntimeException();
		}
	}
	
	protected Object addRange( Object element, boolean isReversed, IROper op1, IROper isDownTo, IROper op2, 
			IRType indexType, boolean isConstraint, boolean isDeclaration ) {
		if( isReversed ) {
			return addRange(element, op2, isDownTo, op1, indexType, isConstraint, isDeclaration);
		} else {
			return addRange(element, op1, isDownTo, op2, indexType, isConstraint, isDeclaration);
		}
	}
	
	protected Object addRange( Object element, IROper op1, IROper isDownTo, IROper op2, 
			IRType indexType, boolean isConstraint, boolean isDeclaration ) {
		IROper v1, v2;

		try {
			if( isConstraint && element instanceof IRType ) {
				IRType type = (IRType) element;
				if( type.isPhysical() ) {
					if( isDeclaration ) {
						op1.setTypeIfNull(IRTypeInteger.TYPE);
						op2.setTypeIfNull(IRTypeInteger.TYPE);
					} else {
						op1.setTypeIfNull(type);
						op2.setTypeIfNull(type);
					}
				} else if( type.isScalar() /*&& !type.isPhysical()*/ ) {
					op1.setTypeIfNull(type);
					op2.setTypeIfNull(type);
				} else if( type instanceof IRTypeArray ) {
					IRTypeArray arr = (IRTypeArray) type;
					IRArrayIndex ind = arr.getIndexes()[arr._currentIndex];
					op1.setTypeIfNull(ind.getIndexType());
					op2.setTypeIfNull(ind.getIndexType());
				} else {
					op1.reportError("unexpected index");
				}
			}
			setTempParent(op1); setTempParent(op2);
			op1.semanticCheck(err);
			op2.semanticCheck(err);
		} catch( CompilerError e ){return null;};
		
		if( indexType == null ) {
			indexType = op1.getType();
		}
		if( indexType == null ) {
			indexType = op2.getType();
		}
		if( indexType == null ) {
			if( element instanceof IRangedElement && op1 != null && op2 != null && isDownTo != null ) {
				IRangedElement r = ((IRangedElement)element);
				r.getRange().setRangeHigh(op1);
				r.getRange().setDownTo(isDownTo);
				r.getRange().setRangeLow(op2);
			} else {
//				op1.reportError();
			}
		}
		
		v1 = IRConst.getConstantValue(op1, err, isDeclaration);
		v2 = IRConst.getConstantValue(op2, err, isDeclaration);
		
		if( v1 == null ) v1 = op1;
		if( v2 == null ) v2 = op2;
		
		if( isConstraint )
			return setRangeContraint(element, v1, isDownTo, v2);
		
		if( element instanceof IRTypeArray ) {
			IRTypeArray type = (IRTypeArray) element;
		  	IRArrayIndex index = new IRArrayIndex(currentPackage, type.getName());
		  	if(isDownTo.isConst()) {
		  		if(isDownTo.getBooleanValue()) {
			  		index.getRange().setRangeHigh( v1 );
			  		index.getRange().setRangeLow( v2 );
			  	} else {
			  		index.getRange().setRangeHigh( v2 );
			  		index.getRange().setRangeLow( v1 );
			  	}
		  	} else {
		  		index.getRange().setRangeLow(v1);
		  		index.getRange().setRangeHigh(v2);
//		  		index.getRange().setLeftRight(true);
		  	}
		  	index.getRange().setDownTo(isDownTo);
		  	if( indexType == null ) {
		  		try {
					v1.semanticCheck(err);
				} catch (CompilerError e) {
//					e.printStackTrace();
				}
		  		try {
					v2.semanticCheck(err);
				} catch (CompilerError e) {
//					e.printStackTrace();
				}
				if( v1.getType() == null || v2.getType() == null ) {
					v1.reportError();
				}
				if( !v1.getType().isSameBase(v2.getType()) ) {
					err.incompatibleTypesNoEx(v1.getType(), v2.getType(), v1);
				}
				indexType = v1.getType();
		  	}
		  	index.setIndexType(indexType);
		  	type.add(index);
		} else if( element instanceof IRangedElement ) {
			IRangedElement iranged = (IRangedElement) element;
		  	if(isDownTo.isConst()) {
		  		if(isDownTo.getBooleanValue()) {
		  			iranged.getRange().setRangeHigh( v1 );
		  			iranged.getRange().setRangeLow( v2 );
			  	} else {
			  		iranged.getRange().setRangeHigh( v2 );
			  		iranged.getRange().setRangeLow( v1 );
			  	}
		  	} else {
		  		iranged.getRange().setRangeLow(v1);
		  		iranged.getRange().setRangeHigh(v2);
//		  		iranged.getRange().setLeftRight(true);
		  	}
		  	iranged.getRange().setDownTo(isDownTo);
		} else if( element instanceof IROper ) {
			IROper op = (IROper) element;
			if( isDownTo.getBooleanValue() ) {
				op = new IROperRange(op, v2, isDownTo, v1 );
			} else {
				op = new IROperRange(op, v1, isDownTo, v2 );
			}
			mark(op);
			return op;
		} else {
			throw new RuntimeException();
		}
		return element;
	}
	
	protected Object addRange( Object element, IROper op1, IROper isDownTo, IROper op2, boolean isConstraint, boolean isDeclaration ) {
//	  	SimValue v1 = getConstantValue(op1).getConstant();
//	  	SimValue v2 = getConstantValue(op2).getConstant();
//	  	addRange( element, v1, isDownTo, v2, null );
		return addRange( element, op1, isDownTo, op2, null, isConstraint, isDeclaration );
	}
	
	protected Object addRange( Object element, IRangedElement ranged, boolean isConstraint, boolean isDeclaration ) {
		IRConst isDownTo = IRConst.getConstantValue(ranged.getRange().isDownTo(), err);
		if( isDownTo != null && isDownTo.getBooleanValue() ) {
			return addRange( element, ranged.getRange().getRangeHigh(), ranged.getRange().isDownTo(), ranged.getRange().getRangeLow(), null, isConstraint, isDeclaration );
		} else {
			return addRange( element, ranged.getRange().getRangeLow(), ranged.getRange().isDownTo(), ranged.getRange().getRangeHigh(), null, isConstraint, isDeclaration );
		}
	}
	
	protected Object addRange( Object element, IRType type, boolean isConstraint, boolean isDeclaration ) {
		return addRange(element, false, type, isConstraint, isDeclaration);
	}
	protected Object addRange( Object element, boolean isReversed, IRType type, boolean isConstraint, boolean isDeclaration ) {
		if( type instanceof IRTypeInteger ) {
			IRTypeInteger itype = (IRTypeInteger) type;
			if( itype.getRange().isDownTo().getBooleanValue() ) {
				return addRange( element, isReversed, itype.getRange().getRangeHigh(), itype.getRange().isDownTo(), itype.getRange().getRangeLow(), type, isConstraint, isDeclaration );
			} else {
				return addRange( element, isReversed, itype.getRange().getRangeLow(), itype.getRange().isDownTo(), itype.getRange().getRangeHigh(), type, isConstraint, isDeclaration );
			}
		} else if( type instanceof IRTypeEnum ) {
			IRTypeEnum en = (IRTypeEnum) type;
			return addRange( element, isReversed, en.getRange().getRangeLow(), getBooleanConst(false), en.getRange().getRangeHigh(), type, isConstraint, isDeclaration );
		} else if( type instanceof IRTypeArray ) {
			IRTypeArray arr = (IRTypeArray) type;
			IRArrayIndex ind = arr.getFirstIndex();
			if( ind.getRange().isDownTo().getBooleanValue() ) {
				return addRange( element, isReversed, ind.getRange().getRangeHigh(), ind.getRange().isDownTo(), ind.getRange().getRangeLow(), type, isConstraint, isDeclaration );
			} else {
				return addRange( element, isReversed, ind.getRange().getRangeLow(), ind.getRange().isDownTo(), ind.getRange().getRangeHigh(), type, isConstraint, isDeclaration );
			}
		} else if( type instanceof IRArrayIndex ) {
			IRArrayIndex ind = (IRArrayIndex) type;
			if( ind.getRange().isDownTo().getBooleanValue() ) {
				return addRange( element, isReversed, ind.getRange().getRangeHigh(), ind.getRange().isDownTo(), ind.getRange().getRangeLow(), type, isConstraint, isDeclaration );
			} else {
				return addRange( element, isReversed, ind.getRange().getRangeLow(), ind.getRange().isDownTo(), ind.getRange().getRangeHigh(), type, isConstraint, isDeclaration );
			}
		} else {
			throw new RuntimeException();
		}
	}
	
	protected Object addRangeAttribute( Object element, IROper op, boolean isConstraint, boolean isDeclaration ) {
		if( op.getBegin() != null && op.getBegin().getFile().endsWith("aggregates.vhd") ) {
			int a = 0;
			a++;
		}
		if( op instanceof IRAttrib && op.getChild(0) instanceof IRConst && op.getChild(0).getType().isType() ) {
			SimValue v = ((IRConst)op.getChild(0)).getConstant();
			IRType type = ((TypeValue)v).getValue();
			IRAttrib att = (IRAttrib) op;
			boolean isReversed;
			if( att.getAttributeName().equalsIgnoreCase("RANGE") ) {
				isReversed = false;
			} else if( att.getAttributeName().equalsIgnoreCase("REVERSE_RANGE") ) {
				isReversed = true;
			} else {
				throw new RuntimeException(att.getAttributeName());
			}
			return addRange( element, isReversed, type, isConstraint, isDeclaration );
		}
		SimValue opValue = getAttributeValue(op);
		if( op instanceof IRAttrib && ((IRAttrib)op).getValue() != null && ((IRAttrib)op).getValue() instanceof IROperRange && element instanceof IRangedElement ) {
			((IRangedElement)element).getRange().assignFrom((IROperRange) ((IRAttrib)op).getValue());
			return element;
		} else if( op instanceof IRAttrib && ((IRAttrib)op).getValue() != null && ((IRAttrib)op).getValue() instanceof IROperRange && element instanceof IRTypeArray ) {
			((IRTypeArray)element).getFirstIndex().getRange().assignFrom((IROperRange) ((IRAttrib)op).getValue());
			return element;
		} else if( opValue != null && opValue instanceof RangeValue ) {
			if( element instanceof IRLoopVariable ) {
				IRLoopVariable var = (IRLoopVariable) element;
				IRangedElement ranged = (IRangedElement) getAttributeValue(op);
				if( ranged != null ) {
					return addRange(element, ranged, isConstraint, isDeclaration);
				} else {
					throw new RuntimeException();
//					var.setRuntimeRange(op);
//					return element;
				}
			} else if( element instanceof IRTypeArray ) {
				IRangedElement ranged = (IRangedElement) getAttributeValue(op);
				return addRange(element, ranged, isConstraint, isDeclaration);
			} else if( element instanceof IRangedElement ) {
				IRangedElement ranged = (IRangedElement) getAttributeValue(op);
				return addRange(element, ranged, isConstraint, isDeclaration);
			} else if( element instanceof IROper ) {
				IRangedElement ranged = (IRangedElement) getAttributeValue(op);
				return addRange(element, ranged, isConstraint, isDeclaration);
			} else {
				throw new RuntimeException();
			}
			
		} else if( op.getType() != null && op.getType().isDescrete() ) {
			if( element instanceof IROper ) {
				IROper cur = (IROper) element;
				try {
					setTempParent(cur);
					cur.semanticCheck(err);
				} catch (CompilerError e) {
					e.printStackTrace();
				}
				IROper res;
				if( op.getType().isDescrete() ) {
					if( opValue != null ) {
						res = new IROperIndex( (IROper) element, new IRConst(opValue) );
					} else {
						res = new IROperIndex( (IROper) element, op );
					}
					if(((IROper) element).getType() != null ) {
						res.setType( getIndirectedType( ((IROper) element).getType()) );
					}
				} else if( op.getType() instanceof IRTypeRange ) {
					RangeValue range = (RangeValue) ((IRConst)op).getConstant();
					res = new IROperRange( (IROper) element, range.getRange().getRangeLow(), range.getRange().isDownTo(), range.getRange().getRangeHigh() );
					mark(op);
				} else {
					throw new RuntimeException();
				}
				return res;
			}
			op.reportError();
		}
		
		op.reportError();
		return null;
	}
	
	protected void addUnconstrainedRange( IRTypeArray arr, IRType indexType ) {
		IRangedElement el = (IRangedElement) indexType;
		arr.add( new IRArrayIndex(currentPackage, arr.getName(), null, null, el.getRange().isDownTo(), indexType) );
	}
	
	protected IRType getIndirectedType( IRType type ) {
		if( type instanceof IRTypeArray ) {
			IRTypeArray arr = (IRTypeArray) type;
			IRType res = arr.getFirstIndex();
			if( res == arr.getLastIndex() ) {
				return arr.getElementType();
			}
			return res;
		} else if( type instanceof IRArrayIndex ) {
			IRArrayIndex index = (IRArrayIndex) type;
			IRType res = index.getNextIndex();
			if( res == index.getArrayType().getLastIndex() ) {
				return index.getArrayType().getElementType();
			}
			return res;
		} else {
			//err.arrayExpected(child)
			throw new RuntimeException();
		}
	}
	
	protected IRArrayIndex getNextIndex( IRType type ) {
		if( type instanceof IRTypeArray ) {
			IRTypeArray arr = (IRTypeArray) type;
			IRArrayIndex res = arr.getFirstIndex();
			return res;
		} else if( type instanceof IRArrayIndex ) {
			IRArrayIndex index = (IRArrayIndex) type;
			IRArrayIndex res = index.getNextIndex();
			return res;
		} else {
			//err.arrayExpected(child)
			throw new RuntimeException();
		}
	}
	
	protected void setTempParent(IRElement el) {
		el.setParent(stack.peek());
	}
	
	protected IROper createIndex( IROper expr, IROper index ) {
		try {
			// case of type'range or type'reverse_range
			IROper ch1 = index.getChildNum() > 0 ? index.getChild(0) : null;
			setTempParent(index);
			index.semanticCheck(err);
			if( index.isRangeOrReverse() && ch1 != null && ch1.getType() != null && ch1.getType().isType() ) {
				index.semanticCheck(err);
				IRAttrib att = (IRAttrib) index;
				IRConst range = (IRConst) att.getValue();
				IRangedElement re = (IRangedElement) range.getConstant();
				if( re.getRange().isConst() ) {
					return new IROperRange(expr, re.getRange().getRangeLow(), re.getRange().isDownTo(), re.getRange().getRangeHigh());
				} else {
					return new IROperRange(expr, re.getRangeType(), att.isReverseRangeAttrib());
				}
			} else if( index.isRangeOrReverse() && ch1 != null && ch1.getType() != null && ch1.getType().isArray() ) {
				index.semanticCheck(err);
				IRAttrib att = (IRAttrib) index;
				IRTypeArray arr = IRTypeArray.getArray( ch1.getType(), err, ch1 );
				IRArrayIndex ind = arr.getFirstIndex();
				if( ind.getRange().isConst() ) {
					return new IROperRange(expr, ind.getRange().getRangeLow(), ind.getRange().isDownTo(), ind.getRange().getRangeHigh());
				} else {
					IROperRange res = new IROperRange(ch1, ind, att.isReverseRangeAttrib());
					res.setChild(0, expr);
					return res;
				}
			}
				
			
			setTempParent(expr);
			expr.semanticCheck(err);
			if( expr.getType() == null ) {
				err.arrayExpected(expr);
				return new IROperError(expr.getBegin());
			}
			if (index == null) System.out.println("index is null");
			if (expr == null) System.out.println("expr is null");
			if (expr.getType() == null) System.out.println("expr.getType() is null, expr is "+expr+" at "+expr.getBegin());
			if( !expr.getType().isType() && index.getType() == null ) {
				if( expr.getType().isArray() ) {
					index.setType( getNextIndex(expr.getType()).getIndexType() );
				} else {
						err.arrayExpected(expr);
					return expr;
				}
			}
			setTempParent(index);
			index.semanticCheck(err);
		} catch (CompilerError e) {
			e.printStackTrace();
		}
		if( index.getType().isDescrete() ) {
			if( !expr.getType().isArray() ) {
				err.arrayExpected(expr);
				return expr;
			}
			IRType t = getIndirectedType(expr.getType());
//			if( expr.getType() instanceof IRTypeArray ) {
//				t = ((IRTypeArray)expr.getType()).getFirstIndex();
//				if( t == ((IRArrayIndex)t).getArrayType().getLastIndex() ) {
//					t = ((IRArrayIndex)t).getArrayType().getElementType();
//				}
//			} else if( expr.getType() instanceof IRArrayIndex ) {
//				IRArrayIndex curIndex = ((IRArrayIndex)expr.getType());
//				t = curIndex.getNextIndex();
//				if( t == curIndex.getArrayType().getLastIndex() ) {
//					t = curIndex.getArrayType().getElementType();
//				}
//			} else {
//				throw new RuntimeException();
//			}
			IROper res = new IROperIndex(expr, index);
			res.setType(t);
			return res;
		} else if( index.getType() instanceof IRTypeRange ) {
			IRAttrib att = (IRAttrib) index;
			RangeValue range = (RangeValue) ((IRConst)att.getValue()).getConstant();
			return mark( new IROperRange( expr, range.getRange().getRangeLow(), range.getRange().isDownTo(), range.getRange().getRangeHigh() ) );
		} else if( expr.getType() instanceof IRArrayIndex ){
//			IRArrayIndex t = (IRArrayIndex) expr.getType();
			IROper res = new IROperIndex( expr, index );
//			if( t.getNextIndex() != null ) {
//				if( t.getNextIndex() == t.getArrayType().getLastIndex() ) {
//					res.setType(t.getArrayType().getElementType());
//				} else {
//					res.setType(t.getNextIndex());
//				}
//			} else {
//				res.setType(t.getArrayType().getElementType());
//			}
			res.setType( getIndirectedType(expr.getType()) );
			return res;
			
		} else if( expr.getType().isType() ){
			IRConst cnst = (IRConst) expr;
			TypeValue v = (TypeValue) cnst.getConstant();
			return new IRTypeCast( v.getValue(), index );
		} else if( index.getType().isType() ) {
			TypeValue tv = (TypeValue) ((IRConst)index).getConstant();
			IRangedElement el = null;
			if( tv.getValue() instanceof IRangedElement ) {
				el = (IRangedElement) tv.getValue();
			} else if( tv.getValue() instanceof IRTypeArray ) {
				el = ((IRTypeArray)tv.getValue()).getFirstIndex();
			}
			if( el != null ) {
				IROperRange res = new IROperRange(expr);
				res.setRangeLow(el.getRange().getRangeLow());
				res.setRangeHigh(el.getRange().getRangeHigh());
				res.setDownTo(el.getRange().isDownTo());
				return res;
			} else {
				throw new RuntimeException(expr.getBegin() + "expr = " + expr + ", index = " + index);
			}
		} else {
			throw new RuntimeException(expr.getBegin() + "expr = " + expr + ", index = " + index);
		}
	}
	
	protected void resetArrayIndexCond( Object res ) {
	  	if( res instanceof IRTypeArray )
	  	{
	  		IRTypeArray arr = (IRTypeArray) res;
	  		arr._currentIndex = 0;
	  	}
	}
	
	protected void advanceArrayIndexCond( Object res ) {
	  	if( res instanceof IRTypeArray )
	  	{
	  		IRTypeArray arr = (IRTypeArray) res;
	  		arr._currentIndex++;
	  	}
	}
	
	public void libraryClosure() {
		df.libraryClosure();
	}
	
	public void startOfPrimaryUnit() {
		df.startOfPrimaryUnit();
		stack.push(df.getContext());
	}
	
	public void endOfPrimaryUnit() {
		df.endOfPrimaryUnit();
		stack.pop();
	}
	
	public void startOfSecondaryUnit() {
		stack.push(df.getContext());
	}
	
	public void endOfSecondaryUnit() {
		stack.pop();
	}
	
	protected int delimIndex(String src) {
		int i1 = src.indexOf('#');
		if( i1 < 0 ) i1 = Integer.MAX_VALUE;
		int i2 = src.indexOf(':');
		if( i2 < 0 ) i2 = Integer.MAX_VALUE;
		return Math.min(i1, i2);
	}
	
	// base # based_integer [ . based_integer ] # [ exponent ]
	IRConst createBasedConstant( Token t ) {
		if( t.image.equalsIgnoreCase("16:9ABCDEF:") ) {
			int a = 0;
			a++;
		}
		int index;
		StringBuffer val = new StringBuffer(t.image.toLowerCase());
		while( (index = val.indexOf("_")) >= 0 ) {
			val.deleteCharAt(index);
		}
		String src = val.toString();
		index = delimIndex(src);
		String baseStr = src.substring(0, index);
		src = src.substring(index+1);
		int base = Integer.parseInt(baseStr);
		
		index = delimIndex(src);
		String expString = src.substring(index+1 < src.length() ? index+1 : src.length());
		if( expString.length() > 0 && expString.charAt(0) == 'e' ) {
			expString = expString.substring(1);
		}
		src = src.substring(0, index);
		int exp = expString.length() > 0 ? Integer.parseInt(expString, base) : 0;
		
		String partialStr = null;
		index = src.indexOf('.');
		if( index >= 0 ) {
			partialStr = src.substring(index+1);
			src = src.substring(0, index);
		}
		
		if( partialStr != null ) {
			double main = Long.parseLong(src + partialStr, base);
			// correcting exponent
			exp -= partialStr.length();
			main *= Math.pow(base, exp);
			return IRTypeReal.createConstant(main);
		} else {
			BigInteger main;
			try {
				main = new BigInteger(src, base);
			} catch( RuntimeException e ) {
				err.valueOutOfRange(begin(t), t.image);
				return IRTypeInteger.createConstant(1);
			}
			if( exp < 0 ) {
				err.valueOutOfRange(begin(t), t.image);
				return IRTypeInteger.createConstant(1);
			}
			BigInteger mul = BigInteger.valueOf(base);
			mul = mul.pow(exp);
			main = main.multiply(mul);
			if( main.compareTo(BigInteger.valueOf(Integer.MAX_VALUE)) > 0 ) {
				err.valueOutOfRange(begin(t), t.image);
				return IRTypeInteger.createConstant(1);
			}
			return IRTypeInteger.createConstant(main.intValue());
		}
	}
	
	IRTypeAny getTypeAny() {
		if( IRTypeAny.TYPE == null ) {
			IRTypeAny.TYPE = new IRTypeAny(currentPackage);
		}
		return IRTypeAny.TYPE;
	}
	
	IRSubProgram processSubProgram( IRSubProgram subProgram ) {
		if( subProgram.getCanonicalName().equalsIgnoreCase("\"-\"(integer,SIGNED)") ) {
			int a = 0;
			a++;
		}
		if( subProgram.getName().equalsIgnoreCase("Proc") ) {
			int a = 0;
			a++;
		}
		if( stack.peek() instanceof ILocalResolver )
		{
			ILocalResolver resolver = (ILocalResolver) stack.peek();
			IRSubProgram old = (IRSubProgram) resolver.localResolve(subProgram.getCanonicalName());
			if( old != null ) {
				old.setParent((IRElement) resolver);
				return old;
			}
		}
		if( stack.peek() instanceof IRPackage.Body ) {
			IRPackage.Body body = (Body) stack.peek();
			IRPackage.Declaration decl = (Declaration) stack.get(stack.size()-2);
			IRSubProgram old = (IRSubProgram) decl.localResolve(subProgram.getCanonicalName());
			if( old == null ) return subProgram;
			old.setParent(body);
			return old;
		} else if( stack.peek() instanceof IRPackage.Declaration ){
			return subProgram;
		} else if( stack.peek() instanceof IRArchitecture ) {
			return subProgram;
		} else if( stack.peek() instanceof IRBlock ) {
			return subProgram;
		} else if( stack.peek() instanceof IRProcess ) {
			return subProgram;
		} else if( stack.peek() instanceof IREntity ) {
			return subProgram;
		} else if( stack.peek() instanceof IRSubProgram ) {
			return subProgram;
		} else {
			throw new RuntimeException(stack.peek().getClass().getCanonicalName());
		}
	}
	
	IRSubProgram getEnclosingSubprogram() {
		int i = stack.size()-1;
		while( i >= 0 ) {
			if( stack.get(i) instanceof IRSubProgram ) {
				return (IRSubProgram) stack.get(i);
			}
			i--;
		}
		return null;
	}
	
	void ensureLastName( String name ) {
		Token t = getToken(0);
		if( !t.image.equalsIgnoreCase(name) ) {
			err.identifiersDontMatch(begin(t), name, t.image);
		}
	}
	
	void ensureLastName( IRNamedElement el ) {
		ensureLastName(el.getName());
	}
	
	static final IROper boolName = new IRDotOper( new IRDotOper( new IRName("STD"), new IRName("STANDARD") ),  new IRName("BOOLEAN"));
//	static final IRName boolName = new IRName("BOOLEAN");
	IRTypeEnum boolType;
	public IRTypeEnum getBoolean() {
		if( boolType == null ) {
			boolType = (IRTypeEnum) getType(boolName);
		}
		return boolType;
	}
	
	static final IROper bitName = new IRDotOper( new IRDotOper( new IRName("STD"), new IRName("STANDARD") ), new IRName("BIT") );
	IRTypeEnum bitType;
	public IRType getBit() {
		if( bitType == null ) {
			bitType = (IRTypeEnum) getType(bitName);
		}
		return bitType;
	}
	
	static final IROper stringName = new IRDotOper( new IRDotOper( new IRName("STD"), new IRName("STANDARD") ), new IRName("STRING"));
	IRTypeArray stringType;
	public IRTypeArray getStringType() {
		if( stringType == null ) {
			stringType = (IRTypeArray) getType(stringName);
		}
		return stringType;
	}
	
	static final IROper severityName = new IRDotOper( new IRDotOper( new IRName("STD"), new IRName("STANDARD") ), new IRName("SEVERITY_LEVEL") );
	IRTypeEnum severityType;
	public IRTypeEnum getSeverityType() {
		if( severityType == null ) {
			severityType = (IRTypeEnum) getType(severityName);
		}
		return severityType;
	}
	
	static final IROper timeName = new IRDotOper( new IRDotOper( new IRName("STD"), new IRName("STANDARD") ), new IRName("TIME") );
	IRTypePhysical timeType;
	public IRTypePhysical getTimeType() {
		if( timeType == null ) {
			timeType = (IRTypePhysical) getType(timeName);
		}
		return timeType;
	}
	
	public IRConst getBooleanConst(boolean value) {
		IRTypeEnum type = getBoolean();
		return type.getValue(value?1:0).getSimValue();
	}
	
	
	// все что касается текстовых координат
	TextCoord begin() {
		Token t = getToken(1);
		return begin(t);
	}
	
	TextCoord begin(Token t) {
		return new TextCoord(filename, t.beginLine, t.beginColumn);
	}
	
	TextCoord end() {
		Token t = getToken(0);
		return end(t);
	}
	
	TextCoord end(Token t) {
		return new TextCoord(filename, t.endLine, t.endColumn);
	}
	
	FullCoord full() {
		Token t = getToken(0);
		return full(t);
	}
	
	FullCoord full( Token t ) {
		return new FullCoord( begin(t), end(t) );
	}
	
	IROper mark( IROper op ) {
		op.setFull(full());
		return op;
	}
	
	IRNamedElement mark( IRNamedElement el, Token token ) {
		el.setFull(full(token));
		return el;
	}
	
	IROper mark( IROper op, Token token ) {
		op.setFull(full(token));
		return op;
	}
	
	IROper markBegin( IROper op ) {
		op.setBegin( begin() );
		return op;
	}
	
	IROper markEnd( IROper op ) {
		op.setEnd(end());
		return op;
	}
	
	IRNamedElement markBegin( IRNamedElement op ) {
		op.setBegin( begin() );
		return op;
	}
	
	IRNamedElement markEnd( IRNamedElement op ) {
		op.setEnd(end());
		return op;
	}
	
	IRStatement markBegin( IRStatement st ) {
		st.setBegin( begin() );
		return st;
	}
	
	IRStatement markEnd( IRStatement st ) {
		st.setEnd( end() );
		return st;
	}
	
	IRType markBegin( IRType type ) {
		type.setBegin( begin() );
		return type;
	}
	
	IRType markEnd( IRType type ) {
		type.setEnd( end() );
		return type;
	}
	
	void mark( IRNamedElement el ) {
		el.setFull(full());
	}
	
	void mark( TextCoord begin, IRNamedElement el ) {
		el.setFull( new FullCoord(begin, end()) );
	}
	
	void mark( IRNamedElement el, TextCoord end ) {
		el.setFull( new FullCoord(begin(), end) );
	}
	
	void mark( TextCoord begin, IRNamedElement el, TextCoord end ) {
		el.setFull( new FullCoord(begin, end) );
	}
}
