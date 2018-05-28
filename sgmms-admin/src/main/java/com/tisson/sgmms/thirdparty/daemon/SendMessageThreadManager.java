package com.tisson.sgmms.thirdparty.daemon;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tisson.sgmms.log.entity.MmsLogMessageEntity;
import com.tisson.sgmms.log.service.MmsLogMessageService;
import com.tisson.tds.dictionary.entity.DictionaryItem;
import com.tisson.tds.dictionary.service.DictionaryService;
import org.apache.commons.beanutils.BeanPropertyValueEqualsPredicate;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isNotBlank;

/**
 * <p>
 *     建议使用消息队列替换掉。
 * </p>
 *
 * @author zhuzhiou
 */
@Deprecated
@Lazy(value = false)
@Component
public class SendMessageThreadManager implements InitializingBean, DisposableBean {

    private volatile boolean running = false;

    private SendMessageThread sendMessageThread;

    @Autowired
    private RedisTemplate<String, MmsLogMessageEntity> redisTemplate;

    @Autowired
    private MmsLogMessageService logMessageService;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private DictionaryService dictionaryService;

    @Override
    public void destroy() throws Exception {
        if (running) {
            running = false;
            sendMessageThread.interrupt();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        if (!running) {
            running = true;
            sendMessageThread = new SendMessageThread();
            sendMessageThread.setLogMessageService(logMessageService);
            sendMessageThread.setRedisTemplate(redisTemplate);
            sendMessageThread.setObjectMapper(objectMapper);

            List<DictionaryItem> dictionaryItems = dictionaryService.findDictionaryItemByDictionaryId("SHORT_MESSAGE_SERVICE");
            DictionaryItem dictionaryItem;

            // FIXME 没有设置字典就不能运行
            dictionaryItem = (DictionaryItem) CollectionUtils.find(dictionaryItems, new BeanPropertyValueEqualsPredicate("value", "URL"));
            if (dictionaryItem != null && isNotBlank(dictionaryItem.getDescription())) {
                sendMessageThread.setServiceUrl(dictionaryItem.getDescription());
            }

            dictionaryItem = (DictionaryItem) CollectionUtils.find(dictionaryItems, new BeanPropertyValueEqualsPredicate("value", "USERNAME"));
            if (dictionaryItem != null && isNotBlank(dictionaryItem.getDescription())) {
                sendMessageThread.setUsername(dictionaryItem.getDescription());
            }

            dictionaryItem = (DictionaryItem) CollectionUtils.find(dictionaryItems, new BeanPropertyValueEqualsPredicate("value", "PASSWORD"));
            if (dictionaryItem != null && isNotBlank(dictionaryItem.getDescription())) {
                sendMessageThread.setPassword(dictionaryItem.getDescription());
            }

            sendMessageThread.start();
        }
    }
}
