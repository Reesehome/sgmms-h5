package com.tisson.sgmms.api.security;

import com.tisson.sgmms.customer.repository.MmsCustomerUserRepository;
import com.tisson.tds.properties.entity.SysProperty;
import com.tisson.tds.properties.service.SysPropertyService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.joda.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static org.apache.commons.lang3.StringUtils.isBlank;

@Service
public class AuthenticationManager {

    @Autowired
    private SysPropertyService sysPropertyService;

    public Authentication authenticate(String compactJws) {
        SysProperty jwtSecret = sysPropertyService.findSysPropertyByKey("JJWT_SECRET");
        if (jwtSecret == null || isBlank(jwtSecret.getPropValue())) {
            throw new IllegalArgumentException("请配置系统参数JJWT_SECRET");
        }
        Claims claims = Jwts.parser().setSigningKey(jwtSecret.getPropValue()).parseClaimsJws(compactJws).getBody();
        if (!"天讯瑞达".equals(claims.getIssuer())) {
            throw new SecurityException("签发者不正确");
        }
        if (!"天讯瑞达".equals(claims.getAudience())) {
            throw new SecurityException("接收方不正确");
        }
        LocalDateTime exp = new LocalDateTime(claims.getExpiration());
        if (exp.isBefore(LocalDateTime.now())) {
            throw new SecurityException("令牌已过期");
        }
        Authentication authentication = new Authentication();
        authentication.setSubject(claims.getSubject());
        authentication.setCompactJws(compactJws);
        return authentication;
    }
}
