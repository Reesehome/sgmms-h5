<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ include file="/tds/menu-right/js/edit.js.jsp"%>

<form id="menuRightForm" class="form-horizontal">
	<input id="rightId" name="rightId" value="${menuRight.rightId}" type="hidden">
	<input id="parentId" name="parentId" value="${parentMenuRight.rightId}" type="hidden">
	<input id="treeCode" name="treeCode" value="${menuRight.treeCode}" type="hidden">
	<input id="sortOrder" name="sortOrder" value="${menuRight.sortOrder}" type="hidden">
	<input id="isLeaf" name="isLeaf" value="${menuRight.isLeaf}" type="hidden">
	
	<spring:message code="tds.menuRight.label.baseProperty"/>
	<hr style="margin-top: 3px;">

	<div class="form-group">
		<label class="col-md-2 control-label"><spring:message code="tds.menuRight.label.previousMenuName"/></label>
		<div class="col-md-10">
			<input value="${parentMenuRight.name}" class="form-control" readonly="readonly">
		</div>
		
		<%--
		<div>
			<label for="name" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.menuName"/></label>
			<div class="col-md-4">
				<input class="form-control" id="name" name="name" value="${menuRight.name}" placeholder="<spring:message code="tds.menuRight.label.inputMenuName"/>">
			</div>
		</div>
		--%>
	</div>
	
	<div class="form-group">		
		<label for="descript" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.menuName"/></label>
		<div class="col-md-10">
			<table id="list"></table>
		</div>
	</div>
	
	<div class="form-group">
		<div>
			<label for="smallIcon" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.smallIcon"/></label>
			<div class="col-md-10">
				<div class="input-group">
					<input type="text" id="smallIcon" name="smallIcon" value="${menuRight.smallIcon}" class="form-control" placeholder="<spring:message code='tds.menuRight.label.selectSmallIcon'/>">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="showIconList()"><spring:message code="tds.menuRight.label.select"/></button>
					</span>
				</div>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<div>
			<label for="largeIcon" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.largeIcon"/></label>
			<div class="col-md-10">
				<div class="input-group">
					<input disabled="disabled" type="text" id="largeIcon" name="largeIcon" value="${menuRight.largeIcon}" class="form-control" placeholder="<spring:message code='tds.menuRight.label.selectLargeIcon'/>">
					<span class="input-group-btn">
						<button disabled="disabled" class="btn btn-default" type="button"><spring:message code="tds.menuRight.label.select"/></button>
					</span>
				</div>
			</div>
		</div>
	</div>
	
	<div class="form-group">		
		<label for="descript" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.descript"/></label>
		<div class="col-md-10">
			<textarea class="form-control" rows="1" id="descript" name="descript">${menuRight.descript}</textarea>
		</div>
	</div>
	
	<br>
	<spring:message code="tds.menuRight.label.menuProperty"/>
	<hr style="margin-top: 3px;">
	
	<div class="form-group">
		<label for="isMenu" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.showAsMenu"/></label>
		<div class="col-md-4">
			<select class="form-control" id="isMenu" name="isMenu">
				<c:choose>
					<c:when test="${'Y' == menuRight.isMenu}">
						<option value="Y"><spring:message code="tds.menuRight.label.yes"/></option>
						<option value="N"><spring:message code="tds.menuRight.label.no"/></option>
					</c:when>
					<c:otherwise>
						<option value="N"><spring:message code="tds.menuRight.label.no"/></option>
						<option value="Y"><spring:message code="tds.menuRight.label.yes"/></option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		
		<div>
			<label for="requestMethod" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.requestMethod"/></label>
		<div class="col-md-4">
			<select class="form-control" id="requestMethod" name="requestMethod">
				<c:choose>
					<c:when test="${'P' == menuRight.requestMethod}">
						<option value="P">POST</option>
						<option value="G">GET</option>
					</c:when>
					<c:otherwise>
						<option value="G">GET</option>
						<option value="P">POST</option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		</div>
	</div>
	
	<div class="form-group">
		<div>
			<label for="requestPath" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.requestPath"/></label>
			<div class="col-md-10">
				<input id="requestPath" name="requestPath" value="${menuRight.requestPath}" class="form-control" placeholder="<spring:message code='tds.menuRight.label.inputRequestPath'/>">
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<div>
			<label for="menuFilter" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.menuFilter"/></label>
			<div class="col-md-10">
				<input id="menuFilter" name="menuFilter" value="${menuRight.menuFilter}" class="form-control" placeholder="<spring:message code='tds.menuRight.label.inputMenuFilter'/>">
			</div>
		</div>
	</div>
	
	<br>
	<spring:message code="tds.menuRight.label.permissionsProperty"/>
	<hr style="margin-top: 3px;">
	
	<div class="form-group">
		<label for="isRight" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.isRight"/></label>
		<div class="col-md-4">
			<select class="form-control" id="isRight" name="isRight">
				<c:choose>
					<c:when test="${'Y' == menuRight.isRight}">
						<option value="Y"><spring:message code="tds.menuRight.label.yes"/></option>
						<option value="N"><spring:message code="tds.menuRight.label.no"/></option>
					</c:when>
					<c:otherwise>
						<option value="N"><spring:message code="tds.menuRight.label.no"/></option>
						<option value="Y"><spring:message code="tds.menuRight.label.yes"/></option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		
		<div>
			<label for="rightCode" class="col-md-2 control-label"><spring:message code="tds.menuRight.label.rightCode"/></label>
			<div class="col-md-4">
				<input id="rightCode" name="rightCode" value="${menuRight.rightCode}" class="form-control" placeholder="<spring:message code='tds.menuRight.label.inputRightCode'/>">
			</div>
		</div>
	</div>
	<!-- 
	<br>
	菜单名称
	<hr style="margin-top: 3px;"> -->
</form>
<input id="executeType" name="executeType" value="${executeType}" type="hidden">
<!-- <table id="list"></table> -->