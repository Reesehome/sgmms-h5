package com.tisson.sgmms.dining.service;

import com.tisson.sgmms.dining.vo.MealVo;
import com.tisson.tds.common.web.PageJqgrid;

import java.util.List;

/**
 * MealService is
 *
 * @author QIAN
 * @since 2018/5/22 9:21
 */
public interface MealService {

    /**
     * 分页查询就餐
     * @param vo
     * @param page
     * @return
     */
    PageJqgrid<MealVo> queryMealPage(MealVo vo, PageJqgrid<MealVo> page);

    /**
     * 查询会议就餐
     * @param mealVo
     * @return
     */
    List<MealVo> queryMealList(MealVo mealVo);
}
