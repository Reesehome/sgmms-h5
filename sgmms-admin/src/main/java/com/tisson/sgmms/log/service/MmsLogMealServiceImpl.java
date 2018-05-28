package com.tisson.sgmms.log.service;

import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import com.tisson.sgmms.log.repository.MmsLogMealRepository;
import com.tisson.sgmms.log.specification.LogMealSpecifications;
import com.tisson.tds.common.utils.IndexGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

import static org.springframework.data.jpa.domain.Specifications.where;

@Service
public class MmsLogMealServiceImpl implements MmsLogMealService {

    @Autowired
    private MmsLogMealRepository logMealRepository;

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsLogMealEntity> findAll(@NotNull Specification<MmsLogMealEntity> specification) {
        return logMealRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsLogMealEntity addLogMeal(String meal_id) {
        Authentication authentication = Authentication.getCurrent();
        String user_id = authentication.getSubject();
        Specification<MmsLogMealEntity> specification = where(new LogMealSpecifications.MealId(meal_id))
                .and(new LogMealSpecifications.UserId(user_id));
        long total_scan = logMealRepository.count(specification);
        MmsLogMealEntity enitty = new MmsLogMealEntity();
        enitty.setId(IndexGenerator.generatorId());
        enitty.setMealId(meal_id);
        enitty.setMealTime(new Date());
        enitty.setUserId(user_id);
        enitty.setTotalScan(total_scan + 1);
        logMealRepository.saveAndFlush(enitty);
        return enitty;
    }
}
