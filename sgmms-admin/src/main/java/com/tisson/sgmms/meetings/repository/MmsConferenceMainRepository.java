package com.tisson.sgmms.meetings.repository;

import com.tisson.sgmms.meetings.entity.MmsConferenceMainEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MmsConferenceMainRepository extends JpaRepository<MmsConferenceMainEntity, String>, JpaSpecificationExecutor<MmsConferenceMainEntity> {

    List<MmsConferenceMainEntity> queryMeetingByCode(String code);
}
