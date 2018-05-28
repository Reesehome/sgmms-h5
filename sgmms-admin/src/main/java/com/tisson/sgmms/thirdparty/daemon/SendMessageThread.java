package com.tisson.sgmms.thirdparty.daemon;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tisson.sgmms.log.entity.MmsLogMessageEntity;
import com.tisson.sgmms.log.service.MmsLogMessageService;
import com.tisson.sgmms.thirdparty.exception.GatewayException;
import com.tisson.sgmms.thirdparty.handler.SendMessageResponseHandler;
import com.tisson.sgmms.thirdparty.vo.SendMessageResponse;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static org.apache.commons.codec.binary.Base64.encodeBase64String;
import static org.apache.commons.codec.digest.DigestUtils.md5Hex;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.RandomStringUtils.randomNumeric;

/**
 * <p>
 *     建议使用消息队列替换掉。
 * </p>
 *
 * @author zhuzhiou
 */
@Deprecated
public class SendMessageThread extends Thread {

    public static final ThreadGroup threadGroup = new ThreadGroup("SendMessageThread");

    private Logger logger = LoggerFactory.getLogger(SendMessageResponse.class);

    private RedisTemplate<String, MmsLogMessageEntity> redisTemplate;

    private MmsLogMessageService logMessageService;

    private ObjectMapper objectMapper;

    private String serviceUrl;

    private String username;

    private String password;

    public SendMessageThread() {
        super(threadGroup, "异步发送短信");
        super.setDaemon(true);
    }

    public void setRedisTemplate(RedisTemplate<String, MmsLogMessageEntity> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public void setLogMessageService(MmsLogMessageService logMessageService) {
        this.logMessageService = logMessageService;
    }

    public void setObjectMapper(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    public void setServiceUrl(String serviceUrl) {
        this.serviceUrl = serviceUrl;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * 线程主体，循环运行sync()方法，直到调用了kill()方法。
     */
    @Override
    public void run() {
        try(CloseableHttpClient httpClient = HttpClients.createMinimal()) {
            while (!isInterrupted()) {
                try {
                    sendMessage(httpClient);
                } catch (GatewayException e) {
                    if (logger.isErrorEnabled()) {
                        logger.error("短信网关返回错误（{}）", e.getMessage());
                    }
                } catch (Throwable e) {
                    if (logger.isErrorEnabled()) {
                        logger.info("发送短信失败", e);
                    }
                }
            }
            if (logger.isInfoEnabled()) {
                logger.info("调试信息，中断发生了");
            }
        } catch (IOException e) {
            // 忽略关闭的IO异常
        }
    }

    /*
    如果是spring的bean，可以直接设置实体类的属性，无须sendFailed、sendSucceed这2个方法，上消息队列的时候删除掉。
     */
    private void sendMessage(CloseableHttpClient httpClient) {
        ListOperations<String, MmsLogMessageEntity> listOps = redisTemplate.opsForList();
        MmsLogMessageEntity logMessage = listOps.rightPop("messages", 0, TimeUnit.SECONDS);
        Integer expires_in = logMessage.getExpiresIn();
        if (expires_in != null && expires_in.longValue() > 1) {
            Date expiration = DateUtils.addSeconds(logMessage.getCreateTime(), expires_in);
            if (new Date().after(expiration)) {
                if (logger.isWarnEnabled()) {
                    logger.warn("在有效时间内未能发送短信，请同步服务器时间、同时检查消息队列客户端是否运行中");
                }
                return;
            }
        }
        HttpPost httpPost = createSendMessagePost(logMessage);
        SendMessageResponse result;
        try {
            result = httpClient.execute(httpPost, new SendMessageResponseHandler(objectMapper));
        } catch (Exception e) {
            logMessageService.sendFailed(logMessage.getId(), e.getMessage());
            return;
        }
        logMessageService.sendSucceed(logMessage.getId(), result.getMsgId());
    }

    private HttpPost createSendMessagePost(MmsLogMessageEntity logMessage) {
        String vaCode = StringUtils.join(DateFormatUtils.format(logMessage.getSendTime(), "yyyyMMddHHmm"), randomNumeric(6));
        StringBuilder payload = new StringBuilder();
        payload.append("{")
                .append("\"account\":\"").append(username).append("\",")
                .append("\"password\":\"").append(md5Hex(StringUtils.join(password, vaCode))).append("\",")
                .append("\"vaCode\":\"").append(vaCode).append("\",")
                .append("\"phoneNum\":\"").append(logMessage.getMobile()).append("\",")
                .append("\"content\":\"").append(encodeBase64String(logMessage.getContent().getBytes(StandardCharsets.UTF_8))).append("\",")
                .append("\"bizId\":\"").append(randomAlphanumeric(12)).append("\"")
                .append("}");
        if (logger.isInfoEnabled()) {
            logger.info("发送到短信网关：{}", payload.toString());
        }
        HttpPost httpPost = new HttpPost(serviceUrl);
        httpPost.setEntity(new StringEntity(payload.toString(), ContentType.APPLICATION_JSON));
        return httpPost;
    }
}
