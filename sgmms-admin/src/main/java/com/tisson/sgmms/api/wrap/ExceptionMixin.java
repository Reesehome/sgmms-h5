package com.tisson.sgmms.api.wrap;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * <p>异常类，只需要序列化<code>message</code>属性。</p>
 *
 * @author zhuzhiou
 */
@JsonIgnoreProperties(value = {"stackTrace", "cause", "ourStackTrace", "stackTraceDepth", "suppressed"})
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.NONE, getterVisibility = JsonAutoDetect.Visibility.NONE, isGetterVisibility = JsonAutoDetect.Visibility.NONE)
public interface ExceptionMixin {

    @JsonProperty("description")
    String getMessage();
}
