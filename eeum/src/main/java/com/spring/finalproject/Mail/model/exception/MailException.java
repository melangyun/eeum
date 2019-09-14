package com.spring.finalproject.Mail.model.exception;

public class MailException extends RuntimeException{
	public MailException() {
	}

	public MailException(String msg) {
		super(msg);
	}
}
