package com.tisson.sgmms.log.service;

import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.log.entity.MmsLogAttendanceEntity;
import com.tisson.sgmms.log.repository.MmsLogAttendanceRepository;
import com.tisson.sgmms.log.specification.LogAttendanceSpecifications;
import com.tisson.sgmms.meetings.entity.MmsConferenceAttendanceEntity;
import com.tisson.sgmms.meetings.repository.MmsConferenceAttendanceRepository;
import com.tisson.tds.common.utils.IndexGenerator;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.domain.Specifications;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class MmsLogAttendanceServiceImpl implements MmsLogAttendanceService {

    @Autowired
    private MmsConferenceAttendanceRepository conferenceAttendanceRepository;

    @Autowired
    private MmsLogAttendanceRepository logAttendanceRepository;

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsLogAttendanceEntity> findAll(Specification<MmsLogAttendanceEntity> specification) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return logAttendanceRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsLogAttendanceEntity addLogAttendance(String attendance_id, String location, Double lat, Double lng) {
        Authentication authentication = Authentication.getCurrent();
        String user_id = authentication.getSubject();
        Specification<MmsLogAttendanceEntity> specification = Specifications
                .where(new LogAttendanceSpecifications.UserId(user_id))
                .and(new LogAttendanceSpecifications.AttendanceId(attendance_id));
        List<MmsLogAttendanceEntity> logAttendances = logAttendanceRepository.findAll(specification, new Sort(Sort.Direction.ASC, "arrivalTime"));
        if (CollectionUtils.isEmpty(logAttendances)) {
            Date arrival_time = new Date();
            MmsLogAttendanceEntity logAttendance = new MmsLogAttendanceEntity();
            logAttendance.setId(IndexGenerator.generatorId());
            logAttendance.setAttendanceId(attendance_id);
            logAttendance.setLat(lat);
            logAttendance.setLng(lng);

            logAttendance.setArrivalTime(arrival_time);
            logAttendance.setLocation(location);
            logAttendance.setUserId(user_id);

            MmsConferenceAttendanceEntity conferenceAttendance = conferenceAttendanceRepository.findOne(attendance_id);
            if (conferenceAttendance == null) {
                throw new IllegalArgumentException();
            }
            if (arrival_time.before(conferenceAttendance.getLatenessBeginTime())) {
                logAttendance.setLateness("N");
            } else {
                logAttendance.setLateness("Y");
            }
            logAttendanceRepository.save(logAttendance);
            return logAttendance;
        }
        return logAttendances.get(0);
    }
}
