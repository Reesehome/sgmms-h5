<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><spring:message code="tds.db.label.dbmanager" /></title>
		<jsp:include page="/tds/common/ui-lib.jsp" />
		<style type="text/css">
			html,body{height: 100%;}
			.full-height{height: 100%;}
			.full-width{width: 100%;}
			.tree-font-color{color: rgb(110, 130, 155);}
			.horizontal{display: inline-block;vertical-align: top;}
			.horizontal + .horizontal{padding-left: 5px;margin-left: -5px;}
			.panel-body-addition{height: 100%;}
			.panel-body-content{height: 100%;overflow: auto;}
			.module-header{height: 40px;vertical-align: middle;display: table-cell;}
			.module-body{padding-top: 40px;margin-top: -40px;}
		</style>
	</head>
	<body>
		<div class="container-fluid full-height">
			<div class="row module-header">
				<strong><i class="glyphicon glyphicon-list"></i><spring:message code="tds.db.label.dbmanager" /></strong>
			</div>
		    <div class="row module-body full-height">
	        	<div class="panel panel-info">
					<div class="panel-heading" style="height: 45px;">
						<div class="btn-group pull-right">
							<button type="button" class="btn btn-primary" id="dashboardAdd"><spring:message code="tds.common.label.add" /></button>
							<button type="button" class="btn btn-primary" id="dashboardEdit"><spring:message code="tds.common.label.edit" /></button>
							<button type="button" class="btn btn-primary" id="dashboardWidgetEdit"><spring:message code="tds.db.btn.widgetEdit" /></button>
							<button type="button" class="btn btn-warning" id="dashboardDelete"><spring:message code="tds.common.label.delete" /></button>
						</div>
					</div>
					<div class="panel-body">
				    	<table id="dashboardTable"></table> 
				    	<div id="dashboardGridpager"></div> 
					</div>
				</div>
		    </div>
		</div>
		<jsp:include page="/tds/dashboard/dashboard-manager.js.jsp" />
	</body>
</html>