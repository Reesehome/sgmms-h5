package com.tisson.sgmms.thirdparty.vo;

import java.io.Serializable;

public class SendMessageResponse implements Serializable {

    private String msgId;

    private String phoneNum;

    private String status;

    public SendMessageResponse() {
    }

    public SendMessageResponse(String msgId, String phoneNum, String status) {
        this.msgId = msgId;
        this.phoneNum = phoneNum;
        this.status = status;
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
