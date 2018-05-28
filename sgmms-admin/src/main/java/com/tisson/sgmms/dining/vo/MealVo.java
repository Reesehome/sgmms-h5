package com.tisson.sgmms.dining.vo;

/**
 * MealVo is 就餐管理
 *
 * @author QIAN
 * @since 2018/5/22 9:15
 */
public class MealVo {

    private String conferenceId;

    /**
     * 姓名
     */
    private String userName;

    /**
     * 手机号
     */
    private String userPhone;

    /**
     * 就餐日期
     */
    private String date;

    /**
     * 就餐名称
     */
    private String name;

    /**
     * 就餐标准
     */
    private String standard;


    /**
     * 就餐时间段
     */
    private String timeSlot;

    /**
     * 就餐时间
     */
    private String time;

    /**
     * 就餐地点
     */
    private String location;

    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
