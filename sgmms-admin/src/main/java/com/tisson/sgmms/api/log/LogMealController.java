package com.tisson.sgmms.api.log;

import com.tisson.sgmms.api.exception.ExceptionController;
import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.service.MmsCustomerUserService;
import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import com.tisson.sgmms.log.service.MmsLogMealService;
import com.tisson.sgmms.log.specification.LogMealSpecifications;
import com.tisson.sgmms.meetings.entity.MmsConferenceMainEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import com.tisson.sgmms.meetings.service.MmsConferenceService;
import com.tisson.sgmms.meetings.specification.ConferenceMainSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceMealSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceUserSpecifications;
import org.apache.commons.beanutils.BeanPredicate;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.functors.EqualPredicate;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static org.springframework.data.jpa.domain.Specifications.where;

@RequestMapping("/api/conference/{conference_code}/meal")
@RestController
public class LogMealController extends ExceptionController {

    @Autowired
    private MmsLogMealService logMealService;

    @Autowired
    private MmsCustomerUserService customerUserService;

    @Autowired
    private MmsConferenceService conferenceService;

    @RequestMapping(method = RequestMethod.GET)
    public Map<String, ?> getLogMeals(@PathVariable String conference_code) {
        // 根据会议编码找到记录
        List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(
                new ConferenceMainSpecifications.ConferenceCode(conference_code));
        if (conferenceMains == null || conferenceMains.isEmpty()) {
            throw new IllegalArgumentException("会议编码不正确");
        }
        MmsConferenceMainEntity conferenceMain = conferenceMains.get(0);
        // 返回结果
        Map<String, Object> root = new HashMap<>();
        root.put("success", true);
        // 找到该会议的就餐设置
        List<MmsConferenceMealEntity> conferenceMeals = conferenceService.findConferenceMeals(
                new ConferenceMealSpecifications.ConferenceId(conferenceMain.getId()));
        if (conferenceMeals == null || conferenceMeals.isEmpty()) {
            root.put("content", Collections.EMPTY_LIST);
        } else {
            // 根据就餐的外键，找到就餐记录
            Authentication authentication = Authentication.getCurrent();
            String userId = authentication.getSubject();
            List<MmsLogMealEntity> logMeals = logMealService.findAll(where(new LogMealSpecifications.UserId(userId)));
            List<Map<String, String>> content = new ArrayList<>();
            Map<String, String> hashMap;
            // 输出协议
            for (MmsConferenceMealEntity conferenceMeal : conferenceMeals) {
                hashMap = new HashMap<>();
                hashMap.put("begin_date", DateFormatUtils.format(conferenceMeal.getBeginTime(), "yyyy-MM-dd a"));
                hashMap.put("begin_time", DateFormatUtils.format(conferenceMeal.getBeginTime(), "HH:mm"));
                hashMap.put("end_time", DateFormatUtils.format(conferenceMeal.getEndTime(), "HH:mm"));
                hashMap.put("location", conferenceMeal.getLocation());
                MmsLogMealEntity logMeal = (MmsLogMealEntity) CollectionUtils.find(logMeals, new BeanPredicate("mealId", new EqualPredicate(conferenceMeal.getId())));
                if (logMeal != null) {
                    hashMap.put("meal_time", DateFormatUtils.format(logMeal.getMealTime(), "HH:mm"));
                } else {
                    hashMap.put("meal_time", null);
                }
                content.add(hashMap);
            }
            root.put("content", content);
        }
        return root;
    }

    @RequestMapping(method = RequestMethod.POST)
    public Map<String, Object> addLogMeal(@PathVariable String conference_code, @RequestParam String meal_id) {
        // 根据会议编码找到记录
        List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(
                new ConferenceMainSpecifications.ConferenceCode(conference_code));
        if (conferenceMains == null || conferenceMains.isEmpty()) {
            throw new IllegalArgumentException("会议编码不正确");
        }
        MmsConferenceMainEntity conferenceMain = conferenceMains.get(0);
        // 返回结果
        Map<String, Object> evidence = new HashMap<>();
        if (conferenceMain == null) {
            throw new IllegalArgumentException("会议标识不正确");
        }
        evidence.put("success", true);
        evidence.put("conference_title", conferenceMain.getTitle());
        // 找到该会议的就餐设置
        List<MmsConferenceMealEntity> conferenceMeals = conferenceService.findConferenceMeals(
                where(new ConferenceMealSpecifications.ConferenceId(conferenceMain.getId()))
                .and(new ConferenceMealSpecifications.MealId(meal_id)));
        if (conferenceMeals == null || conferenceMeals.isEmpty()) {
            throw new IllegalArgumentException("就餐标识不正确");
        }
        MmsConferenceMealEntity conferenceMeal = conferenceMeals.get(0);
        evidence.put("meal_location", conferenceMeal.getLocation());
        Date rightNow = new Date();
        if (rightNow.after(conferenceMeal.getBeginTime()) && rightNow.before(conferenceMeal.getEndTime())) {
            MmsLogMealEntity entity = logMealService.addLogMeal(meal_id);
            evidence.put("total_scan", entity.getTotalScan());
            evidence.put("meal_status", "OPEN");
        } else {
            evidence.put("meal_status", "REST");
            evidence.put("total_scan", 0);
        }
        // 查询用户的姓名、电话
        Authentication authentication = Authentication.getCurrent();
        String userId = authentication.getSubject();
        MmsCustomerUserEntity customerUser = customerUserService.findOne(userId);
        if (customerUser != null) {
            evidence.put("compellation", customerUser.getUserName());
            evidence.put("mobile", customerUser.getMobile());
            // 查询用户是否订餐
            List<MmsConferenceUserEntity> conferenceUsers = conferenceService.findConferenceUsers(
                    where(new ConferenceUserSpecifications.ConferenceId(conferenceMain.getId()))
                            .and(new ConferenceUserSpecifications.UserId(userId)));
            if (conferenceUsers == null || conferenceUsers.isEmpty()) {
                evidence.put("meal_reserve", "N");
            } else {
                MmsConferenceUserEntity conferenceUser = conferenceUsers.get(0);
                evidence.put("meal_reserve", conferenceUser.getReserveMeal());
            }
        } else { //用户不存在，不能就餐
            evidence.put("meal_reserve", "N");
        }
        return evidence;
    }
}
