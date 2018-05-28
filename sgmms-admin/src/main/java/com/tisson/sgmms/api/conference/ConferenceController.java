package com.tisson.sgmms.api.conference;

import com.tisson.sgmms.api.exception.ExceptionController;
import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import com.tisson.sgmms.log.service.MmsLogAttendanceService;
import com.tisson.sgmms.log.specification.LogAttendanceSpecifications;
import com.tisson.sgmms.meetings.entity.*;
import com.tisson.sgmms.meetings.service.MmsConferenceService;
import com.tisson.sgmms.meetings.specification.ConferenceAttachmentSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceAttendanceSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceMainSpecifications;
import com.tisson.sgmms.meetings.specification.ConferenceUserSpecifications;
import org.apache.commons.beanutils.BeanPredicate;
import org.apache.commons.beanutils.BeanToPropertyValueTransformer;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.functors.EqualPredicate;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.domain.Specifications;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RequestMapping("/api/conference")
@RestController
public class ConferenceController extends ExceptionController {

    @Autowired
    private MmsConferenceService conferenceService;

    /**
     * 会议列表
     */
    @RequestMapping(method = RequestMethod.GET)
    public Map<String, Object> getConferences (@PageableDefault(direction = Sort.Direction.DESC, sort = "createOn") Pageable pageable) {
        Authentication authentication = Authentication.getCurrent();
        if (authentication == null) {
            throw new SecurityException();
        }
        String userId = authentication.getSubject();
        // 先找自己的会议标识
        Specification<MmsConferenceUserEntity> specification = Specifications.where(new ConferenceUserSpecifications.UserId(userId));
        Page<MmsConferenceUserEntity> users = conferenceService.findConferenceUsers(specification, pageable);
        Map<String, Object> wrapper = new HashMap<>();
        wrapper.put("success", true);
        if (users == null || users.getNumberOfElements() == 0) {
            wrapper.put("content", Collections.EMPTY_LIST);
            wrapper.put("total_pages", 0);
            wrapper.put("total_elements", 0);
        } else {
            // 根据会议标识找到会议记录
            Collection<String> conferenceIds = (Collection<String>) CollectionUtils.collect(users.getContent(), new BeanToPropertyValueTransformer("conferenceId"));
            List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(
                    new ConferenceMainSpecifications.ConferenceIds(conferenceIds),
                    new Sort(Sort.Direction.DESC, "createOn"));
            List<Map<String, Object>> content = new ArrayList<>();
            Map<String, Object> hashMap;
            for (MmsConferenceMainEntity conferenceMain : conferenceMains) {
                hashMap = new HashMap<>();
                hashMap.put("title", conferenceMain.getTitle());
                hashMap.put("code", conferenceMain.getCode());
                hashMap.put("begin_time", DateFormatUtils.format(conferenceMain.getBeginTime(), "yyyy-MM-dd HH:mm"));
                hashMap.put("end_time", DateFormatUtils.format(conferenceMain.getEndTime(), "yyyy-MM-dd HH:mm"));
                hashMap.put("status", conferenceMain.getStatus());
                hashMap.put("venue", conferenceMain.getVenue());
                hashMap.put("total_users", conferenceMain.getTotalUsers());
                content.add(hashMap);
            }
            wrapper.put("content", content);
            wrapper.put("total_pages", users.getTotalPages());
            wrapper.put("total_elements", users.getTotalElements());
        }
        return wrapper;
    }

    /**
     * 会议详情
     */
    @RequestMapping(value = "/{conference_code}", method = RequestMethod.GET)
    public Map<String, Object> getConferenceDetail (@PathVariable String conference_code) {
        Specification<MmsConferenceMainEntity> specification = new ConferenceMainSpecifications.ConferenceCode(conference_code);
        List<MmsConferenceMainEntity> conferenceMains = conferenceService.findConferenceMains(specification);
        if (conferenceMains == null || conferenceMains.isEmpty()) {
            throw new IllegalArgumentException("会议编码不正确");
        }
        MmsConferenceMainEntity conferenceMain = conferenceMains.get(0);
        HashMap<String, Object> root = new HashMap<>();
        root.put("success", true);
        root.put("title", conferenceMain.getTitle());
        root.put("code", conferenceMain.getCode());
        root.put("begin_time", DateFormatUtils.format(conferenceMain.getBeginTime(), "yyyy-MM-dd HH:mm"));
        root.put("end_time", DateFormatUtils.format(conferenceMain.getEndTime(), "yyyy-MM-dd HH:mm"));
        root.put("status", conferenceMain.getStatus());
        root.put("venue", conferenceMain.getVenue());
        root.put("total_users", conferenceMain.getTotalUsers());
        MmsConferenceDetailEntity conferenceMore = conferenceService.getConferenceDetail(conferenceMain.getId());
        if (conferenceMore != null) {
            root.put("agendum", conferenceMore.getAgendum());
            root.put("attention", conferenceMore.getAttention());
        } else {
            root.put("agendum", null);
            root.put("attention", null);
        }
        List<MmsConferenceAttachmentEntity> conferenceAttachments = conferenceService.findConferenceAttachments(
                new ConferenceAttachmentSpecifications.ConferenceId(conferenceMain.getId()),
                new Sort(Sort.Direction.ASC, "createOn")
        );
        if (CollectionUtils.isNotEmpty(conferenceAttachments)) {
            List<Map<String, String>> attachments = new ArrayList<>();
            Map<String, String> hashMap;
            for (MmsConferenceAttachmentEntity conferenceAttachment : conferenceAttachments) {
                hashMap = new HashMap<>();
                hashMap.put("title", conferenceAttachment.getTitle());
                hashMap.put("name", conferenceAttachment.getName());
                hashMap.put("uri", conferenceAttachment.getUri());
                attachments.add(hashMap);
            }
            root.put("attachments", attachments);
        } else {
            root.put("attachments", Collections.EMPTY_LIST);
        }
        return root;
    }
}
