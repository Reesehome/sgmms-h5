<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<form id="dashboardForm" class="form-horizontal">
	<input type="hidden" id="dbId" name="dbId" value="${dashboard.dbId}">
	<input type="hidden" id="userId" name="userId" value="${dashboard.userId}">
	
	<div class="form-group">
		<label for="dbName" class="col-md-3 control-label"><spring:message code="tds.db.label.defaultName" /></label>
		<div class="col-md-7">
			<input class="form-control" type="text" id="dbName" name="dbName" value="${dashboard.dbName}">
		</div>
	</div>
	
	<div class="form-group">		
		<label for="langList" class="col-md-3 control-label"></label>
		<div class="col-md-7">
			<table id="langList"></table>
		</div>
	</div>
	
	<div class="form-group">
		<div>
			<label for="dbIcon" class="col-md-3 control-label"><spring:message code="tds.db.label.icon" /></label>
			<div class="col-md-7">
				<div class="input-group">
					<input class="form-control" type="text" id="dbIcon" name="dbIcon" value="${dashboard.dbIcon}">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" id="btnSelectIcon"><spring:message code="tds.menuRight.label.select"/></button>
					</span>
				</div>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label for="margin" class="col-md-3 control-label"><spring:message code="tds.db.label.widgetMargin" /></label>
		<div class="col-md-7">
			<input class="form-control" type="number" id="margin" name="margin" value="${dashboard == null ? 3 : dashboard.margin}">
		</div>
	</div>
	
	<div class="form-group">
		<label for="baseWidth" class="col-md-3 control-label"><spring:message code="tds.db.label.widgetCellWidth" /></label>
		<div class="col-md-7">
			<input class="form-control" type="number" id="baseWidth" name="baseWidth" value="${dashboard == null ? 200 : dashboard.baseWidth}">
		</div>
	</div>
	
	<div class="form-group">
		<label for="baseHeight" class="col-md-3 control-label"><spring:message code="tds.db.label.widgetCellHeight" /></label>
		<div class="col-md-7">
			<input class="form-control" type="number" id="baseHeight" name="baseHeight" value="${dashboard == null ? 150 : dashboard.baseHeight}">
		</div>
	</div>
</form>

<%@ include file="/tds/dashboard/dashboard-edit.js.jsp"%>
