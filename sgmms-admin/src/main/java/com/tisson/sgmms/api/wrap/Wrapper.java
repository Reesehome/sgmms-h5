package com.tisson.sgmms.api.wrap;

import java.io.Serializable;

public class Wrapper<T> implements Serializable {

    private boolean success;

    @com.fasterxml.jackson.annotation.JsonUnwrapped
    @org.codehaus.jackson.annotate.JsonUnwrapped
    private T content;

    public Wrapper(boolean success) {
        this.success = success;
    }

    public Wrapper(boolean success, T content) {
        this.success = success;
        this.content = content;
    }

    public boolean isSuccess() {
        return success;
    }

    public T getContent() {
        return content;
    }

    public static Wrapper<Void> success() {
        return new Wrapper<>(true);
    }

    public static <T> Wrapper<T> success(T content) {
        return new Wrapper<>(true, content);
    }
}
