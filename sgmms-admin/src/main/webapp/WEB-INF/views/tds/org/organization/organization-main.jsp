<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		
		<title>组织管理</title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
		<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
		<link rel="stylesheet" href="${ctx }/tds/static/scrollbar/css/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">
		
		
		<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
		<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>
		<script type="text/javascript" src="${ctx }/tds/common/ztree-ext.js"></script>
		
		<style type="text/css">
			#treeRightMenu {
				display: none;
				width:180px;
				position: absolute;
				z-index: 1000;
			}
			html,body{height: 100%;}
			.full-height{height: 100%;}
			.full-width{width: 100%;}
			.tree-font-color{color: rgb(110, 130, 155);}
			.horizontal{display: inline-block;vertical-align: top;}
			.horizontal + .horizontal{padding-left: 5px;margin-left: -5px;}
			.container-column{padding: 2px;}
			.nav-container{padding-top: 57px;margin-top: -52px;}
			.panel-body-addition{height: 100%;}
			.panel-body-content{height: 100%;overflow: auto;}
			.module-header{height: 40px;vertical-align: middle;display: table-cell;}
			.module-body{padding-top: 40px;margin-top: -40px;}
		</style>
	</head>
	<body>
		<div class="container-fluid full-height">
			<div class="row module-header">
				<span class="glyphicon glyphicon-user"></span> <strong><spring:message code="tds.organization.label.management" /></strong>
			</div>
			<!-- 
			<div class="row" style="height:10%;">
				<div class="col-sm-12">
					<br>
		        	<span class="glyphicon glyphicon-user"></span> <strong>组织管理</strong>
		        	<hr>
		        </div>
			</div>
        	 -->
			<div class="row module-body full-height">
				<!-- 左边功能树 -->
				<div class="col-xs-4 col-md-3" style="padding-right: 1px">
					<div class="panel panel-info" style="height:300px;overflow: auto;">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li role="presentation" class="active"><a data-toggle="tab" href="#head-all-organization"><spring:message code="tds.organization.label.all.department"/></a></li>
								<li role="presentation"><a data-toggle="tab" href="#head-search"><spring:message code="tds.common.label.search"/></a></li>
							</ul>
							<div class="tab-content">
								<div id="head-all-organization" class="tab-pane in active">
									<ul id="tree" class="ztree"></ul>
								</div>
								<div id="head-search" class="tab-pane">
									<div class="row" style="margin-top: 10px;">
						    			<form class="form-inline" style="text-align: center;">
							    			<div class="radio">
							    				<label>
								    				<input type="radio" name="searchType" value="O" checked="checked"><spring:message code="tds.organization.label.department" />
							    				</label>
							    			</div>
							    			<div class="radio">
							    				<label>
								    				<input type="radio" name="searchType" value="E"><spring:message code="tds.user.label.user" />
							    				</label>
							    			</div>
							    			<button type="button" class="btn btn-primary" id="search"><spring:message code="tds.common.label.search"/></button>
						    			</form>
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-10">
						    				<div id="organization-search-content">
							    				<form id="orgSearchForm">
							    					<div class="form-group">
							    						<label for="search_org_name"><spring:message code="tds.common.label.input"/></label>
														<input type="text" class="form-control" name="search_org_name" id="search_org_name" placeholder="<spring:message code='tds.organization.label.departmentname.initials'/>">
							    					</div>
							    				</form>
						    				</div>
						    				
						    				<div id="user-search-content" style="display: none;">
							    				<form id="userSearchForm">
							    					<div class="form-group">
							    						<label for="search_user_name"><spring:message code="tds.common.label.input"/></label>
														<input type="text" class="form-control" name="search_user_name" id="search_user_name" placeholder="<spring:message code='tds.user.label.username.initials.account'/>">
							    					</div>
							    				</form>
						    				</div>
					    				</div>
					    			</div>
								</div>
							</div>
						</div>
					</div>
					<div id="buttomContainer" class="panel panel-info" style="height:295px; margin-top: 5px;">
						
					</div>
				</div>
		        
		    	<!-- 右边编辑页面 -->
				<div class="col-xs-8 col-md-9" style="padding-left: 1px">
					<div class="panel panel-info" style="height:600px;">
						<div id="mainContainer" class="panel-body"></div>
					</div>
				</div>
			</div>
		</div>
		
		<optRight:hasOptRight rightCode="IDR_ORG_EDIT_ORG">
			<!-- 树右键菜单 -->
			<div id="treeRightMenu" class="list-group">
				<a id="addOrg" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>　<spring:message code="tds.organization.label.department.add" /></a>
				<a id="deleteOrganization" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>　<spring:message code="tds.organization.label.department.delete" /></a>
				
				<!-- 添加禁用状态，    -->
				<a id="notEnableOrganization" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>　<spring:message code="tds.organization.notEnable" /></a>
				<a id="enableOrganization" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>　<spring:message code="tds.organization.notEnable.no" /></a>
				
				
				<%--<a id="nodeRefresh" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>　<spring:message code="tds.common.label.refresh" /></a> --%>
			</div>
		</optRight:hasOptRight>
	</body>
	
	<jsp:include page="/tds/org/organization/organization-main.js.jsp" />
</html>