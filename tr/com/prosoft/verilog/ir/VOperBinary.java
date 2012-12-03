package com.prosoft.verilog.ir;

public class VOperBinary extends VOper {
	
	VBinaryKind kind;

	public VOperBinary(VOper left, VBinaryKind kind, VOper right) {
		super(left, right);
		this.kind = kind;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.BINARY;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( !env.ensureType(VTypeKind.scalar, getChild(0), false) || 
				!env.ensureType(VTypeKind.scalar, getChild(1), false) ) {
			return null;
		}
		switch(kind) {
		case ADD:
		case SUB:
		case MUL:
		case DIV:
		case MOD:
		case BAND:
		case BOR:
		case BXOR:
		case BEQ:
			return env.inferBiggestTypeAndMakeCast(new VOper[] {getChild(0), getChild(1)});
			
		case CEQ:
		case CNE:
		case EQ:
		case NE:
		case GT:
		case GE:
		case LT:
		case LE:
		case LAND:
		case LOR:
			env.inferBiggestTypeAndMakeCast(new VOper[] {getChild(0), getChild(1)});
			return VTypeVector.singleBit;
			
		case ASL:
		case ASR:
		case LSL:
		case LSR:
			env.ensureType(VTypeKind.intAndVector, getChild(1), false);
		case POW:
			return getChild(0).getType();
			
		default:
			throw new RuntimeException(kind.toString());
		}
	}

	public VBinaryKind getBinaryKind() {
		return kind;
	}
}
