package com.tisson.sgmms.customer.controller;

import com.google.common.collect.ImmutableMap;
import com.tisson.sgmms.api.wrap.Wrapper;
import com.tisson.sgmms.customer.entity.MmsCustomerCompanyEntity;
import com.tisson.sgmms.customer.service.MmsCustomerCompanyService;
import com.tisson.sgmms.customer.vo.MmsCustomerCompanyBean;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;

import java.util.List;

import static org.apache.commons.lang3.StringUtils.isBlank;

@RequestMapping("/customer/company")
@Controller
public class MmsCustomerCompanyController {

    @Autowired
    private MmsCustomerCompanyService customerCompanyService;

    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public String main() {
        return "admin/customer/company-index.jsp";
    }

    @RequestMapping(value = "/findByParentId", method = RequestMethod.POST)
    public ResponseEntity<?> findByParentId(@RequestParam(value = "id", required = false) String parentId) {
        StringBuilder response = new StringBuilder();
        response.append("[");
        List<MmsCustomerCompanyEntity> customerCompanies = customerCompanyService.findByParentId(parentId);
        if (CollectionUtils.isNotEmpty(customerCompanies)) {
            for (MmsCustomerCompanyEntity customerCompany : customerCompanies) {
                response.append("{");
                response.append("\"id\": \"").append(customerCompany.getId()).append("\",");
                if (isBlank(customerCompany.getParentId())) {
                    response.append("\"parentId\": null,");
                } else {
                    response.append("\"parentId\": \"").append(customerCompany.getParentId()).append("\",");
                }
                response.append("\"name\": \"").append(customerCompany.getName()).append("\",");
                if ("Y".equalsIgnoreCase(customerCompany.getEnabled())) {
                    response.append("\"enabled\": true");
                } else {
                    response.append("\"enabled\": false");
                }
                response.append("},");
            }
            response.deleteCharAt(response.length() - 1);
        }
        response.append("]");
        return ResponseEntity.ok(response.toString());
    }

    @RequestMapping(value = "/all", method = RequestMethod.POST)
    @ResponseBody
    public List<MmsCustomerCompanyBean> all() {
        return customerCompanyService.findAll();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> findById(@PathVariable("id") String id) {
        StringBuilder response = new StringBuilder();
        response.append("{");
        MmsCustomerCompanyEntity customerCompany = customerCompanyService.findById(id);
        if (customerCompany == null) {
            response.append("\"success\": false");
            response.append("\"message\": \"公司不存在\"");
        } else {
            response.append("\"success\": true,");
            response.append("\"id\": \"").append(customerCompany.getId()).append("\",");
            if (isBlank(customerCompany.getParentId())) {
                response.append("\"parentId\": null,");
            } else {
                response.append("\"parentId\": \"").append(customerCompany.getParentId()).append("\",");
            }
            response.append("\"name\": \"").append(customerCompany.getName()).append("\",");
            if ("Y".equalsIgnoreCase(customerCompany.getEnabled())) {
                response.append("\"enabled\": true");
            } else {
                response.append("\"enabled\": false");
            }
        }
        response.append("}");
        return ResponseEntity.ok(response.toString());
    }

    @RequestMapping(value = "/form", method = RequestMethod.GET)
    public String form(@RequestParam(value = "id", required = false) String id, Model model) {
        MmsCustomerCompanyEntity customerCompany;
        if (isBlank(id)) {
            customerCompany = new MmsCustomerCompanyEntity();
        } else {
            customerCompany = customerCompanyService.findById(id);
        }
        if (customerCompany == null) {
            model.addAttribute("errorMessage", "数据不正确，请联系管理员");
            customerCompany = new MmsCustomerCompanyEntity();
        }
        model.addAttribute("company", customerCompany);
        return "admin/customer/company-form.jsp";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> save(@Validated MmsCustomerCompanyEntity customerCompany, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", "校验失败"));
        }
        try {
            customerCompanyService.save(customerCompany);
        } catch (UnsupportedOperationException e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", "根节点不能编辑"));
        } catch (Exception e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", "系统错误，请联系管理员"));
        }
        String location = MvcUriComponentsBuilder.fromMethodName(MmsCustomerCompanyController.class, "findById", customerCompany.getId()).toUriString();
        return ResponseEntity
                .status(HttpStatus.OK)
                .header("Location", location)
                .body(ImmutableMap.of("success", true));
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<?> delete(@PathVariable String id) {
        try {
            customerCompanyService.delete(id);
        } catch (UnsupportedOperationException e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", "根节点不能删除"));
        }  catch (Exception e) {
            return ResponseEntity.ok(ImmutableMap.of("success", false, "message", e.getMessage()));
        }
        return ResponseEntity
                .ok(ImmutableMap.of("success", true));
    }
}
