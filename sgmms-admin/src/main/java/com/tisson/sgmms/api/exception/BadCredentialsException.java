package com.tisson.sgmms.api.exception;

/**
 * <p>
 *     密码/验证码不正确
 * </p>
 *
 * @author zhuzhiou
 */
public class BadCredentialsException extends SecurityException {

    public BadCredentialsException() {
        super();
    }

    public BadCredentialsException(String message) {
        super(message);
    }
}
