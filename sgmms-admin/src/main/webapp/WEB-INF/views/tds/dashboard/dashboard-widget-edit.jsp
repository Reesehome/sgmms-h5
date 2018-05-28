<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!doctype html>
<html>
<head>
<title>${title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/tds/common/ui-lib.jsp" />
<link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.css">
<link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/demo.css">
${dashboardCSS}
<script src="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.js" type="text/javascript" charset="utf-8"></script>
${dashboardJS}
<style type="text/css">
.dropdown-menu {
	left:;
}
html,body{height: 100%;}
body {
 margin: 0px;
}
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
		<strong><i class="glyphicon glyphicon-list"></i> <spring:message code="tds.db.widget.label.dbWidgetEdit" /></strong>
	</div>
    <div class="row module-body full-height">
    	<div class="panel panel-default">
			<div class="panel-heading " style="height: 40px">
				<h3 class="panel-title">${title}</h3>
				<div class="btn-group pull-right" style="top: -19px;">
					<button type="button" class="btn btn-default" id="widgetAdd"><spring:message code="tds.common.label.add" /></button>
					<button type="button" class="btn btn-default" id="widgetSave"><spring:message code="tds.common.label.save" /></button>
					<button type="button" class="btn btn-default" id="widgetBack"><spring:message code="tds.common.label.return" /></button>
				</div>
			</div>
			<div class="panel-body">
				<div class="gridster">
					<ul></ul>
				</div>
			</div>
		</div>
		${widgetHtml}
    </div>
</div>
</body>
</html>

<jsp:include page="/tds/dashboard/dashboard-widget-edit.js.jsp" />