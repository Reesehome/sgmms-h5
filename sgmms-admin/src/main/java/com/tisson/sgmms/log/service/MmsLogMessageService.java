package com.tisson.sgmms.log.service;

import com.tisson.sgmms.log.entity.MmsLogMessageEntity;

public interface MmsLogMessageService {

    MmsLogMessageEntity addLogMessage(String mobile, String content);

    void sendFailed(String id, String failCause);

    void sendSucceed(String id, String messageId);
}
