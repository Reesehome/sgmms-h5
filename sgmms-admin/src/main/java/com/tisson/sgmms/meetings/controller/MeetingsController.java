package com.tisson.sgmms.meetings.controller;

import com.tisson.sgmms.meetings.service.MeetingsService;
import com.tisson.sgmms.meetings.vo.*;
import com.tisson.tds.common.web.PageJqgrid;
import com.tisson.tds.common.web.Result;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author hasee.
 * @time 2018/5/8 15:10.
 * @description 会议管理
 */

@Controller
@RequestMapping("/admin//meetings/")
public class MeetingsController {

    private static final Logger LOG = LoggerFactory.getLogger(MeetingsController.class);

    @Autowired
    private MeetingsService meetingsService;

    @RequestMapping({"index.do"})
    public String index() {
        return "admin/meetings/index.jsp";
    }

    @RequestMapping({"modify.do"})
    public ModelAndView modify(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        String meetingsId = request.getParameter("meetingsId");
        if (StringUtils.isNotEmpty(meetingsId)) {
            MeetingVo vo = meetingsService.getMeetingsDetail(meetingsId);
            modelAndView.addObject("meetingsVo", vo);
        }
        modelAndView.addObject("meetingsId", meetingsId);
        modelAndView.setViewName("admin/meetings/modify.jsp");
        return modelAndView;
    }

    @RequestMapping({"setting.do"})
    public ModelAndView setting(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        String meetingsId = request.getParameter("meetingsId");
        if (StringUtils.isNotEmpty(meetingsId)) {
            MeetingVo vo = meetingsService.getMeetingsDetail(meetingsId);
            modelAndView.addObject("meetingsVo", vo);
        }
        modelAndView.addObject("meetingsId", meetingsId);
        modelAndView.addObject("entry", request.getParameter("entry"));
        modelAndView.addObject("h5Domain", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/");
        modelAndView.setViewName("admin/meetings/setting.jsp");
        return modelAndView;
    }

    @RequestMapping({"setting/dialog/attendance.do"})
    public ModelAndView attendanceDialog(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        String meetingsId = request.getParameter("meetingsId");

        modelAndView.addObject("meetingsId", meetingsId);
        modelAndView.setViewName("admin/meetings/dialog/attendance.jsp");
        return modelAndView;
    }

    @RequestMapping({"setting/dialog/dinner.do"})
    public ModelAndView dinnerDialog(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        String meetingsId = request.getParameter("meetingsId");
        modelAndView.addObject("meetingsId", meetingsId);
        modelAndView.setViewName("admin/meetings/dialog/dinner.jsp");
        return modelAndView;
    }

    /**
     * 分页查询会议管理列表信息
     *
     * @param vo
     * @param page
     * @return
     */
    @RequestMapping(value = {"queryMeetingsPage"}, method = RequestMethod.POST)
    @ResponseBody
    public PageJqgrid<MeetingVo> queryMeetingsPage(MeetingVo vo, PageJqgrid<MeetingVo> page) {
        try {
            PageJqgrid<MeetingVo> resultPage = meetingsService.findMeetingsList(vo, page);
            resultPage.setResult(new Result("数据加载成功", true));
            return resultPage;
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("分页查询会议管理列表信息", e);
            page.setResult(new Result("分页查询会议管理列表信息", false));
            return page;
        }
    }

    /**
     * 删除会议记录
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"delete/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO delete(@PathVariable("id") String id) {
        CommonVO vo = new CommonVO();
        try {
            vo.setResult(meetingsService.delMeetings(id));
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除会议记录", e);
            vo.setMsg("删除会议记录失败");
            vo.setResult(false);
        }
        return vo;
    }

    /**
     * 启动会议记录
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"start/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO start(@PathVariable("id") String id) {
        CommonVO vo = new CommonVO();
        try {
            String msg = meetingsService.startMeetings(id);
            vo.setMsg(msg);
            vo.setResult(msg == null);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("启动会议记录", e);
            vo.setResult(false);
            vo.setMsg("启动会议记录异常");
        }
        return vo;
    }

    /**
     * 完成会议记录
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"finish/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO finish(@PathVariable("id") String id) {
        CommonVO vo = new CommonVO();
        try {
            String msg = meetingsService.finishMeetings(id);
            vo.setMsg(msg);
            vo.setResult(msg == null);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("完成会议记录", e);
            vo.setResult(false);
            vo.setMsg("完成会议记录异常");
        }
        return vo;
    }

    /**
     * 会议通知
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"notify/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public boolean notify(@PathVariable("id") String id) {
        try {
            return meetingsService.meetingsNotify(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除会议记录", e);
            return false;
        }
    }

    /**
     * 获取会议详细信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"detail/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public MeetingVo meetings(@PathVariable("id") String id) {
        try {
            return meetingsService.getMeetingsDetail(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取会议详细信息", e);
            return null;
        }
    }

    @RequestMapping(value = {"detail/validate"}, method = RequestMethod.GET)
    @ResponseBody
    public boolean validate(@RequestParam("id") String id, @RequestParam("code") String code) {
        try {
            MmsConferenceMainVo entity = meetingsService.queryMeetingByCode(code);
            return entity == null || entity.getId().equals(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取会议详细信息", e);
            return false;
        }
    }

    /**
     * 保存会议信息
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = {"detail/save"}, method = RequestMethod.POST)
    @ResponseBody
    public MeetingVo meetings(MeetingVo vo) {
        try {
            return meetingsService.saveMeetings(vo);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("保存会议信息", e);
            return null;
        }
    }

    @RequestMapping(value = {"setting/member/save"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO memberSave(MeetingMemberVo vo) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsMember(vo);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("保存参会人员信息", e);
            result.setMsg("保存参会人员信息异常.");
            result.setResult(false);
        }
        return result;
    }

    @RequestMapping(value = {"setting/member/delete"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO memberDel(@RequestParam("id") String id) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.deleteMeetingsMember(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除参会人员信息", e);
            result.setMsg("删除参会人员信息异常.");
            result.setResult(false);
        }
        return result;
    }

    @RequestMapping(value = {"setting/member"}, method = RequestMethod.GET)
    @ResponseBody
    public List<MeetingMemberVo> memberList(@RequestParam("meetingsId") String meetingsId) {
        try {
            return meetingsService.meetingsMemberList(meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取参会人员列表", e);
            return null;
        }
    }

    @RequestMapping(value = {"setting/arrange"}, method = RequestMethod.GET)
    @ResponseBody
    public MeetingArrangeVo arrangeVo(@RequestParam("meetingsId") String meetingsId) {
        try {
            return meetingsService.meetingsArrangeData(meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取会议安排", e);
            return null;
        }
    }

    @RequestMapping(value = {"setting/arrange/save"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO arrangeSave(MeetingArrangeVo vo) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsArrange(vo);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("保存会议安排失败", e);
            result.setMsg("保存失败.");
            result.setResult(false);
        }
        return result;
    }


    /**
     * 获取会议考勤设置列表
     *
     * @param meetingsId
     * @return
     */
    @RequestMapping(value = {"setting/attendance"}, method = RequestMethod.GET)
    @ResponseBody
    public List<MeetingAttendanceVo> attendanceList(@RequestParam("meetingsId") String meetingsId) {
        try {
            return meetingsService.meetingsAttendanceList(meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取考情设置列表", e);
            return null;
        }
    }


    @RequestMapping(value = {"setting/attendance/save"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO attendanceSave(@RequestBody List<MeetingAttendanceVo> vos) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsAttendance(vos);
        } catch (Exception e) {

            e.printStackTrace();
            LOG.error("保存考勤设置失败", e);
            result.setMsg("保存失败.");
            result.setResult(false);
        }
        return result;
    }

    @RequestMapping(value = {"setting/attendance/modify"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO attendanceModify(MeetingAttendanceVo vo) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsAttendance(vo);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("修改考勤设置失败", e);
            result.setMsg("修改失败.");
            result.setResult(false);
        }
        return result;
    }

    @RequestMapping(value = {"setting/attendance/delete"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO attendanceDelete(@RequestParam("id") String id) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.deleteMeetingsAttendance(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除考勤设置失败", e);
            result.setMsg("删除失败.");
            result.setResult(false);
        }
        return result;
    }


    /**
     * 获取会议就餐设置列表
     *
     * @param meetingsId
     * @return
     */
    @RequestMapping(value = {"setting/dinner"}, method = RequestMethod.GET)
    @ResponseBody
    public List<MeetingDinnerVo> dinnerList(@RequestParam("meetingsId") String meetingsId) {
        try {
            return meetingsService.meetingsDinnerList(meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取就餐设置列表", e);
            return null;
        }
    }

    /**
     * 保存就餐设置
     *
     * @param vos
     * @return
     */
    @RequestMapping(value = {"setting/dinner/save"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO dinnerSave(@RequestBody List<MeetingDinnerVo> vos) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsDinner(vos);
        } catch (Exception e) {

            e.printStackTrace();
            LOG.error("保存考勤设置失败", e);
            result.setMsg("保存失败.");
            result.setResult(false);
        }
        return result;
    }

    /**
     * 修改就餐设置
     *
     * @param vo
     * @return
     */
    @RequestMapping(value = {"setting/dinner/modify"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO dinnerModify(MeetingDinnerVo vo) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.saveMeetingsDinner(vo);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("修改考勤设置失败", e);
            result.setMsg("修改失败.");
            result.setResult(false);
        }
        return result;
    }

    /**
     * 删除就餐设置
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"setting/dinner/delete"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO dinnerDelete(@RequestParam("id") String id) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.deleteMeetingsDinner(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除考勤设置失败", e);
            result.setMsg("删除失败.");
            result.setResult(false);
        }
        return result;
    }

    /**
     * 获取附件列表
     *
     * @param meetingsId
     * @return
     */
    @RequestMapping(value = {"setting/attachment"}, method = RequestMethod.GET)
    @ResponseBody
    public List<MeetingAttachmentVo> attachmentList(@RequestParam("meetingsId") String meetingsId) {
        try {
            return meetingsService.meetingsAttachmentList(meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("获取会议附件列表", e);
            return null;
        }
    }

    /**
     * 删除附件
     *
     * @param id
     * @return
     */
    @RequestMapping(value = {"setting/attachment/delete"}, method = RequestMethod.GET)
    @ResponseBody
    public CommonVO attachmentDelete(@RequestParam("id") String id) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.deleteMeetingsAttachment(id);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("删除考勤设置失败", e);
            result.setMsg("删除失败.");
            result.setResult(false);
        }
        return result;
    }

    @RequestMapping(value = {"setting/attachment/upload"}, method = RequestMethod.POST)
    @ResponseBody
    public CommonVO attachmentUpload(@RequestParam("file") MultipartFile file
            , @RequestParam("meetingsId") String meetingsId) {
        CommonVO result = new CommonVO();
        try {
            result = meetingsService.uploadMeetingsAttachment(file, meetingsId);
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("上传会议附件失败", e);
            result.setMsg("上传失败.");
            result.setResult(false);
        }
        return result;
    }
}
