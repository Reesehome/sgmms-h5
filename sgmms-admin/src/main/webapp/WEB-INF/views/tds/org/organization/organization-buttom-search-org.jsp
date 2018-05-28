<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<div class="panel-heading">
	<div class="row">
		<div class="col-xs-6">&nbsp;&nbsp;<spring:message code="tds.organization.label.department.list" /></div>
		<div class="col-xs-6" style="text-align: right;">
			<div class="btn-group" role="group">
				<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<spring:message code="tds.common.label.operate" />
					<span class="caret"></span>
			    </button>
				<ul class="dropdown-menu">
					<%--
					<li><a href="javascirpt:void(0);" id="btnButtomDepAdd"><spring:message code="tds.organization.label.department.add" /></a></li>
					 --%>
					<li><a href="javascirpt:void(0);" id="btnButtomUserAdd"><spring:message code="tds.organization.label.user.add" /></a></li>
				</ul>
			</div>
			&nbsp;
		</div>
	</div>
</div>
<div class="panel-body" style="height:240px;overflow: auto;">
	<div class="row">
		<div class="col-xs-12">
	    	<table id="buttomSearchOrgTable"></table> 
			<div id="buttomSearchOrgGridPager"></div> 
		</div>
	</div>
</div>

<jsp:include page="/tds/org/organization/organization-buttom-search-org.js.jsp" />

