<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!-- <div class="form-group has-error" id="tipId" > -->
<!--       <label class="control-label" for="inputError1">提示：请选择一个用户进行操作</label> -->
<!--  </div> -->
 <div id="alertTip" class="alert alert-warning" role="alert" style="display: none;">提示：请选择一个用户进行操作</div>
<form id="selectPersonForm" class="form-horizontal">
	
	<div class="form-group">
		<label for="txtNewPassword" class="col-sm-3 control-label">请输入</label>
		<div class="col-sm-7">
			<div class="input-group">
				<input type="text" id="search_user_name" name="userName"  class="form-control" placeholder="用户名称、首字母或账号">
				<span class="input-group-btn">
					<button type="button" class="btn btn-primary" onclick="selectUser()" id="selectPerson"><spring:message code="tds.common.label.search" /></button>
				</span>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label"></label>
		<div class="col-sm-7">
			<table id="buttomSearchUserTable"></table>
			<div id="buttomSearchUserGridPager"></div> 
		</div>
	</div>
</form>


<jsp:include page="/tds/workflow/task/task-turn-select.js.jsp" />

