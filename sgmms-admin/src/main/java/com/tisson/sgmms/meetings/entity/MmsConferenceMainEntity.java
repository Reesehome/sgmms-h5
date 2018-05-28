package com.tisson.sgmms.meetings.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

/**
 * @author hasee.
 * @time 2018/5/9 17:01.
 * @description
 */
@Entity
@Table(name = "mms_conference_main")
public class MmsConferenceMainEntity {
    private String id;
    private String code;
    private String title;
    private Date beginTime;
    private Date endTime;
    private String status;
    private String venue;
    private Integer totalUsers;
    private String comment;
    private String createBy;
    private Date createOn;
    private Integer version;
    private String updateBy;
    private Date updateOn;
    private String enabled;

    @Id
    @Column(name = "id", nullable = false, length = 32)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "code", nullable = true, length = 45)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Basic
    @Column(name = "title", nullable = true, length = 45)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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
    @Column(name = "status", nullable = true)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "venue", nullable = true, length = 200)
    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    @Basic
    @Column(name = "total_users", nullable = true)
    public Integer getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(Integer totalUsers) {
        this.totalUsers = totalUsers;
    }

    @Basic
    @Column(name = "comment", nullable = true, length = 1000)
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
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
    @Column(name = "version", nullable = true)
    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
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

    @Basic
    @Column(name = "enabled", nullable = false)
    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enable) {
        this.enabled = enable;
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, code, title, beginTime, endTime, status, venue, totalUsers, comment, createBy, createOn, version, updateBy, updateOn);
    }
}
