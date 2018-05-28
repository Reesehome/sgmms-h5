package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;

/**
 * @author hasee.
 * @time 2018/5/15 15:51.
 * @description
 */
public class MeetingMemberVo implements Serializable {
    private String id;
    private String userId;
    private String mobile;
    private String userName;
    private String gender;
    private String companyId;
    private String conferenceId;
    private String reserveMeal;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    public String getReserveMeal() {
        return reserveMeal;
    }

    public void setReserveMeal(String reserveMeal) {
        this.reserveMeal = reserveMeal;
    }

    public MeetingMemberVo buildVo(MmsConferenceUserEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    @Override
    public String toString() {
        return "MeetingMemberVo{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", mobile='" + mobile + '\'' +
                ", userName='" + userName + '\'' +
                ", gender='" + gender + '\'' +
                ", companyId='" + companyId + '\'' +
                ", conferenceId='" + conferenceId + '\'' +
                ", reserveMeal='" + reserveMeal + '\'' +
                '}';
    }
}
