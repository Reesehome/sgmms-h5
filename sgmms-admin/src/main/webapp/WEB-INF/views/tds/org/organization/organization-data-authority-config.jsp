<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<style type="text/css">
	div#right-data-tree-menu {
		position : absolute;
		display : none;
		border : 1px solid #337ab7;
		width:180px;
		padding : 2px;
		background-color: white;
		z-index: 1000;
	}
</style>
<div class="row">&nbsp;</div>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-6 col-md-6" style="padding-right: 1px;">
			<div class="panel panel-info">
				<div class="panel-heading"><spring:message code="tds.organization.label.permissions.type" /></div>
				<div class="panel-body" style="height:490px;overflow: auto;">
					<ul id="authorityTypeTree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div id="data-right-div" class="col-xs-6 col-md-6" style="padding-left: 1px;">
			<div class="panel panel-info">
				<div class="panel-heading"><spring:message code="tds.organization.label.permissions.data" /></div>
				<div class="panel-body" style="height:490px;overflow: auto;">
					<ul id="authorityDataTree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="right-data-tree-menu" class="list-group">
	<a id="selectRightDataParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择父节点</a>
	<a id="selectRightDataSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择子节点</a>
	<a id="cancelRightDataParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消父节点</a>
	<a id="cancelRightDataSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消子节点</a>
</div>

<jsp:include page="/tds/org/organization/organization-data-authority-config.js.jsp" />
