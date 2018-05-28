package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttendanceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MmsConferenceAttendanceRepository extends JpaRepository<MmsConferenceAttendanceEntity, String>, JpaSpecificationExecutor<MmsConferenceAttendanceEntity> {

    @Query("from MmsConferenceAttendanceEntity where conferenceId=:conferenceId order by beginTime asc")
    List<MmsConferenceAttendanceEntity> findByConferenceId(@Param("conferenceId") String conferenceId);

}
