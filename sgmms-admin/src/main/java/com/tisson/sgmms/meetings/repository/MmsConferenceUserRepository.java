package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MmsConferenceUserRepository extends JpaRepository<MmsConferenceUserEntity, String>, JpaSpecificationExecutor<MmsConferenceUserEntity> {

    List<MmsConferenceUserEntity> findByConferenceId(String conferenceId);

}
