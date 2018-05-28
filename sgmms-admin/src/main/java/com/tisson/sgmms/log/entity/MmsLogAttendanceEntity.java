package com.tisson.sgmms.log.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "mms_log_attendance")
public class MmsLogAttendanceEntity {
    private String id;
    private String attendanceId;
    private String userId;
    private String lateness;
    private Date arrivalTime;
    private Double lng;
    private Double lat;
    private String location;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Basic
    @Column(name = "attendance_id")
    public String getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(String attendanceId) {
        this.attendanceId = attendanceId;
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
    @Column(name = "lateness")
    public String getLateness() {
        return lateness;
    }

    public void setLateness(String lateness) {
        this.lateness = lateness;
    }

    @Basic
    @Column(name = "arrival_time")
    public Date getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    @Basic
    @Column(name = "lng")
    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }

    @Basic
    @Column(name = "lat")
    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    @Basic
    @Column(name = "location")
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
