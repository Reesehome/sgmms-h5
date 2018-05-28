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
@Table(name = "mms_conference_attachment", schema = "sgmms", catalog = "")
public class MmsConferenceAttachmentEntity {
    private String id;
    private String conferenceId;
    private String title;
    private String name;
    private String uri;
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
    @Column(name = "conference_id", nullable = true, length = 32)
    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
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
    @Column(name = "name", nullable = true, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "uri", nullable = true, length = 200)
    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
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
        MmsConferenceAttachmentEntity that = (MmsConferenceAttachmentEntity) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(conferenceId, that.conferenceId) &&
                Objects.equals(title, that.title) &&
                Objects.equals(name, that.name) &&
                Objects.equals(uri, that.uri) &&
                Objects.equals(createOn, that.createOn) &&
                Objects.equals(createBy, that.createBy) &&
                Objects.equals(updateOn, that.updateOn) &&
                Objects.equals(updateBy, that.updateBy);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, conferenceId, title, name, uri, createOn, createBy, updateOn, updateBy);
    }
}
