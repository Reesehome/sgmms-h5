package com.tisson.sgmms.customer.specification;

import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.validation.constraints.NotNull;

public class CustomerUserSpecification {

    public static class Mobile implements Specification<MmsCustomerUserEntity> {

        private String mobile;

        public Mobile(@NotNull String mobile) {
            this.mobile = mobile;
        }

        @Override
        public Predicate toPredicate(Root<MmsCustomerUserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("mobile"), mobile);
        }
    }

    public static class UserName implements Specification<MmsCustomerUserEntity> {

        private String userName;

        public UserName(@NotNull String userName) {
            this.userName = userName;
        }

        @Override
        public Predicate toPredicate(Root<MmsCustomerUserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("userName"), userName);
        }
    }

    public static class CompanyId implements Specification<MmsCustomerUserEntity> {

        private String companyId;

        public CompanyId(@NotNull String companyId) {
            this.companyId = companyId;
        }

        @Override
        public Predicate toPredicate(Root<MmsCustomerUserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("companyId"), companyId);
        }
    }

    public static class Enabled implements Specification<MmsCustomerUserEntity> {

        private String enabled;

        public Enabled(@NotNull String enabled) {
            this.enabled = enabled;
        }

        @Override
        public Predicate toPredicate(Root<MmsCustomerUserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            return criteriaBuilder.equal(root.get("enabled"), enabled);
        }
    }
}
