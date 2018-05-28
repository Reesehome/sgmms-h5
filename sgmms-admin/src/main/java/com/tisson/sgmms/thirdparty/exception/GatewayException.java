package com.tisson.sgmms.thirdparty.exception;

/**
 * <p>
 *     短信平台异常
 * </p>
 */
public class GatewayException extends RuntimeException {

    public GatewayException(String message) {
        super(message);
    }
}
