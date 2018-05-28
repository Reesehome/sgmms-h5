package com.tisson.sgmms.api.exception;

public class UserStatusException extends SecurityException {

    public UserStatusException() {
        super();
    }

    public UserStatusException(String message) {
        super(message);
    }
}