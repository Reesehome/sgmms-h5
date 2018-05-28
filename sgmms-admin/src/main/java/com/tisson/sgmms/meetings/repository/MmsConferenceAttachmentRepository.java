package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceAttachmentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MmsConferenceAttachmentRepository extends JpaRepository<MmsConferenceAttachmentEntity, String>, JpaSpecificationExecutor<MmsConferenceAttachmentEntity> {

/*
    List<MmsConferenceAttachmentEntity> findByConferenceId(String conferenceId);
*/

    @Query("from MmsConferenceAttachmentEntity where conferenceId=:conferenceId order by createOn asc")
    List<MmsConferenceAttachmentEntity> findByConferenceId(@Param("conferenceId") String conferenceId);

}
