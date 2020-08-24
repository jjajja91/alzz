package alz.board.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import alz.board.exceptions.TemporaryServerException;
import alz.board.exceptions.UnsatisfiedContentException;

@RestControllerAdvice
public class BoardApiControllerAdvice {
	
	// 잘못된 요청
	@ExceptionHandler(UnsatisfiedContentException.class)
	public ResponseEntity<?> unsatisfy(UnsatisfiedContentException e) {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getError());
	}
	
	// 생기지 않아야할 에러가 생긴 경우
	@ExceptionHandler(TemporaryServerException.class)
	public ResponseEntity<?> tempServer(TemporaryServerException e) {
		return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(e.getError());
	}
}
