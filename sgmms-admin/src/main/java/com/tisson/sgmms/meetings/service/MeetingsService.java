package com.tisson.sgmms.meetings.service;

import com.tisson.sgmms.meetings.vo.*;
import com.tisson.tds.common.web.PageJqgrid;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author hasee.
 * @time 2018/5/10 10:28.
 * @description
 */
public interface MeetingsService {

    /**
     * 查询会议管理列表
     *
     * @param vo
     * @param page
     * @return
     */
    PageJqgrid<MeetingVo> findMeetingsList(MeetingVo vo, PageJqgrid<MeetingVo> page);

    /**
     * 根据ID获取会议信息
     *
     * @param id
     * @return
     */
    MeetingVo getMeetingsDetail(String id);

    /**
     * 保存会议信息
     *
     * @param vo
     * @return
     */
    MeetingVo saveMeetings(MeetingVo vo);

    /**
     * 通过会议编码查询会议信息
     *
     * @param code
     * @return
     */
    MmsConferenceMainVo queryMeetingByCode(String code);

    /**
     * 逻辑删除会议记录
     *
     * @param id
     * @return
     */
    boolean delMeetings(String id);

    /**
     * 将启动会议
     *
     * @param id
     * @return
     */
    String startMeetings(String id);

    /**
     * 结束会议
     *
     * @param id
     * @return
     */
    String finishMeetings(String id);

    /**
     * 短信通知当前参加会议的成员
     *
     * @param id
     * @return
     */
    boolean meetingsNotify(String id);

    /**
     * 保存参会人员信息
     *
     * @param vo
     * @return
     */
    CommonVO saveMeetingsMember(MeetingMemberVo vo);

    /**
     * 保存参会人员信息
     *
     * @param id
     * @return
     */
    CommonVO deleteMeetingsMember(String id);


    /**
     * 获取会议参会人员列表
     *
     * @param meetingsId
     * @return
     */
    List<MeetingMemberVo> meetingsMemberList(String meetingsId);


    /**
     * 获取会议安排
     *
     * @param meetingsId
     * @return
     */
    MeetingArrangeVo meetingsArrangeData(String meetingsId);

    /**
     * 保存会议安排文本
     *
     * @param vo
     * @return
     */
    CommonVO saveMeetingsArrange(MeetingArrangeVo vo);

    /**
     * 保存考勤设置文本
     *
     * @param vos
     * @return
     */
    CommonVO saveMeetingsAttendance(List<MeetingAttendanceVo> vos);

    /**
     * 保存考勤设置文本
     *
     * @param vo
     * @return
     */
    CommonVO saveMeetingsAttendance(MeetingAttendanceVo vo);

    /**
     * 保存考勤设置文本
     *
     * @param id
     * @return
     */
    CommonVO deleteMeetingsAttendance(String id);

    /**
     * 获取会议考勤设置列表
     *
     * @param meetingsId
     * @return
     */
    List<MeetingAttendanceVo> meetingsAttendanceList(String meetingsId);


    /**
     * 获取会议就餐设置列表
     *
     * @param meetingsId
     * @return
     */
    List<MeetingDinnerVo> meetingsDinnerList(String meetingsId);

    /**
     * 保存就餐设置文本
     *
     * @param vos
     * @return
     */
    CommonVO saveMeetingsDinner(List<MeetingDinnerVo> vos);

    /**
     * 保存就餐设置文本
     *
     * @param vo
     * @return
     */
    CommonVO saveMeetingsDinner(MeetingDinnerVo vo);

    /**
     * 保存就餐设置文本
     *
     * @param id
     * @return
     */
    CommonVO deleteMeetingsDinner(String id);

    /**
     * @param file
     * @param meetingsId
     * @return
     */
    CommonVO uploadMeetingsAttachment(MultipartFile file, String meetingsId);

    /**
     * @param meetingsId
     * @return
     */
    List<MeetingAttachmentVo> meetingsAttachmentList(String meetingsId);

    /**
     * @param id
     * @return
     */
    CommonVO deleteMeetingsAttachment(String id);
}
