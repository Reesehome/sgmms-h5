<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<jsp:include page="/tds/workflow/model/model-edit.js.jsp" />

<form id="modelForm" action="${ctx}/admin/workflow/model/create.do" class="form-horizontal" target="_blank" method="post">

	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">名称</label>
		<div class="col-sm-7">
			<input id="name" name="name"  class="form-control" placeholder="请输入流程名称" value="" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="key" class="col-sm-3 control-label">流程编码</label>
		<div class="col-sm-7">
			<input id="key" name="key" class="form-control" placeholder="请输入流程编码" value="">
		</div>
	</div>
	

	
	<div class="form-group">
		<label for="description" class="col-sm-3 control-label">描述</label>
		<div class="col-sm-7">
        <textarea class="form-control" rows="3" id="description" name="description"  placeholder="<spring:message code='tds.sys.property.inputremark'/>"></textarea>		
        </div>
	</div>
	
</form>