<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<jsp:include page="/tds/index/js/password-edit.js.jsp" />

<form id="passwordForm" class="form-horizontal">
	<div class="form-group">
		<label for="txtOldPassword" class="col-sm-3 control-label">旧密码</label>
		<div class="col-sm-7">
			<input type="password" id="oldPassword" name="oldPassword"  class="form-control" placeholder="旧密码">
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtNewPassword" class="col-sm-3 control-label">新密码</label>
		<div class="col-sm-7">
			<input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="新密码">
		</div>
	</div>
	<div class="form-group">
		<label for="txtNewPassword2" class="col-sm-3 control-label">新密码确认</label>
		<div class="col-sm-7">
			<input type="password" id="newPassword2" name="newPassword2" class="form-control" placeholder="新密码确认">
		</div>
	</div>
</form>