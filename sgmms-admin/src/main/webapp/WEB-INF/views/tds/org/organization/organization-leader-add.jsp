<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<form id="leaderAddForm" class="form-horizontal">
	<div class="form-group">
		<label for="txtLeaderType" class="col-sm-3 control-label"><spring:message code="tds.user.label.leader.type" /></label>
		<div class="col-sm-7">
			<input type="hidden" id="orgId" value="${orgId }">
			<dictionary:select code="leaderType" selectId="leaderType" selectName="leaderType" cssClass="form-control"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtNewPassword" class="col-sm-3 control-label"><spring:message code="tds.user.label.user.search" /></label>
		<div class="col-sm-7">
			<div class="input-group">
				<input type="text" id="leaderUserName" name="leaderUserName"  class="form-control" placeholder="<spring:message code='tds.common.label.input' /><spring:message code='tds.user.label.username.initials.account' />">
				<span class="input-group-btn">
					<button type="button" class="btn btn-primary" id="leaderUserSearch"><spring:message code="tds.common.label.search" /></button>
				</span>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label"></label>
		<div class="col-sm-7">
			<table id="leaderSelectTable"></table>
			<div id="leaderSelectGridPager"></div> 
		</div>
	</div>
</form>

<jsp:include page="/tds/org/organization/organization-leader-add.js.jsp" />
