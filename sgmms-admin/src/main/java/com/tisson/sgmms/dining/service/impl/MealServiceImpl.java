package com.tisson.sgmms.dining.service.impl;

import com.tisson.sgmms.dining.service.MealService;
import com.tisson.sgmms.dining.vo.MealVo;
import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import com.tisson.sgmms.log.repository.MmsLogMealRepository;
import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import com.tisson.sgmms.meetings.repository.MmsConferenceMealRepository;
import com.tisson.tds.common.web.PageJqgrid;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * MealServiceImpl is 会议就餐
 *
 * @author QIAN
 * @since 2018/5/22 9:22
 */
@Service
public class MealServiceImpl implements MealService {


    @Autowired
    private MmsLogMealRepository mmsLogMealRepository;

    @Autowired
    private MmsConferenceMealRepository mmsConferenceMealRepository;
    
    /**
     * 分页查询就餐
     * @param vo
     * @param page
     * @return
     */
    @Override
    public PageJqgrid<MealVo> queryMealPage(final MealVo vo, PageJqgrid <MealVo> page) {
        final List <MmsConferenceMealEntity> mmsConferenceMealEntitieList = queryMmsConferenceMealEntitieList(vo);
        PageJqgrid<MealVo> pageJQgrid = new PageJqgrid<>();
        Specification <MmsLogMealEntity> specification = queryCondition(vo, mmsConferenceMealEntitieList);
        if (mmsConferenceMealEntitieList != null && mmsConferenceMealEntitieList.size() > 0) {
            PageJqgrid <MmsLogMealEntity> tmp = new PageJqgrid <MmsLogMealEntity>();
            tmp.initResult(mmsLogMealRepository.findAll(specification, page.convertToPageRequest()));
            List <MealVo> mealVoList = initResult(tmp.getRows());
            BeanUtils.copyProperties(tmp, pageJQgrid);
            pageJQgrid.setRows(mealVoList);
        }
        return pageJQgrid;
    }

    /**
     * 查询会议就餐
     * @param vo
     * @return
     */
    @Override
    public List <MealVo> queryMealList(final MealVo vo) {
        final List <MmsConferenceMealEntity> mmsConferenceMealEntitieList = queryMmsConferenceMealEntitieList(vo);
        List <MealVo> mealVoList = null;
        Specification <MmsLogMealEntity> specification = queryCondition(vo, mmsConferenceMealEntitieList);
        if (mmsConferenceMealEntitieList != null && mmsConferenceMealEntitieList.size() > 0) {
            List <MmsLogMealEntity> mmsLogMealEntityList = mmsLogMealRepository.findAll(specification);
            mealVoList = initResult(mmsLogMealEntityList);
            return mealVoList;
        }
        return new ArrayList <MealVo>();
    }


    /**
     * 日期转String类型
     * @param date
     * @param pattern
     * @return
     */
    private String dateToString(Date date, String pattern) {
        DateFormat dFormat = new SimpleDateFormat(pattern); //HH表示24小时制；

        if (date != null) {
            return dFormat.format(date);
        }
        return "";
    }

    /**
     * 根据会议编号查询会议就餐
     * @param mealVo
     * @return
     */
    private final List<MmsConferenceMealEntity> queryMmsConferenceMealEntitieList(MealVo mealVo) {
        List <MmsConferenceMealEntity> mmsConferenceMealEntitieList = null;

        if (StringUtils.isNotEmpty(mealVo.getConferenceId())) {
            mmsConferenceMealEntitieList = mmsConferenceMealRepository.findByConferenceId(mealVo.getConferenceId());
        }

        return mmsConferenceMealEntitieList;
    }


    /**
     * 初始化查询条件
     * @param vo
     * @param mmsConferenceMealEntitieList
     * @return
     */
    private Specification<MmsLogMealEntity> queryCondition(final MealVo vo, final List <MmsConferenceMealEntity> mmsConferenceMealEntitieList) {
        Specification<MmsLogMealEntity> specification = new Specification<MmsLogMealEntity>() {
            @Override
            public Predicate toPredicate(Root<MmsLogMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<>();

                if (StringUtils.isNotBlank(vo.getUserName())) {
                    list.add(criteriaBuilder.like(root.get("userName").as(String.class), "%" + vo.getUserName() + "%"));
                }

                if (StringUtils.isNotBlank(vo.getUserPhone())) {
                    list.add(criteriaBuilder.like(root.get("userPhone").as(String.class), "%" + vo.getUserPhone() + "%"));
                }

                CriteriaBuilder.In<Object> in = criteriaBuilder.in(root.get("id"));
                if (mmsConferenceMealEntitieList != null && mmsConferenceMealEntitieList.size() > 0) {
                    for (MmsConferenceMealEntity mmsConferenceMealEntity : mmsConferenceMealEntitieList) {
                        in.value(mmsConferenceMealEntity.getId());
                    }
                    list.add(in);
                }
                criteriaQuery.orderBy(criteriaBuilder.desc(root.get("mealTime")));
                Predicate[] predicates = new Predicate[list.size()];
                predicates = list.toArray(predicates);
                CriteriaQuery<?> cq = criteriaQuery.where(list.toArray(predicates));
                return cq.getRestriction();
            }
        };

        return specification;
    }

    /**
     * 查询结果处理
     * @param mmsLogMealEntityList
     * @return
     */
    private List <MealVo> initResult(List <MmsLogMealEntity> mmsLogMealEntityList) {
        List <MealVo> mealVoList = new ArrayList <MealVo>();
        for (MmsLogMealEntity mmsLogMealEntity : mmsLogMealEntityList) {
            MealVo mealVo = new MealVo();
            mealVo.setUserPhone(mmsLogMealEntity.getUserPhone()); // 手机号
            mealVo.setUserName(mmsLogMealEntity.getUserName()); // 姓名
            mealVo.setDate(dateToString(mmsLogMealEntity.getMealTime(), "yyyy-MM-dd")); // 就餐日期
            mealVo.setTime(dateToString(mmsLogMealEntity.getMealTime(), "yyyy-MM-dd HH:mm:ss")); // 就餐时间

            if (mmsLogMealEntity.getMmsConferenceMealEntity() != null) {
                MmsConferenceMealEntity mmsConferenceMealEntity = mmsLogMealEntity.getMmsConferenceMealEntity();
                mealVo.setName(mmsConferenceMealEntity.getName()); // 就餐名称
                mealVo.setLocation(mmsConferenceMealEntity.getLocation()); // 就餐地点
                String timeSlot = dateToString(mmsConferenceMealEntity.getBeginTime(), "HH:mm:ss") + "~" + dateToString(mmsConferenceMealEntity.getEndTime(), "HH:mm:ss");
                mealVo.setTimeSlot(timeSlot); // 就餐时间段

            }
            mealVoList.add(mealVo);
        }

        return mealVoList;
    }

}
