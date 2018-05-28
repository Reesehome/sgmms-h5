<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<div class="panel-heading">
	<div class="row">
		<div class="col-xs-6">&nbsp;&nbsp;<spring:message code="tds.user.label.user.list" /></div>
		
		<optRight:hasOptRight rightCode="IDR_ORG_EDIT_USER">
			<div class="col-xs-6" style="text-align: right;">
				<div class="btn-group" role="group">
					<button type="button" id="btnUserAdd" class="btn btn-primary"><spring:message code="tds.common.label.add"/></button>
					<button type="button" id="btnUserDel" class="btn btn-warning"><spring:message code="tds.common.label.delete"/></button>
				</div>
				&nbsp;
			</div>
		</optRight:hasOptRight>
	</div>
</div>
<div class="panel-body" style="height:260px;overflow: auto;">
	<div class="row">
		<div class="col-xs-12">
	    	<table id="buttomPersonTable"></table> 
			<div id="buttomPersonGridPager"></div> 
		</div>
	</div>
</div>

<jsp:include page="/tds/org/organization/organization-buttom-user.js.jsp" />

