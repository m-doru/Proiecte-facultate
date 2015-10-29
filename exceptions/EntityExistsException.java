package exceptions;

public class EntityExistsException extends Throwable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 495472072610828584L;
	String err;
	public EntityExistsException() {
		
	}
	public EntityExistsException(String _err){
		this.err = _err;
	}
}
