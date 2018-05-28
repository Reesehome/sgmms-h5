<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<div class="panel-heading">
	<div class="row">
		<div class="col-xs-6">&nbsp;&nbsp;<spring:message code="tds.user.label.user.list" /></div>
		<div class="col-xs-6" style="text-align: right;">
			<button type="button" id="btnUserDel" class="btn btn-warning"><spring:message code="tds.common.label.delete" /></button>
			&nbsp;
		</div>
	</div>
</div>
<div class="panel-body" style="height:240px;overflow: auto;">
	<div class="row">
		<div class="col-xs-12">
	    	<table id="buttomSearchUserTable"></table> 
			<div id="buttomSearchUserGridPager"></div> 
		</div>
	</div>
</div>

<jsp:include page="/tds/org/organization/organization-buttom-search-user.js.jsp" />

