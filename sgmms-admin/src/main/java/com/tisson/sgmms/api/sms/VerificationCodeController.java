package com.tisson.sgmms.api.sms;

import com.google.common.primitives.Longs;
import com.tisson.sgmms.api.exception.ExceptionController;
import com.tisson.sgmms.api.wrap.Wrapper;
import com.tisson.sgmms.log.service.MmsLogMessageService;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.LocalDate;
import org.joda.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.TimeUnit;

import static org.apache.commons.lang3.RandomStringUtils.randomNumeric;
import static org.apache.commons.lang3.StringUtils.isNotBlank;
import static org.apache.commons.lang3.StringUtils.join;

@RequestMapping("/api")
@RestController
public class VerificationCodeController extends ExceptionController {

    private static final String[] headers = new String[] {"13", "14", "15", "16", "17", "18" };

    @Autowired
    private MmsLogMessageService logMessageService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @RequestMapping(value = "/verificationCode", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE, produces = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.POST)
    public Wrapper<Void> sendCode(@RequestParam String mobile) {
        if (StringUtils.length(mobile) != 11 || !ArrayUtils.contains(headers, StringUtils.substring(mobile, 0, 2))) {
            throw new IllegalArgumentException("手机号码不正确");
        }
        ValueOperations<String, String> valueOps = stringRedisTemplate.opsForValue();
        // 对发送次数进行限制
        String key1 = join("verification_code:valve:count:", mobile);
        long increment = valueOps.increment(key1, 1);
        if (increment == 1) {
            stringRedisTemplate.expireAt(key1, LocalDate.now().plusDays(1).toDateMidnight().toDate());
        } else if ( increment > 5) {
            throw new IllegalArgumentException("发送验证码过多，请24小时后重试。");
        }
        // 对发送频率进行限制
        String key2 = join("verification_code:valve:time:", mobile);
        if (valueOps.get(key2) != null) {
            throw new IllegalArgumentException("发送验证码太快了，请1分钟后重试。");
        }
        valueOps.set(key2, LocalDateTime.now().toString("yyyy-MM-dd HH:mm:ss"), 1, TimeUnit.MINUTES);

        String verificationCode = randomNumeric(6);
        // 将验证码放到缓存，如果上一次的验证码依然有效，则重发
        String key3 = join("verification_code:", mobile);
        String value = valueOps.get(key3);
        if (isNotBlank(value)) {
            verificationCode = StringUtils.substringBefore(value, ",");
        }
        logMessageService.addLogMessage(mobile, join("登陆验证码", verificationCode, "，有效时间5分钟。"));

        long expires_in = 5 * 60;
        valueOps.set(key3, verificationCode, expires_in, TimeUnit.SECONDS);
        return Wrapper.success();
    }
}
