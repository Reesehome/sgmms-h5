package com.tisson.sgmms.meetings.specification;

import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;

public final class ConferenceMealSpecifications {

    public static class ConferenceId implements Specification<MmsConferenceMealEntity> {

        private String conferenceId;

        public ConferenceId(@NotNull String conferenceId) {
            this.conferenceId = conferenceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("conferenceId"), conferenceId);
        }
    }

    public static class MealId implements Specification<MmsConferenceMealEntity> {

        private String mealId;

        public MealId(@NotNull String mealId) {
            this.mealId = mealId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMealEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("id"), mealId);
        }
    }
}
