package com.tisson.sgmms.api.exception;

import java.security.AccessControlException;

public class DeniedException extends AccessControlException {

    public DeniedException(String message) {
        super(message);
    }
}
