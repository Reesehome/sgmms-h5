package com.tisson.sgmms.meetings.specification;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttachmentEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;

public final class ConferenceAttachmentSpecifications {

    public static class ConferenceId implements Specification<MmsConferenceAttachmentEntity> {

        private String conferenceId;

        public ConferenceId(@NotNull String conferenceId) {
            this.conferenceId = conferenceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceAttachmentEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("conferenceId"), conferenceId);
        }
    }
}
