package com.tisson.sgmms.api.filter;

import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.api.security.AuthenticationManager;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.apache.commons.lang3.StringUtils.*;

/**
 * <p>JSON Web Signature</p>
 *
 * @author zhuzhiou
 */
public class ClaimsFilter implements Filter {

    private AntPathMatcher antPathMatcher = new AntPathMatcher("/");

    private String[] whitelists = StringUtils.split("/api/authentication*|/api/verificationCode*|/api/**/*.html|/api/**/*.js|/api/**/*.json|/api/**/*.css|/api/**/*.map|/api/**/*.png", "|");

    private AuthenticationManager authenticationManager;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        ServletContext sc = filterConfig.getServletContext();
        WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(sc);
        this.authenticationManager = wac.getBean(AuthenticationManager.class);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = removeStart(request.getRequestURI(), request.getContextPath());
        for (String whitelist : whitelists) {
            // 白名单
            if (antPathMatcher.match(whitelist, path)) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
        String authorization = request.getHeader("Authorization");
        if (isBlank(authorization) || !startsWithIgnoreCase(authorization, "Bearer ")) {
            response.setStatus(401);
            return;
        }
        String compactJws = StringUtils.substring(authorization, 7);
        //SecurityContext context = SecurityContext.getContext();
        try {
            Authentication authentication = authenticationManager.authenticate(compactJws);
            Authentication.setCurrent(authentication);
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (SecurityException e) {
            response.setStatus(401);
        } finally {
            Authentication.clear();
        }
    }

    @Override
    public void destroy() {
        this.authenticationManager = null;
    }
}
