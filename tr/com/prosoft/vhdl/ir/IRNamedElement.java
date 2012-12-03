package com.prosoft.vhdl.ir;

import com.prosoft.common.FullCoord;
import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;

public class IRNamedElement extends IRElement implements ICoordinatedElement {

	private String name;
	private FullCoord coord = new FullCoord(null, null);

	public IRNamedElement(IRElement parent, String name) {
		super(parent);
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String toString() {
		return getName();
	}

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
	
	public IRType getType() {
		return null;
	}

    public static boolean isLocalElement( IRElement elt )
    {
//     	if( (elt instanceof IRConstant || elt instanceof IRVariable) && elt.getParent() instanceof IRArchitecture ) {
//     		return true;
//     	}
        IRElement p = elt.getParent();
        return
            p instanceof IRSubProgram ||
            p instanceof IRProcess ||
            p instanceof IRSubProgram.ParameterHolder ||
            p instanceof IRForStatement ||
            // бывает у портов
            p instanceof IRForGenerateStatement ||
            p instanceof IROperAssoc ||
            p instanceof IRDotOper // ||
            // TODO: временная заглушка для case choice-ов
            //p instanceof IRChoices
            ;
    }

    public static String getFullName(IRElement elt, String name)
    {
    	if( name != null && name.equals("dead_loop") ) {
    		int a = 0;
    		a++;
    	}

//        if ( isLocalElement(elt) )
//        {
//            return name;
//        }

        IRElement cur = elt.getParent();
        String res = name;
        while( !(cur instanceof LibEnvironment) ) {
            if(        cur instanceof IRPackage ) {
                res = ((IRPackage)cur).getName() + "." + res;
            } else if( cur instanceof Library ) {
                res = ((Library)cur).getName() + "." + res;
            } else if( cur instanceof IRArchitecture ) {
//                 res = ((IRArchitecture)cur).getName() + "." + res;
                // выбора архитектур пока все равно нет
                // так что не засоряем промежуточное представление
            } else if( cur instanceof IREntity ) {
            	IREntity en = ((IREntity)cur); 
                res = en.getName() + "." + res;
                return res;
            } else if( cur instanceof IRProcess ) {
                res = ((IRProcess)cur).getName() + "." + res;
            } else if( cur instanceof IRBlock ) {
                res = ((IRBlock)cur).getName() + "." + res;
            } else if( cur instanceof IRSubProgram ) {
                res = ((IRSubProgram)cur).getName() + "." + res;
            } else if( cur instanceof IRDesignFile ||
                       cur instanceof IRPackage.Body ||
                       cur instanceof IRPackage.Declaration ||
                       cur instanceof IRContext ||
                       cur instanceof IRStatement ) {

            } else {
                throw new RuntimeException(cur.getClass().getCanonicalName() + " at " + ((ICoordinatedElement)elt).getBegin() );
            }
            if( cur.getParent() == null ) throw new RuntimeException();
            cur = cur.getParent();
        }
        if ( res == null )
        {
            throw new RuntimeException(elt.getClass().getCanonicalName() + " " +
                                       elt.getParent().getClass().getCanonicalName());
        }
        return res;
    }

	private String fullName = null;
	public String getFullName() {
		if( fullName == null ) {
			if( name == null || name != null && name.equals("period_1MHz") ) {
				int a = 0;
				a++;
			}
			fullName = getFullName(this, getName());
		}
//        if ( fullName == null )
//        {
//        	getFullName(this, getName());
//            throw new RuntimeException(getClass().getCanonicalName() + " " +
//                                       getParent().getClass().getCanonicalName());
//        }
		return fullName;
	}
}
