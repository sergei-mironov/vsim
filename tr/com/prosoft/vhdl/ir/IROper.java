package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.Vector;

import com.prosoft.common.FullCoord;
import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.ir.IRArrBound.Bound;
import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.sim.EnumSimValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.TypeValue;

public abstract class IROper extends IRElement implements ICoordinatedElement {
	
	public abstract IROperKind getKind();

	private ArrayList<IROper> children = new ArrayList<IROper>();
//	private IROper parent;
	
	enum TYPE_KNOWLEDGE { FLEX, DEFINED, FIXED };
	private TYPE_KNOWLEDGE knowledge;
	private IRType type;
	private IRType knownType;
	
	// семантическая проверка и выяснение типа
	public abstract void semanticCheck( IRErrorFactory err ) throws CompilerError;
	protected abstract boolean requiresValuesAtChildren();
	public abstract boolean isEqualTo( IROper other );
	public abstract IROper dup();
	
	public void getAccessedObjects( ArrayList<IROper> write, ArrayList<IROper> read, boolean isWriteTarget ) {
		if( this instanceof IObjectElement ) {
			IObjectElement el = (IObjectElement) this;
			if( el.isPrimary() ) {
				if( isWriteTarget ) {
					write.add(this);
				} else {
					read.add(this);
				}
			}
		}
		for( int i = 0; i < getChildNum(); i++ ) {
			getChild(i).getAccessedObjects(write, read, isWriteTarget);
		}
	}
	
	public void checkWrite( IRObjectClass allowed, IRErrorFactory err ) {
		if( this instanceof IObjectElement ) {
			if( ((IObjectElement)this).getObjectClass() != allowed ) {
				if( allowed == IRObjectClass.VARIABLE ) {
					err.variableExpected(this);
				} else if( allowed == IRObjectClass.SIGNAL ){
					err.signalExpected(this);
				} else {
					throw new RuntimeException();
				}
			} else {
				if( ((IObjectElement)this).getObjectClass() == IRObjectClass.VARIABLE ) {
					IRVariable var = (IRVariable) ((IObjectElement)this).getTopmostValueableObject();
					if( var.isParameter() && var.getDirection() == IRDirection.INPUT ) {
						err.cantWrite(this);
					}
				}
			}
		} else if( getKind() == IROperKind.CONCAT ) {
			for( int i = 0; i < getChildNum(); i++ ) {
				getChild(i).checkWrite(allowed, err);
			}
		} else if( getKind() == IROperKind.AGGREG ) {
			for( int i = 0; i < getChildNum(); i++ ) {
				getChild(i).checkWrite(allowed, err);
			}
		} else {
			err.signalExpected(this);
		}
	}
	
	public void exchangeTypesWith(IROper other) {
		IRType t = other.getType();
		other.setType(getType());
		setType(t);
	}
	
	public void checkRead( IRObjectClass allowed, IRErrorFactory err ) {
		if( this instanceof IObjectElement ) {
			IRObjectClass cur = ((IObjectElement)this).getObjectClass(); 
			if( cur != allowed ) {
				if( allowed == IRObjectClass.VARIABLE ) {
					err.variableExpected(this);
				} else if( allowed == IRObjectClass.SIGNAL ){
					err.signalExpected(this);
				} else {
					throw new RuntimeException();
				}
			} else {
				if( ((IObjectElement)this).getObjectClass() == IRObjectClass.VARIABLE ) {
					IRVariable var = (IRVariable) ((IObjectElement)this).getTopmostValueableObject();
					if( var.isParameter() && var.getDirection() == IRDirection.OUTPUT ) {
						err.cantRead(this);
					}
				}
				return;
			}
		} /*else if( getKind() == IROperKind.CONCAT ) {
			for( int i = 0; i < getChildNum(); i++ ) {
				getChild(i).checkWrite(allowed, err);
			}
		} else*/ {
			err.signalExpected(this);
		}
	}
	
	static ArrayList<IROper> dupIROperArray( ArrayList<IROper> source ) {
		ArrayList<IROper> res = new ArrayList<IROper>(source.size());
		for( int i = 0; i < source.size(); i++ ) {
			IROper op = source.get(i);
			if( op != null ) op = op.dup();
			res.add( op );
		}
		return res;
	}
	
	static ArrayList<IRStatement> dupIRStatementArray( ArrayList<IRStatement> source ) {
		ArrayList<IRStatement> res = new ArrayList<IRStatement>(source.size());
		for( int i = 0; i < source.size(); i++ ) {
			IRStatement stat = (IRStatement) source.get(i).dup();
			if( stat != null ) stat = (IRStatement) stat.dup();
			res.add( stat );
		}
		return res;
	}
	
	static IROper[] dupIROperArray( IROper[] source ) {
		IROper[] res = new IROper[source.length];
		for( int i = 0; i < source.length; i++ ) {
			res[i] = source[i].dup();
		}
		return res;
	}
	
	static Vector<IROper> dupIROperVector( Vector<IROper> source ) {
		if( source == null ) return new Vector<IROper>(0);
		Vector<IROper> res = new Vector<IROper>(source.size());
		for( int i = 0; i < source.size(); i++ ) {
			res.set( i, source.get(i).dup() );
		}
		return res;
	}
	
	protected IROper dupChildrenAndCoordAndType( IROper source ) {
		for( int i = 0; i < source.getChildNum(); i++ ) {
			IROper ch = source.getChild(i);
			setChild(i, ch != null ? ch.dup() : null);
		}
		coord = source.coord;
		type = source.getType();
//		setParent(source.getParent());
		return this;
	}
	
	public boolean isConst() { return false; }
	
	public IRType getFixedType() {
		if( knowledge != TYPE_KNOWLEDGE.FIXED) return null;
		return knownType;
	}
	
	public IRType getDefinedType() {
		if( knowledge != TYPE_KNOWLEDGE.DEFINED) return null;
		return knownType;
	}
	
	public boolean isFixedType() {
		return knowledge == TYPE_KNOWLEDGE.FIXED;
	}
	
	public boolean isDefinedType() {
		return knowledge == TYPE_KNOWLEDGE.DEFINED;
	}
	
	public void setFixedType(IRType fixedType) {
		this.knownType = fixedType;
		this.type = fixedType;
		knowledge = TYPE_KNOWLEDGE.FIXED;
	}
	
	public void setDefinedType(IRType definedType) {
		if( knowledge == TYPE_KNOWLEDGE.FIXED ) return;
		this.knownType = definedType;
		this.type = definedType;
		knowledge = TYPE_KNOWLEDGE.DEFINED;
	}
	
	public IRType getType() {
		if( knownType != null ) return knownType;
		return type;
	}
	
	public void setType(IRType type) {
		if( knownType != null ) return;
		this.type = type;
	}
	
	public void setTypeIfNull(IRType type) {
		if( this.type == null )
			this.type = type;
	}
	
	public void setTypeIfNullAndSemanticCheck(IRType type, IRErrorFactory err) throws CompilerError {
		if( this.type == null ) {
			this.type = type;
		}
		semanticCheck(err);
	}
	
	public void visit( IROperVisitor visitor ) {
		int pi = getParentOper() != null ? getParentOper().children.indexOf(this) : -1;
		visitor.visit( getParentOper(), pi, this );
		for( int i = 0; i < children.size(); i++ ) {
			IROper op = children.get(i);
			if( op != null )
				op.visit(visitor);
		}
	}
	
	public void setChild( int childIndex, IROper child ) {
		while( childIndex >= children.size() ) {
			children.add(null);
		}
//		if( child.parent != null )
//			throw new RuntimeException();
		IROper oldChild = children.get(childIndex);
		if( oldChild != null ) {
			oldChild.setParent( null );
		}
		if( child != null ) child.setParent( this );
		children.set(childIndex, child);
	}
	
	public IROper getChild( int index ) {
		if( index >= children.size() ) {
			throw new IndexOutOfBoundsException(index + ">=" + children.size());
		}
		return children.get(index);
	}
	
	public int getChildNum() {
		return children.size();
	}
	
	public IROper getParentOper() {
		if( getParent() instanceof IROper ) {
			return (IROper) getParent();
		}
		return null;
	}
	
	public IRType getParentsType() {
		if( getParent() instanceof IROper ) {
			return ((IROper)getParent()).getType();
		} else if( getParent() instanceof IRConstant ) {
			return ((IRConstant)getParent()).getType();
		} else if( getParent() instanceof IRVariable ) {
			return ((IRVariable)getParent()).getType();
		} else if( getParent() instanceof IRSignal ) {
			return ((IRSignal)getParent()).getType();
		} else {
			return null;
		}
	}
	
	public IROper() {
		super(null);
	}
	
	public IROper( IROper child ) {
		super(null);
		setChild(0, child);
	}
	
	public IROper( IROper child1, IROper child2 ) {
		super(null);
		setChild(0, child1);
		setChild(1, child2);
	}
	
	public static IROper create( IRNamedElement el ) {
		if( el instanceof IRVariable ) {
			return new IRVarOper((IRVariable) el);
		} else if( el instanceof IRSignal ) {
			return new IRSignalOper((IRSignal)el);
		} else if( el instanceof IRConstant ) {
			IRConstant cnst = (IRConstant)el;
//			if( cnst.value != null ) {
//				return cnst.getValue();
//			} else {
				return new IRConstRead(cnst);
//			}
		} else if( el instanceof IRFunction ) {
			return new IRFunctionCall( null, ((IRFunction) el).getName());
		} else if( el instanceof IRSubProgram ) {
			return new IRFunctionCall( null, ((IRSubProgram) el).getName());
		} else if( el instanceof Library ) {
			return new IRName(el.getName());
		} else if( el instanceof IRArchitecture || el instanceof IRBlock || el instanceof IRProcess ) {
			return new IRName(el.getName());
		} else if( el instanceof IRType ) {
			TypeValue v = new TypeValue((IRType) el);
			return new IRConst(v.getType(), v);
		} else if( el instanceof IREnumValue ) {
			IREnumValue v = (IREnumValue) el;
			return new IRConst(v.owningType, new EnumSimValue(v) );
		} else if( el instanceof IRPhysicalUnits ) {
			IRPhysicalUnits units = (IRPhysicalUnits) el;
			return units.value;
		} else if( el instanceof IRAlias ) {
			IRAlias al = (IRAlias) el;
			return new IROperAlias(al);
//			if( al.getType() != null && al.getType().isArray() ) {
//				IRArrayIndex ind = IRTypeArray.getIndex(al.getType(), null, null);
//				if( ind.getRangeHigh() == null || ind.getRangeLow() == null ) {
//					int a = 0;
//					a++;
//				}
//			}
//			return new IRTypeCast(al.getType()!=null?al.getType():al.getExpression().getType(),al.getExpression());
		} else {
			System.err.println("Can't create " + (el != null ? el.getName() : ""));//throw new RuntimeException();
			return null;
		}
	}
	
	public boolean isValueRequired() {
		if( getParentOper() == null ) return false;
		return getParentOper().requiresValuesAtChildren();
	}
	
	protected boolean defaultIsEqualTo( IROper other ) {
		if( getKind() != other.getKind() ) return false;
		if( getChildNum() != other.getChildNum() ) return false;
		for( int i = 0; i < getChildNum(); i++ ) {
			if( !getChild(i).isEqualTo(other.getChild(i)) ) return false;
		}
		return true;
	}
	
	public boolean isBoolean() {
		return getType() instanceof IRTypeEnum && getType().getName().equalsIgnoreCase("boolean");
	}
	
	public boolean getBooleanValue() {
		if( this instanceof IRArrBound && ((IRArrBound)this).bound == Bound.IS_DOWN_TO ) {
			IRType chType = getChild(0).getType();
			if( chType != null && chType.isArray() ) {
				IRArrayIndex ind = IRTypeArray.getIndex(chType, null, this);
				return ind.getRange().isDownTo().getBooleanValue();
			}
		}
		if( !isBoolean() || !isConst() )
			throw new RuntimeException();
		SimValue cnst = ((IRConst)this).getConstant();
		return cnst.getEnumValue().getValue() > 0;
	}
	
	public boolean isRangeOrReverse() {
		if( !(this instanceof IRAttrib) ) return false;
		IRAttrib att = (IRAttrib) this;
		return att.getAttributeName().equalsIgnoreCase("RANGE") || att.getAttributeName().equalsIgnoreCase("REVERSE_RANGE");
	}
	
	public boolean isDirectRangeAttrib() {
		if( !(this instanceof IRAttrib) ) return false;
		IRAttrib att = (IRAttrib) this;
		return att.getAttributeName().equalsIgnoreCase("RANGE");
	}
	
	public boolean isReverseRangeAttrib() {
		if( !(this instanceof IRAttrib) ) return false;
		IRAttrib att = (IRAttrib) this;
		return att.getAttributeName().equalsIgnoreCase("REVERSE_RANGE");
	}
	
	
	
	
	private FullCoord coord = new FullCoord(null, null);
	
	@Override
	public TextCoord getBegin() {
		return coord.getBegin();
	}

	@Override
	public TextCoord getEnd() {
		return coord.getEnd();
	}

	@Override
	public FullCoord getFull() {
		return coord;
	}

	@Override
	public void setBegin(TextCoord coord) {
		this.coord = new FullCoord(coord, getEnd());
	}

	@Override
	public void setEnd(TextCoord coord) {
		this.coord = new FullCoord(getBegin(), coord);
	}

	@Override
	public void setFull(FullCoord coord) {
		this.coord = coord;
	}
	
	
}
