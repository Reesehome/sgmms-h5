<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Log</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<style>
	.vertical-space{margin-bottom: 10px; }
	.module-header{height: 40px;vertical-align: middle;display: table-cell;margin-left: -15px; }
	.ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
	.ui-widget-content .link:hover{color: #23527c;}
	.form-group .input-field{width: 180px;}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="module-header">
			<strong><i class="glyphicon glyphicon-list"></i> <spring:message code="baf.loginlog.label.loginSearch"/></strong>
		</div><!-- module-header -->
		<div>
			<!-- 查询条件 -->
			<div class="panel panel-info">
				<div class="panel-heading" style="min-height: 45px;">
					<b><spring:message code="tds.common.label.searchForm"/></b>
					<div class="btn-group pull-right">
	    				<button type="button"  class="btn btn-primary" onclick="exportLoginLog();"><spring:message code="baf.loginlog.label.exportLoginLog"/></button>
	    			</div>
				</div>
				<div class="panel-body">
					<form id="searchLoginForm" class="form-inline">
						
						<div class="col-sm-10 form-group" style="margin-left: 10%;">
							<label class="control-label" for="beginTime"><spring:message code="baf.loginlog.label.loginTime"/></label>
							<input id="beginTime" value="${yesterday }" name="beginTime" class="input-field form-control" placeholder="<spring:message code='baf.loginlog.label.selectStartTime'/>" readonly="readonly">
							
							<label class="control-label" for="endTime"><spring:message code="baf.loginlog.label.to"/></label>
							<input id="endTime" value="${today }" name="endTime" class="input-field form-control" placeholder="<spring:message code='baf.loginlog.label.selectEndTime'/>" readonly>
							
							<div class="btn-group">
								<button type="button" class="btn btn-primary" onclick="searchLoginLog();"><spring:message code="tds.common.label.search" /></button>
								<button type="button" class="btn btn-success" onclick="cleanSearchForm();"><spring:message code="tds.common.label.clean" /></button>
							</div>
						</div>
					</form>
					<form id="ExportLoginLogForm" action="${ctx }/admin/loginlog/exportLoginLog.do" target="ExportLoginLogFrame">
						<input type="hidden" value="" name="beginTime"/>
						<input type="hidden" value="" name="endTime"/>
						<input type="hidden" value="" name="version"/>
					</form>
				</div>
			</div>
		</div>
		<div class="vertical-space"></div>
		<div>
			<div class="panel panel-info">
				<div class="panel-heading"><b><spring:message code="baf.loginlog.label.loginList"/></b></div>
				<div class="panel-body">
			    	<table id="loginLogGrid"></table> 
 					<div id="loginLogGridPager"></div> 
				</div>
			</div>
		</div>
	</div>
	<iframe id="ExportLoginLogFrame" name="ExportLoginLogFrame" style="display: none;"></iframe>
<script type="text/javascript">
	function getContext(){
		return '${ctx}';
	}
	var i18n = {
		'a':'<spring:message code="baf.loginlog.label.operateUser"/>',
		'b':'<spring:message code="baf.loginlog.label.loginName"/>',
		'c':'<spring:message code="baf.loginlog.label.loginTime"/>',
		'd':'<spring:message code="baf.loginlog.label.loginIP"/>',
		'e':'<spring:message code="baf.loginlog.label.loginResult"/>',
		'f':'<spring:message code="baf.loginlog.label.timeLast"/>',
		'g':'<spring:message code="baf.loginlog.label.offlineStatus"/>',
		'h':'<spring:message code="baf.loginlog.label.sysLog"/>',
		'i':'<spring:message code="tds.common.label.view"/>',
		'j':'<spring:message code="baf.loginlog.label.sysLogInfo"/>',
		'k':'<spring:message code="tds.common.label.close"/>',
		'l':'<spring:message code="tds.common.label.hour"/>',
		'm':'<spring:message code="tds.common.label.minute"/>'
	};
	
	function exportLoginLog(){
		BootstrapDialog.confirm({
			title: '<spring:message code="tds.common.label.alertTitle"/>',
			message: exportMessage(),
			type: BootstrapDialog.TYPE_WARNING,
			closable: true,
			draggable: true,
			btnCancelLabel: '<spring:message code="tds.common.label.cancel"/>',
			btnOKLabel: '<spring:message code="tds.common.label.confirm"/>',
			btnOKClass: 'btn-primary',
			callback: function(result){
			    if(result) {
			    	$('#ExportLoginLogForm input[name="beginTime"]').val($('#beginTime').val());
					$('#ExportLoginLogForm input[name="endTime"]').val($('#endTime').val());
					$('#ExportLoginLogForm input[name="version"]').val($('#versionDiv').find('input[name="version"]:checked').val());
					$('#ExportLoginLogForm').submit();
			    }
			}
		});
	}
	
	function exportMessage(){
		var message = '<div id="versionDiv">';
		message += '<label class="control-label" style="margin-right: 5px;" for="beginTime"><spring:message code="baf.loginlog.message.selectExcelVersion"/></label>';
		message += '<label class="radio-inline"><input type="radio" name="version" id="version1" value="2003"> 2003</label>';
		message += '<label class="radio-inline"><input type="radio" name="version" id="version2" value="gt2003"> 2007 <spring:message code="tds.common.label.orHighVersion"/></label>';
		message += '</div>';
		return message;
	}
	
	
</script>
<script type="text/javascript" src="${ctx }/tds/log/login.log.js"></script>
</body>
</html>