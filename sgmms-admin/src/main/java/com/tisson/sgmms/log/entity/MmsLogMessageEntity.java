package com.tisson.sgmms.log.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "mms_log_message")
public class MmsLogMessageEntity {

    public final static String SEND_STATUS_PENDING = "pending";

    public final static String SEND_STATUS_SUCCEED = "succeed";

    public final static String SEND_STATUS_FAILED = "failed";

    private String id;

    private String mobile;

    private String content;

    private String sendStatus;

    private String messageId;

    private String failCause;

    private Date sendTime;

    private Integer expiresIn;

    private Date createTime;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "mobile")
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Basic
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "send_status")
    public String getSendStatus() {
        return sendStatus;
    }

    public void setSendStatus(String sendStatus) {
        this.sendStatus = sendStatus;
    }

    @Basic
    @Column(name = "message_id")
    public String getMessageId() {
        return messageId;
    }

    /**
     * <p>
     *     发送状态为成功时有值
     * </p>
     */
    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    @Basic
    @Column(name = "fail_cause")
    public String getFailCause() {
        return failCause;
    }

    /**
     * <p>
     *     发送状态为失败时有值
     * </p>
     */
    public void setFailCause(String failCause) {
        this.failCause = failCause;
    }

    @Basic
    @Column(name = "send_time")
    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    @Transient
    public Integer getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(Integer expiresIn) {
        this.expiresIn = expiresIn;
    }

    @Basic
    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
