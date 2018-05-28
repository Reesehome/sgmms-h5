<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Current Authority</title>
</head>
<body>
	<div class="horizontal full-height full-width">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
			<div class="panel-heading" style="min-height: 45px;">
				<b><spring:message code="tds.authority.label.currentAuthority"/></b>
				<div class="btn-group pull-right">
    				<button id="saveGroup" onclick="clickSaveGroup();" type="button" class="btn btn-primary pull-right"><spring:message code="tds.common.label.save"/></button>
    			</div>
			</div>
			<div class="panel-body">
				<form:form id="GroupForm" class="form-horizontal" modelAttribute="group" role="form">
					<input id="oldName" type="hidden" value="${group.name}"/>
					<div class="form-group">
				    	<label for="groupName"class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.name"></spring:message></label>
				   		<div class="col-sm-8">
					    	<form:input path="name" class="required form-control" id="groupName" value="${group.name }"/>
					    </div>
				  	</div>
				  	<div class="form-group">
				    	<label for="groupDesc" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.description"></spring:message></label>
				    	<div class="col-sm-8">
				    		<form:textarea rows="1" path="description" class="form-control" max-length="128" id="groupDesc"  value="${group.description }"/>
				    	</div>
				  	</div>
				  	<form:hidden path="id" value="${group.id }" id="groupId"/>
				  	<form:hidden path="isValid" value="${group.isValid }" id="isValid"/>
				  	<form:hidden path="sortOrder" value="${group.sortOrder }" id="sortOrder"/>
				  	<form:hidden path="creatorId" value="${group.creatorId }" id="creatorId"/>
				  	
				  	<input type="hidden" name="rightIds" value="" id="rightIds"/>
				  	<input type="hidden" name="orgIds" value="" id="orgIds"/>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>