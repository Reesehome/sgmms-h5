<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tisson.tds.workflow.util.ProcessDefinitionCache,org.activiti.engine.RepositoryService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

   

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title><spring:message code="tds.sys.property.title"/></title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
	
		<jsp:include page="/tds/workflow/processInstance/processMontor-main.js.jsp" />
		
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
			<div class="module-header">
				<span><strong><i class="glyphicon glyphicon-list"></i> 流程监控</strong></span>
			</div>
			   <!-- tab -->
			   <ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active" onclick="processListTab()"><a href="#processListTab" aria-controls="processListTab" role="tab" data-toggle="tab">流程实例列表</a></li>
				    <li role="presentation" onclick="allTaskTab()"><a href="#allTaskTab" aria-controls="allTaskTab" role="tab" data-toggle="tab">全部任务列表</a></li>
               </ul>
              
               <div class="tab-content">
                    <div class="vertical-space"></div>
				    <div role="tabpanel" class="tab-pane active" id="processListTab">
				          <div id="processListTabMainbox"></div>
				    </div>
				    <div role="tabpanel" class="tab-pane" id="allTaskTab" >
				          <div id="allTaskTabMainbox"></div>
				    </div>
               </div>
               <!-- end tab -->
		</div>
	</body>
</html>