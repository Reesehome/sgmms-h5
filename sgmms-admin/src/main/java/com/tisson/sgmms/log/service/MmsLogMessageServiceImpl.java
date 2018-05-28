package com.tisson.sgmms.log.service;

import com.tisson.sgmms.log.entity.MmsLogMessageEntity;
import com.tisson.sgmms.log.repository.MmsLogMessageRepository;
import com.tisson.tds.common.utils.IndexGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.Date;

import static org.apache.commons.lang3.StringUtils.isNotBlank;

@Service
public class MmsLogMessageServiceImpl implements MmsLogMessageService {

    @Autowired
    private MmsLogMessageRepository logMessageRepository;

    @Autowired
    private RedisTemplate<String, MmsLogMessageEntity> redisTemplate;

    /**
     * <p>
     *     将短信插入到数据库，同时发送到消息队列，异步发送短信。
     * </p>
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsLogMessageEntity addLogMessage(String mobile, String content) {
        MmsLogMessageEntity logMessage = new MmsLogMessageEntity();
        logMessage.setMobile(mobile);
        logMessage.setContent(content);
        logMessage.setSendTime(new Date());
        logMessage.setId(IndexGenerator.generatorId());
        logMessage.setSendStatus(MmsLogMessageEntity.SEND_STATUS_PENDING);

        ListOperations<String, MmsLogMessageEntity> listOps = redisTemplate.opsForList();
        listOps.leftPush("messages", logMessage);

        logMessageRepository.save(logMessage);
        return logMessage;
    }

    /**
     * <p>
     *     三个状态：pending、succeed、failed
     * </p>
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void sendFailed(@NotNull String id, @NotNull String failCause) {
        MmsLogMessageEntity logMessage = logMessageRepository.findOne(id);
        if (logMessage == null) {
            throw new IllegalStateException();
        }
        logMessage.setFailCause(failCause);
        logMessage.setSendStatus("failed");
    }

    /**
     * <p>
     *     三个状态：pending、succeed、failed
     * </p>
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void sendSucceed(@NotNull String id, @NotNull String messageId) {
        MmsLogMessageEntity logMessage = logMessageRepository.findOne(id);
        if (logMessage == null) {
            throw new IllegalStateException();
        }
        logMessage.setMessageId(messageId);
        logMessage.setSendStatus("succeed");
    }
}
