package com.tisson.sgmms.api.security;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

public class Authentication implements Serializable {

    static ThreadLocal<Authentication> threadLocal = new ThreadLocal<>();

    private String subject;

    private String compactJws;

    private boolean authenticated;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getCompactJws() {
        return compactJws;
    }

    public void setCompactJws(String compactJws) {
        this.compactJws = compactJws;
    }

    public boolean isAuthenticated() {
        return authenticated;
    }

    public void setAuthenticated(boolean authenticated) {
        this.authenticated = authenticated;
    }

    public static Authentication getCurrent() {
        Authentication authentication = threadLocal.get();
        if (authentication == null) {
            throw new SecurityException();
        }
        return authentication;
    }

    public static void setCurrent(@NotNull Authentication authentication) {
        threadLocal.set(authentication);
    }

    public static void clear() {
        threadLocal.remove();
    }
}
