package com.tisson.sgmms.api.wrap;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.lang.reflect.Array;

//@ControllerAdvice
public class ResponseWrapAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public @ResponseBody Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        if (returnType.getMethodAnnotation(ResponseWrap.class) != null) {
            if (body instanceof Exception) {
                return new Wrapper(false, body);
            }
            if (body instanceof Void || body instanceof String || body instanceof Array) {
                throw new UnsupportedOperationException("使用OpenAPI注解的函数，只能返回对象或集合，不能返回基本类型、Void、数组等");
            }
            return new Wrapper(true, body);
        }
        return body;
    }
}
