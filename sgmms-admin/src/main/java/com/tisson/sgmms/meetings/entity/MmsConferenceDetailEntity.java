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
@Table(name = "mms_conference_detail", schema = "sgmms", catalog = "")
public class MmsConferenceDetailEntity {
    private String conferenceId;
    private String agendum;
    private String attention;
    private String createBy;
    private Date createOn;
    private String updateBy;
    private Date updateOn;

    @Id
    @Column(name = "conference_id", nullable = false, length = 32)
    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    @Basic
    @Column(name = "agendum", nullable = true, length = -1)
    public String getAgendum() {
        return agendum;
    }

    public void setAgendum(String agendum) {
        this.agendum = agendum;
    }

    @Basic
    @Column(name = "attention", nullable = true, length = -1)
    public String getAttention() {
        return attention;
    }

    public void setAttention(String attention) {
        this.attention = attention;
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
        MmsConferenceDetailEntity that = (MmsConferenceDetailEntity) o;
        return Objects.equals(conferenceId, that.conferenceId) &&
                Objects.equals(agendum, that.agendum) &&
                Objects.equals(attention, that.attention) &&
                Objects.equals(createBy, that.createBy) &&
                Objects.equals(createOn, that.createOn) &&
                Objects.equals(updateBy, that.updateBy) &&
                Objects.equals(updateOn, that.updateOn);
    }

    @Override
    public int hashCode() {

        return Objects.hash(conferenceId, agendum, attention, createBy, createOn, updateBy, updateOn);
    }
}
