<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ include file="/tds/dataRight/js/data-right-type-edit.js.jsp"%>


<form id="dataRightFactorTypeForm" class="form-horizontal">
	<input id="rightTypeId" name="rightTypeId" value="${rightFactorType.rightTypeId}" type="hidden">
	<input id="treeCode" name="treeCode" value="${rightFactorType.treeCode}" type="hidden">
	<input id="parentId" name="parentId" value="${rightFactorType.parentId}" type="hidden">

	<div class="form-group">
		<label for="parentFactorTypeName" class="col-md-3 control-label"><spring:message code="tds.dataRight.label.parentRightType"/></label>
		<div class="col-md-9">
			<input id="parentFactorTypeName" name="parentFactorTypeName" value="${parentRightFactorType.rightTypeName}" class="form-control" readonly="readonly">
		</div>
	</div>

	<div class="form-group">
		<label for="factorTypeName" class="col-md-3 control-label"><spring:message code="tds.dataRight.label.RightTypeName"/></label>
		<div class="col-md-9">
			<input id="rightTypeName" name="rightTypeName" value="${rightFactorType.rightTypeName}" class="form-control" >
		</div>
	</div>

	<div class="form-group">
		<label for="factorTypeDes" class="col-md-3 control-label"><spring:message code="tds.dataRight.label.description"/></label>
		<div class="col-md-9">
			<textarea class="form-control" rows="3" id="remark" name="remark" value="${rightFactorType.remark}">${rightFactorType.remark}</textarea>
		</div>
	</div>
	
	<div class="form-group">
		<div class="col-md-10"></div>
		<div class="col-md-2 text-right">
<%-- 			<button type="button" class="btn btn-primary" onclick="saveRightType()">　<spring:message code="tds.common.label.save"/>　</button> --%>
		</div>
	</div>
</form>