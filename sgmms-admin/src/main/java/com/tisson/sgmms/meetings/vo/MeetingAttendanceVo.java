package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttendanceEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * @author hasee.
 * @time 2018/5/17 14:22.
 * @description
 */
public class MeetingAttendanceVo implements Serializable {

    private String id;
    private String conferenceId;
    private String conferenceCode;
    private Date beginTime;
    private Date latenessBeginTime;
    private Date endTime;
    private Date latenessEndTime;

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

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getLatenessBeginTime() {
        return latenessBeginTime;
    }

    public void setLatenessBeginTime(Date latenessBeginTime) {
        this.latenessBeginTime = latenessBeginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getLatenessEndTime() {
        return latenessEndTime;
    }

    public void setLatenessEndTime(Date latenessEndTime) {
        this.latenessEndTime = latenessEndTime;
    }

    public String getConferenceCode() {
        return conferenceCode;
    }

    public void setConferenceCode(String conferenceCode) {
        this.conferenceCode = conferenceCode;
    }

    public MeetingAttendanceVo buildVo(MmsConferenceAttendanceEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }

    @Override
    public String toString() {
        return "MeetingAttendanceVo{" +
                "id='" + id + '\'' +
                ", conferenceId='" + conferenceId + '\'' +
                ", beginTime=" + beginTime +
                ", latenessBeginTime=" + latenessBeginTime +
                ", endTime=" + endTime +
                ", latenessEndTime=" + latenessEndTime +
                '}';
    }
}
