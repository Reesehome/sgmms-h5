package com.tisson.sgmms.meetings.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

/**
 * @author hasee.
 * @time 2018/5/15 15:59.
 * @description
 */
@Entity
@Table(name = "mms_conference_user", schema = "sgmms", catalog = "")
public class MmsConferenceUserEntity {
    private String id;
    private String userId;
    private String conferenceId;
    private String reserveMeal;
    private Date createOn;
    private String createBy;
    private Date updateOn;
    private String updateBy;

    @Id
    @Column(name = "id", nullable = false, length = 32)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "user_id", nullable = true, length = 32)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
    @Column(name = "reserve_meal", nullable = true)
    public String getReserveMeal() {
        return reserveMeal;
    }

    public void setReserveMeal(String reserveMeal) {
        this.reserveMeal = reserveMeal;
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
    @Column(name = "create_by", nullable = true, length = 36)
    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
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
    @Column(name = "update_by", nullable = true, length = 36)
    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MmsConferenceUserEntity that = (MmsConferenceUserEntity) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(userId, that.userId) &&
                Objects.equals(conferenceId, that.conferenceId) &&
                Objects.equals(reserveMeal, that.reserveMeal) &&
                Objects.equals(createOn, that.createOn) &&
                Objects.equals(createBy, that.createBy) &&
                Objects.equals(updateOn, that.updateOn) &&
                Objects.equals(updateBy, that.updateBy);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, userId, conferenceId, reserveMeal, createOn, createBy, updateOn, updateBy);
    }
}
