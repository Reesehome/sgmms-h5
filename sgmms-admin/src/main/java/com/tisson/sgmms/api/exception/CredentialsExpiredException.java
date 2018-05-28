package com.tisson.sgmms.api.exception;

public class CredentialsExpiredException extends SecurityException {

    public CredentialsExpiredException() {
        super();
    }

    public CredentialsExpiredException(String message) {
        super(message);
    }
}
