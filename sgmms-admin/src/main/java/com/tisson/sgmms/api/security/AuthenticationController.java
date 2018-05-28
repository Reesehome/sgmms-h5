package com.tisson.sgmms.api.security;

import com.tisson.sgmms.api.exception.BadCredentialsException;
import com.tisson.sgmms.api.exception.CredentialsExpiredException;
import com.tisson.sgmms.api.exception.ExceptionController;
import com.tisson.sgmms.api.exception.UserStatusException;
import com.tisson.sgmms.api.wrap.Wrapper;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.service.MmsCustomerUserService;
import com.tisson.sgmms.customer.specification.CustomerUserSpecification;
import com.tisson.tds.properties.entity.SysProperty;
import com.tisson.tds.properties.service.SysPropertyService;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.LocalDateTime;
import org.joda.time.Seconds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.join;
import static org.springframework.data.jpa.domain.Specifications.where;

/**
 * <p>
 * <b>AuthenticationController</b> 令牌管理
 * </p>
 * @author zhuzhiou
 */
@RequestMapping("/api")
@RestController
public class AuthenticationController extends ExceptionController {

    @Autowired
    private SysPropertyService sysPropertyService;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Autowired
    private MmsCustomerUserService customerUserService;

    @RequestMapping(value = "/authentication", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE, method = RequestMethod.POST)
    public Wrapper<AccessToken> doPost(@RequestParam("mobile") String mobile, @RequestParam("verification_code") String verificationCode) {
        SysProperty jwtSecret = sysPropertyService.findSysPropertyByKey("JJWT_SECRET");
        if (jwtSecret == null || isBlank(jwtSecret.getPropValue())) {
            throw new IllegalArgumentException("请配置系统参数JJWT_SECRET");
        }
        ValueOperations<String, String> valueOps = redisTemplate.opsForValue();
        String key = join("verification_code:success:", mobile);
        String verificationCode_redis = valueOps.get(key);
        if (isBlank(verificationCode_redis)) {
            throw new CredentialsExpiredException("验证码已失效");
        } else if (!StringUtils.equals(verificationCode, StringUtils.substringBefore(verificationCode_redis, ","))) {
            throw new BadCredentialsException("验证码错误");
        }
        Specification specification = where(new CustomerUserSpecification.Mobile(mobile));//.and(new EnabledSpecification("Y"));
        Sort sort = new Sort(Sort.Direction.DESC, "updateOn");
        List<MmsCustomerUserEntity> customerUserEntities = customerUserService.findAll(specification, sort);
        if (customerUserEntities == null || customerUserEntities.isEmpty()) {
            throw new UserStatusException("手机号码禁止登陆");
        }
        MmsCustomerUserEntity mmsCustomerUserEntity = customerUserEntities.get(0);
        redisTemplate.delete(key);
        AccessToken jwtToken = generateToken(mmsCustomerUserEntity.getId(), jwtSecret.getPropValue());
        return Wrapper.success(jwtToken);
    }

    private AccessToken generateToken(String subject, String jwtSecret) {
        LocalDateTime iat = LocalDateTime.now();
        LocalDateTime exp = new LocalDateTime(iat).plusYears(1);
        JwtBuilder builder = Jwts.builder()
                .setIssuer("天讯瑞达")
                .setIssuedAt(iat.toDate())
                .setExpiration(exp.toDate())
                .setAudience("天讯瑞达")
                .setSubject(subject)
                .signWith(SignatureAlgorithm.HS256, jwtSecret);
        AccessToken accessToken = new AccessToken(builder.compact(), Seconds.secondsBetween(iat, exp).getSeconds());
        return accessToken;
    }
}
