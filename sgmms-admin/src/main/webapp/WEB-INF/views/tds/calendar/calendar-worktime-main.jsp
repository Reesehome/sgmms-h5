<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>工作日配置管理</title>
	
	<jsp:include page="/tds/common/ui-lib.jsp" />
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<br>
	        	<a href="#"><strong><i class="glyphicon glyphicon-list"></i> 数据列表</strong></a>
	        	<hr>
	        </div>
		</div>
	    <div class="row">
	        <div class="col-sm-12" id="mainContainerBox">
	        	<form id="worktimeForm" class="form-horizontal">
					<input id="id" name="id" type="hidden" value="${calendarWorktime.id}">
					<div class="form-group">
						<label for="workday" class="col-sm-2 col-md-offset-2 control-label"><spring:message code="tds.calendar.worktime.label.workday" /></label>
						<div class="col-sm-7">
							<input type="checkbox" name="workday" value="1"> <spring:message code="tds.common.label.monday" />
							<input type="checkbox" name="workday" value="2"> <spring:message code="tds.common.label.tuesday" />
							<input type="checkbox" name="workday" value="3"> <spring:message code="tds.common.label.wednesday" />
							<input type="checkbox" name="workday" value="4"> <spring:message code="tds.common.label.thursday" />
							<input type="checkbox" name="workday" value="5"> <spring:message code="tds.common.label.friday" />
							<input type="checkbox" name="workday" value="6"> <spring:message code="tds.common.label.saturday" />
							<input type="checkbox" name="workday" value="7"> <spring:message code="tds.common.label.sunday" />
						</div>
					</div>
					
					<div class="form-group">
						<label for="txtOnMorHour" class="col-sm-2 col-md-offset-2 control-label"><spring:message code="tds.calendar.worktime.label.onMorningTime"/></label>
						<div class="col-sm-4 input-group">
							<input type="number" min="0" max="23" id="onMorHour" name="onMorHour" class="form-control" value="${calendarWorktime.onMorHour}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.hour" /></span>
							<input type="number" min="0" max="59" id="onMorMinute" name="onMorMinute" class="form-control" value="${calendarWorktime.onMorMinute}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.minute" /></span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="txtOffMorHour" class="col-sm-2 col-md-offset-2 control-label"><spring:message code="tds.calendar.worktime.label.offMorningTime"/></label>
						<div class="col-sm-4 input-group">
							<input type="number" min="0" max="23" id="offMorHour" name="offMorHour" class="form-control" value="${calendarWorktime.offMorHour}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.hour" /></span>
							<input type="number" min="0" max="59" id="offMorMinute" name="offMorMinute" class="form-control" value="${calendarWorktime.offMorMinute}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.minute" /></span>
						</div>
					</div>
					
					<div class="form-group">
						<label for="txtOnAftHour" class="col-sm-2 col-md-offset-2 control-label"><spring:message code="tds.calendar.worktime.label.onAfternoonTime"/></label>
						<div class="col-sm-4 input-group">
							<input type="number" min="0" max="23" id="onAftHour" name="onAftHour" class="form-control" value="${calendarWorktime.onAftHour}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.hour" /></span>
							<input type="number" min="0" max="59" id="onAftMinute" name="onAftMinute" class="form-control" value="${calendarWorktime.onAftMinute}"/>
							<span class="input-group-addon"><spring:message code="tds.common.label.minute" /></span>
						</div>
					</div>
					<div class="form-group">
						<label for="txtOffAftHour" class="col-sm-2 col-md-offset-2 control-label"><spring:message code="tds.calendar.worktime.label.onAfternoonTime"/></label>
						<div class="col-sm-4 input-group">
							<input type="number" min="0" max="23" id="offAftHour" name="offAftHour" class="form-control" value="${calendarWorktime.offAftHour}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.hour" /></span>
							<input type="number" min="0" max="59" id="offAftMinute" name="offAftMinute" class="form-control" value="${calendarWorktime.offAftMinute}" />
							<span class="input-group-addon"><spring:message code="tds.common.label.minute" /></span>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-5 col-md-offset-2 control-label">
							<button type="button" id="saveBtn" class="btn btn-primary"><spring:message code="tds.common.label.save" /></button>
						</div>
					</div>
				</form>
	        </div>
	    </div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		var workdays = '${workdays}';
		if(workdays) {
			$.each(workdays.split("#"), function(index, value) {
				$("input[name=workday][value="+ value + "]:checkbox").attr("checked", true);
			});
		};
		
		//save calendar worktime infomations
		$("#saveBtn").click(function() {
			var workdays = [];
			$("input[name=workday]:checked").each(function(index, value) {
				workdays[index] = $(this).val();
			});
			if(workdays.length <= 0) {
				BootstrapDialog.show({
					title: '<spring:message code="tds.common.label.errorMessage"/>',
		            size: BootstrapDialog.SIZE_SMALL,
		            type : BootstrapDialog.TYPE_WARNING,
		            message: "工作日不能为空",
		            buttons: [{
		                label: '<spring:message code="tds.common.label.close"/>',
		                action : function(dialogItself) {
		                	dialogItself.close();
		                }
		            }]
		        });
				return;
			}
			var params = $("#worktimeForm").serialize();
			params += "&workdays=" + workdays;
			$.tdsAjax({
				url:ctx + "/admin/calendar/worktime/saveCalendarWorktime.do",
				cache:false,
				type : "post",
				dataType:"json",
				data:params,
				success: function(result){
					if(result.success) {
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.alertTitle"/>',
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action : function(dialogItself) {
				                	dialogItself.close();
				                }
				            }]
				        });
					}else {
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action : function(dialogItself) {
				                	dialogItself.close();
				                }
				            }]
				        });
					}
				}
			});
		});
	});
</script>

</html>