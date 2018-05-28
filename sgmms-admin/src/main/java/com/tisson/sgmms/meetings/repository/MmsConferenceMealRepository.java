package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceMealEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MmsConferenceMealRepository extends JpaRepository<MmsConferenceMealEntity, String>, JpaSpecificationExecutor<MmsConferenceMealEntity> {

    @Query("from MmsConferenceMealEntity where conferenceId=:conferenceId order by beginTime asc")
    List<MmsConferenceMealEntity> findByConferenceId(@Param("conferenceId") String conferenceId);

}
