package alz.user.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import alz.user.exceptions.UnauthorizedException;

@ControllerAdvice
public class UserPageControllerAdvice {
	
	@ExceptionHandler(UnauthorizedException.class)
	public String unAuthorized(UnauthorizedException e) {
		return "error/unAuthorized";
	}

}
