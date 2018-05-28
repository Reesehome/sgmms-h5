package com.tisson.sgmms.thirdparty.handler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tisson.sgmms.thirdparty.exception.GatewayException;
import com.tisson.sgmms.thirdparty.vo.SendMessageResponse;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static org.apache.commons.lang3.StringUtils.join;

public class SendMessageResponseHandler implements ResponseHandler<SendMessageResponse> {

    private static Logger logger = LoggerFactory.getLogger(SendMessageResponse.class);

    private ObjectMapper objectMapper;

    public SendMessageResponseHandler(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Override
    public SendMessageResponse handleResponse(HttpResponse httpResponse) throws ClientProtocolException, IOException {
        StatusLine statusLine = httpResponse.getStatusLine();
        if (statusLine.getStatusCode() <200 || statusLine.getStatusCode() >= 300) {
            if (logger.isErrorEnabled()) {
                logger.error("短信网关返回错误的http状态码：{}", statusLine.getStatusCode());
            }
            throw new HttpResponseException(statusLine.getStatusCode(), statusLine.getReasonPhrase());
        }

        String response = EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8);
        logger.info("短信网关返回：{}", response);

        JsonNode root = objectMapper.readTree(response);
        JsonNode error = root.get("errCode");
        if (error == null || error.isMissingNode()) {
            throw new IllegalStateException();
        } else if (!"0".equals(error.asText())) {
            JsonNode node = root.get("errDesc");
            String message = (node == null || node.isMissingNode()) ? join("错误码：", error.asText()) : join(error.asText(), "：", new String(Base64.decodeBase64(node.textValue()), StandardCharsets.UTF_8));
            throw new GatewayException(message);
        }
        Iterator<JsonNode> iterator = root.get("result").iterator();
        if (iterator.hasNext()) {
            JsonNode result = iterator.next();
            return new SendMessageResponse(result.get("msgId").asText(), result.get("phoneNum").asText(), result.get("status").asText());
        } else {
            throw new GatewayException("短信平台返回空数据");
        }
    }
}
