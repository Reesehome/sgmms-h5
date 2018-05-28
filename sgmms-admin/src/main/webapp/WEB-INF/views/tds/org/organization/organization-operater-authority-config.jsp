<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<div class="row">&nbsp;</div>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-info">
				<div class="panel-heading"><spring:message code="tds.organization.label.operation.authority.group.configuration" /></div>
				<div class="panel-body" style="height:490px;overflow: auto;">
					<ul id="operaterAuthorityTree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/tds/org/organization/organization-operater-authority-config.js.jsp" />