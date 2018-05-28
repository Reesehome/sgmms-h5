package com.tisson.sgmms.customer.repository;

import com.tisson.sgmms.customer.entity.MmsCustomerCompanyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MmsCustomerCompanyRepository extends JpaRepository<MmsCustomerCompanyEntity, String>, JpaSpecificationExecutor<MmsCustomerCompanyEntity> {
}
