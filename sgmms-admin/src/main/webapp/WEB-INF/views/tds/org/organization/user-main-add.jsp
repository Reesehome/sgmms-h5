<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<ul class="nav nav-tabs">
	<li role="presentation" class="active"><a data-toggle="tab" href="#userBaseInfo"><spring:message code="tds.user.label.baseinfo" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#userDepartmentConfig"><spring:message code="tds.user.label.department" /></a></li>
	<li role="presentation"><a data-toggle="tab" href="#userAuthorityConfig"><spring:message code="tds.user.label.operating.rights.management" /></a></li>
	
	<optRight:hasOptRight rightCode="IDR_ORG_EDIT_USER">
		<li role="presentation" class="pull-right"><button id="btnAddUserSave" class="btn btn-primary"><spring:message code="tds.common.label.save" /></button></li>
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
</div>

<optRight:hasOptRight rightCode="IDR_ORG_EDIT_USER">
	<jsp:include page="/tds/org/organization/user-main-add.js.jsp" />
</optRight:hasOptRight>