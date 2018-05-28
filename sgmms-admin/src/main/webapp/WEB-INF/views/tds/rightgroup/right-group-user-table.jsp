<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Authority User Table</title>
</head>
<body>
	<c:set var="groupid" value="${group.id }"></c:set>
	<div class="horizontal full-height full-width">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
			<div class="panel-body">
				<div id="org-table-query-criteria" style="border-coloe: #bce8f1; margin-top: 2%;">
					<form id="QueryGroupUserForm" class="form-horizontal" >
						<div class="form-group">
					    	<label for="userName"class="col-sm-2 control-label"><spring:message code="tds.common.label.input"/></label>
					    	<div class="col-sm-6">
					    		<input type="text" name="userName" class="form-control" id="userName" placeholder="<spring:message code="tds.authority.label.inputUser"/>"/>
					   		</div>
					   		<%-- <label for="loginName"class="col-sm-2 control-label"><spring:message code="tds.authority.label.loginName"/></label>
					    	<div class="col-sm-3">
					    		<input type="text" name="loginName" class="form-control" id="loginName"/>
					   		</div> --%>
					   		<div class="col-sm-2">
					   			<div class="btn-group">
					    		<button type="button" class="btn btn-primary" id="reloadGroupUserTable"><spring:message code="tds.common.label.search"/></button>
					    		</div>
					   		</div>
					 	</div>
					</form>
				</div>
				
				<div style="height: 60%;margin-top: 3%">
					<table id="group-user-table"></table> 
					<div id="group-user-table-pager"></div> 
				</div>
			</div>
		</div>
	</div>
	<script>
		function initGroupUserTable(groupId,userNameVal,loginNameVal){
			var userName = isNotNullAndEmpty(userNameVal)?userNameVal:'';
			var loginName = isNotNullAndEmpty(loginNameVal)?loginNameVal:'';
			var params = {groupId:groupId,userName:userName,loginName:loginName};
			var ctx = getJspParam('ctx');
			$("#group-user-table").jqGrid({
				mtype: 'post',
				url: ctx + getJspParam('path') + '/right/group/findGroupSpecificUser.do',//请求数据的url地址
				postData: params,
				datatype: 'json',  //请求的数据类型
			   	colNames:['<spring:message code="tds.authority.label.userName"/>','<spring:message code="tds.authority.label.loginName"/>','<spring:message code="tds.authority.label.department"/>'], //数据列名称（数组）
			   	colModel:[ //数据列各参数信息设置
			   		{name:'userName',index:'userName', width:250,align:'start'},
			   		{name:'loginName',index:'loginName', width:250,align:'start'},
					{name:'department',index:'department', width:250,align:'start'}
			   	],
			   	rowNum:10,//每页显示记录数
			   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
			   	pager : '#group-user-table-pager',  //表格数据关联的分页条，html元素
				autowidth: true, //自动匹配宽度
				height: '200',   //设置高度
				gridview:true, //加速显示
			    viewrecords: true,  //显示总记录数
				multiselect: true,  //可多选，出现多选框
				multiselectWidth: 25, //设置多选列宽度
				sortable:true,  //可以排序
				sortname: 'userName',  //排序字段名
			    sortorder: 'desc', //排序方式：倒序，本例中设置默认按id倒序排序
				loadComplete:function(data){ //完成服务器请求后，回调函数
					var params = {widtharray:[4,15,15,64],tableid:'group-user-table',pager:'group-user-table-pager'};
					resizeTable(params);
				}
			});
		}
		
		function reloadGroupUserTable(){
			var userNameVal = $('#QueryGroupUserForm').find('#userName').val();
			var loginNameVal = $('#QueryGroupUserForm').find('#loginName').val();
			var userName = isNotNullAndEmpty(userNameVal)?userNameVal:'';
			var loginName = isNotNullAndEmpty(loginNameVal)?loginNameVal:'';
			var groupId = '${groupid }';
			var params = {groupId:groupId,userName:userName,loginName:loginName};
			$("#group-user-table").jqGrid('setGridParam',{postData:params,page:1}).trigger("reloadGrid");
		}
		
		$('#reloadGroupUserTable').click(reloadGroupUserTable);
		
		initGroupUserTable('${groupid}','');
	</script>
</body>
</html>