package com.tisson.sgmms.meetings.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Objects;

/**
 * @author hasee.
 * @time 2018/5/15 15:59.
 * @description
 */
@Entity
@Table(name = "mms_conference_attendance", schema = "sgmms", catalog = "")
public class MmsConferenceAttendanceEntity {
    private String id;
    private String conferenceId;
    private Date beginTime;
    private Date latenessBeginTime;
    private Date endTime;
    private Date latenessEndTime;
    private String createBy;
    private Date createOn;
    private String updateBy;
    private Date updateOn;

    @Id
    @Column(name = "id", nullable = false, length = 32)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "conference_id", nullable = true, length = 32)
    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    @Basic
    @Column(name = "begin_time", nullable = true)
    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    @Basic
    @Column(name = "lateness_begin_time", nullable = true)
    public Date getLatenessBeginTime() {
        return latenessBeginTime;
    }

    public void setLatenessBeginTime(Date latenessBeginTime) {
        this.latenessBeginTime = latenessBeginTime;
    }

    @Basic
    @Column(name = "end_time", nullable = true)
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Basic
    @Column(name = "lateness_end_time", nullable = true)
    public Date getLatenessEndTime() {
        return latenessEndTime;
    }

    public void setLatenessEndTime(Date latenessEndTime) {
        this.latenessEndTime = latenessEndTime;
    }

    @Basic
    @Column(name = "create_by", nullable = true, length = 36)
    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    @Basic
    @Column(name = "create_on", nullable = true)
    public Date getCreateOn() {
        return createOn;
    }

    public void setCreateOn(Date createOn) {
        this.createOn = createOn;
    }

    @Basic
    @Column(name = "update_by", nullable = true, length = 36)
    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    @Basic
    @Column(name = "update_on", nullable = true)
    public Date getUpdateOn() {
        return updateOn;
    }

    public void setUpdateOn(Date updateOn) {
        this.updateOn = updateOn;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MmsConferenceAttendanceEntity that = (MmsConferenceAttendanceEntity) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(conferenceId, that.conferenceId) &&
                Objects.equals(beginTime, that.beginTime) &&
                Objects.equals(latenessBeginTime, that.latenessBeginTime) &&
                Objects.equals(endTime, that.endTime) &&
                Objects.equals(latenessEndTime, that.latenessEndTime) &&
                Objects.equals(createBy, that.createBy) &&
                Objects.equals(createOn, that.createOn) &&
                Objects.equals(updateBy, that.updateBy) &&
                Objects.equals(updateOn, that.updateOn);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, conferenceId, beginTime, latenessBeginTime, endTime, latenessEndTime, createBy, createOn, updateBy, updateOn);
    }
}
