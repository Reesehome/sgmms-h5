<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<link rel="stylesheet" href="${ctx}/tds/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<link rel="stylesheet" href="${ctx}/tds/common/ztree-ext.css" type="text/css">
		
		<link rel="stylesheet" href="${ctx}/tds/menu-right/css/menuRight.css" type="text/css">
		
		<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
		
		<script type="text/javascript" src="${ctx}/tds/common/ztree-ext.js"></script>
		
		<jsp:include page="/tds/menu-right/js/index.js.jsp" />
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" style="height:10%;padding-top:10px;padding-bottom: 10px;">
				<div class="col-sm-12">
		        	<span class="glyphicon glyphicon-wrench"></span> <strong><spring:message code="tds.menuRight.label.menuAndPermissions"/></strong>
		        </div>
			</div>
        	
			<div class="row">
				<!-- 左边功能树 -->
				<div class="col-xs-4 col-md-3" style="padding-right: 1px">
					<div id="treePanel" class="panel panel-info">
						<div id="treePanelHeader" class="panel-heading clearfix">
							<span class="pull-left" style="height: 34px;padding-top: 7.5px;"><b><spring:message code="tds.menuRight.label.menuTree"/></b></span>
						</div>
						
						<div id="treePanelBody" onContextMenu="showRightMenu(event,'treePanelRightMenu');return false;" class="panel-body" style="height:600px;overflow: auto;">
							<ul id="tree" class="ztree"></ul>
						</div>
					</div>
				</div>
		        
		    	<!-- 右边编辑页面 -->
				<div class="col-xs-8 col-md-9" style="padding-left: 1px">
					<div class="panel panel-info">
						<div class="panel-heading clearfix">
							<span class="pull-left" style="padding-top: 7.5px;"><b><spring:message code="tds.menuRight.label.editProperty"/></b></span>
							<button type="button" class="btn btn-primary pull-right" onclick="editMenuRight()">　<spring:message code="tds.common.label.save"/>　</button>
						</div>
						<div id="mainContainer" class="panel-body" style="min-height:600px;"></div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 树右键菜单 -->
		<div id="treeRightMenu" class="list-group">
			<a href="javascript:addMenu('executeTypeAddLevel');void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.menuRight.label.addSameLevelMenu"/></a>
			<a href="javascript:addMenu('executeTypeAddSub');void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.menuRight.label.addSubMenu"/></a>
			<a href="javascript:deleteMenu();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>　<spring:message code="tds.common.label.delete"/></a>
		</div>
		
		<!-- 树面板右键菜单 -->
		<div id="treePanelRightMenu" class="list-group">
			<a href="javascript:addMenu('executeTypeAddTop');void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.menuRight.label.addTopMenu"/></a>
		</div>
	</body>
</html>