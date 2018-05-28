package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceMainEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * @author hasee.
 * @time 2018/5/10 10:29.
 * @description
 */
public class MeetingVo implements Serializable {

    /**
     * 会议id
     */
    private String id;
    /**
     * 会议编号
     */
    private String code;
    /**
     * 会议标题
     */
    private String title;
    /**
     * 会议开始时间
     */
    private Date beginTime;
    /**
     * 会议结束时间
     */
    private Date endTime;
    /**
     * 会议状态
     */
    private String status;
    /**
     * 创建人
     */
    private String createBy;
    /**
     * 创建时间
     */
    private Date createOn;

    /**
     * 会议地点
     */
    private String venue;

    /**
     * 备注
     */
    private String comment;

    /**
     * 会议人数
     */
    private Integer totalUsers;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    /**
     * 转换实体为vo对象
     *
     * @param entity
     */
    public MeetingVo buildVo(MmsConferenceMainEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Integer getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(Integer totalUsers) {
        this.totalUsers = totalUsers;
    }

    @Override
    public String toString() {
        return "MeetingVo{" +
                "id='" + id + '\'' +
                ", code='" + code + '\'' +
                ", title='" + title + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                ", status='" + status + '\'' +
                ", createBy='" + createBy + '\'' +
                ", createOn=" + createOn +
                ", venue='" + venue + '\'' +
                ", comment='" + comment + '\'' +
                ", totalUsers=" + totalUsers +
                '}';
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

}
