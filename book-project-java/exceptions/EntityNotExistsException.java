package exceptions;

public class EntityNotExistsException extends Throwable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5713793100825663589L;
	public String err;
	public EntityNotExistsException(){
		;
	}
	public EntityNotExistsException(String err){
		this.err = err;
	}
}
