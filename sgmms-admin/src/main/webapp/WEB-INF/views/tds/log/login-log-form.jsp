<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Form</title>
</head>
<body>
	<form:form id="LoginLogForm" class="form-horizontal" modelAttribute="loginLog" role="form">
		<div class="form-group">
			<label for="userName"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.operateUser"/> </label>
			<div class="col-sm-7">
				<form:input path="userName" class="form-control" readonly="readonly" id="userName"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="loginName"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.loginName"/> </label>
			<div class="col-sm-7">
				<form:input path="loginName" class="form-control" readonly="readonly" id="loginName"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="loginTime"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.loginTime"/> </label>
			<div class="col-sm-7">
				<form:input path="loginTime" class="form-control" readonly="readonly" id="loginTime"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="address"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.loginIP"/></label>
			<div class="col-sm-7">
				<form:input path="address" class="form-control" readonly="readonly" id="address"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="loginId"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.loginSerialNum"/> </label>
			<div class="col-sm-7">
				<form:input path="loginId" class="form-control" readonly="readonly" id="loginId"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="offlineStatusDisplay"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.withdrawal"/> </label>
			<div class="col-sm-7">
				<form:input path="offlineStatusDisplay" class="form-control" readonly="readonly" id="offlineStatusDisplay"/>
		    </div>
		</div>
		<div class="form-group">
			<label for="offlineTime"class="col-sm-3 control-label"><spring:message code="baf.loginlog.label.withdrawalTime"/> </label>
			<div class="col-sm-7">
				<form:input path="offlineTime" class="form-control" readonly="readonly" id="offlineTime"/>
		    </div>
		</div>
	</form:form>
</body>
</html>