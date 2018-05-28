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
		
		<jsp:include page="/tds/workflow/js/process.js.jsp" />
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
				<span><strong><i class="glyphicon glyphicon-list"></i> 流程发布</strong></span>
			</div>
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		        	
		        	<div class="panel panel-info">
						<div class="panel-heading ">部署新流程</div>
						<div id="deploymentBody" >
							<div class="panel-body">
								<form id="deploymentForm" action="${ctx}/admin/workflow/deploy.do" class="form-horizontal" method="post" enctype="multipart/form-data">
									  <input id="message" type="hidden" name="message" value="${message}"/>
									   <div class="form-group">
									     <div class="col-sm-12">
								         <div>支持文件格式：zip、bar、bpmn、bpmn20.xml</div>
								         </div>
								       </div>
									 
									  <div class="form-group">
											<div class="col-sm-6">
											    <div class="input-group">
											          <input id="upload" name="file"  type="file" style="display:none">
												      <input type="text" readonly="readonly" class="form-control" id="uploadId" placeholder="未选择文件">
												      <div class="input-group-addon" id="selectBtn" onclick="$('input[id=upload]').click();">选择文件</div>

											    </div>
											</div>
											
											<div class="col-sm-2">
											<button type="button" class="btn btn-primary" onclick="publicDeploy()">发布</button>
										    </div>
									 </div>
									 
								</form>
							</div>
							
						</div>
					</div>
		        	
		        	
		            <div class="vertical-space"></div> 
		        	<div class="panel panel-info">
						<div class="panel-heading">
							流程列表
						</div>
						<div id="tablePanel" class="panel-body">
					    	<table id="list"></table> 
   							<div id="gridpager"></div> 
						</div>
					</div>
		        </div>
		    </div>
		</div>
	</body>
</html>