package com.prosoft.vhdl.ir;

import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;

public class IRElement {
	
	private IRElement parent;
	
	public IRElement( IRElement parent ) {
		this.parent = parent;
	}

	public IRNamedElement resolve( String name ) {
		IRElement resolver = this;
		while( resolver != null ) {
			if( resolver instanceof ILocalResolver ) {
				IRNamedElement res = ((ILocalResolver)resolver).localResolve(name);
				if( res != null ) return res;
			}
			if( resolver.parent == null && !(resolver instanceof LibEnvironment) ) {
				throw new RuntimeException("Incomplete tree upon " + resolver);
			}
			resolver = resolver.parent;
		}
		return null;
	}
	
	public IRComponent resolveComponent( String name ) {
		IRElement resolver = this;
		while( resolver != null ) {
			if( resolver instanceof IRComponentTypeHolder ) {
				IRComponent res = ((IRComponentTypeHolder)resolver).getComponent(name);
				if( res != null ) return res;
			}
			if( resolver.parent == null && !(resolver instanceof LibEnvironment) ) {
				throw new RuntimeException("Incomplete tree upon " + resolver);
			}
			resolver = resolver.parent;
		}
		return null;
	}
	
	public void resolve( IRSubprogramSearchContext cnt ) throws CompilerError {
		IRElement resolver = this;
		if( cnt.localResolver != null ) {
			resolver = (IRElement) cnt.localResolver;
		}
		while( resolver != null ) {
			if( resolver instanceof ILocalResolver ) {
				((ILocalResolver)resolver).localResolve(cnt);
			}
			if( resolver.parent == null && !(resolver instanceof LibEnvironment) ) {
				String coord = "";
				if( resolver instanceof ICoordinatedElement ) {
					ICoordinatedElement el = (ICoordinatedElement) resolver;
					if( el.getBegin() != null ) {
						coord = el.getBegin().toString();
					}
				}
				throw new RuntimeException("Incomplete tree upon " + resolver + " at " + coord);
			}
			resolver = resolver.parent;
		}
		cnt.checkMatched();
	}
	
	public void setParent(IRElement parent) {
		this.parent = parent;
	}
	
	public IRElement getParent() {
		return parent;
	}
	
	public IRElement getNonOperParent() {
		if( this instanceof IROper ) {
			return getParent().getNonOperParent();
		}
		return this;
	}
	
	public IRContext getContext() {
		if( this instanceof IRContext ) {
			return (IRContext) this;
		}
		return getParent().getContext();
	}
	
	public void reportError() {
		reportError("Internal compiler error");
	}

	public void reportError(String errorString) {
		TextCoord coord = null;
		IRElement el = this;
		while( el != null ) {
			if( el instanceof ICoordinatedElement ) {
				coord = ((ICoordinatedElement)el).getBegin();
				if( coord != null ) {
					break;
				}
			}
			el = el.getParent();
		}
		if(coord!=null)  throw new RuntimeException(coord + errorString);
		throw new RuntimeException(errorString);
	}
	
}
