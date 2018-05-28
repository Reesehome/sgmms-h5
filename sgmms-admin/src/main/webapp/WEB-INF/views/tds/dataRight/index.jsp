<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		
		<title>数据权限首页</title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		<link rel="stylesheet" href="${ctx}/tds/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<link rel="stylesheet" href="${ctx}/tds/common/ztree-ext.css" type="text/css">
		<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
		
		<jsp:include page="/tds/dataRight/js/index.js.jsp" />
	
		<style type="text/css">
			#treeRightMenu ,#root{
				display: none;
				width:230px;
				position: absolute;
				z-index: 1000;
			}
			
			.inner-panel{
			     margin-bottom: 6px;
			     margin-left: -5px;
			     margin-right: -5px;
			}
			.vertical-space{margin-bottom: 10px; }
			
		</style>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" style="height:10%">
				<div class="col-sm-12">
					<div class="vertical-space"></div>
		        	<span class="glyphicon glyphicon-wrench"></span> <strong><spring:message code="tds.dataRight.label.dataRight"/></strong>
		            <div class="vertical-space"></div>
		        </div>
			</div>
        	
			<div class="row" >
				<!-- 树对象 -->
				<div class="col-xs-4 col-md-3" style="padding-right: 1px">
					<div id="treePanel" class="panel panel-info" oncontextmenu="getFisrtTreeMenu()">
<%-- 						<div id="treePanelHeader" class="panel-heading"><b><spring:message code="tds.dataRight.label.dataRightTree"/></b></div> --%>
						
						<div id="treePanelHeader" class="panel-heading clearfix">
							<span class="pull-left" style="height: 34px;padding-top: 7.5px;"><b><spring:message code="tds.dataRight.label.dataRightTree"/></b></span>
						</div>
						
						<div id="treePanelBody" class="panel-body" style="height:650px;overflow: auto;">
							<ul id="tree" class="ztree"></ul>
						</div>
					</div>
				</div>
		        
		    	<!-- 右边编辑页面 -->
				<div class="col-xs-8 col-md-9" style="padding-left: 1px;">
					<div class="panel panel-info" >
<%-- 						<div class="panel-heading" id="right-panel"><b><spring:message code="tds.dataRight.label.dataRightInfo"/></b></b> --%>
<%-- 						<button id="cumBtn-temple"   type="button" style="float: right;" class="btn btn-primary  btn-xs" onclick="">　<spring:message code="tds.common.label.save"/>　</button> --%>
<!-- 						</div> -->
						
						<div class="panel-heading clearfix" id="right-panel" >
							<span class="pull-left" style="padding-top: 7.5px;"><b><spring:message code="tds.dataRight.label.dataRightInfo"/></b></span>
							<button id="cumBtn-temple"  type="button" class="btn btn-primary pull-right" onclick="">     <spring:message code="tds.common.label.save"/>     </button>
						</div>
						
						<div id="mainContainer" class="panel-body" style="height:650px;overflow: hidden;"></div>
					</div>
				</div>
			</div>
		</div>
		
		
	</body>
	<!-- 树右键菜单 -->
		<div id="treeRightMenu" class="list-group">
			<a href="#" onclick="addRightFactorType('addTop')" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.dataRight.label.addTopRightType"/></a>
			<a id="menuRightFactorTypeSub" onclick="addRightFactorType('addSub')" href="#" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.dataRight.label.addRightType"/></a>
			<a id="menuRightFactor" onclick="addRightFactor()" href="#" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.dataRight.label.addRight"/></a>
			<a id="deleteTreeNode" href="#" onclick="deleteTreeNode();" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>　<spring:message code="tds.dataRight.label.deleteSelectNode"/></a>
		</div>
		<div id="root" class="list-group"  >
			<a href="#"  onclick="addRightFactorType('root')" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.dataRight.label.addTopRightType"/></a>
		</div>
</html>