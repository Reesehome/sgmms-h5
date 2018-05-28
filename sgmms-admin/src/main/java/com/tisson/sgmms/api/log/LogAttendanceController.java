package com.tisson.sgmms.api.log;

import com.tisson.sgmms.api.exception.DeniedException;
import com.tisson.sgmms.api.exception.ExceptionController;
import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.service.MmsCustomerUserService;
import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import com.tisson.sgmms.log.service.MmsLogAttendanceService;
import com.tisson.sgmms.log.specification.LogAttendanceSpecifications;
import com.tisson.sgmms.meetings.entity.MmsConferenceAttendanceEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceMainEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import com.tisson.sgmms.meetings.service.MmsConferenceService;
import com.tisson.sgmms.meetings.specification.ConferenceAttendanceSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceMainSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceUserSpecifications;
import org.apache.commons.beanutils.BeanPredicate;
import org.apache.commons.beanutils.BeanToPropertyValueTransformer;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.functors.EqualPredicate;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.domain.Specifications;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static org.springframework.data.jpa.domain.Specifications.where;

@RequestMapping("/api/conference")
@RestController
public class LogAttendanceController extends ExceptionController {

    @Autowired
    private MmsConferenceService conferenceService;

    @Autowired
    private MmsLogAttendanceService logAttendanceService;

    @Autowired
    private MmsCustomerUserService customerUserService;

    /**
     * 签到记录
     */
    @RequestMapping(value = "/{conference_code}/attendance", method = RequestMethod.GET)
    public Map<String, Object> getAttendances (@PathVariable String conference_code) {
        // 根据会议编码找到记录
        Specification<MmsConferenceMainEntity> specification = new ConferenceMainSpecifications.ConferenceCode(conference_code);
        List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(specification);
        if (conferenceMains == null || conferenceMains.isEmpty()) {
            throw new IllegalArgumentException("会议编码不正确");
        }
        MmsConferenceMainEntity conferenceMain = conferenceMains.get(0);
        // 返回结果
        Map<String, Object> root = new HashMap<>();
        root.put("success", true);
        // 找到该会议的考勤设置
        List<MmsConferenceAttendanceEntity> conferenceAttendances = conferenceService.findConferenceAttendances(
                new ConferenceAttendanceSpecifications.ConferenceId(conferenceMain.getId()),
                new Sort(Sort.Direction.ASC, "createOn"));
        if (CollectionUtils.isEmpty(conferenceAttendances)) {
            root.put("content", Collections.EMPTY_LIST);
        } else {
            Authentication authentication = Authentication.getCurrent();
            if (authentication == null) {
                throw new SecurityException();
            }
            // 根据考勤的外键，找到考勤记录
            Collection<String> attendanceIds = CollectionUtils.collect(conferenceAttendances, new BeanToPropertyValueTransformer("id"));
            List<MmsLogAttendanceEntity> logAttendances = logAttendanceService.findAll(Specifications
                    .where(new LogAttendanceSpecifications.AttendanceIds(attendanceIds))
                    .and(new LogAttendanceSpecifications.UserId(authentication.getSubject())));
            // 组装数据
            List<Map<String, String>> content = new ArrayList<>();
            MmsLogAttendanceEntity logAttendance;
            Map<String, String> hashMap;
            for (MmsConferenceAttendanceEntity conferenceAttendance : conferenceAttendances) {
                hashMap = new HashMap<>();
                hashMap.put("begin_date", DateFormatUtils.format(conferenceAttendance.getBeginTime(), "yyyy-MM-dd a"));
                hashMap.put("begin_time", DateFormatUtils.format(conferenceAttendance.getBeginTime(), "HH:mm"));
                hashMap.put("end_time", DateFormatUtils.format(conferenceAttendance.getEndTime(), "HH:mm"));
                logAttendance = (MmsLogAttendanceEntity) CollectionUtils.find(logAttendances, new BeanPredicate("attendanceId", new EqualPredicate(conferenceAttendance.getId())));
                if (logAttendance == null) { // 未签到
                    hashMap.put("attendance_result", "W");
                    hashMap.put("arrival_time", null);
                } else {
                    hashMap.put("attendance_result", "N".equalsIgnoreCase(logAttendance.getLateness()) ? "Y" : "C");
                    hashMap.put("arrival_time", DateFormatUtils.format(logAttendance.getArrivalTime(), "yyyy-MM-dd HH:mm:ss"));
                }
                content.add(hashMap);
            }
            root.put("content", content);
        }
        return root;
    }

    /**
     * 签到
     */
    @RequestMapping(value = "/{conference_code}/attendance", method = RequestMethod.POST)
    public Map<String, Object> addAttendances (@PathVariable String conference_code,
                                               @RequestParam String attendance_id,
                                               @RequestParam(required = false) String location,
                                               @RequestParam(required = false) Double lat,
                                               @RequestParam(required = false) Double lng) {
        // 根据会议编码找到记录
        List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(
                new ConferenceMainSpecifications.ConferenceCode(conference_code));
        if (conferenceMains == null || conferenceMains.isEmpty()) {
            throw new IllegalArgumentException("会议编码不正确");
        }
        MmsConferenceMainEntity conferenceMain = conferenceMains.get(0);
        // 找到该会议的打卡设置
        List<MmsConferenceAttendanceEntity> conferenceAttendances = conferenceService.findConferenceAttendances(
                where(new ConferenceAttendanceSpecifications.ConferenceId(conferenceMain.getId()))
                        .and(new ConferenceAttendanceSpecifications.AttendanceId(attendance_id)));
        if (conferenceAttendances == null || conferenceAttendances.isEmpty()) {
            throw new IllegalArgumentException("会议标识不正确");
        }//提示二维码无效?
        MmsConferenceAttendanceEntity conferenceAttendance = conferenceAttendances.get(0);
        // 查询用户是否被邀
        Authentication authentication = Authentication.getCurrent();
        String userId = authentication.getSubject();
        List<MmsConferenceUserEntity> conferenceUsers = conferenceService.findConferenceUsers(
                where(new ConferenceUserSpecifications.ConferenceId(conferenceMain.getId()))
                        .and(new ConferenceUserSpecifications.UserId(userId)));
        // 返回结果
        Map<String, Object> root = new HashMap<>();
        if (CollectionUtils.isEmpty(conferenceUsers)) {
            throw new DeniedException("用户不是会议出席人员");
        }
        root.put("success", true);
        root.put("conference_title", conferenceMain.getTitle());
        root.put("begin_time", DateFormatUtils.format(conferenceAttendance.getBeginTime(), "HH:mm"));
        root.put("end_time", DateFormatUtils.format(conferenceAttendance.getEndTime(), "HH:mm"));
        // 查询用户姓名、手机号码
        MmsCustomerUserEntity customerUser = customerUserService.findOne(userId);
        if (customerUser != null) {
            root.put("compellation", customerUser.getUserName());
            root.put("mobile", customerUser.getMobile());
            Date rightNow = new Date();
            if (rightNow.before(conferenceAttendance.getBeginTime())) {
                root.put("attendance_status", "UNOPENED");
            } else if (rightNow.after(conferenceAttendance.getEndTime())) {
                root.put("attendance_status", "CLOSED");
            } else {
                root.put("attendance_status", "OPENING");
                MmsLogAttendanceEntity logAttendance = logAttendanceService.addLogAttendance(attendance_id, location, lat, lng);
                root.put("arrival_time", DateFormatUtils.format(logAttendance.getArrivalTime(), "HH:mm:ss"));
                root.put("attendance_result", "Y".equalsIgnoreCase(logAttendance.getLateness()) ? "C" : "Y");
                logAttendance.setLateness(logAttendance.getLateness());
            }
        } else {
            throw new SecurityException();
        }
        return root;
    }
}
