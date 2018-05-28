package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceDetailEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MmsConferenceDetailRepository extends JpaRepository<MmsConferenceDetailEntity, String>, JpaSpecificationExecutor<MmsConferenceDetailEntity> {

    MmsConferenceDetailEntity findByConferenceId(String conferenceId);

}
