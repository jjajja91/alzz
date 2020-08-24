package alz.order.exceptions;

import org.springframework.validation.FieldError;

public class TemporaryServerException extends RuntimeException {
	
	private FieldError error;
	
	public TemporaryServerException() {
		super();
	}

	public TemporaryServerException(FieldError error) {
		this.error = error;
	}

	public FieldError getError() {
		return error;
	}

}
