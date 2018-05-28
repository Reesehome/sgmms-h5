package com.tisson.sgmms.api.sms;

import com.google.common.collect.ImmutableMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RequestMapping("/api")
@RestController
public class SmsReportController {

    private Logger logger = LoggerFactory.getLogger(SmsReportController.class);

    @RequestMapping(value = "/sms/report")
    public Map<String, String> doPost() {
        try {
            // 异步处理
            return null;
        } catch (Exception e) {
            if (logger.isErrorEnabled()) {
                logger.error("处理回执失败", e);
            }
            return ImmutableMap.of("errCode", "998", "errDesc", e.getMessage());
        }
    }
}
