package com.tisson.sgmms.api.sms;

public interface SendSmsService {

    void sendSms(String mobile, String content);
}
