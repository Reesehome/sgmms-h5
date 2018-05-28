package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttachmentEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * @author hasee.
 * @time 2018/5/22 10:27.
 * @description
 */
public class MeetingAttachmentVo implements Serializable {

    private String id;
    private String conferenceId;
    private String title;
    private String name;
    private String uri;
    private String createBy;
    private Date createOn;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateOn() {
        return createOn;
    }

    public void setCreateOn(Date createOn) {
        this.createOn = createOn;
    }

    public MeetingAttachmentVo buildVo(MmsConferenceAttachmentEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }

    @Override
    public String toString() {
        return "MeetingAttachmentVo{" +
                "id='" + id + '\'' +
                ", conferenceId='" + conferenceId + '\'' +
                ", title='" + title + '\'' +
                ", name='" + name + '\'' +
                ", uri='" + uri + '\'' +
                ", createBy='" + createBy + '\'' +
                ", createOn=" + createOn +
                '}';
    }
}
