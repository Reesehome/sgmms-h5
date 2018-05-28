<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>节假日配置管理</title>
	
	<jsp:include page="/tds/common/ui-lib.jsp" />
	<jsp:include page="/tds/calendar/calendar-holiday.jsp" />
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<br>
	        	<a href="#"><strong><i class="glyphicon glyphicon-calendar"></i> 日历管理</strong></a>
	        	<hr>
	        </div>
		</div>
	    <div class="row">
	        <div class="col-sm-12" id="mainContainerBox">
	        	<div class="panel panel-info">
					<div class="panel-heading">
						<b><spring:message code="tds.common.label.searchForm"/></b>
					</div>
					<div class="panel-body">
						<form id="searchForm" class="form-horizontal">
							<div class="form-group">
								<label for="txtHolidayName" class="col-sm-2 control-label"><spring:message code="tds.calendar.holiday.label.holidayName"/></label>
								<div class="col-sm-2">
									<input id="holidayName" name="holidayName" class="form-control" placeholder="<spring:message code='tds.calendar.holiday.label.holidayName'/>">
								</div>
								
								<label for="txtYear" class="col-sm-2 control-label"><spring:message code="tds.calendar.holiday.label.year"/></label>
								<div class="col-sm-2">
									<input id="year" name="year" class="form-control" placeholder="<spring:message code='tds.calendar.holiday.label.year'/>">
								</div>
								<div class="col-sm-4">
									<button type="button" class="btn btn-primary" onclick="queryCalendarHoliday()"><spring:message code="tds.common.label.search" /></button>
									<button type="button" class="btn btn-primary" onclick="cleanForm()"><spring:message code="tds.common.label.clean" /></button>
								</div>
							</div>
						</form>
					</div>
				</div>
	        
	        	<div class="panel panel-info">
					<div class="panel-heading">
						<button type="button"  class="btn btn-primary" onclick="showEdieWindow('add')"><spring:message code="tds.common.label.add" /></button>
						<button type="button" class="btn btn-success" onclick="showEdieWindow('update')"><spring:message code="tds.common.label.update" /></button>
						<button id="btnDelete" type="button" class="btn btn-warning"><spring:message code="tds.common.label.delete" /></button>
					</div>
					<div class="panel-body">
				    	<table id="list"></table> 
						<div id="gridpager"></div> 
					</div>
				</div>
	        </div>
	    </div>
	</div>
</body>
</html>