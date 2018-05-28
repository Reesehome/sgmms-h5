package com.tisson.sgmms.api.exception;

import com.tisson.sgmms.api.wrap.Wrapper;
import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 *     异常时也需要返回<code>JSON</code>对象，不使用ControllerAdvice是避免污染了基础平台的接口。
 * </p>
 *
 * @author zhuzhiou
 */
public abstract class ExceptionController {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public Wrapper<Exception> handleException(HttpServletRequest request, Exception exception) {
        if (logger.isErrorEnabled()) {
            logger.error("异常出错", exception);
        }
        Wrapper<Exception> wrapper = new Wrapper<>(false, exception);
        return wrapper;
    }

    @ExceptionHandler(value = SecurityException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ResponseBody
    public Wrapper<SecurityException> handleException(SecurityException exception) {
        Wrapper<SecurityException> wrapper = new Wrapper<>(false, exception);
        return wrapper;
    }

    @ExceptionHandler(value = DeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    @ResponseBody
    public Wrapper<DeniedException> handleException(DeniedException exception) {
        Wrapper<DeniedException> wrapper = new Wrapper<>(false, exception);
        return wrapper;
    }
}
