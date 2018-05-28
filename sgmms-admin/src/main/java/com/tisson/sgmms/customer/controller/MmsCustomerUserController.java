package com.tisson.sgmms.customer.controller;

import com.google.common.collect.ImmutableMap;
import com.tisson.sgmms.customer.entity.MmsCustomerUserEntity;
import com.tisson.sgmms.customer.service.MmsCustomerUserService;
import com.tisson.sgmms.customer.specification.CustomerUserSpecification;
import com.tisson.sgmms.customer.vo.MmsCustomerUserVo;
import com.tisson.tds.common.web.PageJqgrid;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.domain.Specifications;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;

import java.net.URI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.lang3.StringUtils.isNotBlank;

/**
 * @author hasee
 */
@RequestMapping("/customer/user")
@Controller
public class MmsCustomerUserController {

    @Autowired
    private MmsCustomerUserService customerUserService;

    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public String main() {
        return "admin/customer/user-index.jsp";
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    @ResponseBody
    public PageJqgrid<MmsCustomerUserEntity> getCustomerUsers(@RequestParam(required = false) String name,
                                 @RequestParam(required = false) String mobile,
                                 @RequestParam(required = false) String companyId,
                                 @PageableDefault PageJqgrid pageable) {
        Specifications<MmsCustomerUserEntity> specifications = Specifications.where(new CustomerUserSpecification.Enabled("Y"));
        if (StringUtils.isNotBlank(name)) {
            Specification<MmsCustomerUserEntity> specification = new CustomerUserSpecification.UserName(name);
            specifications = specifications.and(specification);
        }
        if (StringUtils.isNotBlank(mobile)) {
            Specification<MmsCustomerUserEntity> specification = new CustomerUserSpecification.Mobile(mobile);
            specifications = specifications.and(specification);
        }
        if (StringUtils.isNotBlank(companyId)) {
            Specification<MmsCustomerUserEntity> specification = new CustomerUserSpecification.CompanyId(companyId);
            specifications = specifications.and(specification);
        }
        pageable.setSord("desc");
        pageable.setSidx("createOn");
        Page<MmsCustomerUserEntity> page = customerUserService.findAll(specifications, pageable.convertToPageRequest());
        pageable.initResult(page);
        return pageable;
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> save(MmsCustomerUserEntity customerUser) {
        customerUserService.save(customerUser);
        URI location = MvcUriComponentsBuilder.fromMethodName(MmsCustomerUserController.class, "form", customerUser.getId()).build().toUri();
        return ResponseEntity.created(location).body("{\"success\": true}");
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> form(@PathVariable(value = "userId") String userId) {
        Map<String, Object> root = new HashMap<>();
        MmsCustomerUserEntity customerUser = customerUserService.findOne(userId);
        if (customerUser == null) {
            root.put("success", false);
            root.put("message", "用户不存在");
        } else {
            root.put("success", true);
            root.put("id", customerUser.getId());
            root.put("userName", customerUser.getUserName());
            root.put("mobile", customerUser.getMobile());
            root.put("gender", customerUser.getGender());
            root.put("companyId", customerUser.getCompanyId());
        }
        return root;
    }

    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public ResponseEntity<?> delete(@RequestParam(value = "userId[]") String[] userIds) {
        try {
            customerUserService.bulkDelete(Arrays.asList(userIds));
        } catch (UnsupportedOperationException e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", "根节点不能删除"));
        }  catch (Exception e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", e.getMessage()));
        }
        return ResponseEntity
                .ok(ImmutableMap.of("success", true));
    }

    @RequestMapping(value = "company/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<MmsCustomerUserVo> companyUser(@PathVariable("id") String id) {
        return customerUserService.findUserByCompanyId(id);
    }
}
