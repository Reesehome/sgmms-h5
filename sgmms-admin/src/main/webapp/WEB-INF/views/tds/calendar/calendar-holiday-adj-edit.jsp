<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<form id="holidayAdjForm" class="form-horizontal">
	<input id="id" name="id" type="hidden" value="${calendarHolidayAdj.id}">

	<div class="form-group">
		<label for="txtAdjustName" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.adjustName"/></label>
		<div class="col-sm-7">
			<input id="adjustName" name="adjustName"  class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.adjustName'/>" value="${calendarHolidayAdj.adjustName}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtAdjustType" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.adjustType"/></label>
		<div class="col-sm-7">
			<select class="form-control" id="_adjustType" name="adjustType">
				<option value="R"><spring:message code="tds.calendar.holidayadj.label.adjustType.R" /></option>
				<option value="W"><spring:message code="tds.calendar.holidayadj.label.adjustType.W" /></option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtStartDate" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.startDate"/></label>
		<div class="col-sm-7">
			<input id="_startDate" name="startDate" class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.startDate'/>" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtEndDate" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.endDate"/></label>
		<div class="col-sm-7">
			<input id="_endDate" name="endDate" class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.endDate'/>"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtAdjustDesc" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.adjustDesc"/></label>
		<div class="col-sm-7">
			<textarea id="adjustDesc" name="adjustDesc" class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.adjustDesc'/>">${calendarHolidayAdj.adjustDesc}</textarea>
		</div>
	</div>
</form>

<script src="${ctx}/tds/calendar/calendar-holiday-adj.js"></script>
<script type="text/javascript">
<!--
	$(document).ready(function() {
		initEditDateWidget();
		
		//初始化
		$("#_adjustType").val('${calendarHolidayAdj.adjustType}' == 'W' ? 'W' : 'R');
		var startDate = '${calendarHolidayAdj.startDate}';
		var endDate = '${calendarHolidayAdj.endDate}';
		if(startDate) {
			$("#_startDate").val(startDate.substring(0, 10));
		}
		if(endDate) {
			$("#_endDate").val(endDate.substring(0, 10));
		}
	});
//-->
</script>