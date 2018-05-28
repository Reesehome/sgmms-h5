<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<jsp:include page="/tds/demo/table/js/edit.js.jsp" />

<form id="demoForm" class="form-horizontal">
	<input id="id" name="id" type="hidden" value="${demo.id}">

	<div class="form-group">
		<label for="txtTitle" class="col-sm-3 control-label">标题</label>
		<div class="col-sm-7">
			<input id="title" name="title"  class="form-control" placeholder="请输入标题" value="${demo.title}">
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtPrice" class="col-sm-3 control-label">价格</label>
		<div class="col-sm-7">
			<input id="price" name="price" class="form-control" placeholder="请输入价格" value="${demo.price}">
		</div>
	</div>
</form>