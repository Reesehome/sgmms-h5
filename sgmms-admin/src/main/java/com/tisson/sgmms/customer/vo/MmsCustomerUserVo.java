package com.tisson.sgmms.customer.vo;

import java.io.Serializable;

/**
 * @author hasee.
 * @time 2018/5/15 15:29.
 * @description
 */
public class MmsCustomerUserVo implements Serializable {
    private String id;
    private String userName;
    private String mobile;
    private String email;
    private String gender;
    private String comment;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "MmsCustomerUserVo{" +
                "id='" + id + '\'' +
                ", userName='" + userName + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }
}
