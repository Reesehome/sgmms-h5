<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<form id="holidayForm" class="form-horizontal">
	<input id="id" name="id" type="hidden" value="${calendarHoliday.id}">

	<div class="form-group">
		<label for="txtHolidayName" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.holidayName"/></label>
		<div class="col-sm-7">
			<input id="holidayName" name="holidayName"  class="form-control" placeholder="请输入<spring:message code='tds.calendar.holiday.label.holidayName'/>" value="${calendarHoliday.holidayName}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtStartDate" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.startDate"/></label>
		<div class="col-sm-7">
			<input id="startDate" name="startDate" class="form-control" placeholder="请输入<spring:message code='tds.calendar.holiday.label.startDate'/>"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtEndDate" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.endDate"/></label>
		<div class="col-sm-7">
			<input id="endDate" name="endDate" class="form-control" placeholder="请输入<spring:message code='tds.calendar.holiday.label.endDate'/>"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtIsLunar" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.isLunar"/></label>
		<div class="col-sm-7">
			<select class="form-control" id="isLunar" name="isLunar">
				<option value="n">否</option>
				<option value="y">是</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtIsYearPeriod" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.isYearPeriod"/></label>
		<div class="col-sm-7">
			<select class="form-control" id="isYearPeriod" name="isYearPeriod">
				<option value="n">否</option>
				<option value="y">是</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtYear" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.year"/></label>
		<div class="col-sm-7">
			<input id="year" name="year" class="form-control" placeholder="请输入<spring:message code='tds.calendar.holiday.label.year'/>" value="${calendarHoliday.year}" />
		</div>
	</div>
	
	<div class="form-group">
		<label for="txtHolidayDesc" class="col-sm-3 control-label"><spring:message code="tds.calendar.holiday.label.holidayDesc"/></label>
		<div class="col-sm-7">
			<textarea id="holidayDesc" name="holidayDesc" class="form-control" placeholder="请输入<spring:message code='tds.calendar.holiday.label.holidayDesc'/>">${calendarHoliday.holidayDesc}</textarea>
		</div>
	</div>
</form>

<script src="${ctx}/tds/calendar/calendar-holiday.js"></script>
<script type="text/javascript">
<!--
	$(document).ready(function() {
		initDateWidget();
		
		//初始化
		$("#isLunar").val('${calendarHoliday.isLunar}' == 'y' ? 'y' : 'n');
		$("#isYearPeriod").val('${calendarHoliday.isYearPeriod}' == 'y' ? 'y' : 'n');
		var startDate = '${calendarHoliday.startDate}';
		var endDate = '${calendarHoliday.endDate}';
		if(startDate) {
			$("#startDate").val(startDate.substring(0, 10));
		}
		if(endDate) {
			$("#endDate").val(endDate.substring(0, 10));
		}
	});
//-->
</script>