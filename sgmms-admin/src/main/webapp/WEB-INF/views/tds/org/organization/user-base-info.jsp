<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<div class="row">&nbsp;</div>
<form id="userEditForm" class="form-horizontal">
	<input id="userId" name="userId" type="hidden" value="${orgUser.userId}">
	<input id="isValid" name="isValid" type="hidden" value="${orgUser.isValid}">
	<input id="orgId" name="orgId" type="hidden" value="${orgId }">
	<input id="oldLoginName" type="hidden" value="${orgUser.loginName}" />
	<input id="isRequestInputUserRdn" type="hidden" value="${isRequestInputUserRdn }">
	
	<div class="form-group">
		<label for="txtUserName" class="col-sm-2 control-label"><spring:message code="tds.user.label.username" /></label>
		<div class="col-sm-4">
			<input type="text" id="userName" name="userName" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.username' />" value="${orgUser.userName}" />
		</div>
		<label for="txtLoginName" class="col-sm-2 control-label"><spring:message code="tds.user.label.loginname" /></label>
		<div class="col-sm-4">
			<input type="text" id="loginName" name="loginName"  class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.loginname' />" value="${orgUser.loginName}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtUserType" class="col-sm-2 control-label"><spring:message code="tds.user.label.usertype" /></label>
		<div class="col-sm-4">
			<dictionary:select code="userType" selectId="userType" selectName="userType" cssClass="form-control" selectValue="${orgUser.userType}"/>
		</div>
		<label for="txtGender" class="col-sm-2 control-label"><spring:message code="tds.user.label.gender" /></label>
		<div class="col-sm-4">
			<div class="form-control">
				<dictionary:radio code="genderType" radioName="gender" checkValue="${orgUser.gender}"/>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtEmployDate" class="col-sm-2 control-label"><spring:message code="tds.user.label.hiredate" /></label>
		<div class="col-sm-4">
			<input type="text" id="employDate" name="employDate"  class="form-control" value="${orgUser.employDate}" readonly="readonly" />
		</div>
		<label for="txtExpiredDate" class="col-sm-2 control-label"><spring:message code="tds.user.label.account.expirydate" /></label>
		<div class="col-sm-4">
			<input type="text" id="expiredDate" name="expiredDate"  class="form-control" value="${orgUser.expiredDate}" readonly="readonly" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtOfficePhone" class="col-sm-2 control-label"><spring:message code="tds.user.label.office.phone" /></label>
		<div class="col-sm-4">
			<input type="text" id="officePhone" name="officePhone" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.office.phone' />" class="form-control" value="${orgUser.officePhone}" />
		</div>
		<label for="txtHomePhone" class="col-sm-2 control-label"><spring:message code="tds.user.label.home.phone" /></label>
		<div class="col-sm-4">
			<input type="text" id="homePhone" name="homePhone" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.home.phone' />" value="${orgUser.homePhone}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtMobilePhone" class="col-sm-2 control-label"><spring:message code="tds.user.label.mobile.phone" /></label>
		<div class="col-sm-4">
			<input type="text" id="mobilePhone" name="mobilePhone" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.mobile.phone' />" value="${orgUser.mobilePhone}" />
		</div>
		<label for="txtFax" class="col-sm-2 control-label"><spring:message code="tds.user.label.fax" /></label>
		<div class="col-sm-4">
			<input type="text" id="fax" name="fax"  class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.fax' />" value="${orgUser.fax}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtEmail" class="col-sm-2 control-label"><spring:message code="tds.user.label.email" /></label>
		<div class="col-sm-4">
			<input type="email" id="email" name="email" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code='tds.user.label.email' />" value="${orgUser.email}" />
		</div>
		<label for="txtDuty" class="col-sm-2 control-label"><spring:message code="tds.user.label.receive.instant.messages" /></label>
		<div class="col-sm-4">
			<div class="form-control">
				<dictionary:radio code="yesOrNo" radioName="duty" checkValue="${orgUser.duty}"/>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtIsLimitMultiLogin" class="col-sm-2 control-label"><spring:message code="tds.user.label.allow.duplicate.entries" /></label>
		<div class="col-sm-4">
			<div class="form-control">
				<dictionary:radio code="yesOrNo" radioName="isLimitMultiLogin" checkValue="${orgUser.isLimitMultiLogin}"/>
			</div>
		</div>
		<label for="txtIsVirtual" class="col-sm-2 control-label"><spring:message code="tds.user.label.outside.system.account" /></label>
		<div class="col-sm-4">
			<div class="form-control">
				<dictionary:radio code="yesOrNo" radioName="isVirtual" checkValue="${orgUser.isVirtual}"/>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label for="isEnable" class="col-sm-2 control-label"><spring:message code="tds.user.label.isEnable" /></label>
		<div class="col-sm-4">
			<div class="form-control">
				<dictionary:radio code="yesOrNo" radioName="isEnable" checkValue="${orgUser.isEnable}"/>
			</div>
		</div>
		
		
		<label for="userRdn" class="col-sm-2 control-label"><spring:message code="tds.user.label.userRdn" /></label>
		<div class="col-sm-4">
				<input type="text" id="userRdn" name="userRdn" class="form-control" placeholder="<spring:message code='tds.common.label.input' /> <spring:message code="tds.user.label.userRdn" />" value="${orgUser.userRdn}" />
		</div>
		
	</div>
	
	<%--
	<div class="form-group">
		<label for="imsi" class="col-sm-2 control-label">IMSI</label>
		<div class="col-sm-4">
			<input type="text" id="imsi" name="imsi"  class="form-control" value="${orgUser.imsi}" />
		</div>
	</div>
	--%>
	
	<div class="form-group">
		<label for="txtLimitedIp" class="col-sm-2 control-label"><spring:message code="tds.user.label.limit.login.ip" /></label>
		<div class="col-sm-10">
			<textarea id="limitedIp" name="limitedIp" class="form-control" rows="2" placeholder="<spring:message code='tds.user.label.limit.login.ip.example' />">${orgUser.limitedIp }</textarea>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtRemark" class="col-sm-2 control-label"><spring:message code="tds.user.label.remark" /></label>
		<div class="col-sm-10">
			<textarea id="remark" name="remark" class="form-control" rows="2">${orgUser.remark }</textarea>
		</div>
	</div>
</form>

<jsp:include page="/tds/org/organization/user-base-info.js.jsp" />
