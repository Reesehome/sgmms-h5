<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<div class="row">&nbsp;</div>
<form id="depEditForm" class="form-horizontal">
	<input id="parentOrgId" name="parentOrgId" type="hidden" value="${parentOrgId==null ? organization.parentOrgId : parentOrgId}">
	<input id="isValid" name="isValid" type="hidden" value="${organization.isValid}">
	<input id="treeCode" name="treeCode" type="hidden" value="${organization.treeCode}">
	<input id="operateFlag" name="operateFlag" type="hidden" value="${operateFlag}">
	<input id="orgId" name="orgId" type="hidden" value="${organization.orgId }">
	
	<input id="newParentId"  name="newParentId" type="hidden" value="" >
	
	<div class="form-group">
		<label for="txtFullParentOrganizationName" class="col-sm-3 control-label"><spring:message code="tds.organization.label.parent.department" /></label>
		<div class="col-sm-7">
			<input type="text" id="fullParentOrganizationName" name="fullParentOrganizationName"  class="form-control" value="${fullParentOrganizationName}" disabled="disabled" />
		</div>
		<div class="col-sm-2">
		    <input type="button" id="selectOrg"  value='<spring:message code="tds.common.label.select" />'  class="btn btn-primary"/>
		</div>
	</div>
	
	<%-- 
	<div class="form-group">
		<label for="txtOrgId" class="col-sm-3 control-label"><spring:message code="tds.organization.label.department.number" /></label>
		<div class="col-sm-7">
			<input type="text" id="orgId" name="orgId" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.department.number' />" value="${organization.orgId }" <c:if test="${operateFlag =='E' }">readonly</c:if> />
		</div>
	</div>
	--%>
	
	<div class="form-group">
		<label for="txtOrgName" class="col-sm-3 control-label"><spring:message code="tds.organization.label.department.name" /></label>
		<div class="col-sm-7">
			<input type="text" id="orgName" name="orgName" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.department.name' />" value="${organization.orgName }"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtTypeId" class="col-sm-3 control-label"><spring:message code="tds.organization.label.department.type" /></label>
		<div class="col-sm-7">
			<dictionary:select code="orgType" selectId="typeId" selectName="typeId" cssClass="form-control" selectValue="${organization.typeId }" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtIsOA" class="col-sm-3 control-label"><spring:message code="tds.organization.label.department.oa" /></label>
		<div class="col-sm-7">
			<dictionary:select code="yesOrNo" selectId="isOA" selectName="isOA" cssClass="form-control" selectValue="${organization.isOA }" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtPhone" class="col-sm-3 control-label"><spring:message code="tds.organization.label.contact.phone" /></label>
		<div class="col-sm-7">
			<input type="text" id="phone" name="phone" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.contact.phone' />" value="${organization.phone }"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtFax" class="col-sm-3 control-label"><spring:message code="tds.organization.label.fax" /></label>
		<div class="col-sm-7">
			<input type="text" id="fax" name="fax" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.fax' />" value="${organization.fax }"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtEmail" class="col-sm-3 control-label"><spring:message code="tds.organization.label.official.email" /></label>
		<div class="col-sm-7">
			<input type="email" id="email" name="email" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.official.email' />" value="${organization.email }"/>
		</div>
	</div>
	
	<%-- 
	<div class="form-group">
		<label for="txtEmail" class="col-sm-3 control-label"><spring:message code="tds.organization.label.household.register" /></label>
		<div class="col-sm-7">
			<input type="text" id="householdRegister" name="householdRegister" class="form-control" value="${organization.householdRegister}"/>
		</div>
	</div>
	--%>
	
	<div class="form-group">
		<label for="txtOrgDes" class="col-sm-3 control-label"><spring:message code="tds.organization.label.remark" /></label>
		<div class="col-sm-7">
			<input type="text" id="orgDes" name="orgDes" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.organization.label.remark' />" value="${organization.orgDes }" />
		</div>
	</div>
</form>

<jsp:include page="/tds/org/organization/organization-department.js.jsp" />
