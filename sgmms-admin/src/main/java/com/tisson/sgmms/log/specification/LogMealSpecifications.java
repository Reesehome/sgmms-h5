package com.tisson.sgmms.log.specification;

import com.tisson.sgmms.log.entity.MmsLogMealEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;

public class LogMealSpecifications {

    public static class MealId implements Specification<MmsLogMealEntity> {

        private String mealId;

        public MealId(@NotNull String mealId) {
            this.mealId = mealId;
        }

        @Override
        public Predicate toPredicate(Root<MmsLogMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("mealId"), mealId);
        }
    }

    public static class UserId implements Specification<MmsLogMealEntity> {

        private String userId;

        public UserId(@NotNull String userId) {
            this.userId = userId;
        }


        @Override
        public Predicate toPredicate(Root<MmsLogMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("userId"), userId);
        }
    }
}
