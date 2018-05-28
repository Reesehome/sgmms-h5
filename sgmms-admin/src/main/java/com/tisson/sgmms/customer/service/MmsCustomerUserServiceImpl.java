package com.tisson.sgmms.customer.service;

import com.tisson.sgmms.api.security.Authentication;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.repository.MmsCustomerUserRepository;
import com.tisson.sgmms.customer.vo.MmsCustomerUserVo;
import com.tisson.tds.api.AppContext;
import com.tisson.tds.api.vo.User;
import com.tisson.tds.common.utils.IndexGenerator;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import static org.apache.commons.lang3.StringUtils.isBlank;

@Service
public class MmsCustomerUserServiceImpl implements MmsCustomerUserService {

    @Resource
    private MmsCustomerUserRepository customerUserRepository;

    @Autowired
    private MapperFactory mapperFactory;

    @Autowired
    private AppContext appContext;

    /**
     * 根据主键获取数据
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public MmsCustomerUserEntity findOne(@NotNull String userId) {
        return customerUserRepository.findOne(userId);
    }

    /**
     * @author 刘波
     */
    @Override
    public List<MmsCustomerUserVo> findUserByCompanyId(final String companyId) {
        Specification<MmsCustomerUserEntity> specification = new Specification<MmsCustomerUserEntity>() {
            @Override
            public Predicate toPredicate(Root<MmsCustomerUserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                Predicate predicate = criteriaBuilder.equal(root.get("companyId").as(String.class), companyId);
                predicates.add(predicate);
                CriteriaQuery<?> cq = criteriaQuery.where(predicates.toArray(new Predicate[predicates.size()]));
                return cq.getRestriction();
            }
        };
        Sort sort = new Sort(Sort.Direction.DESC, "createOn");
        mapperFactory
                .classMap(MmsCustomerUserEntity.class, MmsCustomerUserVo.class)
                .byDefault()
                .register();
        MapperFacade mapperFacade = mapperFactory.getMapperFacade();
        return mapperFacade.mapAsList(customerUserRepository.findAll(specification, sort), MmsCustomerUserVo.class);
    }

    /**
     * 根据动态条件查询数据，分页
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Page<MmsCustomerUserEntity> findAll(Specification<MmsCustomerUserEntity> specification, Pageable pageable) {
        return customerUserRepository.findAll(specification, pageable);
    }

    /**
     * 根据动态条件查询数据
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<MmsCustomerUserEntity> findAll(Specification<MmsCustomerUserEntity> specification, Sort sort) {
        return customerUserRepository.findAll(specification, sort);
    }

    /**
     * 批量删除数据
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void bulkDelete(Collection<String> userIds) {
        if (CollectionUtils.isEmpty(userIds)) {
            throw new IllegalArgumentException();
        }
        customerUserRepository.bulkDelete(userIds);
    }

    /**
     * 增加或更新用户
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void save(MmsCustomerUserEntity customerUser) {
        User user = appContext.getUser();
        customerUser.setUpdateBy(user.getId());
        customerUser.setUpdateOn(new Date());

        if (isBlank(customerUser.getId())) {
            customerUser.setId(IndexGenerator.generatorId());
            customerUser.setCreateBy(customerUser.getUpdateBy());
            customerUser.setCreateOn(customerUser.getUpdateOn());
            customerUser.setEnabled("Y");
            customerUserRepository.save(customerUser);
        } else {
            MmsCustomerUserEntity entity = customerUserRepository.findOne(customerUser.getId());
            MapperFacade mapperFacade = mapperFactory.getMapperFacade();
            mapperFacade.map(customerUser, entity);
        }
    }
}
