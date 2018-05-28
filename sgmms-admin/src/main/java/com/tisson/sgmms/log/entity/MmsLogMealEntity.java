package com.tisson.sgmms.log.entity;

import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "mms_log_meal")
public class MmsLogMealEntity {
    private String id;
    private String mealId;
    private String userId;
    private String userName;
    private String userPhone;
    private Date mealTime;
    private Long totalScan;

    private MmsConferenceMealEntity mmsConferenceMealEntity;  // 关联查询

    @Id
    @Column(name="id",insertable=false,updatable=false)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "meal_id")
    public String getMealId() {
        return mealId;
    }

    public void setMealId(String mealId) {
        this.mealId = mealId;
    }

    @Basic
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "user_name")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "user_phone")
    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    @Basic
    @Column(name = "meal_time")
    public Date getMealTime() {
        return mealTime;
    }

    public void setMealTime(Date mealTime) {
        this.mealTime = mealTime;
    }

    @Basic
    @Column(name = "total_scan")
    public Long getTotalScan() {
        return totalScan;
    }

    public void setTotalScan(Long totalScan) {
        this.totalScan = totalScan;
    }

    @OneToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="id")
    public MmsConferenceMealEntity getMmsConferenceMealEntity() {
        return mmsConferenceMealEntity;
    }

    public void setMmsConferenceMealEntity(MmsConferenceMealEntity mmsConferenceMealEntity) {
        this.mmsConferenceMealEntity = mmsConferenceMealEntity;
    }
}
