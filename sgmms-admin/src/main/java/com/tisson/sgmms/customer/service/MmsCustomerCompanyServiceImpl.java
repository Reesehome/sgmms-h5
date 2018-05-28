package com.tisson.sgmms.customer.service;

import com.tisson.sgmms.customer.entity.MmsCustomerCompanyEntity;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.repository.MmsCustomerCompanyRepository;
import com.tisson.sgmms.customer.repository.MmsCustomerUserRepository;
import com.tisson.sgmms.customer.specification.CustomerUserSpecification;
import com.tisson.sgmms.customer.vo.MmsCustomerCompanyBean;
import com.tisson.tds.api.AppContext;
import com.tisson.tds.api.vo.User;
import com.tisson.tds.common.utils.IndexGenerator;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isNotBlank;

@Service
public class MmsCustomerCompanyServiceImpl implements MmsCustomerCompanyService {

    @Autowired
    private MmsCustomerCompanyRepository customerCompanyRepository;

    @Autowired
    private MmsCustomerUserRepository customerUserRepository;

    @Autowired
    private MapperFactory mapperFactory;

    @Autowired
    private AppContext appContext;

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public MmsCustomerCompanyEntity findById(@NotNull String id) {
        return customerCompanyRepository.getOne(id);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public List<MmsCustomerCompanyEntity> findByParentId(final String parentId) {
        Specification<MmsCustomerCompanyEntity> specification = new Specification<MmsCustomerCompanyEntity>() {
            @Override
            public Predicate toPredicate(Root<MmsCustomerCompanyEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                if (isNotBlank(parentId)) {
                    return criteriaBuilder.equal(root.get("parentId"), parentId);
                } else {
                    return criteriaBuilder.isNull(root.get("parentId"));
                }
            }
        };
        Sort sort = new Sort(Sort.Direction.DESC, "createOn");
        return customerCompanyRepository.findAll(specification, sort);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void save(@NotNull MmsCustomerCompanyEntity customerCompany) {
        if (isBlank(customerCompany.getParentId())) {
            throw new UnsupportedOperationException("根节点不能编辑");
        }
        if (isBlank(customerCompany.getId())) {
            customerCompany.setId(IndexGenerator.generatorId());
        }
        User user = appContext.getUser();
        customerCompany.setCreateBy(user.getId());
        customerCompany.setUpdateBy(user.getId());
        Date rightNow = new Date();
        customerCompany.setUpdateOn(rightNow);
        customerCompany.setCreateOn(rightNow);
        customerCompanyRepository.save(customerCompany);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void delete(@NotNull String id) {
        if (customerUserRepository.count(new CustomerUserSpecification.CompanyId(id)) > 0) {
            throw new IllegalStateException("该组织下已有用户，不能删除。");
        }
        MmsCustomerCompanyEntity customerCompany = customerCompanyRepository.getOne(id);
        if (customerCompany != null) {
            if (isBlank(customerCompany.getParentId())) {
                throw new UnsupportedOperationException("根节点不能删除");
            }
            customerCompanyRepository.delete(id);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsCustomerCompanyBean> findAll() {
        Specification<MmsCustomerCompanyEntity> specification = new Specification<MmsCustomerCompanyEntity>() {
            @Override
            public Predicate toPredicate(Root<MmsCustomerCompanyEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                Predicate predicate = criteriaBuilder.equal(root.get("enabled"), "Y");
                predicates.add(predicate);
                CriteriaQuery<?> cq = criteriaQuery.where(predicates.toArray(new Predicate[predicates.size()]));
                return cq.getRestriction();
            }
        };
        Sort sort = new Sort(Sort.Direction.DESC, "createOn");
        mapperFactory
                .classMap(MmsCustomerCompanyEntity.class, MmsCustomerCompanyBean.class)
                .byDefault()
                .register();
        MapperFacade mapperFacade = mapperFactory.getMapperFacade();
        return mapperFacade.mapAsList(customerCompanyRepository.findAll(specification, sort), MmsCustomerCompanyBean.class);
    }
}
