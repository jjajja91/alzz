package alz.board.exceptions;

import org.springframework.validation.FieldError;

public class UnsatisfiedContentException extends RuntimeException {
	
	private FieldError error;
	
	public UnsatisfiedContentException() {
		super();
	}
	
	public UnsatisfiedContentException(FieldError error) {
		this.error = error;
	}

	public FieldError getError() {
		return error;
	}

}
