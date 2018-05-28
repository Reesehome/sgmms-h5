package com.tisson.sgmms.log.service;

import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface MmsLogMealService {

    /**
     * <p>
     *     检索记录
     * </p>
     */
    List<MmsLogMealEntity> findAll(Specification<MmsLogMealEntity> specification);

    /**
     * <p>
     *     就餐
     * </p>
     */
    MmsLogMealEntity addLogMeal(String meal_id);
}
