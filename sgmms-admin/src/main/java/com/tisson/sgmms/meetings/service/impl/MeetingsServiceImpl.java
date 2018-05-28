package com.tisson.sgmms.meetings.service.impl;

import com.tisson.sgmms.customer.entity.MmsCustomerCompanyEntity;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.repository.MmsCustomerCompanyRepository;
import com.tisson.sgmms.customer.repository.MmsCustomerUserRepository;
import com.tisson.sgmms.log.entity.MmsLogMessageEntity;
import com.tisson.sgmms.log.repository.MmsLogAttendanceRepository;
import com.tisson.sgmms.log.repository.MmsLogMealRepository;
import com.tisson.sgmms.log.service.MmsLogMessageService;
import com.tisson.sgmms.meetings.constants.MeetingsConstants;
import com.tisson.sgmms.meetings.entity.*;
import com.tisson.sgmms.meetings.repository.*;
import com.tisson.sgmms.meetings.service.FileService;
import com.tisson.sgmms.meetings.service.MeetingsService;
import com.tisson.sgmms.meetings.vo.*;
import com.tisson.tds.api.AppContext;
import com.tisson.tds.api.vo.User;
import com.tisson.tds.common.utils.IndexGenerator;
import com.tisson.tds.common.web.PageJqgrid;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

/**
 * @author hasee.
 * @time 2018/5/10 10:32.
 * @description
 */
@Service
public class MeetingsServiceImpl implements MeetingsService {

    private final Logger LOG = LoggerFactory.getLogger(MeetingsServiceImpl.class);
    private final Map<String, String> STATUS_DICT_MAP = new HashMap<>();

    {
        STATUS_DICT_MAP.put("UNSTART", "未启动");
        STATUS_DICT_MAP.put("STARTED", "启动");
        STATUS_DICT_MAP.put("ENDED", "结束");
    }

    @Resource
    private MmsConferenceMainRepository meetingsRepository;
    @Resource
    private MmsConferenceUserRepository mmsConferenceUserRepository;
    @Resource
    private MmsCustomerUserRepository mmsCustomerUserRepository;
    @Resource
    private MmsConferenceDetailRepository mmsConferenceDetailRepository;
    @Resource
    private MmsConferenceAttendanceRepository mmsConferenceAttendanceRepository;
    @Resource
    private MmsConferenceAttachmentRepository mmsConferenceAttachmentRepository;
    @Resource
    private MmsConferenceMealRepository mmsConferenceMealRepository;
    @Resource
    private MmsLogMealRepository mmsLogMealRepository;
    @Resource
    private MmsLogAttendanceRepository mmsLogAttendanceRepository;

    @Autowired
    private MmsConferenceMessageRepository conferenceMessageRepository;
    @Autowired
    private MmsCustomerCompanyRepository customerCompanyRepository;
    @Autowired
    private MmsLogMessageService logMessageService;

    @Autowired
    private AppContext appContext;
    @Autowired
    private FileService fileService;

    @Override
    public PageJqgrid<MeetingVo> findMeetingsList(final MeetingVo listVo, PageJqgrid<MeetingVo> page) {
        PageJqgrid<MeetingVo> pageJQgrid = new PageJqgrid<>();
        Specification<MmsConferenceMainEntity> specification = new Specification<MmsConferenceMainEntity>() {
            @Override
            public Predicate toPredicate(Root<MmsConferenceMainEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<>();
                if (StringUtils.isNotBlank(listVo.getTitle())) {
                    list.add(criteriaBuilder.like(root.get("title").as(String.class), "%" + listVo.getTitle() + "%"));
                }
                if (StringUtils.isNotBlank(listVo.getStatus())) {
                    list.add(criteriaBuilder.equal(root.get("status").as(String.class), listVo.getStatus()));
                }
                if (listVo.getBeginTime() != null) {
                    list.add(criteriaBuilder.greaterThanOrEqualTo(root.get("beginTime").as(Date.class), listVo.getBeginTime()));
                }
                if (listVo.getEndTime() != null) {
                    list.add(criteriaBuilder.lessThanOrEqualTo(root.get("endTime").as(Date.class), listVo.getEndTime()));
                }
                list.add(criteriaBuilder.equal(root.get("enabled").as(String.class), MeetingsConstants.MEETINGS_ENABLED_Y));
                criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createOn")));
                Predicate[] predicates = new Predicate[list.size()];
                predicates = list.toArray(predicates);
                CriteriaQuery<?> cq = criteriaQuery.where(list.toArray(predicates));
                return cq.getRestriction();
            }
        };
        PageJqgrid<MmsConferenceMainEntity> tmp = new PageJqgrid<MmsConferenceMainEntity>();
        tmp.initResult(meetingsRepository.findAll(specification, new PageRequest(page.getPage() - 1, page.getPageSize())));
        List<MeetingVo> meetingsListVos = new ArrayList<MeetingVo>();
        for (MmsConferenceMainEntity entity : tmp.getRows()) {
            meetingsListVos.add(this.formatFiled(new MeetingVo().buildVo(entity)));
        }
        BeanUtils.copyProperties(tmp, pageJQgrid);
        pageJQgrid.setRows(meetingsListVos);
        return pageJQgrid;
    }

    private MeetingVo formatFiled(MeetingVo entity) {
        entity.setStatus(this.STATUS_DICT_MAP.get(entity.getStatus()));
        return entity;
    }

    /**
     * 通过会议编码查询会议信息
     *
     * @param code
     * @return
     */
    @Override
    public MmsConferenceMainVo queryMeetingByCode(String code) {
        MmsConferenceMainVo mmsConferenceMainVo = null;
        List<MmsConferenceMainEntity> mmsConferenceMainEntityList = meetingsRepository.queryMeetingByCode(code);
        if (mmsConferenceMainEntityList != null && mmsConferenceMainEntityList.size() > 0) {
            mmsConferenceMainVo = new MmsConferenceMainVo();
            BeanUtils.copyProperties(mmsConferenceMainEntityList.get(0), mmsConferenceMainVo);
        }
        return mmsConferenceMainVo;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public boolean delMeetings(String id) {
        MmsConferenceMainEntity entity = meetingsRepository.getOne(id);
        entity.setUpdateBy(appContext.getUser().getUserName());
        entity.setUpdateOn(new Date());
        entity.setEnabled(MeetingsConstants.MEETINGS_ENABLED_N);
        return meetingsRepository.save(entity) != null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public String startMeetings(String id) {
        MmsConferenceMainEntity entity = meetingsRepository.getOne(id);
        if (MeetingsConstants.MEETINGS_STATUS_UNSTART.equals(entity.getStatus())) {
            entity.setUpdateBy(appContext.getUser().getUserName());
            entity.setUpdateOn(new Date());
            entity.setStatus(MeetingsConstants.MEETINGS_STATUS_STARTED);
            return meetingsRepository.save(entity) != null ? null : "启动会议记录失败[保存数据异常].";
        }
        return "启动会议记录失败[会议状态只能为未启动].";
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public String finishMeetings(String id) {
        MmsConferenceMainEntity entity = meetingsRepository.getOne(id);
        if (MeetingsConstants.MEETINGS_STATUS_STARTED.equals(entity.getStatus())) {
            entity.setUpdateBy(appContext.getUser().getUserName());
            entity.setUpdateOn(new Date());
            entity.setStatus(MeetingsConstants.MEETINGS_STATUS_ENDED);
            return meetingsRepository.save(entity) != null ? null : "结束会议记录失败[保存数据异常].";
        }
        return "结束会议记录失败[会议状态只能为已启动].";
    }

    @Override
    public boolean meetingsNotify(String id) {
        MmsConferenceMainEntity conferenceMain = meetingsRepository.findOne(id);
        Assert.notNull(conferenceMain, "会议不存在");
        List<MmsConferenceUserEntity> conferenceUsers = mmsConferenceUserRepository.findByConferenceId(id);
        if (conferenceUsers != null) {
            String content;
            for (MmsConferenceUserEntity conferenceUser : conferenceUsers) {
                content = String.format("你的%1$s将于%2$tF %2$tr开始，请准时参加。", conferenceMain.getTitle(), conferenceMain.getBeginTime());
                userNotify(conferenceUser.getUserId(), content);
            }
        }
        return false;
    }

    private void userNotify(String userId, String content) {
        MmsCustomerUserEntity customerUser = mmsCustomerUserRepository.findOne(userId);
        Assert.notNull(customerUser, "用户不存在");

        // 插入到短信日志表
        MmsLogMessageEntity logMessage = logMessageService.addLogMessage(customerUser.getMobile(), content);

        // 短信关联表
        MmsConferenceMessageEntity conferenceMessage = new MmsConferenceMessageEntity();
        conferenceMessage.setId(IndexGenerator.generatorId());
        conferenceMessage.setMessageId(logMessage.getId());

        // 公司
        MmsCustomerCompanyEntity customerCompany = customerCompanyRepository.findOne(customerUser.getCompanyId());
        Assert.notNull(customerCompany, "单位不存在");
        conferenceMessage.setCompanyId(customerCompany.getId());
        conferenceMessage.setCompanyName(customerCompany.getName());

        // 用户
        conferenceMessage.setUserId(customerUser.getId());
        conferenceMessage.setUserName(customerUser.getUserName());

        // 审计
        User user = appContext.getUser();
        conferenceMessage.setCreateBy(user.getId());
        conferenceMessage.setCreateOn(new Date());
        conferenceMessageRepository.save(conferenceMessage);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsMember(MeetingMemberVo vo) {
        CommonVO result = new CommonVO();
        try {
            /**
             * TODO
             * 2018/5/15
             * 参会人员校验重复添加
             */

            MmsConferenceUserEntity entity = new MmsConferenceUserEntity();
            Date now = new Date();
            if (StringUtils.isNotBlank(vo.getId())) {
                entity = mmsConferenceUserRepository.getOne(vo.getId());
                entity.setUpdateBy(appContext.getUser().getUserName());
                entity.setUpdateOn(now);
            } else {
                MmsConferenceMainEntity mainEntity = meetingsRepository.findOne(vo.getConferenceId());
                if (mainEntity == null) {
                    throw new NullPointerException("会议主记录为空.");
                }
                mainEntity.setTotalUsers(mainEntity.getTotalUsers() + 1);
                mainEntity.setUpdateBy(appContext.getUser().getUserName());
                mainEntity.setUpdateOn(now);
                meetingsRepository.save(mainEntity);
                entity.setId(IndexGenerator.generatorId());
                entity.setCreateBy(appContext.getUser().getUserName());
                entity.setCreateOn(now);
            }
            entity.setReserveMeal(vo.getReserveMeal());
            entity.setConferenceId(vo.getConferenceId());
            entity.setUserId(vo.getUserId());
            result.setData(new MeetingMemberVo().buildVo(mmsConferenceUserRepository.save(entity)));
            result.setResult(true);
        } catch (Exception e) {
            LOG.error("保存参会人员失败.", e);
            result.setResult(false);
            result.setMsg("保存参会人员失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO deleteMeetingsMember(String id) {
        CommonVO vo = new CommonVO();
        try {
            MmsConferenceUserEntity entity = mmsConferenceUserRepository.findOne(id);
            MmsConferenceMainEntity mainEntity = meetingsRepository.findOne(entity.getConferenceId());
            Date now = new Date();
            if (mainEntity == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            mainEntity.setTotalUsers(mainEntity.getTotalUsers() - 1);
            mainEntity.setUpdateBy(appContext.getUser().getUserName());
            mainEntity.setUpdateOn(now);
            meetingsRepository.save(mainEntity);
            mmsConferenceUserRepository.delete(entity);
            vo.setResult(true);
        } catch (Exception e) {
            LOG.error("删除参会人员失败.", e);
            vo.setResult(false);
            vo.setMsg("删除参会人员失败[" + e.getMessage() + "]");
        }
        return vo;
    }

    @Override
    public List<MeetingMemberVo> meetingsMemberList(String meetingsId) {
        List<MmsConferenceUserEntity> userEntities = mmsConferenceUserRepository.findByConferenceId(meetingsId);
        List<MeetingMemberVo> meetingMemberVos = new ArrayList<MeetingMemberVo>();
        for (MmsConferenceUserEntity userEntity : userEntities) {
            MmsCustomerUserEntity customerUserEntity = mmsCustomerUserRepository.findOne(userEntity.getUserId());
            MeetingMemberVo vo = new MeetingMemberVo().buildVo(userEntity);
            if (customerUserEntity != null) {
                vo.setMobile(customerUserEntity.getMobile());
                vo.setUserName(customerUserEntity.getUserName());
                vo.setGender(customerUserEntity.getGender());
                vo.setCompanyId(customerUserEntity.getCompanyId());
            }
            meetingMemberVos.add(vo);
        }
        return meetingMemberVos;
    }

    @Override
    public MeetingArrangeVo meetingsArrangeData(String meetingsId) {
        MmsConferenceDetailEntity entity = mmsConferenceDetailRepository.findByConferenceId(meetingsId);
        if (entity != null) {
            return new MeetingArrangeVo().buildVo(entity);
        }
        return null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsArrange(MeetingArrangeVo vo) {
        CommonVO result = new CommonVO();
        try {
            if (meetingsRepository.findOne(vo.getConferenceId()) == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            Date now = new Date();
            MmsConferenceDetailEntity entity = mmsConferenceDetailRepository.findByConferenceId(vo.getConferenceId());
            if (vo.getAgendum() != null) {
                entity.setAgendum(vo.getAgendum());
            }
            if (vo.getAttention() != null) {
                entity.setAttention(vo.getAttention());
            }
            entity.setUpdateBy(appContext.getUser().getUserName());
            entity.setUpdateOn(now);
            mmsConferenceDetailRepository.save(entity);
            result.setResult(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            LOG.error("保存会议安排信息失败.", e);
            result.setResult(false);
            result.setMsg("保存会议安排信息失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsAttendance(List<MeetingAttendanceVo> vos) {
        CommonVO result = new CommonVO();
        try {
            if (vos.size() > 0) {
                if (meetingsRepository.findOne(vos.get(0).getConferenceId()) == null) {
                    throw new NullPointerException("会议主记录为空.");
                }
                Date now = new Date();
                List<MmsConferenceAttendanceEntity> entities = new ArrayList<MmsConferenceAttendanceEntity>();
                for (MeetingAttendanceVo vo : vos) {
                    MmsConferenceAttendanceEntity entity = new MmsConferenceAttendanceEntity();
                    BeanUtils.copyProperties(vo, entity);
                    entity.setId(IndexGenerator.generatorId());
                    entity.setCreateBy(appContext.getUser().getUserName());
                    entity.setCreateOn(now);
                    entities.add(entity);
                }
                mmsConferenceAttendanceRepository.save(entities);
            }
            result.setResult(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            LOG.error("保存考勤记录信息失败.", e);
            result.setResult(false);
            result.setMsg("保存考勤记录信息失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsAttendance(MeetingAttendanceVo vo) {
        CommonVO result = new CommonVO();
        try {
            if (meetingsRepository.findOne(vo.getConferenceId()) == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            Date now = new Date();
            MmsConferenceAttendanceEntity entity = new MmsConferenceAttendanceEntity();
            if (StringUtils.isNotEmpty(vo.getId())) {
                entity = mmsConferenceAttendanceRepository.findOne(vo.getId());
                entity.setUpdateOn(now);
                entity.setUpdateBy(appContext.getUser().getUserName());
            } else {
                entity.setId(IndexGenerator.generatorId());
                entity.setConferenceId(vo.getConferenceId());
                entity.setCreateBy(appContext.getUser().getUserName());
                entity.setCreateOn(now);
            }
            entity.setBeginTime(vo.getBeginTime());
            entity.setEndTime(vo.getEndTime());
            entity.setLatenessBeginTime(vo.getLatenessBeginTime());
            entity.setLatenessEndTime(vo.getLatenessEndTime());
            mmsConferenceAttendanceRepository.save(entity);
            result.setResult(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            LOG.error("保存考勤记录信息失败.", e);
            result.setResult(false);
            result.setMsg("保存考勤记录信息失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO deleteMeetingsAttendance(String id) {
        CommonVO vo = new CommonVO();
        try {
            MmsConferenceAttendanceEntity entity = mmsConferenceAttendanceRepository.findOne(id);
            MmsConferenceMainEntity mainEntity = meetingsRepository.findOne(entity.getConferenceId());
            if (mainEntity == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            mmsLogAttendanceRepository.delete(mmsLogAttendanceRepository.findByAttendanceId(entity.getId()));
            mmsConferenceAttendanceRepository.delete(entity);
            vo.setResult(true);
        } catch (Exception e) {
            LOG.error("删除考勤记录失败.", e);
            vo.setResult(false);
            vo.setMsg("删除考勤记录失败[" + e.getMessage() + "]");
        }
        return vo;
    }

    @Override
    public MeetingVo getMeetingsDetail(String id) {
        if (StringUtils.isNotEmpty(id)) {
            MmsConferenceMainEntity entity = meetingsRepository.findOne(id);
            return new MeetingVo().buildVo(entity);
        }
        return null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public MeetingVo saveMeetings(MeetingVo vo) {
        MmsConferenceMainEntity entity = new MmsConferenceMainEntity();
        Date now = new Date();
        if (StringUtils.isNotBlank(vo.getId())) {
            entity = meetingsRepository.getOne(vo.getId());
            entity.setUpdateBy(appContext.getUser().getUserName());
            entity.setUpdateOn(now);
        } else {
            entity.setId(IndexGenerator.generatorId());
            entity.setCreateBy(appContext.getUser().getUserName());
            entity.setCreateOn(now);
            entity.setEnabled(MeetingsConstants.MEETINGS_ENABLED_Y);
            MmsConferenceDetailEntity detailEntity = new MmsConferenceDetailEntity();
            detailEntity.setConferenceId(entity.getId());
            detailEntity.setCreateBy(appContext.getUser().getUserName());
            detailEntity.setCreateOn(now);
            mmsConferenceDetailRepository.save(detailEntity);
        }
        entity.setTitle(vo.getTitle());
        entity.setVenue(vo.getVenue());
        entity.setBeginTime(vo.getBeginTime());
        entity.setEndTime(vo.getEndTime());
        entity.setStatus(vo.getStatus());
        entity.setComment(vo.getComment());
        entity.setCode(vo.getCode());
        return new MeetingVo().buildVo(meetingsRepository.save(entity));
    }

    @Override
    public List<MeetingAttendanceVo> meetingsAttendanceList(String meetingsId) {
        MmsConferenceMainEntity entity = meetingsRepository.findOne(meetingsId);
        if (entity != null) {
            List<MmsConferenceAttendanceEntity> attendanceEntities = mmsConferenceAttendanceRepository.findByConferenceId(meetingsId);
            List<MeetingAttendanceVo> meetingAttendanceVos = new ArrayList<MeetingAttendanceVo>();
            for (MmsConferenceAttendanceEntity attendanceEntity : attendanceEntities) {
                MeetingAttendanceVo vo = new MeetingAttendanceVo().buildVo(attendanceEntity);
                vo.setConferenceCode(entity.getCode());
                meetingAttendanceVos.add(vo);
            }
            return meetingAttendanceVos;
        }
        return null;
    }

    @Override
    public List<MeetingDinnerVo> meetingsDinnerList(String meetingsId) {
        MmsConferenceMainEntity entity = meetingsRepository.findOne(meetingsId);
        if (entity != null) {
            List<MmsConferenceMealEntity> mealEntities = mmsConferenceMealRepository.findByConferenceId(meetingsId);
            List<MeetingDinnerVo> meetingDinnerVos = new ArrayList<MeetingDinnerVo>();
            for (MmsConferenceMealEntity mealEntity : mealEntities) {
                MeetingDinnerVo vo = new MeetingDinnerVo().buildVo(mealEntity);
                vo.setConferenceCode(entity.getCode());
                meetingDinnerVos.add(vo);
            }
            return meetingDinnerVos;
        }
        return null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsDinner(List<MeetingDinnerVo> vos) {
        CommonVO result = new CommonVO();
        try {
            if (vos.size() > 0) {
                if (meetingsRepository.findOne(vos.get(0).getConferenceId()) == null) {
                    throw new NullPointerException("会议主记录为空.");
                }
                Date now = new Date();
                List<MmsConferenceMealEntity> entities = new ArrayList<MmsConferenceMealEntity>();
                for (MeetingDinnerVo vo : vos) {
                    MmsConferenceMealEntity entity = new MmsConferenceMealEntity();
                    BeanUtils.copyProperties(vo, entity);
                    entity.setId(IndexGenerator.generatorId());
                    entity.setCreateBy(appContext.getUser().getUserName());
                    entity.setCreateOn(now);
                    entities.add(entity);
                }
                mmsConferenceMealRepository.save(entities);
            }
            result.setResult(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            LOG.error("保存会议就餐设置失败.", e);
            result.setResult(false);
            result.setMsg("保存会议就餐设置失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO saveMeetingsDinner(MeetingDinnerVo vo) {
        CommonVO result = new CommonVO();
        try {
            if (meetingsRepository.findOne(vo.getConferenceId()) == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            Date now = new Date();
            MmsConferenceMealEntity entity = new MmsConferenceMealEntity();
            if (StringUtils.isNotEmpty(vo.getId())) {
                entity = mmsConferenceMealRepository.findOne(vo.getId());
                entity.setUpdateBy(appContext.getUser().getUserName());
                entity.setUpdateOn(now);
            } else {
                entity.setId(IndexGenerator.generatorId());
                entity.setConferenceId(vo.getConferenceId());
                entity.setCreateBy(appContext.getUser().getUserName());
                entity.setCreateOn(now);
            }
            entity.setBeginTime(vo.getBeginTime());
            entity.setEndTime(vo.getEndTime());
            entity.setName(vo.getName());
            entity.setLocation(vo.getLocation());
            mmsConferenceMealRepository.save(entity);
            result.setResult(true);
            result.setMsg("保存成功");
        } catch (Exception e) {
            LOG.error("保存会议就餐设置失败.", e);
            result.setResult(false);
            result.setMsg("保存会议就餐设置失败[" + e.getMessage() + "]");
        }
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO deleteMeetingsDinner(String id) {
        CommonVO vo = new CommonVO();
        try {
            MmsConferenceMealEntity entity = mmsConferenceMealRepository.findOne(id);
            MmsConferenceMainEntity mainEntity = meetingsRepository.findOne(entity.getConferenceId());
            if (mainEntity == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            mmsLogMealRepository.delete(mmsLogMealRepository.findByMealId(entity.getId()));
            mmsConferenceMealRepository.delete(entity);
            vo.setResult(true);
        } catch (Exception e) {
            LOG.error("删除就餐设置失败.", e);
            vo.setResult(false);
            vo.setMsg("删除就餐设置失败[" + e.getMessage() + "]");
        }
        return vo;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO uploadMeetingsAttachment(MultipartFile file, String meetingsId) {
        CommonVO vo = new CommonVO();
        try {
            if (file.getSize() <= MeetingsConstants.UPLOAD_FILE_SIZE_ATTACH) {
                String path = fileService.saveFileToLocal(file, MeetingsConstants.UPLOAD_TYPE_ATTACH, meetingsId);
                MmsConferenceAttachmentEntity entity = new MmsConferenceAttachmentEntity();
                entity.setId(IndexGenerator.generatorId());
                entity.setConferenceId(meetingsId);
                entity.setName(file.getOriginalFilename());
                entity.setTitle(file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf(".")));
                entity.setUri(path);
                entity.setCreateBy(appContext.getUser().getUserName());
                entity.setCreateOn(new Date());
                mmsConferenceAttachmentRepository.save(entity);
                vo.setResult(true);
            } else {
                vo.setResult(false);
                vo.setMsg("会议附件上传失败[文件大小不能超过 " + MeetingsConstants.UPLOAD_FILE_SIZE_ATTACH + "MB]");
            }
        } catch (Exception e) {
            LOG.error("会议附件上传失败.", e);
            vo.setResult(false);
            vo.setMsg("删除就餐设置失败[" + e.getMessage() + "]");
        }
        return vo;
    }

    @Override
    public List<MeetingAttachmentVo> meetingsAttachmentList(String meetingsId) {
        List<MmsConferenceAttachmentEntity> attachmentEntities = mmsConferenceAttachmentRepository.findByConferenceId(meetingsId);
        List<MeetingAttachmentVo> attachmentVos = new ArrayList<MeetingAttachmentVo>();
        for (MmsConferenceAttachmentEntity attachmentEntity : attachmentEntities) {
            attachmentVos.add(new MeetingAttachmentVo().buildVo(attachmentEntity));
        }
        return attachmentVos;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public CommonVO deleteMeetingsAttachment(String id) {
        CommonVO vo = new CommonVO();
        try {
            MmsConferenceAttachmentEntity entity = mmsConferenceAttachmentRepository.findOne(id);
            MmsConferenceMainEntity mainEntity = meetingsRepository.findOne(entity.getConferenceId());
            if (mainEntity == null) {
                throw new NullPointerException("会议主记录为空.");
            }
            vo.setResult(fileService.delFileForLocal(entity.getName(), MeetingsConstants.UPLOAD_TYPE_ATTACH, entity.getConferenceId()));
            if (vo.isResult()) {
                mmsConferenceAttachmentRepository.delete(entity);
            } else {
                vo.setMsg("删除会议附件失败");
            }
        } catch (Exception e) {
            LOG.error("删除会议附件失败.", e);
            vo.setResult(false);
            vo.setMsg("删除会议附件失败[" + e.getMessage() + "]");
        }
        return vo;
    }
}
