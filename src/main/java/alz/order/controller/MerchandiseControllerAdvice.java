package alz.order.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;

@RestControllerAdvice
public class MerchandiseControllerAdvice {
	
	@ExceptionHandler(UnsatisfiedContentException.class)
	public ResponseEntity<?> unsatisfy(UnsatisfiedContentException e) {
		System.out.println("unsatisfy");
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getError());
	}
	
	@ExceptionHandler(TemporaryServerException.class)
	public ResponseEntity<?> tempServer(TemporaryServerException e) {
		System.out.println("temporary");
		return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(e.getError());
	}
}
