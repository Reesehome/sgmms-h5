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
		
		<jsp:include page="/tds/sysProperties/js/table.js.jsp" />
		<style type="text/css">
		.vertical-space{margin-bottom: 10px; }
	    .module-header{height: 40px;vertical-align: middle;display: table-cell;}
	    .form-group .input-field{width: 50%;}
		</style>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row module-header">
				<span><strong><i class="glyphicon glyphicon-list"></i> <spring:message code="tds.sys.property.list"/></strong></span>
			</div>
			
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		        	<div class="panel panel-info">
						<div class="panel-heading ">
						<spring:message code="tds.common.label.searchForm"/>
<%-- 							<h4 class="panel-title pull-left" style="padding-top: 2px;"><spring:message code="tds.common.label.searchForm"/></h4> --%>
							
<!-- 							<div class="pull-right"> -->
<!-- 								<a class="btn btn-default btn-xs" role="button" data-toggle="collapse" href="#searchBody"> -->
<!-- 									<span class="glyphicon glyphicon-chevron-up"></span> -->
<!-- 								</a> -->
<!-- 							</div> -->
						</div>
						<div id="searchBody" >
							<div class="panel-body">
								<form id="searchForm" class="form-horizontal">
									<div class="form-group">
										<label for="txtTitle" class="col-sm-2 control-label"><spring:message code="tds.sys.property.key"/></label>
										<div class="col-sm-3">
											<input id="propKey" name="propKey" class="form-control" placeholder="<spring:message code='tds.sys.property.inputkey'/>">
										</div>
										
										<label for="txtPrice" class="col-sm-2 control-label"><spring:message code="tds.sys.property.value"/></label>
										<div class="col-sm-3">
											<input id="propValue" name="propValue" class="form-control" placeholder="<spring:message code='tds.sys.property.inputvalue'/>">
										</div>
									
									    <div class="col-sm-2">
											
											<div class="btn-group" role="group" aria-label="">
									         <button type="button" class="btn btn-primary" onclick="searchSysProperty()"><spring:message code="tds.sys.property.search"/></button>
											<button type="button" class="btn btn-success" onclick="cleanForm()"><spring:message code="tds.sys.property.clear"/></button>
							                </div>
										</div>
									
									</div>
									
								</form>
							</div>
						</div>
					</div>
		        <div class="vertical-space"></div>
		        	<div class="panel panel-info">
						<div class="panel-heading clearfix">
						    <span class="pull-left" style="padding-top: 7.5px;"><spring:message code="tds.sys.property.list"/></span>
<%-- 							<button type="button"  class="btn btn-primary" onclick="showEdieWindow('add')"><spring:message code="tds.sys.property.add"/></button> --%>
							
<%-- 							<button type="button" class="btn btn-success" onclick="showEdieWindow('update')"><spring:message code="tds.sys.property.update"/></button> --%>
							
<%-- 							<button id="btnDelete" type="button" class="btn btn-warning"><spring:message code="tds.sys.property.delete"/></button> --%>
						
							   <div class="btn-group pull-right" role="group" aria-label="">
									  <button type="button" class="btn btn-primary" onclick="showEdieWindow('add')"><spring:message code="tds.sys.property.add"/></button>
									  <button type="button" class="btn btn-success" onclick="showEdieWindow('update')"><spring:message code="tds.sys.property.update"/></button>
									  <button type="button" onclick="deleteSys()" id="btnDelete" class="btn btn-warning"><spring:message code="tds.sys.property.delete"/></button>
							   </div>
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