<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<style type="text/css">
	div#right-item-authorized-menu {
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
		<div class="row">
			<div class="col-xs-4 col-md-4" style="padding-right : 1px;">
				<div class="panel panel-info">
					<div class="panel-heading"><spring:message code="tds.user.label.has.permissions.group" /></div>
					<div class="panel-body" style="height:490px;overflow: auto;">
						<ul id="hasBelongRightGroupTree" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-xs-4 col-md-4" style="padding-left: 1px; padding-right: 1px;">
				<div class="panel panel-info">
					<div class="panel-heading"><spring:message code="tds.user.label.grant.permissions.group" /></div>
					<div class="panel-body" style="height:490px;overflow: auto;">
						<ul id="rightGroupAuthorizedTree" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div id="right-item-authorized-div" class="col-xs-4 col-md-4" style="padding-left: 1px;">
				<div class="panel panel-info">
					<div class="panel-heading"><spring:message code="tds.user.label.grant.permissions.alone" /></div>
					<div class="panel-body" style="height:490px;overflow: auto;">
						<ul id="rightItemAuthorizedTree" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="right-item-authorized-menu" class="list-group">
	<a id="selectParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择父节点</a>
	<a id="selectSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择子节点</a>
	<a id="cancelParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消父节点</a>
	<a id="cancelSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消子节点</a>
</div>

<jsp:include page="/tds/org/organization/user-operater-authority-config.js.jsp" />