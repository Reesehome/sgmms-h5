package com.tisson.sgmms.meetings.specification;

import com.tisson.sgmms.meetings.entity.MmsConferenceMainEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;
import java.util.Collection;

public final class ConferenceMainSpecifications {

    public static class ConferenceId implements Specification<MmsConferenceMainEntity> {

        private String conferenceId;

        public ConferenceId(@NotNull String conferenceId) {
            this.conferenceId = conferenceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMainEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("id"), conferenceId);
        }
    }

    public static class ConferenceIds implements Specification<MmsConferenceMainEntity> {

        private Collection<String> conferenceIds;

        public ConferenceIds(@NotNull Collection<String> conferenceIds) {
            this.conferenceIds = conferenceIds;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMainEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            CriteriaBuilder.In<String> predicate = criteriaBuilder.in(root.<String>get("id"));
            for (String conferenceId : conferenceIds) {
                predicate.value(conferenceId);
            }
            return predicate;
        }
    }

    public static class ConferenceCode implements Specification<MmsConferenceMainEntity> {

        private String conferenceCode;

        public ConferenceCode(@NotNull String conferenceCode) {
            this.conferenceCode = conferenceCode;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMainEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("code"), conferenceCode);
        }
    }

    public static class Enabled implements Specification<MmsConferenceMainEntity> {

        private String enabled;

        public Enabled(@NotNull String enabled) {
            this.enabled = enabled;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceMainEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("enabled"), enabled);
        }
    }
}
