<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<div class="row" style="margin-top: 5px;"></div>

<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-info">
			<div class="panel-body">
		    	<table id="personTable"></table> 
				<div id="personGridPager"></div> 
			</div>
		</div>
	</div>
</div>

<!-- 性别，应用于jqgrid中 -->
<dictionary:select code="genderType" selectId="person-genderType" style="display:none;"/>
<!-- 用户类型，应用于jqgrid -->
<dictionary:select code="userType" selectId="person-userType" style="display:none;"/>

<jsp:include page="/tds/org/organization/organization-person.js.jsp" />

