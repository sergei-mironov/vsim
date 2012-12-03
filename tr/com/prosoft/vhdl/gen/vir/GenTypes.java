package com.prosoft.vhdl.gen.vir;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Stack;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.GenDesc;
import com.prosoft.glue.HDLAssoc;
import com.prosoft.glue.HDLExpr;
import com.prosoft.glue.HDLKind;
import com.prosoft.glue.PortDesc;
import com.prosoft.glue.gen.GenGlue;
import com.prosoft.verilog.gen.vir.GenVTypes;
import com.prosoft.vhdl.gen.Scope;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.ILocalResolver;
import com.prosoft.vhdl.ir.IRAfter;
import com.prosoft.vhdl.ir.IRAggreg;
import com.prosoft.vhdl.ir.IRAlias;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRArrBound;
import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRAssertStatement;
import com.prosoft.vhdl.ir.IRAttrib;
import com.prosoft.vhdl.ir.IRBinaryOper;
import com.prosoft.vhdl.ir.IRBlock;
import com.prosoft.vhdl.ir.IRCaseStatement;
import com.prosoft.vhdl.ir.IRChoices;
import com.prosoft.vhdl.ir.IRComponent;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IRConst;
import com.prosoft.vhdl.ir.IRConstRead;
import com.prosoft.vhdl.ir.IRConstant;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRErrorFactory;
import com.prosoft.vhdl.ir.IRExitOrNextStatement;
import com.prosoft.vhdl.ir.IRFieldOper;
import com.prosoft.vhdl.ir.IRForGenerateStatement;
import com.prosoft.vhdl.ir.IRForStatement;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRFunctionCall;
import com.prosoft.vhdl.ir.IRGenerateStatement;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRIfGenerateStatement;
import com.prosoft.vhdl.ir.IRIfStatement;
import com.prosoft.vhdl.ir.IRLoopVariable;
import com.prosoft.vhdl.ir.IRName;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IROperAlias;
import com.prosoft.vhdl.ir.IROperAssoc;
import com.prosoft.vhdl.ir.IROperComma;
import com.prosoft.vhdl.ir.IROperKind;
import com.prosoft.vhdl.ir.IROperOthers;
import com.prosoft.vhdl.ir.IROperRange;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRParameter;
import com.prosoft.vhdl.ir.IRPhysicalUnits;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRProcedureCall;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRRecordField;
import com.prosoft.vhdl.ir.IRReportStatement;
import com.prosoft.vhdl.ir.IRReturnStatement;
import com.prosoft.vhdl.ir.IRSelectedAssign;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRSignalAssignment;
import com.prosoft.vhdl.ir.IRSignalOper;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRStatements;
import com.prosoft.vhdl.ir.IRSubProgram;
import com.prosoft.vhdl.ir.IRSubProgramHolder;
import com.prosoft.vhdl.ir.IRSubprograms;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeAccess;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeCast;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRTypeHolder;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.ir.IRTypePhysical;
import com.prosoft.vhdl.ir.IRTypeReal;
import com.prosoft.vhdl.ir.IRTypeRecord;
import com.prosoft.vhdl.ir.IRTypes;
import com.prosoft.vhdl.ir.IRUnaryOper;
import com.prosoft.vhdl.ir.IRVarOper;
import com.prosoft.vhdl.ir.IRVariable;
import com.prosoft.vhdl.ir.IRVariableAssignment;
import com.prosoft.vhdl.ir.IRWaitStatement;
import com.prosoft.vhdl.ir.IRWhileStatement;
import com.prosoft.vhdl.ir.IRangedElement;
import com.prosoft.vhdl.ir.ISensivityList;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.sim.ArrayValue;
import com.prosoft.vhdl.sim.PhysicalValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.TypeValue;

public class GenTypes {
	
	public static final boolean GENERATE_T_BEFORE_ENUM = true;
	
	class StackEntry {
		
		IRNamedElement el;
		String parentName;
		HashMap<String, IRType> types = new HashMap<String, IRType>();

		public StackEntry(IRNamedElement el, String parentName) {
			this.el = el;
			this.parentName = parentName;
		}
		
		public IRNamedElement getElement() {
			return el;
		}
		
		public void add(IRType type) {
			types.put(type.getName().toLowerCase(), type);
		}
		
		public String getFullName(IRType type) {
			IRType old = types.get(type.getName().toLowerCase());
			if( old == null && el instanceof IRTypeHolder ) {
				old = ((IRTypeHolder)el).getType(type.getName().toLowerCase());
				if( old != null ) {
					add(old);
				}
			}
			if( old != null ) {
				String res = parentName;
				if( !(el instanceof IRArchitecture) && !(el instanceof IREntity) ) {
					res += "." + el.getName();
				}
				return res + "." + type.getName();
			}
			return null;
		}
	}
	
	class SubProgram {
		
		final String owner;
		final IRSubProgram sub;
		
		public SubProgram(String owner, IRSubProgram sub) {
			this.owner = owner;
			this.sub = sub;
		}

		public int hashCode() {
			return owner.hashCode() ^ sub.hashCode();
		}
		
		public boolean equals( Object other ) {
			if( !(other instanceof SubProgram) ) return false;
			SubProgram sub = (SubProgram) other;
			return owner.equals(sub.owner) && this.sub == sub.sub;
		}
	}
	
	class Type {
		
		final String owner;
		final IRType type;
		
		int hash;
		
		public Type(String owner, IRType type) {
			this.owner = owner;
			this.type = type;
			if( type.getName() != null )
				hash = owner.toLowerCase().hashCode() ^ type.getName().toLowerCase().hashCode();
			else
				hash = owner.toLowerCase().hashCode();
		}

		public int hashCode() {
			return hash;
		}
		
		public boolean equals( Object other ) {
			if( !(other instanceof Type) ) return false;
			Type type = (Type) other;
			if( !owner.equalsIgnoreCase(type.owner) ) return false;
			if( this.type.getName() != null && type.type.getName() != null ) {
				String n1 = this.type.getName();
				String n2 = type.type.getName();
				if( n1.equalsIgnoreCase("ten") || n2.equalsIgnoreCase("ten") ) {
					int a = 0;
					a++;
				}
				boolean res = n1.equalsIgnoreCase(n2);
				return res;
			}
			else
				return false;
		}
		
		public String toString() {
			return owner + "." + type.getName();
		}
	}
	
	class NamedObject {
		final String owner;
		final IRNamedElement object;
		
		public NamedObject(String owner, IRNamedElement obj) {
			this.owner = owner;
			this.object = obj;
			if( owner == null ) {
				throw new RuntimeException(obj.getName());
			}
		}

		public int hashCode() {
			return owner.hashCode() ^ object.hashCode();
		}
		
		public boolean equals( Object other ) {
			if( !(other instanceof NamedObject) ) return false;
			NamedObject obj = (NamedObject) other;
			return owner.equals(obj.owner) && this.object == obj.object;
		}
	}
	
	public static final boolean generateConstantsType = true;
	public static final boolean generateAssignSourceType = false;
	
	public GenGlue glue;
	
	IRErrorFactory err;
	
	VNameSpace ns = new VNameSpace();
	
	HashMap<IRSubProgram, Integer> functionCodes = new HashMap<IRSubProgram, Integer>();
	HashMap<String, Integer> lastFunctionCodes = new HashMap<String, Integer>();
	
	HashSet<SubProgram> subprogramsToGenerate = new HashSet<SubProgram>();
	HashSet<SubProgram> generatedSubprograms = new HashSet<SubProgram>(); 
	HashSet<NamedObject> objectsToGenerate = new HashSet<NamedObject>();
	HashSet<NamedObject> generatedObjects = new HashSet<NamedObject>(); 
	HashSet<Type> typesToGenerate = new HashSet<Type>();
	HashSet<Type> generatedTypes = new HashSet<Type>();
	
	Stack<StackEntry> stack = new Stack<StackEntry>();
	
	GenVTypes verilogGen;
	
	public GenTypes(IRErrorFactory err) {
		this.err = err;
	}
	
	void push(IRNamedElement el, String parentName) { stack.push(new StackEntry(el, parentName)); }
	StackEntry pop() { return stack.pop(); }
	IRArchitecture getOwningArch() {
		for( int i = stack.size() - 1; i >= 0; i-- ) {
			if( stack.get(i).el instanceof IRArchitecture ) return (IRArchitecture) stack.get(i).el;
		}
		return null;
	}
	IRNamedElement getOwningArchOrBlock() {
		for( int i = stack.size() - 1; i >= 0; i-- ) {
			if( stack.get(i).el instanceof IRArchitecture || stack.get(i).el instanceof IRBlock ) return stack.get(i).el;
		}
		return null;
	}
	
	String getTypeFullName(IRType type) {
		if( type.getFullName().startsWith("STD.STANDARD") 
				|| type.getParent() instanceof IRPackage.Declaration 
				|| type.getParent() instanceof IRPackage 
				|| type.getParent() instanceof IRPackage.Body 
			) {
			return type.getFullName();
		}
		for( int i = stack.size() - 1; i >= 0; i-- ) {
			String res = stack.get(i).getFullName(type);
			if( res != null ) return res;
		}
		type.reportError("Can't find type " + type.getFullName() + " in generation stack");
		return null;
	}
//	ISensivityList getOwningProcess() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			if( stack.get(i).el instanceof IRProcess ) return (ISensivityList) stack.get(i).el;
//		}
//		return null;
//	}
	IRComponentInstance getOwningComponent() {
		for( int i = stack.size() - 1; i >= 0; i-- ) {
			if( stack.get(i).el instanceof IRComponentInstance ) return (IRComponentInstance) stack.get(i).el;
		}
		return null;
	}
	
	Integer getFunctionCode( IRSubProgram sub ) {
		String fullName = sub.getFullName();
		Integer lastCode = lastFunctionCodes.get(fullName);
		Integer curCode = functionCodes.get(sub);
		if( curCode != null ) {
			return curCode;
		}
		if( lastCode != null ) {
			curCode = Integer.valueOf(lastCode.intValue()+1);
		} else {
			curCode = Integer.valueOf(0);
		}
		lastFunctionCodes.put(fullName, curCode);
		functionCodes.put(sub, curCode);
		return curCode;
	}
	
	HashMap<IRElement, Integer> uniqueIndexes = new HashMap<IRElement, Integer>();
	
	String getUniqueName( IRElement el ) {
		IRElement owner = el.getParent();
		Integer lastIndex = uniqueIndexes.get(owner);
		Integer newIndex;
		if( lastIndex != null ) {
			newIndex = Integer.valueOf(lastIndex.intValue()+1);
		} else {
			newIndex = Integer.valueOf(0);
		}
		uniqueIndexes.put(owner, newIndex);
		return Integer.toString(newIndex.intValue());
	}
	
//	public void generateFullName( IRFullNamedElement parent, IRFullNamedElement el ) {
//		if( el.getFullName() != null ) return;
//		if( parent == null ) {
//			String name = ns.getUniqueName(el, el.getName());
//			el.setFullName(name);
//			return;
//		}
//		if( parent.getFullName() == null ) {
//			int a = 0;
//			a++;
//		}
//		String name = parent.getFullName() + "." + el.getName();
//		el.setFullName(name);
//	}
	
//	public void generateFullName( String parentName, IRFullNamedElement el ) {
//		if( el.getFullName() != null ) return;
//		String name = parentName + "." + el.getName();
//		el.setFullName(name);
//	}
	
//	public void generateUniqueName( IUniqueNamedElement el ) {
//		String name;
//		if( el instanceof IRReadableNameGenerator ) {
//			IRReadableNameGenerator gen = (IRReadableNameGenerator) el;
//			name = ns.getUniqueName(el, gen.getReadableName());
//		} else {
//			name = ns.getUniqueName(el);
//		}
//		el.setUniqueName(name);
//	}
	
	public boolean isUnconstrainedRange( IRangedElement range ) {
        return range.getRange().getRangeHigh() == null || range.getRange().getRangeLow() == null || range.getRange().isDownTo() == null;
    }
	public boolean isUnconstrainedRanges( IRangedElement[] ranges ) {
        for ( IRangedElement r : ranges )
        {
            if ( isUnconstrainedRange(r) ) return true;
        }
        return false;
    }
    public void generateRange( IRangedElement range, String parentName, TextOut out ) {
        generateRange(range, parentName, out, false);
    }
    public void generateRange( IRangedElement range, String parentName, TextOut out,
                               boolean addBaseType ) {
//    	if( range instanceof IRArrayIndex ) {
//    		IRArrayIndex ind = (IRArrayIndex) range;
//    		if( ind.getName().equalsIgnoreCase("ST_BIT_VECTOR") ) {
//    			int a = 0;
//    			a++;
//    		}
//    		if( ind.getName() != null && /*ind.getSubtypedFrom() != null &&*/ currentlyGeneratingType != ind ) {
//	    		addTypeToGenerate(ind, out);
//	    		generate(ind, false, out);
//	    		return;
//    		}
//    	}
    	
    	if( range.getRange().isRangeOf() ) {
            out.add("(i:a'range 1 ");
            // TODO: что делать с N-ным range, и reverse_range
            generateExpression( range.getRange().getRangeOf(), parentName, out );
            out.add(")");
    	} else if( isUnconstrainedRange(range) ) {
            out.add("[");
            generate(range.getRangeType(), false, parentName, out);
            out.add(" (range <>)]");
        } else if( range.getRange().getRangeHigh().getKind() == IROperKind.ARRAY_BOUND && range.getRange().getRangeLow().getKind() == IROperKind.ARRAY_BOUND
                   && range.getRange().isDownTo().getKind() == IROperKind.ARRAY_BOUND ) {
            out.add("(i:a'range 1 ");
            // TODO: что делать с N-ным range, и reverse_range
            generateExpression( range.getRange().getRangeHigh().getChild(0), parentName, out );
            out.add(")");
        } else {
            IRType rt = range.getRangeType();
            //boolean noSubtype = (rt.isInt() || rt.isReal()) && rt.getSubtypedFrom() == null;
            if ( addBaseType )
            {
                out.add("(");
                generate(rt, false, parentName, out);
                out.add(" ");
            }
            out.add("(range ");
            if( range.getRange().isDownTo().getBooleanValue() ) {
                generateExpression(range.getRange().getRangeHigh(), parentName, out);
                out.add( " downto " );
                generateExpression(range.getRange().getRangeLow(), parentName, out);
            } else {
                generateExpression(range.getRange().getRangeLow(), parentName, out);
                out.add( " to " );
                generateExpression(range.getRange().getRangeHigh(), parentName, out);
            }
            out.add(addBaseType ? "))" : ")");
        }
	}
	
    public void generateRanges( IRArrayIndex[] ranges, String parentName, TextOut out,
                                boolean addBaseType )
    {
		for( int i = 0; i < ranges.length; i++ ) {
            //generate((IRType)ranges[i], false, out);
//             out.add("(" + ranges[i].getBaseTypeName() + " ");
            generateRange( ranges[i], parentName, out, addBaseType );
//             out.add(")");
			if( i + 1 < ranges.length ) out.add(" ");
		}
	}
	
	public void generateLibrary( Library lib, TextOut out ) {
		IRNamedElement[] els = lib.getElements();
		for( int i = 0; i < els.length; i++ ) {
			IRNamedElement el = els[i];
			if( el instanceof IRPackage ) {
				IRPackage pack = (IRPackage) el;
				generate(pack, out);
			} else if( el instanceof IREntity ) {
				IREntity en = (IREntity) el;
				// TODO сущности надо генерировать по другому
//				generate
			}
		}
	}
	
	public void generate(IRPackage pack, TextOut out) {
		String parentName = pack.getFullName();
		ArrayList<IRConstant> cnsts = pack.getDeclarations().getConstants();
		for( int i = 0; i < cnsts.size(); i++ ) {
			generate( cnsts.get(i), parentName, null, out);
		}
		cnsts = pack.getBody().getConstants();
		for( int i = 0; i < cnsts.size(); i++ ) {
			generate( cnsts.get(i), parentName, null, out);
		}
	}
	
	public void generate( IRType type, boolean extendTypes, String parentName, TextOut out ) {
		if( type == null ) {
			int a = 0;
			a++;
		}
        if ( type.getName() != null )
        {
            // генерируем только объявленные типы с именем
            addTypeToGenerate(type, out);
        }
        
        if( type.getName() != null && type.getName().equalsIgnoreCase("st_rec1") ) {
        	int a = 0;
        	a++;
        }
//        String fname = type.getName() != null ? getTypeFullName(type) : type.getFullName();

        IRType subtypedFrom = type.getSubtypedFrom();
        if ( subtypedFrom != null )
        {
            addTypeToGenerate(subtypedFrom, out);
        }

        // DUCK для безымянного типа надо сгенерировать его описание
 //       if( type.getName() == null ) subtypedFrom = null;

        if( !extendTypes && type.getName() != null ) {
            // неанонимный subtype
//            out.add( IRNamedElement.isLocalElement(type) ?
//                     type.getName() : type.getFullName() );
        	out.add( getTypeFullName(type).toUpperCase() );
            return;
        }

		if( type.getResolutionFunctionName() != null ) {
			IRFunction func = type.getResolutionFunction(err);
			try {
				func.semanticCheck(err);
			} catch (CompilerError e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			SubProgram sub = addSubProgramToGenerate(func);
			out.nlTabAdd("(resolved " + getSubFullName(sub).toLowerCase() + " ");
		}
        
		//String fullName = type.getFullName();
        // у variable asdf : integer range 1 to 10
        //   constant qwer : std_logic_vector(1 to 5);
        // имени нет
        // parentName используется в port и function declaraion
        // вроде как ниже он нафиг не нужен?
//		String parentName = null; //fullName.substring( 0, fullName.lastIndexOf('.') );
		if (subtypedFrom == null) {
			// нет subtype-а, генерим тип как есть
			if (type instanceof IRTypeEnum) {
				boolean prevCase = out.isForceLowerCase();
				out.forceLowerCase(false);
				out.add(GENERATE_T_BEFORE_ENUM ? "(t:enum" : "(enum");
				IRTypeEnum en = (IRTypeEnum) type;
				for (int i = 0; i < en.getNumValues(); i++) {
					String s = en.getValue(i).getName();
					if (s.length() < 3 || s.charAt(2) != '\'')
						s = s.toLowerCase();
					out.add(" " + s);
				}
				out.add(")");
				out.forceLowerCase(prevCase);
			} else if (type instanceof IRTypeArray) {
				out.add("(array (");
				IRTypeArray arr = (IRTypeArray) type;
				generateRanges(arr.getIndexes(), parentName, out, true);
				out.add(") of ");
				generate(arr.getElementType(), false, parentName, out);
              out.add(")");
            } else if( type instanceof IRTypeRecord ) {
                out.pushScope(new Scope());
                out.nlTabAdd("(record");
                out.pushScope(new Scope());                
                IRTypeRecord rec = (IRTypeRecord) type;
                for( int i = 0; i < rec.getNumFields(); i++ ) {
                    IRRecordField f = rec.getField(i);
                    out.nlTabAdd( "(" + f.getName() + "\t\t" );
                    generate(f.getType(), false, parentName, out);
                    out.add( ")");
                }
                out.popScope();
                out.add(")");
                out.popScope();
            } else if( type instanceof IRTypeInteger ) {
                IRTypeInteger tint = (IRTypeInteger) type;
                generateRange(tint, parentName, out);
            } else if( type instanceof IRTypeReal ) {
                IRTypeReal treal = (IRTypeReal) type;
                generateRange(treal, parentName, out);
            } else if( type instanceof IRTypeAccess ) {
            	IRTypeAccess acc = (IRTypeAccess) type;
            	out.add("(access " );
            	generate(acc.getTargetType(), false, parentName, out);
                out.add(")");
            } else if( type instanceof IRTypePhysical ) {
            	IRTypePhysical p = (IRTypePhysical) type;
                out.add("(physical ");
                generateRange(p, parentName, out);
                out.add(" " + p.getUnits());
                for ( IRPhysicalUnits u : p.secondaryUnits)
                {
                    out.add(" (" + u.getName() + " ");
                    generateExpression(u.getValue(), parentName, out);
                    out.add(")");
                }
                out.add(")");
            } else {
                out.add(type.getClass().getName());
                out.add(type.toString());
            }
        }
        else // subtypedFrom != null
        {
//             if ( type.getName() == null )
//             {
//                 out.add("(type.getName() is null!!! ");
//             }
//             else
//             {
//                 out.add("(type.getName() == " + type.getName() + " ");
//             }
//             if ( subtypedFrom.getName() == null )
//             {
//                 out.add("(subtypedFrom.getName() is null!!! ");
//             }
//             else
//             {
//                 out.add("(subtypedFrom.getName() == " + subtypedFrom.getName() + " ");
//             }
            if ( type.constrainedSubtype )
            {
//                out.add("(" + subtypedFrom.getFullName().toUpperCase() + " ");
                out.add("(");
                generate(subtypedFrom, false, parentName, out);
                out.add(" ");
                if( type instanceof IRTypeEnum ) {
                    generateRange((IRTypeEnum)type, parentName, out);
                } else if( type instanceof IRTypeArray ) {
                    generateRanges(((IRTypeArray)type).getIndexes(), parentName, out, false);
                } else if( type instanceof IRTypeRecord ) {
                    throw new RuntimeException("Subtyped record " + type.getFullName());
                } else if( type instanceof IRTypeInteger ) {
                    generateRange((IRTypeInteger)type, parentName, out);
                } else if( type instanceof IRTypeReal ) {
                    generateRange((IRTypeReal)type, parentName, out);
                } else if( type instanceof IRTypePhysical ) {
                    generateRange((IRTypePhysical)type, parentName, out);
                } else {
                    out.add(type.getClass().getName());
                    out.add(type.toString());
                }
                out.add(")");
            }
            else
            {
                out.add( getTypeFullName(subtypedFrom).toUpperCase() );
                // если subtype ничем не ограничен, то это просто синоним
                // генерим его имя
            }
        }
        
		if( type.getResolutionFunctionName() != null ) {
            out.add(")");
        }
	}
	
	public void generate( IRVariable var, String parentName, TextOut out ) {
        glue.generateLocation(var.getBegin(), out);
//		if( var.isParameter() ) {
//			out.nlTabAdd( "(variable " + var.getName() + " " + var.getName() + " ");
//		} else {
			if( IRNamedElement.isLocalElement(var) ) {
				out.nlTabAdd( "(variable " + var.getName() + " ");
			} else {
				out.nlTabAdd( "(variable " + parentName + "." + var.getName() + " " );
			}
//		}
//		out.nlTabAdd( "(variable " + var.getUniqueName() + " " + var.getName() + " ");
		generate(var.getType(), false, parentName, out);
		if( var.getInit() != null ) {
			out.add(" ");
			generateExpression(var.getInit(), parentName, out);
		}
		out.add("))");
	}

    public void generate( IRAlias alias, String parentName, TextOut out ) {
    	glue.generateLocation(alias.getBegin(), out);
    	
//        if( parentName == null ) {
//            out.nlTabAdd( "(alias " + alias.getName() + " ");
//        } else {
//            out.nlTabAdd( "(alias " + parentName + "." + alias.getName() + " ");
//        }
        
        out.nlTabAdd( "(alias ");
        generateName(alias, parentName, out);
        out.add(" ");
        
		generate(alias.getType(), false, parentName, out);
		if( alias.getExpression() != null ) {
			out.add(" ");
			generateExpression(alias.getExpression(), parentName, out);
		}
		out.add("))");
	}
	
    // value нужно для переопределения значения, если переопределение не нужно, то надо передавать null
	public void generate( IRConstant cnst, String parentName, IROper value, TextOut out ) {
        //	   if( cnst.isParameter() ) return;
		NamedObject wrap = getObjectWrap(parentName, cnst);
		if( generatedObjects.contains(wrap) ) {
//			System.out.println("Strange, " + cnst.getFullName() + " already generated at " + cnst.getBegin());
			return;
		}
		generatedObjects.add(wrap);
		if( cnst.isParameter() ) return;
		glue.generateLocation(cnst.getBegin(), out);
        if( cnst instanceof IRGeneric ) {
        	out.nlTabAdd( "(generic " );
        } else {
        	out.nlTabAdd( "(constant " );
        }
        
        generateName( cnst, parentName, out );
        
        out.add( " " );
		generate(cnst.getType(), false, parentName, out);
		if( value == null ) {
			value = cnst.getValue();
		}
		if( value != null ) {
			if( cnst instanceof IRGeneric ) {
				
				// TODO Do we really need constant values?
//				IRConst c = IRConst.getConstantValue(value, err);
//				if( c != null ) {
//					value = c;
//				} else {
//					System.err.println("can't find value for " + cnst.getFullName());
//					IRConst.getConstantValue(value, err);
//				}
			}
			out.add(" ");
			generateExpression(value, parentName, out);
		}
		out.add("))");
	}
	
//	protected boolean generateType( IROper op ) {
//		return ! (op.getKind() == IROperKind.VAR || op.getKind() == IROperKind.FCALL 
//				|| op.getKind() == IROperKind.CONST_READ );
//	}
	
	public void generate( IRSignalAssignment stat, String parentName, TextOut out ) {
		out.nlTabAdd( "(i:send " );
		generateExpression( stat.getChild(0), parentName, out );
		out.add( " " );
		generateExpression( stat.getChild(1), parentName, out );
		if( generateAssignSourceType ) {
			out.add(" : ");
			generate( stat.getChild(1).getType(), false, parentName, out );
		}
		out.add( ")" );
	}
	
	public void generate( IRVariableAssignment stat, String parentName, TextOut out ) {
		if( stat.getChild(0).getKind() == IROperKind.VAR && 
				((IRVarOper)stat.getChild(0)).getVariable().getName().equalsIgnoreCase("pc_inc")) {
			int a = 0;
			a++;
		}
		out.nlTabAdd( "(i:set " );
//         generate(stat.getChild(0).getType(), false, out);
//         // i:set пока требует тип переменной
// 		out.add( " " );
		generateExpression( stat.getChild(0), parentName, out );
		out.add( " " );
		if( generateAssignSourceType ) {
			out.add("( ");
		}
		generateExpression( stat.getChild(1), parentName, out );
		if( generateAssignSourceType ) {
			out.add(" : ");
			generate( stat.getChild(1).getType(), false, parentName, out );
			out.add(" ) ");
		}
		out.add( ")" );
	}
	
	public void generate( IRReturnStatement stat, String parentName, TextOut out ) {
		out.nlTabAdd( "(return ");
		if( stat.getBegin().getFile().endsWith("generic_standard_types.vhd") && stat.getBegin().getLine() == 555 ) {
			int a = 0;
			a++;
		}
		if( stat.getChildNum() > 0 ) {
			generateExpression(stat.getChild(0), parentName, out);
			if( generateAssignSourceType ) {
				out.add(" : ");
				generate( stat.getChild(0).getType(), false, parentName, out );
			}
		}
		out.add( ")" );
	}
	
	public void generateIf( IRIfStatement stat, String parentName, TextOut out ) {
		out.nlTabAdd( "(i:if " );
		generateExpression(stat.getIfTree(), parentName, out);
		out.add(" (;;then");

		out.pushScope(new Scope());
        generate( stat.getIfStatement(), parentName, out );
		out.popScope();

		out.nlTabAdd(") (;;else");
		out.pushScope(new Scope());
		
		int scopes = 0;
		
		for( int i = 0; i < stat.getElseIfCount(); i++ ) {
			glue.generateLocation(stat.getElseIfTree(i).getBegin(), out);
			scopes++;
			out.nlTabAdd("(i:if ");
			generateExpression(stat.getElseIfTree(i), parentName, out);
			out.add(" (;; else if" + i);
			out.pushScope(new Scope());
			generate(stat.getElseIfStatement(i), parentName, out);

			out.popScope();
			out.nlTabAdd(") (;;end else if" + i);
			out.pushScope(new Scope());
		}
		
		if( stat.getElseStatement() != null )  {
			generate( stat.getElseStatement(), parentName, out );
		}
		
		while( scopes > 0 ) {
			out.popScope();
			out.nlTabAdd(")))");
            // конец else, if и location
			scopes--;
		}

		out.popScope();
		out.nlTabAdd("))");
	}
	
	//(i:for i in (i:a'range 1 c)
	public void generate( IRForStatement fr, String parentName, TextOut out ) {
//		generateUniqueName( fr.getLoopVariable() );
		out.nlTabAdd( "(i:for " );
		if( fr.getLabel() != null ) {
			out.add(":" + fr.getLabel() + " ");
		}
		out.add( fr.getLoopVariable().getName() + " " );
        generateRange( fr.getLoopVariable(), parentName, out );
		out.pushScope(new Scope());
		generate( fr.getBody(), parentName, out );
		out.popScope();
		out.nlTabAdd( ")" );
	}
	
	public void getCaseChoices(IROper oper, ArrayList<IROper> res) {
		IRConst cnst;
		if( (cnst=IRConst.getConstantValue(oper, err)) != null ) {
			res.add(cnst);
			return;
		}
		
		if( oper instanceof IROperRange ) {
			IROperRange range = (IROperRange) oper;
			IRType type = range.getType();
			if( type.isEnum() ) {
				IRTypeEnum en = (IRTypeEnum) type;
				IRConst fc = IRConst.getConstantValue(range.getRangeLow(), err);
				IRConst lc = IRConst.getConstantValue(range.getRangeHigh(), err);
				if( fc == null || lc == null ) {
					int a = 0;
					a++;
					IRConst.getConstantValue(range.getRangeHigh(), err);
				}
				int first = fc.getConstant().getEnumValue().getValue();
				int last = lc.getConstant().getEnumValue().getValue();
				if( Math.abs(first-last) > 10000 ) {
					throw new RuntimeException("range too much");
				}
				// isDownTo ? -1 : 1
				int inc = first - last > 0 ? -1 : 1;
				for( int i = first; i != last; i += inc ) {
					res.add(en.getValue(i).getSimValue());
				}
				res.add(en.getValue(last).getSimValue());
			} else {
				IRTypeInteger intType = (IRTypeInteger) type;
				int first = IRConst.getConstantValue(range.getRangeLow(), err).getConstant().getIntValue();
				int last = IRConst.getConstantValue(range.getRangeHigh(), err).getConstant().getIntValue();
				if( Math.abs(first-last) > 10000 ) {
					throw new RuntimeException("range too much");
				}
				// isDownTo ? -1 : 1
				int inc = first - last > 0 ? -1 : 1;
				for( int i = first; i != last; i += inc ) {
					res.add(IRTypeInteger.createConstant(i));
				}
				res.add(IRTypeInteger.createConstant(last));
			}
		} else if( oper instanceof IRChoices ) {
			for( int i = 0; i < oper.getChildNum(); i++ ) {
				getCaseChoices(oper.getChild(i), res);
			}
		} else if( oper instanceof IROperOthers || oper instanceof IRAggreg ) {
			res.add(oper);
		} else {
			throw new RuntimeException("Unknown choice " + oper.getClass().getCanonicalName());
		}
	}
	
	public void generateCase( IRCaseStatement stat, String parentName, TextOut out ) {
		
		if( stat.getBegin() != null && stat.getBegin().getFile().endsWith("MIPS_TB.vhdl") && stat.getBegin().getLine() == 117 ) {
			int a = 0;
			a++;
		}
		
		out.nlTabAdd("(i:case (");
		generateExpression( stat.getExpression(), parentName, out );
        out.add(" : ");// + stat.getExpression().getType().getBaseTypeName() +
        Type type = getTypeWrap(stat.getExpression().getType());
        
//        out.add( (type.owner + "." + type.type.getName()).toUpperCase() );
        generate(stat.getExpression().getType(), false, parentName, out);
        
        out.add(") ");
		
		out.pushScope(new Scope());
		
//		for( int i1 = 0; i1 < stat.getNumCases(); i1++ ) {
//			out.nlTabAdd( "( ");
//			generateExpression( stat.getChoice(i1), parentName, out );
//			out.add(" ");
//			out.pushScope(new Scope());
//			generate( stat.getStatement(i1), parentName, out );
//			out.popScope();
//			out.nlTabAdd(")");
//		}

		for( int i1 = 0; i1 < stat.getNumCases(); i1++ ) {
			ArrayList<IROper> choices = new ArrayList<IROper>();
			getCaseChoices(stat.getChoice(i1), choices);
			out.nlTabAdd( "( (");
			for( int i2 = 0; i2 < choices.size(); i2++ ) {
				generateExpression( choices.get(i2), parentName, out );
				out.add(" ");
			}
			out.add(") ");
			out.pushScope(new Scope());
			generate( stat.getStatement(i1), parentName, out );
			out.popScope();
			out.nlTabAdd(")");
		}
		
		out.popScope();
		
		out.nlTabAdd(")");
	}
	
	protected void generateExit( IRExitOrNextStatement stat, String parentName, TextOut out ) {
		if( stat.getCondition() != null ) {
			out.nlTabAdd("(i:if ");
			generateExpression(stat.getCondition(), parentName, out);
			out.pushScope(new Scope());
			out.nlTabAdd("(");
		}
		String kind = stat.isNext() ? "next" : "exit";
		if( stat.getLabel() != null ) {
			out.nlTabAdd("(i:" + kind + " " + stat.getLabel() + " )");
		} else {
			out.nlTabAdd("(i:" + kind + " )");
		}
		if( stat.getCondition() != null ) {
			out.nlTabAdd(")");
			out.nlTabAdd("() ;; empty else");
			out.popScope();
			out.nlTabAdd(")");
		}
	}
	
	protected void generateWhile( IRWhileStatement stat, String parentName, TextOut out ) {
		out.nlTabAdd("(i:while ");
		if( stat.getLabel() != null ) {
			out.add(":" + stat.getLabel() + " ");
		}
		generateExpression(stat.getCondition(), parentName, out);
		out.pushScope(new Scope());
		generate( stat.getBody(), parentName, out );
		out.popScope();
		out.add(")");
	}
	
	public void generate( IRStatement stat, String parentName, TextOut out ) {
        if ( stat.getKind() == IROperKind.STATS )
        {
			generate( (IRStatements) stat, parentName, out );
            // ^ чтобы не генерировать положение в сорце несколько раз
            return;
        }
        glue.generateLocation(stat.getBegin(), out);
		switch( stat.getKind() ) {
		case SIG_ASGN:
			generate( (IRSignalAssignment) stat, parentName, out );
			break;

		case EMPTY_STATEMENT:
			out.nlTabAdd("(i:nop)");
			break;
			
		case VAR_ASGN:
			generate( (IRVariableAssignment) stat, parentName, out );
			break;
			
		case RETURN:
			generate( (IRReturnStatement) stat, parentName, out );
			break;
			
		case FOR:
			generate( (IRForStatement) stat, parentName, out );
			break;
			
		case IF:
			generateIf((IRIfStatement) stat, parentName, out);
			break;
			
		case CASE:
			generateCase( (IRCaseStatement) stat, parentName, out );
			break;
			
		case EXIT:
			generateExit( (IRExitOrNextStatement)stat, parentName, out );
			break;
			
		case WHILE:
			generateWhile( (IRWhileStatement) stat, parentName, out );
			break;
			
		case PROC_CALL:
			out.nlTab();
			generateExpression( ((IRProcedureCall)stat).getCall(), parentName, out);
			break;
			
		case REPORT:
			IRReportStatement rep = (IRReportStatement) stat;
			out.nlTabAdd( "(i:report " );
 			generateExpression(rep.getExpr(), parentName, out);
			if( rep.getSeverity() != null ) {
				out.add(" "); generateExpression(rep.getSeverity(), parentName, out);
			}
			out.add(")");
			break;
			
		case ASSERT:
			IRAssertStatement ass = (IRAssertStatement) stat;
			out.nlTabAdd("(i:assert ");
			generateExpression(ass.getCondition(), parentName, out);
			if( ass.getReport() != null ) {
 				out.add(" report ");
 				generateExpression(ass.getReport(), parentName, out);
			}
			if( ass.getSeverity() != null ) {
 				out.add(" severity ");
 				generateExpression(ass.getSeverity(), parentName, out);
			}
			out.add(")");
			break;

		case WAIT:
			IRWaitStatement wait = (IRWaitStatement) stat;
			out.nlTabAdd("(i:wait");
			if( wait.getSensivityList().size() > 0 ) {
				out.add(" on (");
				for( int i = 0; i < wait.getSensivityList().size(); i++ ) {
					generateExpression(wait.getSensivityList().get(i), parentName, out);
				}
				out.add(")");
			}
			if( wait.getCondition() != null ) {
				out.add(" until ");
				generateExpression(wait.getCondition(), parentName, out);
			}
			if( wait.getTimeout() != null ) {
				out.add(" for ");
				generateExpression(wait.getTimeout(), parentName, out);
			}
			out.add(")");
			break;
			
		default:
			throw new RuntimeException(stat.getKind().toString());
		}
        out.add(")");// конец location-а
	}
	
	public void generate( IRStatements stats, String parentName, TextOut out ) {
		for( int i = 0; i < stats.getNumStatements(); i++ ) {
			IRStatement stat = stats.getStatement(i);
			generate(stat, parentName, out);
		}
	}
	
	protected void generate( String parentName, ArrayList<IRComponentInstance> comps, TextOut out ) {
		for( int i = 0; i < comps.size(); i++ ) {
			generate( parentName, comps.get(i), out, glue.funcsOut, glue.typesOut, glue.cnstsOut );
		}
	}
	
	public void generate( String parentName, IRComponentInstance comp, TextOut out, TextOut funcsOut,
			TextOut typesOut, TextOut cnstsOut ) {
		glue.funcsOut = funcsOut;
		glue.typesOut = typesOut;
		glue.cnstsOut = cnstsOut;
		push(comp, parentName);
		String name;
		if( parentName != null ) {
			name = parentName + "." + comp.getName();
		} else {
			name = comp.getName();
		}
//		generateFullName(name, comp);
		
		IROper[] assoc = comp.getPortAssociations();
		HDLAssoc[] ports = new HDLAssoc[assoc.length];
		for( int i = 0; i < assoc.length; i++ ) {
			IROper op = assoc[i];
			if( !(op instanceof IROperAssoc) ) {
				PortDesc port = comp.getComponent().getPortList().get(i);
				ports[i] = new HDLAssoc(port.getExpr(op.getBegin()), new HDLExpr(op));
			} else {
				ports[i] = new HDLAssoc((IROperAssoc)op);
			}
		}
		
		assoc = comp.getGenericsAssociations();
		HDLAssoc[] gens = new HDLAssoc[assoc.length];
		for( int i = 0; i < assoc.length; i++ ) {
			IROper op = assoc[i];
			if( !(op instanceof IROperAssoc) ) {
				GenDesc gen = comp.getComponent().getGenList().get(i);
				gens[i] = new HDLAssoc(gen.getExpr(op.getBegin()), new HDLExpr(op));
			} else {
				gens[i] = new HDLAssoc((IROperAssoc)assoc[i]);
			}
		}
		
		generate( name, comp, ports, gens, out );
		
//		out.pushScope(new Scope());
//		IROper wires[] = comp.getPortAssociations();
//		for( int i = 0; i < wires.length; i++ ) {
//			out.nlTabAdd("( wire ");
//			generateExpression(wires[i].getChild(0), out);
//			out.add(" ");
//			generateExpression(wires[i].getChild(1), out);
//			out.add(" )");
//		}
//		out.popScope();
		pop();
	}
	
	public void generate( IRBlock block, String parentName, TextOut out ) {
//		generateFullName(parentName, block);
//		IRType[] types = block.getTypes().getTypes();
//		generate(types, out);
		push(block, parentName);
		ArrayList<IRGeneric> gens = block.getGenerics();
		for( int i = 0; i < gens.size(); i++ ) {
			generate( gens.get(i), parentName, null, out );
		}
		for( IRConstant c : block.getConstants() ) {
			generate(c, parentName, c.getValue(), out);
		}
		for( IRPort p : block.getPorts() ) {
			generate( parentName, p, out ); // generating port as signal
		}
		String fullName = getFullName(parentName, block);
		ArrayList<IRSignal> signals = block.getSignals();
		for( int i = 0; i < signals.size(); i++ ) {
			generate( fullName, signals.get(i), out );
		}
		ArrayList<IRAlias> aliases = block.getAliases();
		for( IRAlias al : aliases ) {
			generate( al, fullName, out );
		}
		ArrayList<IRStatement> conc = block.getConcurrent();
		for( int i = 0; i < conc.size(); i++ ) {
			IRStatement stat = conc.get(i);
			generateConcurrent(block.getName(), stat, out);
		}
		ArrayList<IRProcess> procs = block.getProcesses();
		for( int i = 0; i < procs.size(); i++ ) {
			IRProcess proc = procs.get(i);
			generate( proc, fullName, out );
		}
		IRComponentInstance[] comps = block.getComponentInstances();
		for( IRComponentInstance comp : comps ) {
			generate(fullName, comp, out, glue.funcsOut, glue.typesOut, glue.cnstsOut);
		}
		pop();
	}
	
	public void generate( IRProcess proc, String parentName, TextOut out ) {
		out.pushScope(new Scope());
		glue.generateLocation(proc.getBegin(), out);
		if( proc.getBegin().getFile().endsWith("0231.vhd") && proc.getBegin().getLine() >= 225 ) {
			int a = 0;
			a++;
		}
		String procFullName = getFullName(parentName, proc);
		push( proc, parentName );
		out.nlTabAdd("(process " + procFullName + " (");
		out.pushScope(new Scope());
		ArrayList<IROper> list = proc.getSensivityList();
		for( int i = 0; i < list.size(); i++ ) {
			glue.generateLocation(list.get(i).getBegin(), out);
			out.nlTab();
			generateExpression(list.get(i), parentName, out);
            out.add(")");
		}
		out.nlTabAdd(")");
        out.popScope();
		
        generateBody( proc,
                      proc.getVars(),
                      proc.getConstants(),
                      proc.getAliases(),
                      proc.getTypes(),
                      proc.getStatements(),
                      proc.getSubprograms(),
                      parentName, out );
        out.popScope();
		glue.generatePendingItems();
		pop();
	}

    public void generateBody( IRNamedElement elt,
                              ArrayList<IRVariable> vars,
                              ArrayList<IRConstant> constants,
                              ArrayList<IRAlias> aliases,
                              IRTypes localTypes,
                              IRStatement statements,
                              IRSubprograms subprograms,
                              String parentName, TextOut out )
    {
		ArrayList<IRType> types = new ArrayList<IRType>();
		localTypes.getTypes(types);
		
		String fullName = parentName + "." + elt.getName();

        boolean letNeeded =
            types.size() + vars.size() + constants.size() + aliases.size()
            + subprograms.size() > 0;
        
		out.pushScope(new Scope());
        if ( letNeeded )
        {
            out.nlTabAdd("(i:let (");
            out.pushScope(new Scope());
        }
		
//		if( elt.getName().equalsIgnoreCase("CONV_SIGNED") ) {
//			int a = 0;
//			a++;
//		}

        // TODO: по хорошему их надо выводить в порядке объявления
        generateLocalTypes(localTypes, fullName, out);
//		for( IRType type : types ) {
//			String ownerName = parentName;
//			Type t = getTypeWrap(ownerName, type);
//			if( !generatedTypes.contains(t) ) {
//				generatedTypes.add(getTypeWrap(type));
//				generateTypeDefinition(type, ownerName + "." + type.getName(), out);
//			}
//		}
        
		for( int i = 0; i < constants.size(); i++ ) {
			IRConstant cnst = constants.get(i);
			if( cnst.getName().equalsIgnoreCase("zero_indexed_string") ) {
				int a = 0;
				a++;
			}
			generate(cnst, fullName, null, out);
//			generatedConstants.add(cnst);
//			generatedObjects.add(new NamedObject(fullName, cnst));
		}
		for( IRAlias alias : aliases ) {
			generate(alias, parentName, out);
		}
		for( int i = 0; i < vars.size(); i++ ) {
			IRVariable var = vars.get(i);
//			out.nlTabAdd(";; variable " + var.getName() + " of subprogram " + sub.getName());
//			generateUniqueName(var);
			generate(var, parentName, out);
		}
        for( int i = 0; i < subprograms.size(); i++ ) {
            IRSubProgram sub = subprograms.get(i);
            SubProgram wrap = getSubProgramWrap(sub);
            generate(wrap, parentName, out);
        }
        if ( letNeeded )
        {
            out.nlTabAdd(") ;; end locals");
            out.popScope();
        }
		if( statements != null ) generate( statements, parentName, out);
		
		if( elt.getEnd() == null ) {
			System.err.println(elt + " at " + elt.getBegin() + " don't have end coord");
		}
		glue.generateLocation(elt.getEnd(), out);
        out.nlTabAdd("(i:nop))");
        // ^ пустышка в конце для создания точки останова
		out.popScope();
        out.nlTabAdd(letNeeded ? ")))" : "))");
    }
	
	public void generate( SubProgram wrap, String parentName, TextOut out ) {
		IRSubProgram sub = wrap.sub;
		push(sub, parentName);
		glue.generateLocation(sub.getBegin(), out);
//		out.pushScope(new Scope());
		
        generatedSubprograms.add(wrap);
        
		if( sub.getName().equalsIgnoreCase("minus") ) {
			int a = 0;
			a++;
		}
		
		String kind = sub.isFunction() ? "function" : "procedure";
		String subFullName = getSubFullName(wrap);
		Integer code = getFunctionCode(sub);
		
		out.nlTabAdd("(" + kind + " " + subFullName );

        ArrayList<IRParameter> pars = sub.getParameters();
        if ( pars.size() == 0 )
        {
            out.add(" () ");
        }
        else
        {
            out.add(" (");
            out.pushScope(new Scope());
            for( int i = 0; i < pars.size(); i++ ) {
                IRParameter p = pars.get(i);
                glue.generateLocation(p.getBegin(), out);
                out.nlTabAdd("(");
                out.add(p.getName() + " : " );
                generate( p.getType(), false, parentName, out );
                out.add( " " + p.getObjectClass().toString().toLowerCase() );
                if ( p.getDirection() != null )
                {
                    switch ( p.getDirection() )
                    {
                        case NONE:    break;
                        case INPUT:   out.add(" in"); break;
                        case OUTPUT:  out.add(" out"); break;
                        case INOUT:   out.add(" inout"); break;
                        case BUFFER:  out.add(" buffer"); break;
                        case LINKAGE: out.add(" linkage"); break;
                        default:
                            out.add( " " + p.getDirection().toString().toLowerCase() );
                            break;
                    }
                }
                out.add("))");
            }
            out.add(")");
            out.popScope();
        }
		
		if( sub.isFunction() ) {
			IRFunction f = (IRFunction) sub;
            out.add(" ");
			generate( f.getReturnType(), false, parentName, out );
		}

        generateBody( sub,
                      sub.getVars(),
                      sub.getConstants(),
                      sub.getAliases(),
                      sub.getTypes(),
                      sub.getBody(),
                      sub.getSubprograms(),
                      // почему-то у IRSubProgram нет вложенных subprogram
                      parentName, out );
        
        glue.generatePendingItems();
        stack.pop();
	}
	
	public void generate( String parentName, IRSignal sig, TextOut out ) {
		if( sig.getName().equalsIgnoreCase("i_st_real1_1") ) {
			int a = 0;
			a++;
		}
		NamedObject wrap = getObjectWrap(parentName, sig);
		if( generatedObjects.contains(wrap) ) {
//			System.out.println("Strange, " + cnst.getFullName() + " already generated at " + cnst.getBegin());
			return;
		}
		generatedObjects.add(wrap);
		glue.generateLocation(sig.getBegin(), out);
        //out.nlTabAdd(";; signal " + sig.getName());
        // ^ и так сорец выдаем
//		generateFullName(parentName, sig);
		String fullName = getFullName(parentName, sig);
		out.nlTabAdd("(signal " + fullName + " ");
		generate(sig.getType(), false, parentName, out);
		if( sig.getInit() != null ) {
			out.add(" ");
			generateExpression(sig.getInit(), parentName, out);
		}
		out.add("))");
	}
	
	public void generate( String parentName, IRComponentInstance comp, HDLAssoc[] wires, HDLAssoc[] gens, TextOut out ) {
//		out.nlTabAdd( ";; entity " + arch.getEntity().getFullName() );
		{
			out.pushScope(new Scope());
			
			boolean isVHDL = comp.getComponent().getKind() == HDLKind.VHDL;
			
			if( isVHDL ) {
				push(comp.getComponent().getEntity(), parentName);
				push(comp.getComponent().getEntity().getArchitecture(comp.getArchName()), parentName);
			}
			
			glue.generateComponent(HDLKind.VHDL, comp.getComponent(), wires, gens, parentName, comp.getArchName(), out);
			
			if( isVHDL ) {
				pop();
				pop();
			}
			
			out.popScope();
			
		}
	}
	
	public void generateComponentImplementation( String parentName, IREntity entity, String archName, TextOut out ) {
		IRArchitecture arch = entity.getArchitecture(archName);
//		out.nlTabAdd( ";; entity " + arch.getEntity().getFullName() );
		push(entity, parentName);
		push(arch, parentName);
			
//			out.nlTabAdd(")");
		{
			out.pushScope(new Scope());			
			IRTypes types = arch.getEntity().getTypes();
			generateLocalTypes(types, parentName, out);
			types = arch.getTypes();
			generateLocalTypes(types, parentName, out);
//			IRType[] ts = types.getTypes();
//			for( IRType type : ts ) {
//				String ownerName = parentName;
//				Type t = getTypeWrap(ownerName, type);
//				if( !generatedTypes.contains(t) ) {
//					generatedTypes.add(getTypeWrap(type));
//					generateTypeDefinition(type, ownerName + "." + type.getName(), out);
//				}
//			}
			out.popScope();
		}
		{
			out.pushScope(new Scope());
			ArrayList<IRSignal> sigs = entity.getSignals();
			for( int i = 0; i < sigs.size(); i++ ) {
				IRSignal sig = sigs.get(i);
				generate( parentName, sig, out );
			}
			sigs = arch.getSignals();
			for( int i = 0; i < sigs.size(); i++ ) {
				IRSignal sig = sigs.get(i);
				generate( parentName, sig, out );
			}
			out.popScope();
		}
		{
			ArrayList<IRProcess> pr = entity.getProcesses();
			for( int i = 0; i < pr.size(); i++ ) {
				IRProcess proc = pr.get(i);
				generate(proc, parentName, out);
			}
		}
		{
			ArrayList<IRProcess> pr = arch.getProcesses();
			for( int i = 0; i < pr.size(); i++ ) {
				IRProcess proc = pr.get(i);
				generate(proc, parentName, out);
			}
		}
		{
			ArrayList<IRVariable> vars = arch.getVars();
			for( int i = 0; i < vars.size(); i++ ) {
				IRVariable var = vars.get(i);
				generate(var, parentName, out);
			}
		}
		{
			ArrayList<IRAlias> als = arch.getAliases();
			for( int i = 0; i < als.size(); i++ ) {
				IRAlias al = als.get(i);
				generate(al, parentName, out);
			}
		}
		{
			ArrayList<IRConstant> cnsts = arch.getEntity().getConstants();
			for( int i = 0; i < cnsts.size(); i++ ) {
				IRConstant cnst = cnsts.get(i);
				generate(cnst, parentName, null, out);
			}
		}
		{
			ArrayList<IRConstant> cnsts = arch.getConstants();
			for( int i = 0; i < cnsts.size(); i++ ) {
				IRConstant cnst = cnsts.get(i);
				generate(cnst, parentName, null, out);
			}
		}
		{
			out.pushScope(new Scope());
			ArrayList<IRComponentInstance> comps = arch.getComponents();
			for( int i = 0; i < comps.size(); i++ ) {
				try {
					comps.get(i).semanticCheck(err);
				} catch (CompilerError e) {
					e.printStackTrace();
				}
				generate( parentName, comps.get(i), out, glue.funcsOut, glue.typesOut, glue.cnstsOut );
			}
			out.popScope();
		}
		{
			out.pushScope(new Scope());
			ArrayList<IRStatement> concur = arch.getConcurrent();
			for( int i = 0; i < concur.size(); i++ ) {
				generateConcurrent( parentName, concur.get(i), out );
			}
			out.popScope();
		}
		{
			out.pushScope(new Scope());
			ArrayList<IRBlock> blocks = arch.getBlocks();
			for( int i = 0; i < blocks.size(); i++ ) {
				IRBlock bl = blocks.get(i);
				out.nlTabAdd(";; block " + bl.getName());
				out.pushScope(new Scope());
				generate( bl, parentName, out );
				out.popScope();
				out.nlTabAdd(";; end block " + bl.getName());
			}
			out.popScope();
		}
		glue.generatePendingItems();
		pop();
		pop();
		out.nlTabAdd( ";; end entity " + arch.getEntity().getName() );
	}
	
	protected void generateConcurrent(String parentName, IRStatement statement, TextOut out) {
		switch( statement.getKind() ) {
		
		case SIG_ASGN:
		{
			IRSignalAssignment sig = (IRSignalAssignment) statement;
			IRProcess proc = sig.generateProcess(getOwningArch(), err);
			String name = ns.getUniqueName(proc, "autoprocess");
			if( name.equalsIgnoreCase("autoprocess23") ) {
				int a = 0;
				a++;
			}
			proc.setName(name);
//			generateFullName(parentName, proc);
//			proc.setFullName(name);
			generate(proc, parentName, out);
		}
			break;
			
		case SELECT_ASGN:
		{
			IRSelectedAssign asgn = (IRSelectedAssign) statement;
			IRProcess proc = asgn.generateProcess(stack.peek().el, err);
			String name = ns.getUniqueName(proc, "autoselect");
			proc.setName(name);
			generate(proc, parentName, out);
		}
			break;
			
		case GEN_IF:
			if( GenGlue.extendGenerateStatements ) {
				IRIfGenerateStatement ifgen = (IRIfGenerateStatement) statement;
				ifgen.generate(err);
				generate( parentName, ifgen.getProcessedComponents(), out );
				generate( ifgen.getProcessedStatements(), parentName, out );
				generateConcurrent(parentName, ifgen.getProcessedConcurent(), out);
			} else {
				IRIfGenerateStatement ifgen = (IRIfGenerateStatement) statement;
				out.nlTabAdd("(if ");
				generateExpression(ifgen.getCondition(), parentName, out);
				out.add(" generate");
				generateGenerateStatementUnextended(ifgen, parentName, parentName, out);
				out.nlTabAdd(")");
			}
			break;
			
		case GEN_FOR:
			if( GenGlue.extendGenerateStatements ) {
				IRForGenerateStatement forgen = (IRForGenerateStatement) statement;
				forgen.generate(err);
				generate( parentName, forgen.getProcessedComponents(), out );
				generate( forgen.getProcessedStatements(), parentName, out );
				generateConcurrent(parentName, forgen.getProcessedConcurent(), out);
			} else {
				IRForGenerateStatement forgen = (IRForGenerateStatement) statement;
				String processParentName = parentName + "." + forgen.getLabel();
				out.nlTabAdd("(for " + processParentName + " " + forgen.getLoopVariable().getName() + " ");
				generateRange(forgen.getLoopVariable(), parentName, out);
				out.add(" generate");
				generateGenerateStatementUnextended(forgen, parentName, processParentName, out);
				out.nlTabAdd(")");
			}
			break;
			
		case STATS:
			IRStatements stats = (IRStatements) statement;
			for( int i = 0; i < stats.getNumStatements(); i++ ) {
				generateConcurrent(parentName, stats.getStatement(i), out);
			}
			break;
			
		default:
			throw new RuntimeException(statement.getKind().toString());
		}
	}
	
	protected void generateGenerateStatementUnextended(IRGenerateStatement gen, String parentName, String processParentName, TextOut out) {
		out.pushScope(new Scope());
		generate(gen.getStatements(), parentName, out);
		generateConcurrent(parentName, gen.getConcurent(), out);
		ArrayList<IRProcess> prs = gen.getProcesses();
		for( IRProcess p : prs ) {
			generate(p, processParentName, out);
		}
		IRComponentInstance[] insts = gen.getComponentInstances();
		for( IRComponentInstance inst : insts ) {
			generate( parentName, inst, out, glue.funcsOut, glue.typesOut, glue.cnstsOut );
		}
		for( IRBlock bl : gen.getBlocks() ) {
			generate( bl, parentName, out );
		}
		out.popScope();
	}

	public void generate( IROperAssoc assoc, String parentName, TextOut out ) {
	}

    boolean isExpressionOnlyAggreg( IRAggreg aggreg )
    {
        for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
            if( aggreg.getMemberIndex(i) instanceof IROperRange ) {
                return false;
            } else if( aggreg.getMemberIndex(i) instanceof IROperOthers ) {
                return false;
            }
        }
        return true;
    }
	
	public void generate( IRAggreg aggreg, String parentName, TextOut out ) {
		if( aggreg.getChildNum() == 1 && aggreg.getChild(0).getKind() != IROperKind.ASSOC ) {
			generateExpression(aggreg.getChild(0), parentName, out);
		} else {
            out.pushScope(new Scope());
            IRType at = aggreg.getType();
            if( at == null ) {
            	int a = 0;
            	a++;
            }
            IROperRange singleRangeAssoc = null;
            boolean exprOnlyAggreg = isExpressionOnlyAggreg( aggreg );
            boolean needAnnotation =
                !(at instanceof IRArrayIndex // пока не знаю, что с ними делать
            // TODO: у вложенного агрегата в stdlogic_table тип std_ulogic вместо массива
            // имеет тип IRArrayIndex
                  || at.isRecord()
                  || (at.isArray() &&
                      ((exprOnlyAggreg && ((IRTypeArray)at).getIndexes().length == 1)
                       ||
                       !isUnconstrainedRanges(((IRTypeArray)at.getOriginalType()).getIndexes())
                       ))
                  // для массивов аннотация не нужна, если базовый тип
                  // ограничен (т.е. известен размер массива), или для
                  // одномерных массивов, состоящих только из выражений
                  // (для них рамер можно посчитать автоматом).
                  );
			out.nlTabAdd(needAnnotation ? "([" : "[");
            if ( exprOnlyAggreg )
            {
                if ( at.isRecord() )
                {
                    IRTypeRecord rec = (IRTypeRecord) aggreg.getType();
                    for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
                        generateExpression( aggreg.getMemberValue(i), parentName, out );
                        out.add(" ;; " + rec.getField(i).getName());
                        out.nlTabAdd(" ");
                    }
                }
                else
                {
                    for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
                        generateExpression( aggreg.getMemberValue(i), parentName, out );
                        if ( i + 1 < aggreg.getNumMembers() )
                        {
                            out.add(" ");
                        }
                    }
                }
            }
            else
            {
                for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
                    if( aggreg.getType().isRecord() ) {
                        // TODO: а у record-ов others не бывает?
                        IRTypeRecord type = (IRTypeRecord) aggreg.getType();
                        out.add("(i:f " + type.getField(i).getName());
                    } else if( aggreg.getMemberIndex(i) instanceof IROperRange ) {
                        IROperRange r = (IROperRange) aggreg.getMemberIndex(i);
                        out.add("(i:t ");
                        generateRange(r, parentName, out);
                        if (aggreg.getNumMembers() == 1 ) {
                            singleRangeAssoc = r;
                        }
                    } else if( aggreg.getMemberIndex(i) instanceof IROperOthers ) {
                        out.add("(i:others");
                    } else {
                        out.add("(i:e ");
                        generateExpression(aggreg.getMemberIndex(i), parentName, out);
                        // TODO: идет целое число
                        // IRAggreg:360: memberIndexes.add(IRTypeInteger.createConstant(ai));
                    }
                    out.add("\t\t");
                    generateExpression( aggreg.getMemberValue(i), parentName, out );
                    out.add(")");
                    out.nlTabAdd(" ");
                }
            }
//			if( aggreg.getOthersInit() != null ) {
//				out.add("(i:others ");
//				generateExpression( aggreg.getOthersInit(), parentName, out );
//				out.add(")");
//			}
            if ( needAnnotation )
            {
                out.add("] : ");//+aggreg.getType().getClass().getCanonicalName()+" ");
                //generate(aggreg.getType(), false, out);
                IRTypeArray arr = 
                    (aggreg.getType() instanceof IRTypeArray
                     ? (IRTypeArray) aggreg.getType() : null);

                if ( singleRangeAssoc != null
                     && arr != null && arr.getIndexes().length == 1 )
                {
                    // агрегат состоит из единтсвенной ассоциации-диапазона
                    // делаем тип агрегата массивом с заданным диапазоном
                    // (без этого генерится либо фиг знает какой диапазон,
                    // либо может сгенерить тип результата операции &
                    // и для variable foo : array10 := (1 to 9 => '0') & '1'
                    // сгенерит тип агрегата foo)
                    out.add("(array (");
                    generateRange(singleRangeAssoc, parentName, out);
                    //generateRange(arr.getIndexes(), parentName, out, true);
                    out.add(") of " );
                    generate(arr.getElementType(), false, parentName, out);
                    out.add(")");
                }
                else
                {
                    generate(aggreg.getType(), false, parentName, out);
                }

                out.add(")");
            }
            else
            {
                out.add("]");
            }
            out.popScope();
		}
	}
	
	public void generateGenericExpression( IROper oper, String parentName, TextOut out ) {
		out.add( oper.getKind().toString().toLowerCase() + "( " );
		for( int i = 0; i < oper.getChildNum(); i++ ) {
			generateExpression(oper.getChild(i), parentName, out);
			if( i + 1 < oper.getChildNum() ) out.add(", ");
		}
		out.add( " )" );
	}

    public boolean isStringConst( ArrayValue arr ) {
        for( int i = 0; i < arr.getNumComponents(); i++ ) {
            SimValue c = arr.getComponent(i);
            if ( !c.getType().isEnum() )
                return false;
            String val = c.toString();
            if ( val.length() < 3 || val.charAt(2) != '\'' )
                return false;
        }
        return true;
    }
        
	public void generateConstantRepresentation( SimValue cnst, TextOut out ) {
		boolean prevCase = out.isForceLowerCase();
		out.forceLowerCase(false);
        IRType type = cnst.getType();
        //generate(type, true, out);
        if( type == null ) {
        	int a = 0;
        	a++;
        }
        if ( type.getName() != null )
        {
            // генерируем только объявленные типы с именем
            addTypeToGenerate(type, out);
            // TODO: почему-то у report "asdf" тип "asdf" -- какой-то IRArrayIndex
            // который непонятно, как выводить. Ну и у него нет begin(), по-этому
            // addTypeToGenerate его отсекает, как не пойми какой тип
        }
		if( type.isArray() ) {
			ArrayValue arr = (ArrayValue) cnst;
            if ( isStringConst( arr ) )
            {
                out.add("\"");
                for( int i = 0; i < arr.getNumComponents(); i++ ) {
                    out.add(arr.getComponent(i).toString().substring(1,2));
                }
                out.add("\"");
            }
            else
            {
                out.add("[");
                for( int i = 0; i < arr.getNumComponents(); i++ ) {
                    generateConstantRepresentation(arr.getComponent(i), out);
                    if ( i+1 < arr.getNumComponents() ) out.add(" ");                
                }
                out.add("]");
            }
		} else if( type.isEnum() ) {
            String val = cnst.toString();
            if( val.equalsIgnoreCase("a") ) {
            	int a = 0;
            	a++;
            }
            if ( val.length() < 3 || val.charAt(2) != '\'' )
            {
                out.add("'");
                // enum ident-ы тоже имеют префиксом одинарную кавычку
                val = val.toLowerCase();
            }
			out.add(val);
		} else if( type.isPhysical() ) {
			PhysicalValue v = (PhysicalValue) cnst;
            if ( v.getUnits() == null ) // в диапазоне физического типа
            {
                out.add(v.getValue()+"");
                // кстати, диапазон все равно надо игнорировать,
                // т.к. 2^31 от IntValue или 2^63 от (long)doubleValue -- это мало
            }
            else
            {
                out.add("{" + v.getValue() + " " + v.getUnits() + "}");
            }
		} else if( type.isScalar() ) {
			out.add(cnst.toString()); 
		} else if( type.isType() ) {
			out.forceLowerCase(true);
			TypeValue v = (TypeValue) cnst;
			out.add(v.getValue().getFullName());
		} else {
			throw new RuntimeException(type.getName());
		}
		out.forceLowerCase(prevCase);
	}
	
    void generateName( IRNamedElement el, String parentName, TextOut out )
    {
    	if( el.getName().equalsIgnoreCase("some_sig") ) {
    		int a = 0;
    		a++;
    	}
    	if( IRNamedElement.isLocalElement(el) ) {
    		out.add(el.getName());
    	} else {
    		out.add(getFullName(parentName, el));
    	}
        //        out.add(el.getFullName());
        //        out.add(IRNamedElement.getFullName(el, el.getName()));
    }
//     void generateName( IRElement el, String name, String parentName, TextOut out )
//     {
//         out.add(getFullName(parentName, el, name));
//         //        out.add(IRNamedElement.getFullName(el, name));
//     }

    void generateIndex(IROper oper, int idxCount, String parentName, TextOut out)
    {
        if ( idxCount == 1 )
        {
            generateExpression(oper.getChild(0), parentName, out);
        }
        else
        {
            generateIndex(oper.getChild(0), idxCount - 1, parentName, out);
        }
        out.add(" ");
        generateExpression(oper.getChild(1), parentName, out);
    }
    
    protected String getNameFromStack( int lastIndex ) {
    	String ownerName = stack.get(0).el.getName();
    	for( int i = 1; i <= lastIndex; i++ ) {
    		if( stack.get(i).el instanceof IRArchitecture || stack.get(i).el instanceof IREntity ) continue;
    		ownerName += "." + stack.get(i).el.getName();
    	}
    	return ownerName;
    }

    
    
    protected SubProgram getSubProgramWrap( IRSubProgram sub ) {
    	IRSubProgramHolder owner = null;
    	int ownerIndex;
    	if( sub == null || sub.getName() == null || sub.getName().equals("resolved") ) {
    		int a = 0;
    		a++;
    	}
    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
    		if( stack.get(ownerIndex) instanceof IRSubProgramHolder ) {
    			IRSubProgramHolder cur = (IRSubProgramHolder) stack.get(ownerIndex);
    			if( cur.getSubprograms().contains(sub) ) {
    				owner = cur;
    				break;
    			}
    		}
    	}
    	String ownerName;
    	if( owner == null ) {
//    		System.err.println(sub.getFullName());
    		ownerName = sub.getFullName();
    		ownerName = ownerName.substring(0, ownerName.lastIndexOf('.') );
    	} else {
	    	ownerName = getNameFromStack(ownerIndex);
    	}
    	return new SubProgram(ownerName, sub);
    }
    
    protected SubProgram addSubProgramToGenerate( IRSubProgram sub ) {
    	SubProgram res = getSubProgramWrap(sub);
    	subprogramsToGenerate.add( res );
    	return res;
    }

    
    
    
    protected Type getTypeWrap( IRType type ) {
    	IRTypeHolder owner = null;
    	int ownerIndex;
    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
    		if( stack.get(ownerIndex).el instanceof IRTypeHolder ) {
    			IRTypeHolder cur = (IRTypeHolder) stack.get(ownerIndex).el;
    			if( cur.containsType(type) ) {
    				owner = cur;
    				break;
    			}
    		}
    	}
    	if( type.getName() != null && type.getName().equalsIgnoreCase("t_enum1") && (owner == null || !owner.toString().equalsIgnoreCase("GENERIC_STANDARD_TYPES") ) ) {
    		int a = 0;
    		a++;
    	}
    	String ownerName;
    	if( owner == null ) {
//     		System.err.println(type.getFullName());
//     		System.err.println(type.getBaseTypeName());
    		ownerName = type.getFullName();
    		int index = ownerName.lastIndexOf('.');
    		if( index < 0 ) {
    			ownerName = "";
    		} else {
    			ownerName = ownerName.substring(0, index );
    		}
    	} else {
	    	ownerName = getNameFromStack(ownerIndex);
    	}
    	return new Type(ownerName, type);
    }
    
    protected Type getTypeWrap( String ownerName, IRType type ) {
    	return new Type(ownerName, type);
    }
    
    protected Type addTypeToGenerate( IRType type, TextOut out ) {
        if ( type.getBegin() == null )
        {
            // out.add( "type.getBegin() == null" );
            return null;
            // TODO: тут лажа, надо вылечить причину, а не следствие
            // для
            //   atmega128/timer0.vhd:70:1:
            //   type register_synchronizer_t is array (0 to SYNCHRONIZER_DEEP) of synchronized_register_description_t;
            // при печати типа
            //   (type work.timer0.register_synchronizer_t (array ((STD.STANDARD.INTEGER (range 0 to 2))) of work.timer0.synchronized_register_description_t)))
            // получается фиг знает какой STD.STANDARD.INTEGER
            //   at com.prosoft.vhdl.ir.IRTypeInteger.createConstant(IRTypeInteger.java:84)
            // который выводится потом как
            //  (# null location 
            //  (type STD.STANDARD.INTEGER [STD.STANDARD.INTEGER (range <>)]))
        }

        Type wrap = getTypeWrap(type);
        if( !generatedTypes.contains(wrap) 
        		&& !typesToGenerate.contains(wrap) ) {
            typesToGenerate.add(wrap);
        }

    	return wrap;
    }


    protected NamedObject getObjectWrap( String parentName, IRNamedElement el ) {
    	if( el.getName().equalsIgnoreCase("to_resolve") ) {
    		int a = 0;
    		a++;
    	}
    	String res = getFullName(parentName, el);
    	int index = res.lastIndexOf(".");
    	if( index > 0 ) {
    		return new NamedObject( res.substring(0, index), el);
    	} else {
    		return new NamedObject( parentName, el );
    	}
//    	if( cnst.getName().equals("period_1MHz") ) {
//    		int a = 0;
//    		a++;
//    	}
//    	if( cnst instanceof IRLoopVariable ) return new NamedObject("", cnst);
//    	ILocalResolver owner = null;
//    	int ownerIndex;
//    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
//    		if( stack.get(ownerIndex) instanceof ILocalResolver ) {
//    			ILocalResolver cur = (ILocalResolver) stack.get(ownerIndex);
//    			if( cur.contains(cnst) ) {
//    				owner = cur;
//    				break;
//    			}
//    		}
//    	}
//    	String ownerName;
//    	if( owner == null ) {
////    		System.err.println(sub.getFullName());
//    		ownerName = cnst.getFullName();
//    		int index = ownerName.lastIndexOf('.');
//    		if( index < 0 ) {
//    			System.err.println(ownerName);
//    			int a = 0;
//    			a++;
//    			((ILocalResolver)stack.get(0)).contains(cnst);
//    		}
//    		ownerName = ownerName.substring(0, index );
//    	} else {
//	    	ownerName = getNameFromStack(ownerIndex);
//    	}
//    	return new NamedObject(ownerName, cnst);
    }
    
//    protected NamedObject addObjectToGenerate( IRConstant cnst ) {
//    	NamedObject res = getObjectWrap(cnst);
//    	objectsToGenerate.add( res );
//    	return res;
//    }

    
    
    
    
        
    void generateExpressionAsArray( IROper oper, String parentName, TextOut out )
    {
        //        out.add(oper.getType().getClass().getCanonicalName());
        if ( oper.getType() instanceof IRTypeArray ||
             oper.getType() instanceof IRArrayIndex )
        {
            generateExpression(oper, parentName, out);
        }
        else
        {
            // операция & в симуляторе реализована только для массивов
            // по-этому для склеивания элементов, мы превращаем их
            // в одномерный массив
            out.add("[");
            generateExpression(oper, parentName, out);
            out.add("]");
        }
    }
    char typeChar( IRType t )
    {
        //        out.add(oper.getType().getClass().getCanonicalName());
        if ( t instanceof IRTypeInteger )
            return 'i';
        else if ( t instanceof IRTypeReal )
            return 'r';
        else if ( t instanceof IRTypePhysical )
            return 'p';
        else
            return ' ';
    }
	public void generateExpression( IROper oper, String parentName, TextOut out ) {
    	if( oper == null || oper.getBegin() != null && 
    			oper.getBegin().getFile().endsWith("ct00141.vhd") && 
    			oper.getBegin().getLine() == 198 ) {
    		int a = 0;
    		a++;
    	}
        //        out.add(oper.getKind()+" ");
		if( oper instanceof IRBinaryOper ) {
			IRBinaryOper bo = (IRBinaryOper) oper;
            out.add("(");
			if( bo.getSub() != null &&
                (!bo.isBooleanCompatible() /*|| bo.getSub().getBody() != null*/ )) {
				IRFunction func = (IRFunction) bo.getSub();
				SubProgram sub = addSubProgramToGenerate(func);//subprogramsToGenerate.add(func);
                out.add(getSubFullName(sub));
				out.add(" ");
				generateExpression(bo.getChild(0), parentName, out);
				out.add(" ");
				generateExpression(bo.getChild(1), parentName, out);
			} else {
				out.add( bo.getImage() );
                switch ( bo.getKind() )
                {
                    case EQ:
                    case NEQ:
                    case LO:
                    case LE:
                    case GT:
                    case GE:
                        out.add(" ");
                        if( bo.getChild(0).getType() == null ) {
                        	int a = 0;
                        	a++;
                        }
//                        out.add(bo.getChild(0).getType().getBaseTypeName().toUpperCase() + " ");
                        generate(bo.getChild(0).getType(), false, parentName, out); out.add(" ");
                        // для операций сравнения необходим базовый тип
                        // (т.к. по типу результата понять тип
                        // аргументов нельзя)
                        break;
                    case MUL:
                    case DIV:
                    {
                        IRType a = bo.getChild(0).getType();
                        IRType b = bo.getChild(1).getType();

                        if ( a instanceof IRTypePhysical
                             || b instanceof IRTypePhysical
                             || (bo.getKind() == IROperKind.DIV
                                 && a instanceof IRTypeReal) )
                        {
                            out.add("g "
                                    + bo.getChild(0).getType().getBaseTypeName()
                                    + " "
                                    + bo.getChild(1).getType().getBaseTypeName()
                                    );
                        }
                        out.add(" ");

                        break;
                    }
                    default:
                        out.add(" ");
                        break;
                }
                if ( bo.getKind() == IROperKind.CONCAT )
                {
                    generateExpressionAsArray(bo.getChild(0), parentName, out);
                    out.add(" ");
                    generateExpressionAsArray(bo.getChild(1), parentName, out);
                }
                else
                {
                    generateExpression(bo.getChild(0), parentName, out);
                    out.add(" ");
                    generateExpression(bo.getChild(1), parentName, out);
                }
			}
            out.add(")");
			return;
		} else if( oper instanceof IRUnaryOper ) {
			IRUnaryOper uo = (IRUnaryOper) oper;
            out.add("(");
			if( uo.getSub() != null &&
                (!uo.isStandard() || uo.getSub().getBody() != null )) {
				IRFunction func = (IRFunction) uo.getSub();
				SubProgram sub = addSubProgramToGenerate(func);//subprogramsToGenerate.add(func);
                out.add(getSubFullName(sub));
				out.add(" ");
				generateExpression(uo.getChild(0), parentName, out);
            }
            else
            {
// 				out.add( uo.toString() + "sub=" + uo.getSub() + "body=" + uo.getSub().getBody() + " isStandard=" + uo.isStandard());
// 				out.add(" ");
                out.add(uo.getImage());
                out.add(" ");
                generateExpression(uo.getChild(0), parentName, out);
            }
            out.add(")");
			return;
		}
		
		switch( oper.getKind() ) {
		case AGGREG:
			generate( (IRAggreg) oper, parentName, out );
			break;
			
		case CONST:
            generateConstantRepresentation(((IRConst) oper).getConstant(), out);
			break;
			
		case SGNL: {
			IRSignalOper so = (IRSignalOper) oper;
			if( !(so.getSignal() instanceof IRPort) ) objectsToGenerate.add(getObjectWrap(parentName, so.getSignal()));
			generateName(((IRSignalOper) oper).getSignal(), parentName, out);
			break;
		}
			
		case VAR:
            generateName(((IRVarOper) oper).getVariable(), parentName, out);
			break;
			
		case NAME:
			IRName name = (IRName) oper;
            //generateName(name, name.getName(), parentName, out);
			out.add(name.getName());
			break;
			
       case TYPE_CAST:
           IRTypeCast tc = (IRTypeCast)oper;
           out.add("(i:qualify_type ");
           IRType t = oper.getChild(0).getType();
           if ( t instanceof IRTypeInteger ) {
               out.add("STD.STANDARD.INTEGER");
           } else if ( t instanceof IRTypeReal ) {
               out.add("STD.STANDARD.REAL");
               
           } else {
               generate( oper.getType(), false, parentName, out );
               // ^ генерим как было для не real/integer
           }
           out.add(" ");
           generateExpression(tc.getChild(0), parentName, out);
           out.add(")");
		   break;
			
		case QUALIFY:
			out.add("(i:qualify_type ");
			generate( oper.getType(), false, parentName, out );
			out.add(" ");
			generateExpression(oper.getChild(0), parentName, out);
			out.add(")");
			break;
			
		case ARRAY_BOUND:
			IRArrBound bound = (IRArrBound) oper;
			out.add("(i:" + bound.toString().toLowerCase() + " ");//(bound.isHighBound() ? "high" : "low") + "(");
			generateExpression(bound.getChild(0), parentName, out);
			out.add(")");
			break;
			
		case FCALL:
			IRFunctionCall fcall = (IRFunctionCall) oper;
			if( fcall.getFunction() == null ) {
				int a = 0;
				a++;
			}
			SubProgram sub = addSubProgramToGenerate(fcall.getFunction());//subprogramsToGenerate.add(fcall.getFunction());
//			generateUniqueName(fcall.getFunction());
			out.add("(" + getSubFullName(sub));
			IROper[] params = fcall.getProcessedParameters();
			for( int i = 0; i < params.length; i++ ) {
				out.add(" ");
				generateExpression(params[i], parentName, out);
			}
			out.add(")");
			break;
			
		case ATTRIB:
			IRAttrib attrib = (IRAttrib) oper;
			if( attrib.getValue() != null && !(attrib.getValue() instanceof IRArrBound) ) {
				generateExpression(attrib.getValue(), parentName, out);
			} else {
                String aname = attrib.getAttributeName().toLowerCase();
                if( attrib == null || attrib.getCode() == null ) {
                	int a = 0;
                	a++;
                }
                switch ( attrib.getCode() )
                {
                    case ARRAY:
                        out.add("(i:a'" + aname + " 1 ");
                        // TODO: а что делать с N-ным атрибутом?
                        break;
                    case TYPE:
                        out.add("(i:t'" + aname + " ");
                        break;
                    case SIGNAL:
                        out.add("(i:s'" + aname + " ");
                        break;
                    case TYPE_ARRAY:
                        out.add("(i:ta'" + aname + " 1 ");
                        break;
                    default:
                        throw new RuntimeException(attrib.getCode().toString()
                                                   + " attrib in vir?");
                }
				generateExpression(attrib.getChild(0), parentName, out);
				for( int i = 1; i < attrib.getChildNum(); i++ ) {
					out.add(" ");
					generateExpression(attrib.getChild(i), parentName, out);
				}
                out.add(")");
			}
			break;
			
		case CHOICES:
			IRChoices ch = (IRChoices) oper;
            out.add( "(" ); 
			for( int i = 0; i < ch.getChildNum(); i++ ) {
				generateExpression( ch.getChild(i), parentName, out);
                if ( i+1 < ch.getChildNum() ) out.add(" ");
			}
            out.add( ")" );
			break;
			
		case CONST_READ:
			IRConstRead cr = (IRConstRead) oper;
//			constantsToGenerate.add(cr.getConstant());
//			if( cr.getConstant().getName().equalsIgnoreCase("size") && parentName == null ) {
//				int a = 0;
//				a++;
//			}
			objectsToGenerate.add(getObjectWrap(parentName, cr.getConstant()));
            generateName(cr.getConstant(), parentName, out);
			break;
			
		case FIELD:
			IRFieldOper fo = (IRFieldOper) oper;
			out.add(fo.getField().getName());
			break;
			
		case INDEX:
			out.add("(i:index ");
            IRType ch0Type = oper.getChild(0).getType();
            IRTypeArray at;
            if ( ch0Type instanceof IRArrayIndex )
            {
                at = ((IRArrayIndex)ch0Type).getArrayType(); 
            }
            else
            {
                at = (IRTypeArray)ch0Type;
            }
            int idxCount = at.getIndexes().length;
            generateIndex(oper, idxCount, parentName, out);
			out.add(")");
			break;
			
		case RANGE:
			out.add("(i:slice ");
			generateExpression( oper.getChild(0), parentName, out );
            // TODO: у slice-а должен быть range, подходящий для generateRange
            // не только to/downto но и тип/'range/'reverse_range
			generateRange( (IRangedElement) oper, parentName, out );
			out.add(")");
			/*
			out.add(" (range ");
			if( oper.getChild(3).getBooleanValue() ) {
				generateExpression( oper.getChild(2), parentName, out );
				out.add(" downto ");
				generateExpression( oper.getChild(1), parentName, out );
			} else {
				generateExpression( oper.getChild(1), parentName, out );
				out.add(" to ");
				generateExpression( oper.getChild(2), parentName, out );
			}
			out.add("))");
			*/
			break;
			
		case DOT:
			out.add("(i:field ");
			generateExpression( oper.getChild(0), parentName, out ); 
			out.add(" ");
			generateExpression( oper.getChild(1), parentName, out );
			out.add(")");
			break;
			
		case OTHERS:
			out.add("i:others");
			break;

        case OPEN:
			out.add(oper.getKind().toString().toLowerCase());
			break;
			
        case AFTER:
        	IRAfter after = (IRAfter) oper;
        	generateExpression(after.getValue(), parentName, out);
        	out.add(" after ");
        	generateExpression(after.getTime(), parentName, out);
        	break;

		case ALIAS:
			IROperAlias al = (IROperAlias) oper;
			if( al.getAlias().getName().equalsIgnoreCase("av_st_bit_vector_1") ) {
				int a = 0;
				a++;
			}
            generateName(al.getAlias(), parentName, out);
			break;
			
		case COMMA:
			IROperComma comma = (IROperComma) oper;
			generateExpression(comma.getLeft(), parentName, out);
			out.add(" ");
//			out.add(", ");
			generateExpression(comma.getRight(), parentName, out);
			break;
			
		case NULL:
			out.add("NULL");
			break;
			
		default:
			throw new RuntimeException(oper.getKind().toString());
//			generateGenericExpression( oper, parentName, out );
//			break;
		}
	}
	
	protected String getSubFullName( SubProgram sub ) {
		String res = sub.owner + "." + sub.sub.getName();//sub.getFullName();
		Integer code = getFunctionCode(sub.sub);
		if( code.intValue() != 0 ) {
			res += "." + code;
		}
		return res;
	}
	
	public void generateSubprograms( TextOut out ) {
		while( subprogramsToGenerate.size() > 0 ) {
			SubProgram[] subs = subprogramsToGenerate.toArray(new SubProgram[subprogramsToGenerate.size()]);
			for( int i = 0; i < subs.length; i++ ) {
				SubProgram sub = subs[i];
				subprogramsToGenerate.remove(sub);
				if( !generatedSubprograms.contains(sub) ) {
					generate(sub, sub.owner, out);
					generatedSubprograms.add(sub);
				}
			}
		}
	}
	
	
	public String getFullName( String parentName, IRNamedElement el ) {
		if( el.getName() != null && el.getName().equalsIgnoreCase("dummy") ) {
			int a = 0;
			a++;
		}
        if ( IRNamedElement.isLocalElement(el) )
        {
            return el.getName();
        }
		int ownerIndex;
		ILocalResolver owner = null;
		for( ownerIndex = stack.size()-1; ownerIndex >= 0; ownerIndex-- ) {
			IRNamedElement cur = stack.get(ownerIndex).el;
			if( cur instanceof ILocalResolver ) {
				ILocalResolver loc = (ILocalResolver) cur;
				if( loc.contains(el) ) {
					owner = loc;
					break;
				}
			}
		}
		if( owner != null ) {
			String name = getNameFromStack( ownerIndex );
			name += "." + el.getName();
			return name;
		}
		
		if( el.getName() == null ) {
			el.setName(ns.getUniqueName(el, "unnamed"));
		}

        if( parentName != null &&
            (el.getParent() instanceof IRArchitecture ||
             el.getParent() instanceof IREntity ||
             el.getParent() instanceof IRBlock ) ) {
			return parentName + "." + el.getName();
        } else {
            return el.getFullName();
        }
	}
//    public String getFullName( String parentName, IRElement el, String name ) {
//        if( parentName != null &&
//            (el.getParent() instanceof IRArchitecture ||
//             el.getParent() instanceof IREntity) ) {
//			return parentName + "." + name;
//        } else {
//            return IRNamedElement.getFullName(el, name);
//        }
//	}
	
	public void generateObjects( TextOut out ) {
		while( objectsToGenerate.size() > 0 ) {
			NamedObject[] consts = objectsToGenerate.toArray(new NamedObject[objectsToGenerate.size()]);
			for( int i = 0; i < consts.length; i++ ) {
				NamedObject object = consts[i];
				objectsToGenerate.remove(object);
				if( object.object instanceof IRGeneric || object.object instanceof IRLoopVariable ) continue;
				if( !generatedObjects.contains(object) ) {
//                    if ( !IRNamedElement.isLocalElement(cnst.constant) )
					if( object.object instanceof IRConstant ) {
						if( !IRNamedElement.isLocalElement(object.object) ) {
	                        generate( (IRConstant) object.object, object.owner, null, out);
						}
					} else if( object.object instanceof IRSignal ) {
						if( object.object.getName().equalsIgnoreCase("i_t_real1_2") ) {
							int a = 0;
							a++;
						}
						generate( object.owner, (IRSignal) object.object, out);
					}
                }
			}
		}
	}
	
	public void generatePendingItems() {
		while( !objectsToGenerate.isEmpty() || !subprogramsToGenerate.isEmpty() || !typesToGenerate.isEmpty() ) {
			generateObjects(glue.cnstsOut);
			generateSubprograms(glue.funcsOut);
			generateTypes(glue.typesOut);
		}
	}
	
	public void generateTypeDefinition( IRType type, String fullName, TextOut out ) {
    	if( type.getName() != null && type.getName().equalsIgnoreCase("t_rec1") ) {
    		int a = 0;
    		a++;
    	}
		stack.peek().add(type);
		glue.generateLocation(type.getBegin(), out);
		if( type.getName().equalsIgnoreCase("ST_ARR_1") ) {
			int a = 0;
			a++;
		}
//         if ( isFullName && type.getFullName().equalsIgnoreCase("STD.STANDARD.BIT_VECTOR") )
//         {
//             type.dumpStacks();
//         }
        if ( type.getBegin() == null )
        {
            type.dumpStacks();
        }
//		out.nlTabAdd("(type " + (isFullName?type.getFullName():type.getName()) + " ");
		out.nlTabAdd("(type " + fullName.toUpperCase() + " ");
        generate(type, true, fullName, out);
        out.add("))");
    }
	
	public void generateLocalTypes(IRTypes types, String parentName, TextOut out) {
		IRType[] ts = types.getTypes();
		for( IRType type : ts ) {
			stack.peek().add(type);
		}
		for( IRType type : ts ) {
			String ownerName = parentName;
			if( type.getName() != null && type.getName().equalsIgnoreCase("t_enum1") ) {
				int a = 0;
				a++;
			}
			Type t = getTypeWrap(ownerName, type);
			if( !generatedTypes.contains(t) ) {
				generatedTypes.add(getTypeWrap(type));
				generateTypeDefinition(type, ownerName + "." + type.getName(), out);
			}
		}
	}

	public void generateTypes(TextOut out) {
		while( !typesToGenerate.isEmpty() ) {
			Type[] toGen = typesToGenerate.toArray(new Type[typesToGenerate.size()]);
			for( int i = 0; i < toGen.length; i++ ) {
				Type type = toGen[i];
				if( type.type.getName().equalsIgnoreCase("ten") ) {
					int a = 0;
					a++;
				}
				if( type.type.getName() != null &&
                    // ^ тут могут оказаться безымянные типы
                    // от всяких  variable asdf : integer range 1 to 5;
                    // или просто variable asdf : integer;
                    // т.е. от subtypeThunk
                    !generatedTypes.contains(type) &&
                    !IRNamedElement.isLocalElement(type.type)
                    ) {
					generatedTypes.add(type);
//					generateTypeDefinition(type.type, true, out);
					generateTypeDefinition(type.type, type.owner + "." + type.type.getName(), out);
				}
				typesToGenerate.remove(type);
			}
				
		}
	}
}
