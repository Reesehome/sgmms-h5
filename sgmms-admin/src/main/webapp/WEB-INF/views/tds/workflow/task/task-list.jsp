<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title><spring:message code="tds.sys.property.title"/></title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
	    <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.css" rel="stylesheet">
		<script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.js"></script>
		
		<jsp:include page="/tds/workflow/task/task-list.js.jsp" />
		<jsp:include page="/tds/workflow/processInstance/workflow.js.jsp" />
		<jsp:include page="/tds/workflow/task/task-turn.js.jsp" />
		
		<style type="text/css">
		.vertical-space{margin-bottom: 10px; }
	    .module-header{height: 40px;vertical-align: middle;display: table-cell;}
	    .form-group .input-field{width: 50%;}
	   .ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
	   .ui-widget-content .link:hover{color: #23527c;}
		</style>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row module-header">
				<span><strong><i class="glyphicon glyphicon-list"></i> 代办任务</strong></span>
			</div>
			
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		      
		        	<div class="panel panel-info">
						<div class="panel-heading">
							代办任务列表
						</div>
						<div id="tablePanelTask" class="panel-body">
					    	<table id="listTask"></table> 
					    	 <input id="messageTask" type="hidden" name="message" value="${message}"/>
   							<div id="gridpagerTask"></div> 
						</div>
					</div>
		        </div>
		    </div>
		</div>
	</body>
</html>