package com.tisson.sgmms.log.repository;

import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface MmsLogAttendanceRepository extends JpaRepository<MmsLogAttendanceEntity, String>, JpaSpecificationExecutor<MmsLogAttendanceEntity> {

    List<MmsLogAttendanceEntity> findByAttendanceId(String attendanceId);

}
