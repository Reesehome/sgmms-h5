package com.tisson.sgmms.customer.repository;

import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;

public interface MmsCustomerUserRepository extends JpaRepository<MmsCustomerUserEntity, String>, JpaSpecificationExecutor<MmsCustomerUserEntity> {

    @Query(value = "update mms_customer_user set enabled = 'N' where id in (:userIds)", nativeQuery = true)
    @Modifying
    void bulkDelete(@Param("userIds") Collection<String> userIds);
}
