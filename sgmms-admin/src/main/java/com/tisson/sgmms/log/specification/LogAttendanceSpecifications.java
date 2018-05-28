package com.tisson.sgmms.log.specification;

import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;
import java.util.Collection;

public class LogAttendanceSpecifications {

    public static class AttendanceId implements Specification<MmsLogAttendanceEntity> {

        private String attendanceId;

        public AttendanceId(@NotNull String attendanceId) {
            this.attendanceId = attendanceId;
        }

        @Override
        public Predicate toPredicate(Root<MmsLogAttendanceEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("attendanceId"), attendanceId);
        }
    }

    public static class AttendanceIds implements Specification<MmsLogAttendanceEntity> {

        private Collection<String> attendanceIds;

        public AttendanceIds(@NotNull Collection<String> attendanceIds) {
            this.attendanceIds = attendanceIds;
        }

        @Override
        public Predicate toPredicate(Root<MmsLogAttendanceEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            CriteriaBuilder.In<String> predicate = criteriaBuilder.in(root.<String>get("attendanceId"));
            for (String conferenceId : attendanceIds) {
                predicate.value(conferenceId);
            }
            return predicate;
        }
    }

    public static class UserId implements Specification<MmsLogAttendanceEntity> {

        private String userId;

        public UserId(@NotNull String userId) {
            this.userId = userId;
        }


        @Override
        public Predicate toPredicate(Root<MmsLogAttendanceEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("userId"), userId);
        }
    }
}
