package com.tisson.sgmms.log.repository;

import com.tisson.sgmms.log.entity.MmsLogMessageEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MmsLogMessageRepository extends JpaRepository<MmsLogMessageEntity, String>, JpaSpecificationExecutor<MmsLogMessageEntity> {
}
