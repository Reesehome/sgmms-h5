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
		
		<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
		
		<script type="text/javascript" src="${ctx}/tds/common/ztree-ext.js"></script>
		
		<jsp:include page="/tds/workflow/activity-driver-mapper/js/activity-driver-mapper.js.jsp" />
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" style="height:10%;padding-top:10px;padding-bottom: 10px;">
				<div class="col-sm-12">
		        	<span class="glyphicon glyphicon-wrench"></span> <strong>流程参与人配置</strong>
		        </div>
			</div>
        	
			<div class="row">
				<!-- 左边功能树 -->
				<div class="col-xs-4 col-md-3" style="padding-right: 1px">
					<div id="treePanel" class="panel panel-info">
                        <div class="panel-heading clearfix">
                            <span class="pull-left" style="padding-top: 8px;"><b>流程树</b></span>

                            <div class="btn-group pull-right" role="group">
                                <button type="button" class="btn btn-primary" onclick="synchronizeProcess()">同步</button>
                                <button type="button" class="btn btn-warning" id="btnDelete"><spring:message code="tds.sys.property.delete"/></button>
                            </div>
                        </div>
						
						<div id="treePanelBody" class="panel-body" style="height:600px;overflow: auto;">
							<ul id="tree" class="ztree"></ul>
						</div>
					</div>
				</div>
		        
		    	<!-- 右边编辑页面 -->
				<div class="col-xs-8 col-md-9" style="padding-left: 1px">
					<div class="panel panel-info">
						<div class="panel-heading clearfix">
							<span class="pull-left" style="padding-top: 8px;"><b><spring:message code="tds.menuRight.label.editProperty"/></b></span>
							<button type="button" class="btn btn-primary pull-right" onclick="submitForm()">　<spring:message code="tds.common.label.save"/>　</button>
						</div>
						<div id="mainContainer" class="panel-body" style="min-height:600px;"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>