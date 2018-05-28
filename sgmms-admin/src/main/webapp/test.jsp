<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>管理首页</title>
	
	<!-- bootstrap -->
	<link rel="stylesheet" href="${ctx}/tds/static/bootstrap/3.3.4/css/bootstrap.css">
	
	<script src="${ctx}/tds/static/jquery/jquery-1.11.3.min.js"></script>
	
	<!--  Bootstrap 核心 JavaScript 文件 -->
	<script src="${ctx}/tds/static/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	
	
</head>
<body>
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
					<label for="title" class="col-sm-1 control-label"><spring:message code="tds.demo.label.title"/></label>
					<div class="col-sm-5">
						<input id="title" name="title" class="form-control" placeholder="请输入标题">
					</div>
					
					<label for="title" class="col-sm-1 control-label">价格</label>
					<div class="col-sm-5">
						<input id="title" name="price" class="form-control" placeholder="请输入价格">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-1 control-label">创建时间</label>
					<div class="col-sm-5">
						<div class="input-group">
							<input id="startCreateTime" name="startCreateTime" class="form-control" placeholder="请选择开始时间" readonly="readonly">
							<span class="input-group-addon">TO</span>
							<input id="endCreateTime" name="endCreateTime" class="form-control" placeholder="请选择结束时间" readonly>
						</div>
					</div>
					
					<div class="col-sm-2 col-sm-offset-1">
						<button type="button" class="btn btn-primary" >搜索</button>
						<button type="button" class="btn btn-primary">清空</button>
					</div>
				</div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>