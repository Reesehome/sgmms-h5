<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Authority Organization Table</title>
</head>
<body>
	<c:set var="groupid" value="${group.id }"></c:set>
	<div class="horizontal full-height full-width">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
			<div class="panel-body">
				<div id="org-table-query-criteria" style="border-coloe: #bce8f1; margin-top: 2%;">
					<form id="QueryGroupOrgForm" class="form-horizontal" >
						<div class="form-group">
					    	<label for="organizationName"class="col-sm-2 control-label"><spring:message code="tds.common.label.input"/></label>
					    	<div class="col-sm-6">
					    		<input type="text" name="organizationName" class="form-control" id="organizationName" placeholder="<spring:message code="tds.authority.label.inputDepartment"/>"/>
					   		</div>
					   		<div class="col-sm-2">
					   			<div class="btn-group">
					   				<button type="button" class="btn btn-primary" id="reloadGroupOrgTable"><spring:message code="tds.common.label.search"/></button>
					   			</div>
					   		</div>
					 	</div>
					</form>
				</div>
				
				<div style="height: 60%;margin-top: 3%">
					<table id="group-org-table"></table> 
					<div id="group-org-table-pager"></div> 
				</div>
			</div>
		</div>
	</div>
	<script>
		function initGroupOrgTable(groupId,organizationName){
			var orgName = isNotNullAndEmpty(organizationName)?organizationName:'';
			var params = {groupId:groupId,orgName:orgName};
			var ctx = getJspParam('ctx');
			$("#group-org-table").jqGrid({
				url: ctx + getJspParam('path') + '/right/group/findGroupSpecificOrganization.do',//请求数据的url地址
				mtype: 'post',
				postData: params,
				datatype: 'json',  //请求的数据类型
			   	colNames:['<spring:message code="tds.authority.label.deparmentName"/>','<spring:message code="tds.authority.label.superiorDepartment"/>'], //数据列名称（数组）
			   	colModel:[ //数据列各参数信息设置
			   		{name:'orgName',index:'orgName', width:400,align:'start'},
					{name:'parentOrg.orgName',index:'parentOrgName', width:400,align:'start'}
			   	],
			   	rowNum:10,//每页显示记录数
			   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
			   	pager : '#group-org-table-pager',  //表格数据关联的分页条，html元素
				autowidth: true, //自动匹配宽度
				height: '200',   //设置高度
				gridview:true, //加速显示
			    viewrecords: true,  //显示总记录数
				multiselect: true,  //可多选，出现多选框
				multiselectWidth: 25, //设置多选列宽度
				sortable:true,  //可以排序
				sortname: 'orgName',  //排序字段名
			    sortorder: 'desc', //排序方式：倒序，本例中设置默认按id倒序排序
				loadComplete:function(data){ //完成服务器请求后，回调函数
					var params = {widtharray:[4,48,48],tableid:'group-org-table',pager:'group-org-table-pager'};
					resizeTable(params);
				}
			});
		}
		
		function reloadGroupOrgTable(){
			var organizationName = $('#QueryGroupOrgForm').find('#organizationName').val();
			var orgName = isNotNullAndEmpty(organizationName)?organizationName:'';
			var groupId = '${groupid }';
			var params = {groupId:groupId,orgName:orgName};
			$("#group-org-table").jqGrid('setGridParam',{postData:params,page:1}).trigger("reloadGrid");
		}
		
		$('#reloadGroupOrgTable').click(reloadGroupOrgTable);
		
		$(function(){
			initGroupOrgTable('${groupid}','');
		});
	</script>
</body>
</html>