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
		
		<jsp:include page="/tds/workflow/js/process-start.js.jsp" />
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
				<span><strong><i class="glyphicon glyphicon-list"></i> 发起流程</strong></span>
			</div>
			
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		        <form id="startProcess" action="${ctx}/admin/workflow/deploy.do" method="post" >
		        </form>
		        	
		        	<div class="panel panel-info">
						<div class="panel-heading">
							流程列表
						</div>
						<div id="tablePanel" class="panel-body">
					    	<table id="list"></table> 
					    	 <input id="message" type="hidden" name="message" value="${message}"/>
   							<div id="gridpager"></div> 
						</div>
					</div>
		        </div>
		    </div>
		</div>
	</body>
</html>