package com.tisson.sgmms.meetings.service.impl;

import com.tisson.sgmms.meetings.entity.*;
import com.tisson.sgmms.meetings.repository.*;
import com.tisson.sgmms.meetings.service.MmsConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.List;

@Service
public class MmsConferenceServiceImpl implements MmsConferenceService {

    @Autowired
    private MmsConferenceMainRepository conferenceMainRepository;

    @Autowired
    private MmsConferenceDetailRepository conferenceDetailRepository;

    @Autowired
    private MmsConferenceUserRepository conferenceUserRepository;

    @Autowired
    private MmsConferenceMealRepository conferenceMealRepository;

    @Autowired
    private MmsConferenceAttachmentRepository conferenceAttachmentRepository;

    @Autowired
    private MmsConferenceAttendanceRepository conferenceAttendanceRepository;

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsConferenceMainEntity getConferenceMain(@NotNull String conferenceId) {
        return conferenceMainRepository.findOne(conferenceId);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsConferenceDetailEntity getConferenceDetail(@NotNull String conferenceId) {
        return conferenceDetailRepository.findOne(conferenceId);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceMainEntity> findConferenceMains(Specification<MmsConferenceMainEntity> specification, Sort sort) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceMainRepository.findAll(specification, sort);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceMainEntity> findConferenceMains(Specification<MmsConferenceMainEntity> specification) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceMainRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceUserEntity> findConferenceUsers(Specification<MmsConferenceUserEntity> specification) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceUserRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Page<MmsConferenceUserEntity> findConferenceUsers(Specification<MmsConferenceUserEntity> specification, Pageable pageable) {
        if (specification == null || pageable == null) {
            throw new IllegalArgumentException();
        }
        return conferenceUserRepository.findAll(specification, pageable);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceMealEntity> findConferenceMeals(Specification<MmsConferenceMealEntity> specification) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceMealRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceAttachmentEntity> findConferenceAttachments(Specification<MmsConferenceAttachmentEntity> specification, Sort sort) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceAttachmentRepository.findAll(specification, sort);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceAttendanceEntity> findConferenceAttendances(Specification<MmsConferenceAttendanceEntity> specification) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceAttendanceRepository.findAll(specification);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsConferenceAttendanceEntity> findConferenceAttendances(Specification<MmsConferenceAttendanceEntity> specification, Sort sort) {
        if (specification == null) {
            throw new IllegalArgumentException();
        }
        return conferenceAttendanceRepository.findAll(specification, sort);
    }
}
