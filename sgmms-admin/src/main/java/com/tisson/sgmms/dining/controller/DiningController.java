package com.tisson.sgmms.dining.controller;


import com.tisson.sgmms.dining.service.MealService;
import com.tisson.sgmms.dining.vo.MealVo;
import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import com.tisson.sgmms.meetings.service.MeetingsService;
import com.tisson.sgmms.meetings.service.MmsConferenceService;
import com.tisson.sgmms.meetings.vo.MmsConferenceMainVo;
import com.tisson.tds.common.utils.poiUtils.ExportExcel;
import com.tisson.tds.common.utils.poiUtils.ExportExcelUtilFactory;
import com.tisson.tds.common.web.PageJqgrid;
import com.tisson.tds.common.web.Result;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * <p>
 * <b>DiningController</b> is 就餐管理,会议就餐
 * </p>
 *
 * @author QIAN
 * @since 2018/5/9
 */
@Controller
@RequestMapping("/admin/dining")
public class DiningController {

    private final Logger LOGGER = LoggerFactory.getLogger(DiningController.class);

    @Autowired
    private MeetingsService meetingsService;

    @Autowired
    private MmsConferenceService mmsConferenceService;

    @Autowired
    private MealService mealService;

    /**
     * 就餐管理
     * @return
     */
    @RequestMapping(value = {"", "/", "/manager.do"}, method = RequestMethod.GET)
    public String manager(Model model) {
        return "admin/dining/diningManager.jsp";
    }

    /**
     * 会议就餐
     * @return
     */
    @RequestMapping(value = "meeting.do", method = RequestMethod.GET)
    public ModelAndView meeting(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        String meetingCode = request.getParameter("meetingCode");   // 会议编号

        if (StringUtils.isNotEmpty(meetingCode)) {
            MmsConferenceMainVo mmsConferenceMainVo = meetingsService.queryMeetingByCode(meetingCode);
            modelAndView.addObject("mmsConferenceMain", mmsConferenceMainVo);

            final String conferenceId = mmsConferenceMainVo.getId();
            Specification<MmsConferenceMealEntity> specification = new Specification <MmsConferenceMealEntity>() {

                @Override
                public Predicate toPredicate(Root<MmsConferenceMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                    List<Predicate> list = new ArrayList<>();
                    if (StringUtils.isNotBlank(conferenceId)) {
                        list.add(criteriaBuilder.like(root.get("conferenceId").as(String.class), conferenceId));
                    }
                    criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createOn")));
                    Predicate[] predicates = new Predicate[list.size()];
                    predicates = list.toArray(predicates);
                    CriteriaQuery<?> cq = criteriaQuery.where(list.toArray(predicates));
                    return cq.getRestriction();
                }
            };
            List <MmsConferenceMealEntity> mmsConferenceMealEntitiesList = mmsConferenceService.findConferenceMeals(specification);

            if (mmsConferenceMealEntitiesList != null && mmsConferenceMealEntitiesList.size() > 0) {
                for (MmsConferenceMealEntity mmsConferenceMealEntity : mmsConferenceMealEntitiesList) {
                    Date beginTime = mmsConferenceMealEntity.getBeginTime();
                    Date endTime = mmsConferenceMealEntity.getEndTime();
                    Map <String, List <MmsConferenceMealEntity>> map = new HashMap <>();
                }
            }


            modelAndView.addObject("mmsConferenceMealEntitiesList", mmsConferenceMealEntitiesList);
        }
        modelAndView.setViewName("admin/dining/meetingDining.jsp");
        return modelAndView;
    }


    /**
     * 分页查询就餐管理列表信息
     *
     * @param vo
     * @param page
     * @return
     */
    @RequestMapping({"queryMealPage"})
    @ResponseBody
    public PageJqgrid<MealVo> queryMealPage(MealVo vo, PageJqgrid<MealVo> page) {
        try {
            PageJqgrid<MealVo> resultPage = mealService.queryMealPage(vo, page);
            resultPage.setResult(new Result("数据加载成功", true));
            return resultPage;
        } catch (Exception e) {
            e.printStackTrace();
            LOGGER.error("分页查询就餐管理列表信息", e);
            page.setResult(new Result("分页查询就餐管理列表信息", false));
            return page;
        }
    }

    /**
     * 导出会议就餐列表
     * @param mealVo
     * @param response
     */
    @RequestMapping({"exportMeal.do"})
    public void exportMeal(MealVo mealVo, HttpServletResponse response) {
        ServletOutputStream out = null;

        try {
            List<MealVo> mealVoList = mealService.queryMealList(mealVo);
            ExportExcel utils = ExportExcelUtilFactory.generateUtils("gt2003");
            String[] header = new String[]{"姓名", "手机号", "就餐日期", "就餐名称", "就餐时间段", "就餐时间", "就餐地点"};
            String[] properties = new String[]{"userName", "userPhone", "date", "name", "timeSlot", "time", "location"};
            utils.generateExcel("会议就餐", header, properties, mealVoList, MealVo.class);
            response.setHeader("Content-Disposition", "attachment;filename=Meal%20List%20Records" + utils.getSuffix());
            response.setContentType("application/x-download");
            response.setCharacterEncoding("gb2312");
            out = response.getOutputStream();
            utils.export(out);
        } catch (Exception var9) {
            this.LOGGER.error("导出会议就餐列表失败", var9);
        }

    }

}
