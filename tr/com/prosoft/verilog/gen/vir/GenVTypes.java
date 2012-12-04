package com.prosoft.verilog.gen.vir;

import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Stack;

import com.prosoft.common.TextCoord;
import com.prosoft.glue.HDLAssoc;
import com.prosoft.glue.HDLKind;
import com.prosoft.glue.gen.GenGlue;
import com.prosoft.verilog.ir.VAssignStatement;
import com.prosoft.verilog.ir.VBinaryKind;
import com.prosoft.verilog.ir.VCaseElement;
import com.prosoft.verilog.ir.VCaseStatement;
import com.prosoft.verilog.ir.VConst;
import com.prosoft.verilog.ir.VDelayOrEventControl;
import com.prosoft.verilog.ir.VErrorFactory;
import com.prosoft.verilog.ir.VIfStatement;
import com.prosoft.verilog.ir.VInitialOrAlways;
import com.prosoft.verilog.ir.VModule;
import com.prosoft.verilog.ir.VModuleInstance;
import com.prosoft.verilog.ir.VName;
import com.prosoft.verilog.ir.VNamedAssign;
import com.prosoft.verilog.ir.VNamedElement;
import com.prosoft.verilog.ir.VNamedElementKind;
import com.prosoft.verilog.ir.VNet;
import com.prosoft.verilog.ir.VOper;
import com.prosoft.verilog.ir.VOperBinary;
import com.prosoft.verilog.ir.VOperCast;
import com.prosoft.verilog.ir.VOperCond;
import com.prosoft.verilog.ir.VOperEdge;
import com.prosoft.verilog.ir.VOperKind;
import com.prosoft.verilog.ir.VOperRange;
import com.prosoft.verilog.ir.VOperReplic;
import com.prosoft.verilog.ir.VOperUnary;
import com.prosoft.verilog.ir.VParameter;
import com.prosoft.verilog.ir.VReturnStatement;
import com.prosoft.verilog.ir.VStatement;
import com.prosoft.verilog.ir.VStatementKind;
import com.prosoft.verilog.ir.VStatements;
import com.prosoft.verilog.ir.VSubParameter;
import com.prosoft.verilog.ir.VSubProgram;
import com.prosoft.verilog.ir.VType;
import com.prosoft.verilog.ir.VTypeArray;
import com.prosoft.verilog.ir.VTypeInteger;
import com.prosoft.verilog.ir.VTypeKind;
import com.prosoft.verilog.ir.VTypeReal;
import com.prosoft.verilog.ir.VTypeVector;
import com.prosoft.verilog.ir.VValue;
import com.prosoft.verilog.ir.VVariable;
import com.prosoft.verilog.ir.ValueSet;
import com.prosoft.verilog.ir.VValue.VValueArray;
import com.prosoft.verilog.ir.VValue.VValueType;
import com.prosoft.verilog.ir.VValue.VValueVector;
import com.prosoft.vhdl.gen.Scope;
import com.prosoft.vhdl.gen.TextOut;
import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.ir.ILocalResolver;
import com.prosoft.vhdl.ir.IRAggreg;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IROperAssoc;
import com.prosoft.vhdl.ir.IROperOthers;
import com.prosoft.vhdl.ir.IROperRange;
import com.prosoft.vhdl.ir.IRSubProgram;
import com.prosoft.vhdl.ir.IRSubProgramHolder;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeHolder;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.ir.IRTypePhysical;
import com.prosoft.vhdl.ir.IRTypeReal;

public class GenVTypes {
	
	class SubProgram {
		
		final String owner;
		final VSubProgram sub;
		
		public SubProgram(String owner, VSubProgram sub) {
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
		final VType type;
		
		int hash;
		
		public Type(String owner, VType type) {
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
				boolean res = n1.equalsIgnoreCase(n2);
				return res;
			}
			else
				return false;
		}
	}
	
	class Constant {
		final String owner;
		final VParameter constant;
		
		public Constant(String owner, VParameter type) {
			this.owner = owner;
			this.constant = type;
		}

		public int hashCode() {
			return owner.hashCode() ^ constant.hashCode();
		}
		
		public boolean equals( Object other ) {
			if( !(other instanceof Constant) ) return false;
			Constant type = (Constant) other;
			return owner.equals(type.owner) && this.constant == type.constant;
		}
	}
	
	public static final boolean generateConstantsType = true;
	public static final boolean generateAssignSourceType = false;
	
	VErrorFactory err;
	
	VNameSpace ns = new VNameSpace();
	
	HashMap<IRSubProgram, Integer> functionCodes = new HashMap<IRSubProgram, Integer>();
	HashMap<String, Integer> lastFunctionCodes = new HashMap<String, Integer>();
	
	HashSet<SubProgram> subprogramsToGenerate = new HashSet<SubProgram>();
	HashSet<SubProgram> generatedSubprograms = new HashSet<SubProgram>(); 
	HashSet<Constant> constantsToGenerate = new HashSet<Constant>();
	HashSet<Constant> generatedConstants = new HashSet<Constant>(); 
	HashSet<Type> typesToGenerate = new HashSet<Type>();
	HashSet<Type> generatedTypes = new HashSet<Type>();
	
	Stack<VNamedElement> stack = new Stack<VNamedElement>();
	
	HashMap<String, ArrayList<String>> sources = new HashMap<String, ArrayList<String>>();
	
	public GenGlue glue;
	
	public GenVTypes(VErrorFactory err) {
		this.err = err;
	}
	
	VModule getOwningModule() {
		for( int i = stack.size() - 1; i >= 0; i-- ) {
			VNamedElement el = stack.elementAt(i);
			if( el.getElementKind() == VNamedElementKind.MODULE ) return (VModule) el;
		}
		throw new RuntimeException();
	}
	
	ArrayList<String> getFile( String fileName ) throws IOException {
		ArrayList<String> res = sources.get(fileName);
		if( res != null ) return res;
		res = new ArrayList<String>();
		LineNumberReader li = new LineNumberReader(new FileReader(fileName) );
//		LineInputStream li = new LineInputStream( new FileInputStream(fileName) );
		while(li.ready()) {
			res.add(li.readLine());
		}
		sources.put(fileName, res);
		return res;
	}
	
	private TextCoord prevComment;
	
	void generateVHDLSource( TextCoord coord, TextOut out ) {
		if( coord == null || coord.getFile() == null ) return;
		if( prevComment != null && prevComment.getFile().equalsIgnoreCase(coord.getFile()) 
				&& prevComment.getLine() == coord.getLine() ) return;
		ArrayList<String> lines = null;
		try {
			lines = getFile(coord.getFile());
		} catch (IOException e) {
			e.printStackTrace();
		}
		if( lines == null ) return;
		int index = coord.getLine() - 1;
		if( index >= lines.size() ) return;
		out.nlAdd(";; " + lines.get(index));
		prevComment = coord;
	}

    void generateLocation( TextCoord coord, TextOut out ) {
        if ( coord == null )
        {
            out.nlTabAdd("(# null location ");
        }
        else
        {
            out.nlTabAdd("(# \"" + coord.getFile() + "\" "
                         + coord.getLine() + " " + coord.getColumn());
            generateVHDLSource(coord, out);
        }
    }
	
	void push(VNamedElement el) { stack.push(el); }
	VNamedElement pop() { return stack.pop(); }
//	IRArchitecture getOwningArch() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			if( stack.get(i) instanceof IRArchitecture ) return (IRArchitecture) stack.get(i);
//		}
//		return null;
//	}
//	IRNamedElement getOwningArchOrBlock() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			if( stack.get(i) instanceof IRArchitecture || stack.get(i) instanceof IRBlock ) return (IRNamedElement) stack.get(i);
//		}
//		return null;
//	}
//	ISensivityList getOwningProcess() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			if( stack.get(i) instanceof IRProcess ) return (ISensivityList) stack.get(i);
//		}
//		return null;
//	}
//	IRComponentInstance getOwningComponent() {
//		for( int i = stack.size() - 1; i >= 0; i-- ) {
//			if( stack.get(i) instanceof IRComponentInstance ) return (IRComponentInstance) stack.get(i);
//		}
//		return null;
//	}
	
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
	
	public boolean isUnconstrainedRange( VOperRange range ) {
        return range.getLeft() == null || range.getRight() == null;
    }
	public boolean isUnconstrainedRanges( VOperRange[] ranges ) {
        for ( VOperRange r : ranges )
        {
            if ( isUnconstrainedRange(r) ) return true;
        }
        return false;
    }
    public void generateRange( VOperRange range, String parentName, TextOut out ) {
        generateRange(range, parentName, out, false);
    }
    public void generateRange( VOperRange range, String parentName, TextOut out,
                               boolean addBaseType ) {
        if( isUnconstrainedRange(range) ) {
            out.add("[");
            generate(/*range.getRangeType()*/VTypeInteger.TYPE, false, out);
            out.add(" (range <>)]");
        } /*else if( range.getRangeHigh().getKind() == IROperKind.ARRAY_BOUND && range.getRangeLow().getKind() == IROperKind.ARRAY_BOUND
                   && range.isDownTo().getKind() == IROperKind.ARRAY_BOUND ) {
            out.add("(i:a'range 1 ");
            // TODO: что делать с N-ным range, и reverse_range
            generateExpression( range.getRangeHigh().getChild(0), parentName, out );
            out.add(")");
        } */else {
            VType rt = VTypeInteger.TYPE;//range.getRangeType();
            //boolean noSubtype = (rt.isInt() || rt.isReal()) && rt.getSubtypedFrom() == null;
            if ( addBaseType )
            {
                out.add("(");
                generate(rt, false, out);
                out.add(" ");
            }
            out.add("(range ");
            generateExpression(range.getLeft(), parentName, out);
            if( range.isDownTo() ) {
                out.add( " downto " );
            } else {
                out.add( " to " );
            }
            generateExpression(range.getRight(), parentName, out);
            out.add(addBaseType ? "))" : ")");
        }
	}
	
    public void generateRanges( VOperRange[] ranges, String parentName, TextOut out,
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
	
//	public void generateLibrary( Library lib, TextOut out ) {
//		IRNamedElement[] els = lib.getElements();
//		for( int i = 0; i < els.length; i++ ) {
//			IRNamedElement el = els[i];
//			if( el instanceof IRPackage ) {
//				IRPackage pack = (IRPackage) el;
//				generate(pack, out);
//			} else if( el instanceof IREntity ) {
//				IREntity en = (IREntity) el;
//				// TODO сущности надо генерировать по другому
////				generate
//			}
//		}
//	}
	
//	public void generate(IRPackage pack, TextOut out) {
//		String parentName = pack.getFullName();
//		ArrayList<IRConstant> cnsts = pack.getDeclarations().getConstants();
//		for( int i = 0; i < cnsts.size(); i++ ) {
//			generate( cnsts.get(i), parentName, null, out);
//		}
//		cnsts = pack.getBody().getConstants();
//		for( int i = 0; i < cnsts.size(); i++ ) {
//			generate( cnsts.get(i), parentName, null, out);
//		}
//	}
    
//    (type wire (enum '0' '1' 'X' 'Z'))
//    (type bit (enum '0' '1'))
//    (type int (range -2147483648 to 2147483647))
//    (type reg (array ([int (range <>)]) of bit))    boolean stdTypesGenerated;
    void generateFunc(String header, String impl, TextOut out) {
		out.nlTabAdd(header);
		out.pushScope(null);
		out.nlTabAdd(impl);
		out.popScope();
    }
    
    boolean stdTypesGenerated = true;
    public void generateStdTypes() {
    	if( !stdTypesGenerated ) {
    		TextOut out = glue.typesOut;
    		out.nlTabAdd("(type logic (enum '0' '1' 'X' 'Z'))");
    		out.nlTabAdd("(type bit (enum '0' '1'))");
    		out.nlTabAdd("(type int (range -2147483648 to 2147483647))");
    		out.nlTabAdd("(type vector (array ([int (range <>)]) of logic))");
    		out.nlTabAdd("(type real (range -2147483648.0 to 2147483647.0))");
    		generateFunc("(function l2b ((l : logic)) STD.STANDARD.BOOLEAN", "(return (= logic l '1')))", out);
    		generateFunc("(function v2b ((v : vector)) STD.STANDARD.BOOLEAN ", "(return 'TRUE))", out);
//    		generateFunc("(function ~ ((l : logic)) logic", "(return (i:index (['1' '0' 'X' 'X'] : (array (logic) of logic)) l )))", out);
    		generateFunc("(function ~ ((l : vector)) vector", "(return l ))", out);
    		generateFunc("(function == ((a : vector) (b : vector)) vector (return \"X\"))", ";; пока заглушка", out);
    		stdTypesGenerated = true;
    	}
    }

	public void generate( VType type, boolean extendTypes, TextOut out ) {
		generateStdTypes();
        if ( type.getName() != null )
        {
            // генерируем только объявленные типы с именем
            addTypeToGenerate(type, out);
        }
        
        String fname = type.getFullName();
        if( fname.equalsIgnoreCase("work.atmega128_pkg.CNT13_t") ) {
        	int a = 0;
        	a++;
        }

        VType subtypedFrom = type.getSubtypedFrom();
        if ( subtypedFrom != null )
        {
            addTypeToGenerate(subtypedFrom, out);
        }

        // DUCK для безымянного типа надо сгенерировать его описание
 //       if( type.getName() == null ) subtypedFrom = null;

        if( !extendTypes && type.getName() != null && !type.isVector() ) {
            // неанонимный subtype
            out.add( false/*IRNamedElement.isLocalElement(type)*/ ?
                     type.getName() : type.getFullName() );
            return;
        }

        
		//String fullName = type.getFullName();
        // у variable asdf : integer range 1 to 10
        //   constant qwer : std_logic_vector(1 to 5);
        // имени нет
        // parentName используется в port и function declaraion
        // вроде как ниже он нафиг не нужен?
		String parentName = null; //fullName.substring( 0, fullName.lastIndexOf('.') );
        if ( subtypedFrom == null )
        {
            // нет subtype-а, генерим тип как есть
//            if( type instanceof IRTypeEnum ) {
//                out.add("(enum");
//                IRTypeEnum en = (IRTypeEnum) type;
//                for( int i = 0; i < en.getNumValues(); i++ ) {
//                    out.add(" " + en.getValue(i).getName());
//                }
//                out.add(")");
//            } else 
            if( type instanceof VTypeArray ) {
                out.add("(array (");
                VTypeArray arr = (VTypeArray) type;
                generateRange(arr.getRange(), parentName, out, true);
                out.add(") of " );
                generate(arr.getElementType(), false, out);
                out.add(")");
            } else if( type instanceof VTypeVector ) {
                VTypeVector vec = (VTypeVector) type;
	                if( vec.getSize() > 0 ) { //1 ) {
	                out.add("(array (");
	                generateRange(vec.getRange(), parentName, out, true);
	                out.add(") of " );
	//                generate(arr.getElementType(), false, out);
	                out.add("logic");
	                out.add(")");
                } else {
                	out.add(vec.getName());
                }
            } else 
//            	if( type instanceof IRTypeRecord ) {
//                out.pushScope(new Scope());
//                out.nlTabAdd("(record");
//                out.pushScope(new Scope());                
//                IRTypeRecord rec = (IRTypeRecord) type;
//                for( int i = 0; i < rec.getNumFields(); i++ ) {
//                    IRRecordField f = rec.getField(i);
//                    out.nlTabAdd( "(" + f.getName() + "\t\t" );
//                    generate(f.getType(), false, out);
//                    out.add( ")");
//                }
//                out.popScope();
//                out.add(")");
//                out.popScope();
//            } else 
            	if( type instanceof VTypeInteger ) {
            		VTypeInteger tint = (VTypeInteger) type;
//                generateRange(tint, parentName, out);
            } else if( type instanceof VTypeReal ) {
//                IRTypeReal treal = (IRTypeReal) type;
//                generateRange(treal, parentName, out);
            	
            	
//            } else if( type instanceof IRTypePhysical ) {
//            	IRTypePhysical p = (IRTypePhysical) type;
//                out.add("(physical ");
//                generateRange(p, parentName, out);
//                out.add(" " + p.getUnits());
//                for ( IRPhysicalUnits u : p.secondaryUnits)
//                {
//                    out.add(" (" + u.getName() + " ");
//                    generateExpression(u.getValue(), parentName, out);
//                    out.add(")");
//                }
//                out.add(")");
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
            if ( (type.isVector() && !isUnconstrainedRange(((VTypeVector)type).getRange()) ) || type.isArray() )
            {
                out.add("(" + subtypedFrom.getFullName() + " ");
                /*if( type instanceof IRTypeEnum ) {
                    generateRange((IRTypeEnum)type, parentName, out);
                } else */if( type instanceof VTypeVector ) {
                    generateRange(((VTypeVector)type).getRange(), parentName, out, false);
                } else if( type instanceof VTypeArray ) {
                	generateRange(((VTypeArray)type).getRange(), parentName, out, false);
                } else /*if( type instanceof IRTypeInteger ) {
                    generateRange((IRTypeInteger)type, parentName, out);
                } else if( type instanceof IRTypeReal ) {
                    generateRange((IRTypeReal)type, parentName, out);
                } else if( type instanceof IRTypePhysical ) {
                    generateRange((IRTypeReal)type, parentName, out);
                } else */{
                    out.add(type.getClass().getName());
                    out.add(type.toString());
                }
                out.add(")");
            }
            else
            {
                out.add( subtypedFrom.getFullName() );
                // если subtype ничем не ограничен, то это просто синоним
                // генерим его имя
            }
        }
        
//		if( type.getResolutionFunctionName() != null ) {
//            out.add(")");
//        }
	}
	
	public void generate( VVariable var, String parentName, TextOut out ) {
        generateLocation(var.getBegin(), out);
//		if( var.isParameter() ) {
//			out.nlTabAdd( "(variable " + var.getName() + " " + var.getName() + " ");
//		} else {
        
        	// пока походу заменяем на сигнал
			if( parentName == null ) {
				out.nlTabAdd( "(signal \"reg\" " + var.getName() + " ");
			} else {
				out.nlTabAdd( "(signal \"reg\" " + parentName + "." + var.getName() + /*" " + var.getName() +*/ " ");
			}
//			if( parentName == null ) {
//				out.nlTabAdd( "(variable " + var.getName() + " ");
//			} else {
//				out.nlTabAdd( "(variable " + parentName + "." + var.getName() + /*" " + var.getName() +*/ " ");
//			}
			
//		}
//		out.nlTabAdd( "(variable " + var.getUniqueName() + " " + var.getName() + " ");
		generate(var.getType(), false, out);
		if( var.getInit() != null ) {
			out.add(" ");
			generateExpression(var.getInit(), parentName, out);
		}
		out.add("))");
	}

//    public void generate( IRAlias alias, String parentName, TextOut out ) {
//        generateLocation(alias.getBegin(), out);
//        if( parentName == null ) {
//            out.nlTabAdd( "(alias " + alias.getName() + " ");
//        } else {
//            out.nlTabAdd( "(alias " + parentName + "." + alias.getName() + " ");
//        }
//		generate(alias.getType(), false, out);
//		if( alias.getExpression() != null ) {
//			out.add(" ");
//			generateExpression(alias.getExpression(), parentName, out);
//		}
//		out.add("))");
//	}
	
    // value нужно для переопределения значения, если переопределение не нужно, то надо передавать null
	public void generate( VParameter cnst, String parentName, VOper value, TextOut out ) {
        //	   if( cnst.isParameter() ) return;
		Constant wrap = getConstantWrap(cnst);
		if( generatedConstants.contains(wrap) ) {
//			System.out.println("Strange, " + cnst.getFullName() + " already generated at " + cnst.getBegin());
			return;
		}
		generatedConstants.add(wrap);
		if( cnst.getName().equalsIgnoreCase("period_1MHz") ) {
			int a = 0;
			a++;
		}
		// TODO если это параметр функции
//		if( cnst.isParameter() ) return;
		
        generateLocation(cnst.getBegin(), out);
//        if( cnst instanceof IRGeneric ) {
//        	out.nlTabAdd( "(generic " );
//        } else {
        	out.nlTabAdd( "(constant " );
//        }
        generateName( cnst, parentName, out );
        out.add( " " );
		generate(cnst.getType(), false, out);
		if( value == null ) {
			value = cnst.getExpression();
		}
		if( value != null ) {
			out.add(" ");
			generateExpression(value, parentName, out);
		}
		out.add("))");
	}
	
//	protected boolean generateType( IROper op ) {
//		return ! (op.getKind() == IROperKind.VAR || op.getKind() == IROperKind.FCALL 
//				|| op.getKind() == IROperKind.CONST_READ );
//	}
	
	public void generate( VAssignStatement stat, String parentName, TextOut out ) {
		switch(stat.getAssignKind()) {
		case EQ:
			out.nlTabAdd( "(i:set " ); break;
		case ARROW:
			out.nlTabAdd( "(i:send " ); break;
		case ASSIGN:
			out.nlTabAdd( "(i:vsend " ); break;
//			out.nlTabAdd( "(i:send " ); break;
		default:
			throw new RuntimeException(stat.getAssignKind().toString());
		}
		generateExpression( stat.getChild(0), parentName, out );
		out.add( " " );
		generateExpression( stat.getChild(1), parentName, out );
		if( generateAssignSourceType ) {
			out.add(" : ");
			generate( stat.getChild(1).getType(), false, out );
		}
		out.add( ")" );
	}
	
//	public void generate( IRVariableAssignment stat, String parentName, TextOut out ) {
//		if( stat.getChild(0).getKind() == IROperKind.VAR && 
//				((IRVarOper)stat.getChild(0)).getVariable().getName().equalsIgnoreCase("pc_inc")) {
//			int a = 0;
//			a++;
//		}
//		out.nlTabAdd( "(i:set " );
////         generate(stat.getChild(0).getType(), false, out);
////         // i:set пока требует тип переменной
//// 		out.add( " " );
//		generateExpression( stat.getChild(0), parentName, out );
//		out.add( " " );
//		if( generateAssignSourceType ) {
//			out.add("( ");
//		}
//		generateExpression( stat.getChild(1), parentName, out );
//		if( generateAssignSourceType ) {
//			out.add(" : ");
//			generate( stat.getChild(1).getType(), false, out );
//			out.add(" ) ");
//		}
//		out.add( ")" );
//	}
	
	public void generate( VReturnStatement stat, String parentName, TextOut out ) {
		out.nlTabAdd( "(return ");
		generateExpression(stat.getChild(0), parentName, out);
		if( generateAssignSourceType ) {
			out.add(" : ");
			generate( stat.getChild(0).getType(), false, out );
		}
		out.add( ")" );
	}
	
	public void generateIf( VIfStatement stat, String parentName, TextOut out ) {
		out.nlTabAdd( "(i:if " );
		generateCondition(stat.getExpression(), parentName, out);
		out.add(" (;;then");

		out.pushScope(new Scope());
        generate( stat.getIfTree(), parentName, out );
		out.popScope();

		out.nlTabAdd(") (;;else");
		out.pushScope(new Scope());
		
		int scopes = 0;
		
//		for( int i = 0; i < stat.getElseIfCount(); i++ ) {
//			generateLocation(stat.getElseIfTree(i).getBegin(), out);
//			scopes++;
//			out.nlTabAdd("(i:if ");
//			generateExpression(stat.getElseIfTree(i), parentName, out);
//			out.add(" (;; else if" + i);
//			out.pushScope(new Scope());
//			generate(stat.getElseIfStatement(i), parentName, out);
//
//			out.popScope();
//			out.nlTabAdd(") (;;end else if" + i);
//			out.pushScope(new Scope());
//		}
		
		if( stat.getElseTree() != null )  {
			generate( stat.getElseTree(), parentName, out );
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
//	public void generate( IRForStatement fr, String parentName, TextOut out ) {
////		generateUniqueName( fr.getLoopVariable() );
//		out.nlTabAdd( "(i:for " );
//		if( fr.getLabel() != null ) {
//			out.add(":" + fr.getLabel());
//		}
//		out.add( fr.getLoopVariable().getName() + " " );
//        generateRange( fr.getLoopVariable(), parentName, out );
//		out.pushScope(new Scope());
//		generate( fr.getBody(), parentName, out );
//		out.popScope();
//		out.nlTabAdd( ")" );
//	}
	
	public void generateCase( VCaseStatement stat, String parentName, TextOut out ) {
		String caseType = "";
		if( stat.getCaseType() == ValueSet.Z ) {
			caseType = "z";
		} else if( stat.getCaseType() == ValueSet.X ) {
			caseType = "x";
		}
		out.nlTabAdd("(i:vcase" + caseType + " (");
		generateExpression( stat.getExpression(), parentName, out );
        out.add(" : " + stat.getExpression().getType().getBaseTypeName() + ") ");
		
		out.pushScope(new Scope());
		
		for( int ci = 0; ci < stat.getNumCases(); ci++ ) {
			VCaseElement c = stat.getCase(ci);
//			if( c.getNumCases() != 1 ) {
//				throw new RuntimeException("must implement multiple cases");
//			}
			out.nlTabAdd( "((");
			for( int ei = 0; ei < c.getNumCases(); ei++ ) {
				out.add(" ");
				generateExpression( c.getCase(ei), parentName, out );
			}
			out.add(") ");
			out.pushScope(new Scope());
//			generate( stat.getChoice(i).getType(), false, out );
			generate( c.getStatement(), parentName, out );
			out.popScope();
			out.nlTabAdd(")");
		}
		
		out.popScope();
		
		out.nlTabAdd(")");
	}
	
//	protected void generateExit( IRExitStatement stat, String parentName, TextOut out ) {
//		if( stat.getCondition() != null ) {
//			out.nlTabAdd("(i:if ");
//			generateExpression(stat.getCondition(), parentName, out);
//			out.pushScope(new Scope());
//			out.nlTabAdd("(");
//		}
//		if( stat.getLabel() != null ) {
//			out.nlTabAdd("(i:exit " + stat.getLabel() + " )");
//		} else {
//			out.nlTabAdd("(i:exit )");
//		}
//		if( stat.getCondition() != null ) {
//			out.nlTabAdd(")");
//			out.nlTabAdd("() ;; empty else");
//			out.popScope();
//			out.nlTabAdd(")");
//		}
//	}
//	
	
//	protected void generateWhile( IRWhileStatement stat, String parentName, TextOut out ) {
//		out.nlTabAdd("(i:while ");
//		if( stat.getLabel() != null ) {
//			out.add(stat.getLabel() + " ");
//		}
//		generateCondition(stat.getCondition(), parentName, out);
//		out.pushScope(new Scope());
//		generate( stat.getBody(), parentName, out );
//		out.popScope();
//		out.add(")");
//	}
	
	public void generate( VStatement stat, String parentName, TextOut out ) {
        if ( stat.getStatementKind() == VStatementKind.STATEMENTS )
        {
        	VStatements stats = (VStatements) stat;
//			generate( (IRStatements) stat, parentName, out );
        	for( int i = 0; i < stats.getChildNum(); i++ ) {
        		generate( stats.getChild(i), parentName, out );
        	}
            // ^ чтобы не генерировать положение в сорце несколько раз
            return;
        }
        generateLocation(stat.getBegin(), out);
		switch( stat.getStatementKind() ) {
		case ASSIGN:
			generate( (VAssignStatement) stat, parentName, out );
			break;

//		case EMPTY_STATEMENT:
//			out.nlTabAdd("(i:nop)");
//			break;
			
//		case VAR_ASGN:
//			generate( (IRVariableAssignment) stat, parentName, out );
//			break;
			
		case RETURN:
			generate( (VReturnStatement) stat, parentName, out );
			break;
			
//		case FOR:
//			generate( (IRForStatement) stat, parentName, out );
//			break;
			
		case IF:
			generateIf((VIfStatement) stat, parentName, out);
			break;
			
		case CASE:
			generateCase( (VCaseStatement) stat, parentName, out );
			break;
			
//		case EXIT:
//			generateExit( (IRExitStatement)stat, parentName, out );
//			break;
			
//		case WHILE:
//			generateWhile( (IRWhileStatement) stat, parentName, out );
//			break;
			
//		case PROC_CALL:
//			out.nlTab();
//			generateExpression( ((IRProcedureCall)stat).getCall(), parentName, out);
//			break;
			
//		case REPORT:
//			IRReportStatement rep = (IRReportStatement) stat;
//			out.nlTabAdd( "(i:report " );
// 			generateExpression(rep.getExpr(), parentName, out);
//			if( rep.getSeverity() != null ) {
//				out.add(" "); generateExpression(rep.getSeverity(), parentName, out);
//			}
//			out.add(")");
//			break;
			
//		case ASSERT:
//			IRAssertStatement ass = (IRAssertStatement) stat;
//			out.nlTabAdd("(i:assert ");
//			generateExpression(ass.getCondition(), parentName, out);
//			if( ass.getReport() != null ) {
// 				out.add(" report ");
// 				generateExpression(ass.getReport(), parentName, out);
//			}
//			if( ass.getSeverity() != null ) {
// 				out.add(" severity ");
// 				generateExpression(ass.getSeverity(), parentName, out);
//			}
//			out.add(")");
//			break;

//		case WAIT:
//			IRWaitStatement wait = (IRWaitStatement) stat;
//			out.nlTabAdd("(i:wait");
//			if( wait.getSensivityList().size() > 0 ) {
//				out.add(" on (");
//				for( int i = 0; i < wait.getSensivityList().size(); i++ ) {
//					generateExpression(wait.getSensivityList().get(i), parentName, out);
//				}
//				out.add(")");
//			}
//			if( wait.getCondition() != null ) {
//				out.add(" until ");
//				generateExpression(wait.getCondition(), parentName, out);
//			}
//			if( wait.getTimeout() != null ) {
//				out.add(" for ");
//				generateExpression(wait.getTimeout(), parentName, out);
//			}
//			out.add(")");
//			break;
			
		default:
			throw new RuntimeException(stat.getKind().toString());
		}
        out.add(")");// конец location-а
	}
	
//	public void generate( IRStatements stats, String parentName, TextOut out ) {
//		for( int i = 0; i < stats.getNumStatements(); i++ ) {
//			IRStatement stat = stats.getStatement(i);
//			generate(stat, parentName, out);
//		}
//	}
	
//	protected void generate( String parentName, ArrayList<IRComponentInstance> comps, TextOut out ) {
//		for( int i = 0; i < comps.size(); i++ ) {
//			generate( parentName, comps.get(i), out, funcsOut, typesOut, cnstsOut );
//		}
//	}
	
//	TextOut funcsOut;
//	TextOut typesOut;
//	TextOut cnstsOut;
	
	public void generate( String parentName, VModuleInstance comp, TextOut out ) {
		push(comp);
		String name;
		if( parentName != null ) {
			name = parentName + "." + comp.getName();
		} else {
			name = comp.getName();
		}
		
		ArrayList<VOper> assoc = comp.getConnections();
		HDLAssoc[] ports = new HDLAssoc[assoc.size()];
		for( int i = 0; i < assoc.size(); i++ ) {
			ports[i] = new HDLAssoc((VNamedAssign)assoc.get(i));
		}
		
		assoc = comp.getParams();
		HDLAssoc[] gens = new HDLAssoc[assoc.size()];
		for( int i = 0; i < assoc.size(); i++ ) {
			gens[i] = new HDLAssoc((VNamedAssign)assoc.get(i));
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
	
//	public void generate( IRBlock block, String parentName, TextOut out ) {
////		generateFullName(parentName, block);
////		IRType[] types = block.getTypes().getTypes();
////		generate(types, out);
//		ArrayList<IRGeneric> gens = block.getGenerics();
//		for( int i = 0; i < gens.size(); i++ ) {
//			generate( gens.get(i), parentName, null, out );
//		}
//		ArrayList<IRSignal> signals = block.getSignals();
//		for( int i = 0; i < signals.size(); i++ ) {
//			String fullName = getFullName(parentName, block);
//			generate( fullName, signals.get(i), out );
//		}
//		ArrayList<IRStatement> conc = block.getConcurrent();
//		for( int i = 0; i < conc.size(); i++ ) {
//			IRStatement stat = conc.get(i);
//			generateConcurrent(block.getName(), stat, out);
//		}
//		ArrayList<IRProcess> procs = block.getProcesses();
//		for( int i = 0; i < procs.size(); i++ ) {
//			IRProcess proc = procs.get(i);
//			generate( proc, parentName, out );
//		}
//	}
	
	protected void getSensivityList( ArrayList<VOper> list, VOper op ) {
		if( op.getKind() == VOperKind.BINARY && ((VOperBinary)op).getBinaryKind() == VBinaryKind.LOR ) {
			getSensivityList(list, op.getChild(0));
			getSensivityList(list, op.getChild(1));
		} else {
			list.add(op);
		}
	}
	
	public void generate( VInitialOrAlways proc, String parentName, TextOut out ) {
		out.pushScope(new Scope());
        generateLocation(proc.getBegin(), out);
        if( proc.getName() == null ) {
        	proc.setName(ns.getUniqueName(proc, "v_autoprocess") );
        }
		String procFullName = getFullName(parentName, proc);
		push( proc );
		out.nlTabAdd("(process " + procFullName + " (");
		out.pushScope(new Scope());
		ArrayList<VOper> list = new ArrayList<VOper>(); //proc.getSensivityList();
		VDelayOrEventControl ctrl = proc.getStatement().getControl();
		if( ctrl.getDelay() == null && ctrl.getExpression() == null && ctrl.getEvent() != null ) {
			getSensivityList(list, ctrl.getEvent());
		} else if( ctrl.getDelay() == null && ctrl.getExpression() == null && ctrl.getEvent() == null ) {
			proc.getAllReads(list);
		} else {
			throw new RuntimeException();
		}
		for( int i = 0; i < list.size(); i++ ) {
            generateLocation(list.get(i).getBegin(), out);
			out.nlTab();
			generateExpression(list.get(i), parentName, out);
            out.add(")");
		}
		out.nlTabAdd(")");
        out.popScope();
		
        generateBody( proc,
                      new ArrayList<VVariable>(),//proc.getVars(),
                      new ArrayList<VParameter>(),//proc.getConstants(),
//                      proc.getAliases(),
//                      new ArrayList<VType>(),//proc.getTypes(),
                      proc.getStatement(),
//                      proc.getSubprograms(),
                      parentName, out );
        out.popScope();
		glue.generatePendingItems();
		pop();
	}

    public void generateBody( VNamedElement elt,
                              ArrayList<VVariable> vars,
                              ArrayList<VParameter> constants,
//                              ArrayList<IRAlias> aliases,
//                              ArrayList<VType> localTypes,
                              VStatement statements,
//                              IRSubprograms subprograms,
                              String parentName, TextOut out )
    {
//		ArrayList<VType> types = localTypes;
//		localTypes.getTypes(types);
		
		String fullName = parentName + "." + elt.getName();

        boolean letNeeded =
            /*types.size()*/ + vars.size() + constants.size() //+ aliases.size()
            /*+ subprograms.size()*/ > 0;
        
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
//		for( int i = 0; i < types.size(); i++ ) {
//			VType type = types.get(i);
////			generatedTypes.add(type.getFullName());
//			generatedTypes.add(getTypeWrap(type));
////			generateTypeDefinition(type, true, out);
//			generateTypeDefinition(type, VNamedElement.isLocalElement(type)
//                                   ? type.getName() : type.getFullName(), out);
//		}
		for( int i = 0; i < constants.size(); i++ ) {
			VParameter cnst = constants.get(i);
			generate(cnst, null, null, out);
//			generatedConstants.add(cnst);
			generatedConstants.add(new Constant(fullName, cnst));
		}
		for( int i = 0; i < vars.size(); i++ ) {
			VVariable var = vars.get(i);
//			out.nlTabAdd(";; variable " + var.getName() + " of subprogram " + sub.getName());
//			generateUniqueName(var);
			generate(var, null, out);
		}
//        for( int i = 0; i < subprograms.size(); i++ ) {
//            IRSubProgram sub = subprograms.get(i);
//            SubProgram wrap = getSubProgramWrap(sub);
//            generate(wrap, parentName, out);
//        }
        if ( letNeeded )
        {
            out.nlTabAdd(") ;; end locals");
            out.popScope();
        }
		if( statements != null ) generate( statements, parentName, out);
		
		if( elt.getEnd() == null ) {
			System.err.println(elt + " at " + elt.getBegin() + " don't have end coord");
		}
        generateLocation(elt.getEnd(), out);
        out.nlTabAdd("(i:nop))");
        // ^ пустышка в конце для создания точки останова
		out.popScope();
        out.nlTabAdd(letNeeded ? ")))" : "))");
    }
	
	public void generate( SubProgram wrap, String parentName, TextOut out ) {
		VSubProgram sub = wrap.sub;
		stack.push(sub);
        generateLocation(sub.getBegin(), out);
//		out.pushScope(new Scope());
		
        generatedSubprograms.add(wrap);
        
		if( sub.getName().equalsIgnoreCase("minus") ) {
			int a = 0;
			a++;
		}
		
		String kind = sub.isFunction() ? "function" : "procedure";
		String subFullName = getSubFullName(wrap);
//		Integer code = getFunctionCode(sub);
		
		out.nlTabAdd("(" + kind + " " + subFullName );

        ArrayList<VSubParameter> pars = sub.getParams();
        if ( pars.size() == 0 )
        {
            out.add(" () ");
        }
        else
        {
            out.add(" (");
            out.pushScope(new Scope());
            for( int i = 0; i < pars.size(); i++ ) {
                VSubParameter p = pars.get(i);
                generateLocation(p.getBegin(), out);
                out.nlTabAdd("(");
                out.add(p.getName() + " : " );
                generate( p.getType(), false, out );
                out.add( " " + "variable" );//p.getObjectClass().toString().toLowerCase() );
                if ( p.getDir() != null )
                {
                    switch ( p.getDir() )
                    {
//                        case NONE:    break;
                        case INPUT:   out.add(" in"); break;
                        case OUTPUT:  out.add(" out"); break;
                        case INOUT:   out.add(" inout"); break;
//                        case BUFFER:  out.add(" buffer"); break;
//                        case LINKAGE: out.add(" linkage"); break;
                        default:
                            out.add( " " + p.getDir().toString().toLowerCase() );
                            break;
                    }
                }
                out.add("))");
            }
            out.add(")");
            out.popScope();
        }
		
//		if( sub.isFunction() ) {
//			IRFunction f = (IRFunction) sub;
//            out.add(" ");
//			generate( f.getReturnType(), false, out );
//		}

        generateBody( sub,
                      sub.getVars(),
                      new ArrayList<VParameter>(),//sub.getConstants(),
//                      sub.getAliases(),
//                      sub.getTypes(),
                      sub.getBody(),
//                      new IRSubprograms(),
                      // почему-то у IRSubProgram нет вложенных subprogram
                      parentName, out );
        
        glue.generatePendingItems();
        stack.pop();
	}
	
	public void generate( String parentName, VNet sig, TextOut out ) {
        generateLocation(sig.getBegin(), out);
        //out.nlTabAdd(";; signal " + sig.getName());
        // ^ и так сорец выдаем
//		generateFullName(parentName, sig);
		String fullName = getFullName(parentName, sig);
		out.nlTabAdd("(signal " + fullName + " ");
		generate(sig.getType(), false, out);
		if( sig.getInit() != null ) {
			out.add(" ");
			generateExpression(sig.getInit(), parentName, out);
		}
		out.add("))");
	}
	
	public void generate( String parentName, VModuleInstance inst, HDLAssoc[] wires, HDLAssoc[] gens, TextOut out ) {
		
		out.pushScope(null);
		glue.generateComponent(HDLKind.VERILOG, inst.getComponent(), wires, gens, parentName, null, out);
		out.popScope();
	}
		
	public void generateComponentImplementation( String parentName, VModule module, TextOut out ) {
		
		try {
			module.check();
		} catch (CompilerError e1) {
			e1.printStackTrace();
		}
		
		push(module);
		{
			out.pushScope(new Scope());
			ArrayList<VNet> sigs = module.getEnvironment().getNets();
			for( int i = 0; i < sigs.size(); i++ ) {
				VNet sig = sigs.get(i);
				generate( parentName, sig, out );
			}
			out.popScope();
		}
		{
			ArrayList<VInitialOrAlways> pr = module.getConstructs();
			for( int i = 0; i < pr.size(); i++ ) {
				VInitialOrAlways proc = pr.get(i);
//				generateFullName( parentName, proc );
				generate(proc, parentName, out);
			}
		}
		{
			ArrayList<VParameter> cnsts = module.getEnvironment().getParameters();
			for( int i = 0; i < cnsts.size(); i++ ) {
				VParameter cnst = cnsts.get(i);
				generate(cnst, parentName, null, out);
			}
		}
		{
			ArrayList<VVariable> vars = module.getEnvironment().getVariables();
			for( VVariable var : vars ) {
				generate(var, parentName, out);
			}
		}
		{
			out.pushScope(new Scope());
			ArrayList<VModuleInstance> comps = module.getInstances();
			for( int i = 0; i < comps.size(); i++ ) {
				try {
					comps.get(i).semanticCheck();
				} catch (CompilerError e) {
					e.printStackTrace();
				}
				generate( parentName, comps.get(i), out );
			}
			out.popScope();
		}
		{
			out.pushScope(new Scope());
			ArrayList<VStatement> concur = module.getConcurrent();
			for( int i = 0; i < concur.size(); i++ ) {
				generateConcurrent( parentName, concur.get(i), out );
			}
			out.popScope();
		}
		pop();
		out.nlTabAdd( ";; end module " + module.getFullName() );
	}
	
	protected void generateConcurrent(String parentName, VStatement statement, TextOut out) {
		switch( statement.getStatementKind() ) {
		
		case ASSIGN:
		{
			VAssignStatement sig = (VAssignStatement) statement;
			VInitialOrAlways proc = sig.generateProcess(getOwningModule(), err);
			String name = ns.getUniqueName(proc, "v_autoprocess");
			if( name.equalsIgnoreCase("v_autoprocess23") ) {
				int a = 0;
				a++;
			}
			proc.setName(name);
//			generateFullName(parentName, proc);
//			proc.setFullName(name);
			generate(proc, parentName, out);
		}
			break;
			
//		case SELECT_ASGN:
//		{
//			IRSelectedAssign asgn = (IRSelectedAssign) statement;
//			IRProcess proc = asgn.generateProcess(stack.peek(), err);
//			String name = ns.getUniqueName(proc, "autoselect");
//			proc.setName(name);
//			generate(proc, parentName, out);
//		}
//			break;
			
//		case GEN_IF:
//			IRIfGenerateStatement ifgen = (IRIfGenerateStatement) statement;
//			ifgen.generate(err);
//			generate( parentName, ifgen.getProcessedComponents(), out );
//			generate( ifgen.getProcessedStatements(), parentName, out );
//			generateConcurrent(parentName, ifgen.getProcessedConcurent(), out);
//			break;
//			
//		case GEN_FOR:
//			IRForGenerateStatement forgen = (IRForGenerateStatement) statement;
//			forgen.generate(err);
//			generate( parentName, forgen.getProcessedComponents(), out );
//			generate( forgen.getProcessedStatements(), parentName, out );
//			generateConcurrent(parentName, forgen.getProcessedConcurent(), out);
//			break;
//			
		case STATEMENTS:
			VStatements stats = (VStatements) statement;
			for( int i = 0; i < stats.getChildNum(); i++ ) {
				generateConcurrent(parentName, stats.getChild(i), out);
			}
			break;
			
		default:
			throw new RuntimeException(statement.getKind().toString());
		}
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
	
//	public void generate( IRAggreg aggreg, String parentName, TextOut out ) {
//		if( aggreg.getChildNum() == 1 && aggreg.getChild(0).getKind() != IROperKind.ASSOC ) {
//			generateExpression(aggreg.getChild(0), parentName, out);
//		} else {
//            out.pushScope(new Scope());
//            IRType at = aggreg.getType();
//            boolean exprOnlyAggreg = isExpressionOnlyAggreg( aggreg );
//            boolean needAnnotation =
//                !(at instanceof IRArrayIndex // пока не знаю, что с ними делать
//            // TODO: у вложенного агрегата в stdlogic_table тип std_ulogic вместо массива
//            // имеет тип IRArrayIndex
//                  || at.isRecord()
//                  || (at.isArray() &&
//                      ((exprOnlyAggreg && ((IRTypeArray)at).getIndexes().length == 1)
//                       ||
//                       !isUnconstrainedRanges(((IRTypeArray)at.getOriginalType()).getIndexes())
//                       ))
//                  // для массивов аннотация не нужна, если базовый тип
//                  // ограничен (т.е. известен размер массива), или для
//                  // одномерных массивов, состоящих только из выражений
//                  // (для них рамер можно посчитать автоматом).
//                  );
//			out.nlTabAdd(needAnnotation ? "([" : "[");
//            if ( exprOnlyAggreg )
//            {
//                if ( at.isRecord() )
//                {
//                    IRTypeRecord rec = (IRTypeRecord) aggreg.getType();
//                    for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
//                        generateExpression( aggreg.getMemberValue(i), parentName, out );
//                        out.add(" ;; " + rec.getField(i).getName());
//                        out.nlTabAdd(" ");
//                    }
//                }
//                else
//                {
//                    for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
//                        generateExpression( aggreg.getMemberValue(i), parentName, out );
//                        if ( i + 1 < aggreg.getNumMembers() )
//                        {
//                            out.add(" ");
//                        }
//                    }
//                }
//            }
//            else
//            {
//                for( int i = 0; i < aggreg.getNumMembers(); i++ ) {
//                    if( aggreg.getType().isRecord() ) {
//                        // TODO: а у record-ов others не бывает?
//                        IRTypeRecord type = (IRTypeRecord) aggreg.getType();
//                        out.add("(i:f " + type.getField(i).getName());
//                    } else if( aggreg.getMemberIndex(i) instanceof IROperRange ) {
//                        IROperRange r = (IROperRange) aggreg.getMemberIndex(i);
//                        out.add("(i:t ");
//                        generateRange(r, parentName, out);
//                    } else if( aggreg.getMemberIndex(i) instanceof IROperOthers ) {
//                        out.add("(i:others");
//                    } else {
//                        out.add("(i:e ");
//                        generateExpression(aggreg.getMemberIndex(i), parentName, out);
//                        // TODO: идет целое число
//                        // IRAggreg:360: memberIndexes.add(IRTypeInteger.createConstant(ai));
//                    }
//                    out.add("\t\t");
//                    generateExpression( aggreg.getMemberValue(i), parentName, out );
//                    out.add(")");
//                    out.nlTabAdd(" ");
//                }
//            }
////			if( aggreg.getOthersInit() != null ) {
////				out.add("(i:others ");
////				generateExpression( aggreg.getOthersInit(), parentName, out );
////				out.add(")");
////			}
//            if ( needAnnotation )
//            {
//                out.add("] : ");//+aggreg.getType().getClass().getCanonicalName()+" ");
//                generate(aggreg.getType(), false, out);
//                out.add(")");
//            }
//            else
//            {
//                out.add("]");
//            }
//            out.popScope();
//		}
//	}
	
	public void generateGenericExpression( VOper oper, String parentName, TextOut out ) {
		out.add( oper.getKind().toString().toLowerCase() + "( " );
		for( int i = 0; i < oper.getChildNum(); i++ ) {
			generateExpression(oper.getChild(i), parentName, out);
			if( i + 1 < oper.getChildNum() ) out.add(", ");
		}
		out.add( " )" );
	}

    public boolean isStringConst( VValueArray arr ) {
        for( int i = 0; i < arr.getValues().length; i++ ) {
            VValue c = arr.getValues()[i];
//            if ( !c.getType().isEnum() )
//                return false;
            throw new RuntimeException();
//            String val = c.toString();
//            if ( val.length() < 3 || val.charAt(2) != '\'' )
//                return false;
        }
        return true;
    }
        
	public void generateConstantRepresentation( VValue cnst, TextOut out ) {
        VType type = cnst.getType();
        //generate(type, true, out);
        if ( type.getName() != null )
        {
            // генерируем только объявленные типы с именем
            addTypeToGenerate(type, out);
            // TODO: почему-то у report "asdf" тип "asdf" -- какой-то IRArrayIndex
            // который непонятно, как выводить. Ну и у него нет begin(), по-этому
            // addTypeToGenerate его отсекает, как не пойми какой тип
        }
		if( type.isArray() ) {
			VValueArray arr = (VValueArray) cnst;
            if ( isStringConst( arr ) )
            {
                out.add("\"");
                for( int i = 0; i < arr.getValues().length; i++ ) {
                    out.add(arr.getValues()[i].toString().substring(1,2));
                }
                out.add("\"");
            }
            else
            {
                out.add("[");
                for( int i = 0; i < arr.getValues().length; i++ ) {
                    generateConstantRepresentation(arr.getValues()[i], out);
                    if ( i+1 < arr.getValues().length ) out.add(" ");                
                }
                out.add("]");
            }
		} else if( type.isVector() ) {
			VValueVector vec = (VValueVector) cnst;
//			out.add(" "+vec.getLongValue()+" ");
			ValueSet[] vals = vec.getValues();
            out.add("\"");
            for( int i = 0; i < vals.length; i++ ) {
                out.add(vals[i].toString());//.substring(1,2));
            }
            out.add("\"");
		} else if( type.isScalar() ) {
			out.add(cnst.toString()); 
		} else if( type.isType() ) {
			VValueType v = (VValueType) cnst;
			out.add(v.getValue().getFullName());
		} else {
			throw new RuntimeException(type.getName());
		}
	}
	
    void generateName( VNamedElement el, String parentName, TextOut out )
    {
    	if( VNamedElement.isLocalElement(el) ) {
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

    void generateIndex(VOper oper, int idxCount, String parentName, TextOut out)
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
    	String ownerName = stack.get(0).getName();
    	for( int i = 1; i <= lastIndex; i++ ) {
//    		if( stack.get(i) instanceof IRArchitecture ) continue;
    		ownerName += "." + stack.get(i).getName();
    	}
    	return ownerName;
    }

    
    
    protected SubProgram getSubProgramWrap( VSubProgram sub ) {
    	IRSubProgramHolder owner = null;
    	int ownerIndex = -1;
//    	if( sub.getName().equals("resolved") ) {
//    		int a = 0;
//    		a++;
//    	}
//    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
//    		if( stack.get(ownerIndex) instanceof IRSubProgramHolder ) {
//    			VSubProgramHolder cur = (IRSubProgramHolder) stack.get(ownerIndex);
//    			if( cur.getSubprograms().contains(sub) ) {
//    				owner = cur;
//    				break;
//    			}
//    		}
//    	}
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
    
    protected SubProgram addSubProgramToGenerate( VSubProgram sub ) {
    	SubProgram res = getSubProgramWrap(sub);
    	subprogramsToGenerate.add( res );
    	return res;
    }

    
    
    
    protected Type getTypeWrap( VType type ) {
    	IRTypeHolder owner = null;
    	int ownerIndex = -1;
//    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
//    		if( stack.get(ownerIndex) instanceof IRTypeHolder ) {
//    			IRTypeHolder cur = (IRTypeHolder) stack.get(ownerIndex);
//    			if( cur.containsType(type) ) {
//    				owner = cur;
//    				break;
//    			}
//    		}
//    	}
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
    
    protected Type addTypeToGenerate( VType type, TextOut out ) {
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


    protected Constant getConstantWrap( VParameter cnst ) {
    	if( cnst.getName().equals("period_1MHz") ) {
    		int a = 0;
    		a++;
    	}
//    	if( cnst instanceof IRLoopVariable ) return new Constant("", cnst);
    	ILocalResolver owner = null;
    	int ownerIndex = -1;
//    	for( ownerIndex = stack.size() - 1; ownerIndex >= 0; ownerIndex-- ) {
//    		if( stack.get(ownerIndex) instanceof ILocalResolver ) {
//    			ILocalResolver cur = (ILocalResolver) stack.get(ownerIndex);
//    			if( cur.contains(cnst) ) {
//    				owner = cur;
//    				break;
//    			}
//    		}
//    	}
    	String ownerName;
    	if( owner == null ) {
//    		System.err.println(sub.getFullName());
    		ownerName = cnst.getFullName();
    		int index = ownerName.lastIndexOf('.');
    		if( index < 0 ) {
//    			System.err.println(ownerName);
//    			int a = 0;
//    			a++;
//    			((ILocalResolver)stack.get(0)).contains(cnst);
    		}
    		ownerName = ownerName.substring(0, index );
    	} else {
	    	ownerName = getNameFromStack(ownerIndex);
    	}
    	return new Constant(ownerName, cnst);
    }
    
    protected Constant addConstantToGenerate( VParameter cnst ) {
    	Constant res = getConstantWrap(cnst);
    	constantsToGenerate.add( res );
    	return res;
    }

    
    
    
    
        
    void generateExpressionAsArray( VOper oper, String parentName, TextOut out )
    {
        //        out.add(oper.getType().getClass().getCanonicalName());
        if ( oper.getType().getKind() == VTypeKind.ARRAY )
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
    
    public void generateCondition( VOper oper, String parentName, TextOut out ) {
    	if( oper.getType().isVector() ) {
    		out.add("(v2b ");
	    	generateExpression(oper, parentName, out);
	    	out.add(" )");
    	} else {
	    	out.add("(l2b ");
	    	generateExpression(oper, parentName, out);
	    	out.add(" )");
    	}
    }
    
    String getTypeCode(VType type) {
    	if( type.isVector() ) {
    		return "v";
    	} else if( type.isInt() ) {
    		return "i";
    	} else {
    		throw new RuntimeException();
    	}
    }
    
	public void generateExpression( VOper oper, String parentName, TextOut out ) {
        //        out.add(oper.getKind()+" ");
		if( oper instanceof VOperBinary ) {
			VOperBinary bo = (VOperBinary) oper;
            out.add("(");
//			if( bo.getSub() != null &&
//                (!bo.isStandard() || bo.getSub().getBody() != null )) {
//				IRFunction func = (IRFunction) bo.getSub();
//				SubProgram sub = addSubProgramToGenerate(func);//subprogramsToGenerate.add(func);
//                out.add(getSubFullName(sub));
//				out.add(" ");
//				generateExpression(bo.getChild(0), parentName, out);
//				out.add(" ");
//				generateExpression(bo.getChild(1), parentName, out);
//			} 
//			else 
			{
				out.add( bo.getBinaryKind().getImage() + getTypeCode(bo.getChild(0).getType()) + getTypeCode(bo.getChild(1).getType()) );
                switch ( bo.getBinaryKind() )
                {
                    case EQ:
                    case NE:
                    case LT:
                    case LE:
                    case GT:
                    case GE:
                        out.add(" ");
                        
                        // имя типа не добавляем, т.к. временно используются "стандартные" функции вместо встроенных операций
//                		out.add(bo.getChild(0).getType().getName()/*getBaseTypeName()*/ + " ");
                        
                        // для операций сравнения необходим базовый тип
                        // (т.к. по типу результата понять тип
                        // аргументов нельзя)
                        break;
                    case MUL:
                    case DIV:
                    {
                        VType a = bo.getChild(0).getType();
                        VType b = bo.getChild(1).getType();

//                        if ( a instanceof IRTypePhysical
//                             || b instanceof IRTypePhysical
//                             || (bo.getKind() == IROperKind.DIV
//                                 && a instanceof IRTypeReal) )
//                        {
//                            out.add("g "
//                                    + bo.getChild(0).getType().getBaseTypeName()
//                                    + " "
//                                    + bo.getChild(1).getType().getBaseTypeName()
//                                    );
//                        }
                        out.add(" ");

                        break;
                    }
                    default:
                        out.add(" ");
                        break;
                }
                if ( bo.getKind() == VOperKind.CONCAT )
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
		} else if( oper.getKind() == VOperKind.UNARY ) {
			VOperUnary uo = (VOperUnary) oper;
            out.add("(");
//			if( uo.getSub() != null &&
//                (!uo.isStandard() || uo.getSub().getBody() != null )) {
//				IRFunction func = (IRFunction) uo.getSub();
//				SubProgram sub = addSubProgramToGenerate(func);//subprogramsToGenerate.add(func);
//                out.add(getSubFullName(sub));
//				out.add(" ");
//				generateExpression(uo.getChild(0), parentName, out);
//            }
//            else
            {
// 				out.add( uo.toString() + "sub=" + uo.getSub() + "body=" + uo.getSub().getBody() + " isStandard=" + uo.isStandard());
// 				out.add(" ");
                out.add(uo.getUnaryKind().getImage());
                out.add(" ");
                generateExpression(uo.getChild(0), parentName, out);
            }
            out.add(")");
			return;
		}
		
		switch( oper.getKind() ) {
//		case AGGREG:
//			generate( (IRAggreg) oper, parentName, out );
//			break;
//			
		case CONST:
            generateConstantRepresentation(((VConst) oper).getValue(), out);
			break;
			
//		case SGNL:
//			generateName(((IRSignalOper) oper).getSignal(), parentName, out);
//			break;
//			
//		case VAR:
//            generateName(((IRVarOper) oper).getVariable(), parentName, out);
//			break;
			
		case NAME:
			VName name = (VName) oper;
            generateName(name.getElement(), parentName, out);
	//		out.add(name.getName());
			break;
			
       case CAST:
           VOperCast tc = (VOperCast)oper;
           out.add("(i:vqualify_type ");
           generate( oper.getType(), false, out );
           out.add(" ");
           VType t = oper.getChild(0).getType();
           if ( t instanceof VTypeInteger ) {
               out.add("STD.STANDARD.INTEGER");
           } else if ( t instanceof VTypeReal ) {
               out.add("STD.STANDARD.REAL");
               
           } else {
               generate( oper.getChild(0).getType(), false, out );
               // ^ генерим как было для не real/integer
           }
           out.add(" ");
           generateExpression(tc.getChild(0), parentName, out);
           out.add(")");
		   break;
			
//		case QUALIFY:
//			out.add("(i:qualify_type ");
//			generate( oper.getType(), false, out );
//			out.add(" ");
//			generateExpression(oper.getChild(0), parentName, out);
//			out.add(")");
//			break;
			
//		case ARRAY_BOUND:
//			IRArrBound bound = (IRArrBound) oper;
//			out.add("(i:" + bound.toString().toLowerCase() + " ");//(bound.isHighBound() ? "high" : "low") + "(");
//			generateExpression(bound.getChild(0), parentName, out);
//			out.add(")");
//			break;
			
//		case FCALL:
//			IRFunctionCall fcall = (IRFunctionCall) oper;
//			SubProgram sub = addSubProgramToGenerate(fcall.getFunction());//subprogramsToGenerate.add(fcall.getFunction());
//			if( fcall.getFunction() == null ) {
//				int a = 0;
//				a++;
//			}
////			generateUniqueName(fcall.getFunction());
//			out.add("(" + getSubFullName(sub));
//			IROper[] params = fcall.getProcessedParameters();
//			for( int i = 0; i < params.length; i++ ) {
//				out.add(" ");
//				generateExpression(params[i], parentName, out);
//			}
//			out.add(")");
//			break;
			
//		case ATTRIB:
//			IRAttrib attrib = (IRAttrib) oper;
//			if( attrib.getValue() != null && !(attrib.getValue() instanceof IRArrBound) ) {
//				generateExpression(attrib.getValue(), parentName, out);
//			} else {
//                String aname = attrib.getAttributeName().toLowerCase();
//                switch ( attrib.getCode() )
//                {
//                    case ARRAY:
//                        out.add("(i:a'" + aname + " 1 ");
//                        // TODO: а что делать с N-ным атрибутом?
//                        break;
//                    case TYPE:
//                        out.add("(i:t'" + aname + " ");
//                        break;
//                    case SIGNAL:
//                        out.add("(i:s'" + aname + " ");
//                        break;
//                    case TYPE_ARRAY:
//                        out.add("(i:ta'" + aname + " 1 ");
//                        break;
//                    default:
//                        throw new RuntimeException(attrib.getCode().toString()
//                                                   + " attrib in vir?");
//                }
//				generateExpression(attrib.getChild(0), parentName, out);
//				for( int i = 1; i < attrib.getChildNum(); i++ ) {
//					out.add(" ");
//					generateExpression(attrib.getChild(i), parentName, out);
//				}
//                out.add(")");
//			}
//			break;
			
//		case CHOICES:
//			IRChoices ch = (IRChoices) oper;
//            out.add( "(" ); 
//			for( int i = 0; i < ch.getChildNum(); i++ ) {
//				generateExpression( ch.getChild(i), parentName, out);
//                if ( i+1 < ch.getChildNum() ) out.add(" ");
//			}
//            out.add( ")" );
//			break;
			
//		case CONST_READ:
//			IRConstRead cr = (IRConstRead) oper;
////			constantsToGenerate.add(cr.getConstant());
//			constantsToGenerate.add(getConstantWrap(cr.getConstant()));
//            generateName(cr.getConstant(), parentName, out);
//			break;
			
//		case FIELD:
//			IRFieldOper fo = (IRFieldOper) oper;
//			out.add(fo.getField().getName());
//			break;
			
		case INDEX:
			out.add("[(i:index ");
//            IRType ch0Type = oper.getChild(0).getType();
//            IRTypeArray at;
//            if ( ch0Type instanceof IRArrayIndex )
//            {
//                at = ((IRArrayIndex)ch0Type).getArrayType(); 
//            }
//            else
//            {
//                at = (IRTypeArray)ch0Type;
//            }
//            int idxCount = at.getIndexes().length;
            generateIndex(oper, 1, parentName, out);
			out.add(")]");
			break;
		
//		case RANGE:
//			out.add("(i:slice ");
//			generateExpression( oper.getChild(0), parentName, out );
//            // TODO: у slice-а должен быть range, подходящий для generateRange
//            // не только to/downto но и тип/'range/'reverse_range
//			out.add(" (range ");
//			VOperRange range = (VOperRange) oper;
//			generateExpression( range.getLeft(), parentName, out );
//			if( range.isDownTo() ) {
//				out.add(" downto ");
//			} else {
//				out.add(" to ");
//			}
//			generateExpression( range.getLeft(), parentName, out );
//			out.add("))");
//			break;
			
		case SLICE:
			out.add("(i:slice ");
			generateExpression( oper.getChild(0), parentName, out );
            // TODO: у slice-а должен быть range, подходящий для generateRange
            // не только to/downto но и тип/'range/'reverse_range
			out.add(" ");
			generateExpression( oper.getChild(1), parentName, out );
			out.add(")");
			break;
			
		case RANGE:
			out.add("(range ");
			VOperRange range = (VOperRange) oper;
			generateExpression( range.getLeft(), parentName, out );
			if( range.isDownTo() ) {
				out.add(" downto ");
			} else {
				out.add(" to ");
			}
			generateExpression( range.getRight(), parentName, out );
			out.add(")");
			break;
			
		case DOT:
			out.add("(i:field ");
			generateExpression( oper.getChild(0), parentName, out ); 
			out.add(" ");
			generateExpression( oper.getChild(1), parentName, out );
			out.add(")");
			break;
			
		case EDGE:
			VOperEdge edge = (VOperEdge) oper;
			
			// TODO DUCK !!! теряется информация от фронте
//			out.add(edge.isNegative()?"(IEEE.STD_LOGIC_1164.FALLING_EDGE ":"(IEEE.STD_LOGIC_1164.RISING_EDGE ");
			generateExpression( oper.getChild(0), parentName, out );
//			out.add(")");
			break;
			
		case CONCAT:
			if( oper.getChildNum() == 1 ) {
				generateExpression(oper.getChild(0), parentName, out);
			} else {
				int i;
				for( i = 0; i < oper.getChildNum() - 1; i++ ) {
					out.add("(& ");
					generateExpression(oper.getChild(i), parentName, out);
				}
				out.add(" ");
				generateExpression(oper.getChild(i), parentName, out);
				for( i = 0; i < oper.getChildNum() - 1; i++ ) {
					out.add(")");
				}
			}
//            generateExpressionAsArray(oper.getChild(0), parentName, out);
//            if( oper.getChildNum() > 1 ) {
//	            out.add(" ");
//	            generateExpressionAsArray(oper.getChild(1), parentName, out);
//            }
            break;
            
		case COND:
			{
				VOperCond cond = (VOperCond) oper;
				out.add("(? ");
				generateExpression(cond.getCondition(), parentName, out);
				out.add(" ");
				generateExpression(cond.getTrueExpr(), parentName, out);
				out.add(" ");
				generateExpression(cond.getFalseExpr(), parentName, out);
				out.add(")");
			}
			break;
			
		case REPLIC:
		{
			VOperReplic replic = (VOperReplic) oper;
			out.add("(i:replic ");
			generateExpression(replic.getMultiplier(), parentName, out);
			out.add(" ");
			generateExpression(replic.getExpression(), parentName, out);
			out.add(")");
			break;
		}
//		case OTHERS:
//			out.add("i:others");
//			break;

//        case OPEN:
//			out.add(oper.getKind().toString().toLowerCase());
//			break;
			
//        case AFTER:
//        	IRAfter after = (IRAfter) oper;
//        	generateExpression(after.getValue(), parentName, out);
//        	out.add(" after ");
//        	generateExpression(after.getTime(), parentName, out);
//        	break;

//		case ALIAS:
//			IROperAlias al = (IROperAlias) oper;
//            generateName(al.getAlias(), parentName, out);
//			break;
			
//		case COMMA:
//			IROperComma comma = (IROperComma) oper;
//			generateExpression(comma.getLeft(), parentName, out);
//			out.add(", ");
//			generateExpression(comma.getRight(), parentName, out);
//			break;
			
//		case NULL:
//			out.add("NULL");
//			break;
			
		default:
			throw new RuntimeException(oper.getKind().toString());
//			generateGenericExpression( oper, parentName, out );
//			break;
		}
	}
	
	protected String getSubFullName( SubProgram sub ) {
		String res = sub.owner + "." + sub.sub.getName();//sub.getFullName();
		Integer code = Integer.valueOf(0);//getFunctionCode(sub.sub);
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
	
	
	public String getFullName( String parentName, VNamedElement el ) {
		if( parentName == null ) return el.getName();
		return parentName + "." + el.getName();
		/*
        if ( IRNamedElement.isLocalElement(el) )
        {
            return el.getName();
        }
		int ownerIndex;
		ILocalResolver owner = null;
		for( ownerIndex = stack.size()-1; ownerIndex >= 0; ownerIndex-- ) {
			IRNamedElement cur = stack.get(ownerIndex);
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
             el.getParent() instanceof IREntity) ) {
			return parentName + "." + el.getName();
        } else {
            return el.getFullName();
        }
        */
	}
    public String getFullName( String parentName, IRElement el, String name ) {
        if( parentName != null &&
            (el.getParent() instanceof IRArchitecture ||
             el.getParent() instanceof IREntity) ) {
			return parentName + "." + name;
        } else {
            return IRNamedElement.getFullName(el, name);
        }
	}
	
	public void generateConstants( TextOut out ) {
		while( constantsToGenerate.size() > 0 ) {
			Constant[] consts = constantsToGenerate.toArray(new Constant[constantsToGenerate.size()]);
			for( int i = 0; i < consts.length; i++ ) {
				Constant cnst = consts[i];
				constantsToGenerate.remove(cnst);
//				if( cnst.constant instanceof IRGeneric || cnst.constant instanceof IRLoopVariable ) continue;
				if( !generatedConstants.contains(cnst) ) {
//                    if ( !IRNamedElement.isLocalElement(cnst.constant) )
                    {
                        generate(cnst.constant, cnst.owner, null, out);
                    }
				}
			}
		}
	}
	
	public void generatePendingItems() {
		while( !constantsToGenerate.isEmpty() || !subprogramsToGenerate.isEmpty() || !typesToGenerate.isEmpty() ) {
			generateConstants(glue.cnstsOut);
			generateSubprograms(glue.funcsOut);
			generateTypes(glue.typesOut);
		}
	}
	
	public void generateTypeDefinition( VType type, String fullName, TextOut out ) {
        generateLocation(type.getBegin(), out);
//         if ( isFullName && type.getFullName().equalsIgnoreCase("STD.STANDARD.BIT_VECTOR") )
//         {
//             type.dumpStacks();
//         }
        if ( type.getBegin() == null )
        {
//            type.dumpStacks();
        }
//		out.nlTabAdd("(type " + (isFullName?type.getFullName():type.getName()) + " ");
		out.nlTabAdd("(type " + fullName + " ");
        generate(type, true, out);
        out.add("))");
    }

	public void generateTypes(TextOut out) {
		while( !typesToGenerate.isEmpty() ) {
			Type[] toGen = typesToGenerate.toArray(new Type[typesToGenerate.size()]);
			for( int i = 0; i < toGen.length; i++ ) {
				Type type = toGen[i];
				if( type.type.getName() != null &&
                    // ^ тут могут оказаться безымянные типы
                    // от всяких  variable asdf : integer range 1 to 5;
                    // или просто variable asdf : integer;
                    // т.е. от subtypeThunk
                    !generatedTypes.contains(type) 
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
