<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>管理首页</title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<style type="text/css">
			.vertical-space{margin-bottom: 10px; }
			.ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
			.ui-widget-content .link:hover{color: #23527c;}
			.module-header{height: 40px;vertical-align: middle;display: table-cell; }
			.form-group .pure-label{width: 20%;}
			.form-group .title-label{width: 100px;}
			.form-group .input-field{width: 180px;}
		</style>
	</head>
	<body>
		<div class="container-fluid">
			<div class="module-header">
				<strong><i class="glyphicon glyphicon-list"></i> <spring:message code="baf.syslog.label.logSearch"/></strong>
			</div><!-- module-header -->
		    <div>
		        <div id="mainContainerBox">
		        	<div class="panel panel-info">
						<div class="panel-heading">
							<b><spring:message code="tds.common.label.searchForm"/></b>
						</div>
						<div class="panel-body">
							<form id="searchForm" class="form-inline">
								<div class="col-sm-4 form-group">
									<label class="control-label title-label" for="startTime"><spring:message code="baf.syslog.label.logTime"/></label>
									<input id="startTime" value="${yesterday }" name="startTime" class="input-field form-control" placeholder="<spring:message code="baf.syslog.label.selectStartTime"/>" readonly="readonly">
								</div>
								<div class="col-sm-4 form-group">
									<label class="control-label title-label" for="endTime"><spring:message code="baf.syslog.label.to"/></label>
									<input id="endTime" value="${today }" name="endTime" class="input-field form-control" placeholder="<spring:message code="baf.syslog.label.selectEndTime"/>" readonly="readonly">
								</div>
								<div class="col-sm-12" style="margin-bottom: 3px;"></div>
								<div class="col-sm-4 form-group">
<!-- 									<label class="control-label pure-label">  </label> -->
									<label class="control-label title-label" for="logsource"><spring:message code="baf.syslog.label.logSource"/></label>
									<select id="logsource" class="form-control input-field" name="logSource">
										<option value=""></option>
										<c:if test="${not empty logSource }">
											<c:forEach var="aSource" items="${logSource }">
												<option value="${aSource.value }">${aSource.name }</option>
											</c:forEach>
										</c:if>
									</select>
								</div>
								<div class="col-sm-6 form-group">
									<label class="control-label title-label" for="loglevel"><spring:message code="baf.syslog.label.logLevel"/></label>
									<select id="loglevel" class="form-control input-field" name="logLevel">
										<option value=""></option>
										<c:if test="${not empty logLevel }">
											<c:forEach var="aLevel" items="${logLevel }">
												<option value="${aLevel.value }">${aLevel.name }</option>
											</c:forEach>
										</c:if>
									</select>
									<div class="btn-group">
										<button type="button" class="btn btn-primary" onclick="searchLog()"><spring:message code="tds.common.label.search" /></button>
										<button type="button" class="btn btn-success" onclick="cleanForm()"><spring:message code="tds.common.label.clean" /></button>
									</div>
								</div>
							</form>
						</div>
					</div>
		        	<div class="vertical-space"></div>
		        	<div class="panel panel-info">
						<div class="panel-heading"><b><spring:message code="baf.syslog.label.logList"/></b></div>
						<div class="panel-body">
					    	<table id="list"></table> 
   							<div id="gridpager"></div> 
						</div>
					</div>
		        </div>
		    </div>
		</div>
		<jsp:include page="/tds/log/log.jsp" />
	</body>
</html>