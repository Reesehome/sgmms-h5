package com.tisson.sgmms.customer.service;

import com.tisson.sgmms.customer.entity.MmsCustomerCompanyEntity;
import com.tisson.sgmms.customer.vo.MmsCustomerCompanyBean;

import java.util.List;

public interface MmsCustomerCompanyService {

    MmsCustomerCompanyEntity findById(String id);

    List<MmsCustomerCompanyEntity> findByParentId(String id);

    void save(MmsCustomerCompanyEntity customerCompany);

    void delete(String id);

    /**
     * 查找所有公司
     *
     * @return
     */
    List<MmsCustomerCompanyBean> findAll();
}
