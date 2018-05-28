<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>调班调休管理</title>
	
	<jsp:include page="/tds/common/ui-lib.jsp" />
	<jsp:include page="/tds/calendar/calendar-holiday-adj.jsp" />
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
	        	<div class="panel panel-info">
					<div class="panel-heading">
						<h4><spring:message code="tds.common.label.searchForm"/></h4>
					</div>
					<div class="panel-body">
						<form id="searchForm" class="form-horizontal">
							<div class="form-group">
								<label for="txtAdjustName" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.adjustName"/></label>
								<div class="col-sm-3">
									<input id="adjustName" name="adjustName" class="form-control" placeholder="请输入<spring:message code='tds.calendar.holidayadj.label.adjustName'/>">
								</div>
								
								<label for="txtAdjustType" class="col-sm-2 control-label"><spring:message code="tds.calendar.holidayadj.label.adjustType"/></label>
								<div class="col-sm-2">
									<select class="form-control" id="adjustType" name="adjustType">
										<option value="" selected="selected">--请选择--</option>
										<option value="R"><spring:message code="tds.calendar.holidayadj.label.adjustType.R" /></option>
										<option value="W"><spring:message code="tds.calendar.holidayadj.label.adjustType.W" /></option>
									</select>
								</div>
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary" onclick="queryCalendarHoliday()"><spring:message code="tds.common.label.search" /></button>
								</div>
							</div>
							<div class="form-group">
								<label for="txtStartDate" class="col-sm-3 control-label"><spring:message code="tds.calendar.holidayadj.label.rang.startDate"/></label>
								<div class="col-sm-3">
									<input id="startDate" name="startDate" class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.startDate'/>" readonly="readonly">
								</div>
								<label for="txtEndDate" class="col-sm-2 control-label"><spring:message code="tds.calendar.holidayadj.label.rang.endDate"/></label>
								<div class="col-sm-2">
									<input id="endDate" name="endDate" class="form-control" placeholder="<spring:message code='tds.calendar.holidayadj.label.endDate'/>" readonly>
								</div>
								<div class="col-sm-2">
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