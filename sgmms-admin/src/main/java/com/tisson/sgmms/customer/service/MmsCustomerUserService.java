package com.tisson.sgmms.customer.service;

import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.vo.MmsCustomerUserVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import java.util.Collection;
import java.util.List;

public interface MmsCustomerUserService {

    MmsCustomerUserEntity findOne(String userId);

    List<MmsCustomerUserVo> findUserByCompanyId(String companyId);

    Page<MmsCustomerUserEntity> findAll(Specification<MmsCustomerUserEntity> specification, Pageable pageable);

    List<MmsCustomerUserEntity> findAll(Specification<MmsCustomerUserEntity> specification, Sort sort);

    void bulkDelete(Collection<String> userIds);

    void save(MmsCustomerUserEntity customerUser);
}
