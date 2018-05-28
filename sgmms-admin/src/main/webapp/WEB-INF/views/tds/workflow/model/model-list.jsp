<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%
  String   message= (String)request.getAttribute("message");
 // System.out.println("message===="+message);
%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title><spring:message code="tds.sys.property.title"/></title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<jsp:include page="/tds/workflow/model/model.js.jsp" />
		<style type="text/css">
		.vertical-space{margin-bottom: 10px; }
	    .module-header{height: 40px;vertical-align: middle;display: table-cell;}
	    .form-group .input-field{width: 50%;}
	   .ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
	   .ui-widget-content .link:hover{color: #23527c;}
		</style>
		<script type="text/javascript">
		
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row module-header">
				<span><strong><i class="glyphicon glyphicon-list"></i> 流程模型</strong></span>
			</div>
				 
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		        	<div class="panel panel-info">
		        	
						<div class="panel-heading clearfix">
							
							<span class="pull-left" style="padding-top: 7.5px;">流程模型列表</span>
							<button type="button"  class="btn btn-primary pull-right"  onclick="createModel()">创建新流程模型</button>
						</div>
						<div id="tablePanel" class="panel-body">
						   <input type="hidden" id='message' name="message" value="<%=message %>" />
					    	<table id="list"></table> 
   							<div id="gridpager"></div> 
						</div>
					</div>
		        </div>
		    </div>
		</div>
	</body>
</html>