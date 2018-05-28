package com.tisson.sgmms.log.repository;

import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MmsLogMealRepository extends JpaRepository<MmsLogMealEntity, String>, JpaSpecificationExecutor<MmsLogMealEntity> {

    List<MmsLogMealEntity> findByMealId(String mealId);

}
