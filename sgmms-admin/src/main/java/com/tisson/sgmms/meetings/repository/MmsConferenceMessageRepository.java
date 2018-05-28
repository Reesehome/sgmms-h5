package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceMessageEntity;
import com.tisson.sgmms.meetings.entity.MmsConferenceUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MmsConferenceMessageRepository extends JpaRepository<MmsConferenceMessageEntity, String>, JpaSpecificationExecutor<MmsConferenceMessageEntity> {

}
