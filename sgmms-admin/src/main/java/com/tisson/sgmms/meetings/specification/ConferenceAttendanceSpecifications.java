package com.tisson.sgmms.meetings.specification;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttendanceEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;

public final class ConferenceAttendanceSpecifications {

    public static class AttendanceId implements Specification<MmsConferenceAttendanceEntity> {

        private String attendanceId;

        public AttendanceId(@NotNull String attendanceId) {
            this.attendanceId = attendanceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceAttendanceEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("id"), attendanceId);
        }
    }

    public static class ConferenceId implements Specification<MmsConferenceAttendanceEntity> {

        private String conferenceId;

        public ConferenceId(@NotNull String conferenceId) {
            this.conferenceId = conferenceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsConferenceAttendanceEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("conferenceId"), conferenceId);
        }
    }
}
