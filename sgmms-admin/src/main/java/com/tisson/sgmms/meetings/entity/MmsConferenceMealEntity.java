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
@Table(name = "mms_conference_meal")
public class MmsConferenceMealEntity {
    private String id;
    private String conferenceId;
    private String name;
    private Date beginTime;
    private Date endTime;
    private String location;
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
    @Column(name = "name", nullable = true, length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
    @Column(name = "end_time", nullable = true)
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Basic
    @Column(name = "location", nullable = true, length = 200)
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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
        MmsConferenceMealEntity that = (MmsConferenceMealEntity) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(conferenceId, that.conferenceId) &&
                Objects.equals(name, that.name) &&
                Objects.equals(beginTime, that.beginTime) &&
                Objects.equals(endTime, that.endTime) &&
                Objects.equals(location, that.location) &&
                Objects.equals(createBy, that.createBy) &&
                Objects.equals(createOn, that.createOn) &&
                Objects.equals(updateBy, that.updateBy) &&
                Objects.equals(updateOn, that.updateOn);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, conferenceId, name, beginTime, endTime, location, createBy, createOn, updateBy, updateOn);
    }
}
