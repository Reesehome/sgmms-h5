package com.tisson.sgmms.meetings.service;

import com.tisson.sgmms.meetings.entity.*;
import com.tisson.sgmms.meetings.repository.MmsConferenceMainRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface MmsConferenceService {

    MmsConferenceMainEntity getConferenceMain(String conferenceId);

    MmsConferenceDetailEntity getConferenceDetail(String conferenceId);

    List<MmsConferenceMainEntity> findConferenceMains(Specification<MmsConferenceMainEntity> specification);

    List<MmsConferenceMainEntity> findConferenceMains(Specification<MmsConferenceMainEntity> specification, Sort sort);

    List<MmsConferenceUserEntity> findConferenceUsers(Specification<MmsConferenceUserEntity> specification);

    Page<MmsConferenceUserEntity> findConferenceUsers(Specification<MmsConferenceUserEntity> specification, Pageable pageable);

    List<MmsConferenceMealEntity> findConferenceMeals(Specification<MmsConferenceMealEntity> specification);

    List<MmsConferenceAttachmentEntity> findConferenceAttachments(Specification<MmsConferenceAttachmentEntity> specification, Sort sort);

    List<MmsConferenceAttendanceEntity> findConferenceAttendances(Specification<MmsConferenceAttendanceEntity> specification);

    List<MmsConferenceAttendanceEntity> findConferenceAttendances(Specification<MmsConferenceAttendanceEntity> specification, Sort sort);
}
