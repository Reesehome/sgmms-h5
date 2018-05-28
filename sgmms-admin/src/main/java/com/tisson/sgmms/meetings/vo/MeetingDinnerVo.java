package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * @author hasee.
 * @time 2018/5/17 14:23.
 * @description
 */
public class MeetingDinnerVo implements Serializable {

    private String id;
    private String conferenceId;
    private String conferenceCode;
    private String name;
    private Date beginTime;
    private Date endTime;
    private String location;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getConferenceCode() {
        return conferenceCode;
    }

    public void setConferenceCode(String conferenceCode) {
        this.conferenceCode = conferenceCode;
    }

    public MeetingDinnerVo buildVo(MmsConferenceMealEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }

    @Override
    public String toString() {
        return "MeetingDinnerVo{" +
                "id='" + id + '\'' +
                ", conferenceId='" + conferenceId + '\'' +
                ", name='" + name + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                ", location='" + location + '\'' +
                '}';
    }
}
