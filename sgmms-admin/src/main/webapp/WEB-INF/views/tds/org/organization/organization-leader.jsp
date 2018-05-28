<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<div class="row" style="margin-top: 5px;"></div>

<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-info">
			<div class="panel-heading">
				<form id="leaderSearchForm" class="form-inline">
					<div class="form-group">
						<label for="txtSearchUserName" class="control-label"><spring:message code="tds.user.label.username" /></label>
						<input id="searchUserName" name="searchUserName" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.username'/>">
					</div>
					<div class="form-group btn-group pull-right">
						<button type="button" class="btn btn-primary" id="leaderSearch"><spring:message code="tds.common.label.search" /></button>
						
						<optRight:hasOptRight rightCode="IDR_ORG_EDIT_LEADER">
							<button type="button" class="btn btn-primary" id="leaderAdd"><spring:message code="tds.common.label.add" /></button>
							<button type="button" class="btn btn-warning" id="leaderDelete"><spring:message code="tds.common.label.delete" /></button>
						</optRight:hasOptRight>
					</div>
				</form>
			</div>
			<div class="panel-body">
		    	<table id="leaderTable"></table> 
			</div>
		</div>
	</div>
</div>

<!-- 领导类型，应用于jqgrid -->
<dictionary:select code="leaderType" selectId="leader-leaderType" style="display:none;"/>

<jsp:include page="/tds/org/organization/organization-leader.js.jsp" />

