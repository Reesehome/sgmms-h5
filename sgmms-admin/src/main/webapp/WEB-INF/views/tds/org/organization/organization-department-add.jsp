<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<ul class="nav nav-tabs">
	<li role="presentation" class="active"><a data-toggle="tab" href="#departmentInfo"><spring:message code="tds.organization.label.baseinfo" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#operaterAuthorityConfig"><spring:message code="tds.organization.label.grant.permissions.operation" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#dataAuthorityConfig"><spring:message code="tds.organization.label.grant.permissions.data" /></a></li>
	
	<optRight:hasOptRight rightCode="IDR_ORG_EDIT_ORG">
		<li role="presentation" class="pull-right"><button id="btnDepAdd" class="btn btn-primary"><spring:message code="tds.common.label.save" /></button></li>
	</optRight:hasOptRight>
</ul>
<div class="tab-content">
	<div id="departmentInfo" class="tab-pane in active">
		<jsp:include page="organization-department.jsp" />
	</div>
	<div id="operaterAuthorityConfig" class="tab-pane">
		<jsp:include page="organization-operater-authority-config.jsp" />
	</div>
	<div id="dataAuthorityConfig" class="tab-pane">
		<jsp:include page="organization-data-authority-config.jsp" />
	</div>
</div>

<optRight:hasOptRight rightCode="IDR_ORG_EDIT_ORG">
	<jsp:include page="/tds/org/organization/organization-department-add.js.jsp" />
</optRight:hasOptRight>