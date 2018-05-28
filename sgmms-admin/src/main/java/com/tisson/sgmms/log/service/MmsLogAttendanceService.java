package com.tisson.sgmms.log.service;

import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface MmsLogAttendanceService {

    /**
     * <p>
     *     检索记录
     * </p>
     */
    List<MmsLogAttendanceEntity> findAll(Specification<MmsLogAttendanceEntity> specification);

    /**
     * <p>
     *     签到
     * </p>
     */
    MmsLogAttendanceEntity addLogAttendance(String attendance_id, String location, Double lat, Double lng);
}
