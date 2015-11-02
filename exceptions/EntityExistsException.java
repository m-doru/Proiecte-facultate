package exceptions;

public class EntityExistsException extends Throwable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 495472072610828584L;
	public String err;
	public EntityExistsException() {
		;
	}
	public EntityExistsException(String err){
		this.err = err;
	}
}
