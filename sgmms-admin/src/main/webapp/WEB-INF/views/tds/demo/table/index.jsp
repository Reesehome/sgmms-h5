<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>管理首页</title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<jsp:include page="/tds/demo/table/js/table.js.jsp" />
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12">
					<br>
		        	<a href="#"><strong><i class="glyphicon glyphicon-list"></i> 数据列表</strong></a>
		        	<hr>
		        </div>
			</div>
			
		    <div class="row">
		        <div class="col-sm-12" id="mainContainerBox">
		        	<!-- <br>
		        	<a href="#"><strong><i class="glyphicon glyphicon-list"></i> 数据列表</strong></a>
		        	<hr> -->
		        
		        	<div class="panel panel-info">
						<div class="panel-heading clearfix">
							<h4 class="panel-title pull-left" style="padding-top: 2px;"><spring:message code="tds.common.label.searchForm"/></h4>
							
							<div class="pull-right">
								<a class="btn btn-default btn-xs" role="button" data-toggle="collapse" href="#searchBody">
									<span class="glyphicon glyphicon-chevron-up"></span>
								</a>
							</div>
						</div>
						<div id="searchBody" class="collapse">
							<div class="panel-body">
								<form id="searchForm" class="form-horizontal">
									<div class="form-group">
										<label for="txtTitle" class="col-sm-1 control-label"><spring:message code="tds.demo.label.title"/></label>
										<div class="col-sm-5">
											<input id="title" name="title" class="form-control" placeholder="请输入标题">
										</div>
										
										<label for="txtPrice" class="col-sm-1 control-label">价格</label>
										<div class="col-sm-5">
											<input id="price" name="price" class="form-control" placeholder="请输入价格">
										</div>
									</div>
									
									<div class="form-group">
										<label for="txtCreateTime" class="col-sm-1 control-label">创建时间</label>
										<div class="col-sm-5">
											<div class="input-group">
												<input id="startCreateTime" name="startCreateTime" class="form-control" placeholder="请选择开始时间" readonly="readonly">
												<span class="input-group-addon">TO</span>
												<input id="endCreateTime" name="endCreateTime" class="form-control" placeholder="请选择结束时间" readonly>
											</div>
										</div>
										
										<div class="col-sm-1"></div>
										<div class="col-sm-5">
											<button type="button" class="btn btn-primary" onclick="searchDemo()">搜索</button>
											<button type="button" class="btn btn-primary" onclick="cleanForm()">清空</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
		        
		        	<div class="panel panel-info">
						<div class="panel-heading">
							<button type="button"  class="btn btn-primary" onclick="showEdieWindow('add')">添加</button>
							
							<button type="button" class="btn btn-success" onclick="showEdieWindow('update')">修改</button>
							
							<button id="btnDelete" type="button" class="btn btn-warning">删除</button>
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