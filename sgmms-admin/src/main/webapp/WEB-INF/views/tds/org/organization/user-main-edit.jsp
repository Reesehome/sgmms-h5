<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<ul class="nav nav-tabs">
	<li role="presentation" class="active"><a data-toggle="tab" href="#userBaseInfo"><spring:message code="tds.user.label.baseinfo" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#userDepartmentConfig"><spring:message code="tds.user.label.department" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#userAuthorityConfig"><spring:message code="tds.user.label.operating.rights.management" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#dataAuthorityConfig"><spring:message code="tds.organization.label.grant.permissions.data" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#userAuthorityView"><spring:message code="tds.user.label.operating.permissions.preview" /></a></li>
	
	
	<optRight:hasOptRight rightCode="IDR_ORG_EDIT_USER">
		<li role="presentation" class="pull-right">
			<div class="btn-group">
				<button id="btnSetDefaultPassword" class="btn btn-success"><spring:message code="tds.user.label.set.default.password" /></button>
				<button id="btnEditUserSave" class="btn btn-primary"><spring:message code="tds.common.label.save" /></button>
			</div>
		</li>
	</optRight:hasOptRight>
</ul>
<div class="tab-content">
	<div id="userBaseInfo" class="tab-pane in active">
		<jsp:include page="user-base-info.jsp" />
	</div>
	<div id="userDepartmentConfig" class="tab-pane">
		<jsp:include page="user-department-config.jsp" />
	</div>
	<div id="userAuthorityConfig" class="tab-pane">
		<jsp:include page="user-operater-authority-config.jsp" />
	</div>
	<div id="dataAuthorityConfig" class="tab-pane">
		<jsp:include page="organization-data-authority-config.jsp" />
	</div>
	<div id="userAuthorityView" class="tab-pane">
		<jsp:include page="user-operater-authority-view.jsp" />
	</div>
</div>

<optRight:hasOptRight rightCode="IDR_ORG_EDIT_USER">
	<jsp:include page="/tds/org/organization/user-main-edit.js.jsp" />
</optRight:hasOptRight>