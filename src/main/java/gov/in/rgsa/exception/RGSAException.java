package gov.in.rgsa.exception;

public class RGSAException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public RGSAException() {
		super();
	}

	public RGSAException(String message, Throwable cause) {
		super(message, cause);
	}

	public RGSAException(String message) {
		super(message);
	}

	public RGSAException(Throwable cause) {
		super(cause);
	}

}
