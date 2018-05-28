<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<jsp:include page="/tds/workflow/driver-config/js/driver-config.js.jsp" />
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" style="height:10%;padding-top:10px;padding-bottom: 10px;">
				<div class="col-sm-12">
		        	<span class="glyphicon glyphicon-wrench"></span> <strong><spring:message code="tds.menuRight.label.menuAndPermissions"/></strong>
		        </div>
			</div>
        	
			<div class="row">
				<div class="col-xs-12 col-md-12">
                    <div class="panel panel-info">
                        <div class="panel-heading clearfix">
                            <span class="pull-left" style="padding-top: 8px;"><b>获取流程处理人驱动配置</b></span>
                            <div class="btn-group pull-right" role="group">
                                <button type="button" class="btn btn-primary" onclick="showEditWindow('add')"><spring:message code="tds.sys.property.add"/></button>
                                <button type="button" class="btn btn-success" onclick="showEditWindow('update')"><spring:message code="tds.sys.property.update"/></button>
                                <button type="button" class="btn btn-warning" id="btnDelete" ><spring:message code="tds.sys.property.delete"/></button>
                            </div>
                        </div>
                        <div id="mainContainer" class="panel-body" style="min-height:600px;">
                            <table id="list"></table>
                            <div id="gridpager"></div>
                        </div>
                    </div>
				</div>
			</div>
		</div>
	</body>
</html>