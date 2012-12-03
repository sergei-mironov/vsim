package com.prosoft.vhdl.gen.vir;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRBinaryOper;
import com.prosoft.vhdl.ir.IRConstRead;
import com.prosoft.vhdl.ir.IRConstant;
import com.prosoft.vhdl.ir.IRDotOper;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRFieldOper;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRFunctionCall;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRParameter;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRRecordField;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRSignalOper;
import com.prosoft.vhdl.ir.IRSubProgram;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRTypeRecord;
import com.prosoft.vhdl.ir.IRVarOper;
import com.prosoft.vhdl.ir.IRVariable;
import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.lib.Library;

public class GenSymbols {
	
	class Symbol {
		int id;
		IRNamedElement element;
		boolean generated;
		public Symbol(int id, IRNamedElement element) {
			this.id = id;
			this.element = element;
			if( element == null ) {
				int a = 0;
				a++;
			}
		}
	}
	
	HashMap<IRNamedElement, Symbol> map = new HashMap<IRNamedElement, Symbol>();
	HashSet<IROper> generatedOps = new HashSet<IROper>();
	private int lastID = 1;
	
	class Visitor implements IROperVisitor {
		TextOut out;
		public Visitor(TextOut out) {
			this.out = out;
		}
		@Override
		public void visit(IROper parent, int childIndex, IROper child) {
			generate(child, out);
		}
	}
	
	Visitor visitor;
	
	protected Symbol getSymbol( IRNamedElement el ) {
		Symbol res = map.get(el);
		if( res != null ) return res;
		res = new Symbol(lastID++, el);
		map.put(el, res);
		return res;
	}
	
	void generateCoord( TextCoord coord, TextOut out ) {
		out.add( " (\"" + coord.getFile() + "\" (" + coord.getLine() + ", " + coord.getColumn() + "))" );
	}
	
	void generateDefinition( Symbol sym, TextOut out ) {
		out.nlTabAdd( sym.id + " def \"" + sym.element.getName() + "\"" );
		generateCoord(sym.element.getBegin(), out);
		generateCoord(sym.element.getEnd(), out);
		out.add(";; " + sym.element.getName());
	}
	
	String getTypeName( IRType type ) {
		if( type.getName() != null ) return type.getName();
		return type.toString();
	}
	
	void generateUse( IRNamedElement el, IROper op, TextOut out ) {
		Symbol sym = getSymbol(el);
		generate(sym, out);
		out.nlTabAdd( sym.id + " use (" );
		generateCoord( op.getBegin(), out );
		generateCoord( op.getEnd(), out );
		out.add( ");; " + el.getName() );
	}
	
	IRPackage getPackage(IRNamedElement el) {
		IRElement cur = el.getParent();
		while( cur != null ) {
			if( cur instanceof IRPackage.Declaration ) {
				return ((IRPackage.Declaration)cur).getPackage();
			}
			if( cur instanceof IRPackage.Body ) {
				return ((IRPackage.Body)cur).getPackage();
			}
			if( cur instanceof IRPackage ) {
				return (IRPackage) cur;
			}
			cur = cur.getParent();
		}
		return null;
	}
	
	void generateType( IRType type, TextOut out ) {
		type = type.getOriginalType();
		Symbol sym = getSymbol(type);
		if( sym.generated ) return;
		sym.generated = true;
		
		if( type.isRecord() ) {
			IRTypeRecord rec = (IRTypeRecord) type;
			for( int i = 0; i < rec.getNumFields(); i++ ) {
				generateType(rec.getField(i).getType(), out);
			}
		} else if( type.isArray() ) {
			IRTypeArray arr = (IRTypeArray) type;
			generateType(arr.getElementType(), out);
		}
		
		if( !type.isReal() && !type.isInt() && !type.isPhysical() ) {
			generateDefinition(sym, out);
		}
		out.nlAdd(sym.id + " type type ");
		if( type.isEnum() ) {
			out.add(" enum ( ");
			IRTypeEnum en = (IRTypeEnum) type;
			for( int i = 0; i < en.getNumValues(); i++ ) {
				IREnumValue v = en.getValue(i);
				out.add(v.getName() + " ");
			}
			out.add(")");
		} else if( type.isArray() ) {
			IRTypeArray arr = (IRTypeArray) type;
			out.add(" array of " + getSymbol(arr.getElementType()).id );
		} else if( type.isRecord() ) {
			IRTypeRecord rec = (IRTypeRecord) type;
			out.add(" record ( ");
			for( int i = 0; i < rec.getNumFields(); i++ ) {
				IRRecordField f = rec.getField(i);
				Symbol typeSym = getSymbol(f.getType());
				out.add(f.getName() + ":" + typeSym.id + " ");
			}
			out.add(")");
		} else if( type.isReal() | type.isInt() | type.isPhysical() ) {
			out.add(type.getName());
		}
	}
	
	void generate( Symbol sym, TextOut out ) {
		if( sym.generated ) return;
		sym.generated = true;
		IRPackage pack;
		if( (pack = getPackage( sym.element )) != null && pack.getName().equalsIgnoreCase("STANDARD") ) return;
		generateDefinition( sym, out );
		
		if( sym.element instanceof IRArchitecture ) {
			IRArchitecture arch = (IRArchitecture) sym.element;
			generate( getSymbol(arch.getEntity()), out );
			out.nlTabAdd( sym.id + " type architecture " );
			arch.visit(visitor);
			
		} else if( sym.element instanceof IREntity ) {
			IREntity en = (IREntity) sym.element;
			out.nlTabAdd( sym.id + " type entity (" );
			ArrayList<IRPort> ports = en.getPorts();
			for( int i = 0; i < ports.size(); i++ ) {
				IRPort port = ports.get(i);
				out.add( " " + port.getDirection().toString().toLowerCase() + " " + 
						port.getName() + " " + getTypeName( port.getType() ) + " " );
			}
			out.add( ")" );
			for( int i = 0; i < ports.size(); i++ ) {
				IRPort port = ports.get(i);
				generate( getSymbol(port), out);
			}
			
		} else if( sym.element instanceof IRFunction ) {
			IRFunction func = (IRFunction) sym.element;
			out.nlTabAdd( sym.id + " type function " + getTypeName(func.getReturnType()) + " ( " );
			ArrayList<IRParameter> params = func.getParameters();
			for( int i = 0; i < params.size(); i++ ) {
				IRParameter p = params.get(i);
				out.add( p.getDirection().toString().toLowerCase() + " " + p.getName() + " " + 
						getTypeName(p.getType()) + " " );
			}
			out.add( " ) " );
			
		} else if( sym.element instanceof IRGeneric ) {
			IRGeneric gen = (IRGeneric) sym.element;
			out.nlTabAdd( sym.id + " type generic " + gen.getValue().toString() );
			
		} else if( sym.element instanceof IRConstant ) {
			IRConstant cnst = (IRConstant) sym.element;
			generateType(cnst.getType(), out);
			if( cnst.isParameter() || cnst.getValue() == null ) {
				out.nlTabAdd( sym.id + " type constant " + getTypeName(cnst.getType()) );
			} else {
				out.nlTabAdd( sym.id + " type constant " + getTypeName(cnst.getType()) + " " + cnst.getValue().toString() );
			}
			
		} else if( sym.element instanceof IRSignal ) {
			IRSignal sig = (IRSignal) sym.element;
			generateType(sig.getType(), out);
			out.nlTabAdd( sym.id + " type signal " + getTypeName(sig.getType()) );
			
		} else if( sym.element instanceof IRVariable ) {
			IRVariable var = (IRVariable) sym.element;
			generateType(var.getType(), out);
			out.nlTabAdd( sym.id + " type variable " + getTypeName(var.getType()) );
			
		} else if( sym.element instanceof IRPort ) {
			IRPort port = (IRPort) sym.element;
			generateType(port.getType(), out);
			out.nlTabAdd( sym.id + " type port " + port.getDirection().toString().toLowerCase() + " " + getTypeName( port.getType() ));
			
		} else if( sym.element instanceof IRRecordField ) {
			IRRecordField field = (IRRecordField) sym.element;
			generateType(field.getType(), out);
			out.nlTabAdd( sym.id + " type field " + getTypeName( field.getType() ));
			
		} else if( sym.element instanceof IRSubProgram ) {
			IRSubProgram sub = (IRSubProgram) sym.element;
			if( sub instanceof IRFunction ) {
				generateType( ((IRFunction)sub).getReturnType(), out );
			}
			out.nlTabAdd( sym.id + " type " + (sub.isFunction()?"function":"procedure") + sub.getName() );
			for( int i = 0; i < sub.getParameters().size(); i++ ) {
				Symbol cur = getSymbol(sub.getParameters().get(i));
				generate(cur, out);
			}
			
		} else if( sym.element instanceof IRParameter ) {
			IRParameter par = (IRParameter) sym.element;
			out.nlTabAdd( sym.id + " type parameter " + par.getName() );
			
		} else throw new RuntimeException(sym.element.getClass().getSimpleName());
	}
	
	void generateChildOperations( IROper op, TextOut out ) {
		for( int i = 0; i < op.getChildNum(); i++ ) {
			IROper ch = op.getChild(i);
			if( ch != null ) {
				generate( ch, out );
			}
		}
	}
	
	void generate( IROper op, TextOut out ) {
		if( generatedOps.contains(op) ) return;
		generatedOps.add(op);
		generateChildOperations(op, out);
		if( op instanceof IRBinaryOper ) {
			IRBinaryOper bin = (IRBinaryOper) op;
			if( bin.getSub() != null ) {
				IRSubProgram sub = bin.getSub();
				generate(sub, out);
				return;
			}
		}
		switch( op.getKind() ) {
		case CONST_READ:
			IRConstRead cr = (IRConstRead) op;
			generateUse(cr.getConstant(), op, out);
			break;
			
		case FCALL:
			IRFunctionCall fc = (IRFunctionCall) op;
			generateUse( fc.getFunction(), op, out );
			break;
			
		case SGNL:
			IRSignalOper sig = (IRSignalOper) op;
			generateUse(sig.getSignal(), op, out);
			break;
			
		case VAR:
			IRVarOper var = (IRVarOper) op;
			generateUse(var.getVariable(), op, out);
			break;
			
		case FIELD:
			IRFieldOper field = (IRFieldOper) op;
			generateUse(field.getField(), op, out);
			break;
		}
	}
	
	public void generate( IRNamedElement el, TextOut out ) {
		visitor = new Visitor(out);
		generate( getSymbol(el), out );
	}
}
