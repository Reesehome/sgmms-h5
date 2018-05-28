<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
$(function () {
	$("#buttomSearchUserTable").jqGrid({
		url : ctx + '/admin/orguser/findFlowUsers.do?pageSize=5',//请求数据的url地址
		mtype : "POST",
		postData : {userName : ""},
		datatype: 'json',  //请求的数据类型
	   	colNames:[
			"userId",
			"用户名",
			"登录账号"], //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
			{name:'userId', index:'userId', width : 100, hidden : true},
			{name:'userName', index:'userName', width : 100, algin:"center"},
			{name:'loginName', index:'loginName', width : 100, algin:"center"}
	   	],
	   	rowNum:5,//每页显示记录数
	   	rowList:[5,10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#buttomSearchUserGridPager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:175,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		multiselect: true,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'createDate',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
	    //rownumbers : true,
		loadComplete:function(data) { //完成服务器请求后，回调函数
		
		}
	});
	
	$(window).resize(function (){$("#buttomSearchUserTable").jqGrid('setGridWidth', 338);}).trigger('resize');
});


function selectUser(){
	//var userInfo = $("#selectPersonForm").serializeJson();
	var userInfo = {"userName":$("#search_user_name").val()}; 
	$("#buttomSearchUserTable").setGridParam({postData:userInfo}).trigger("reloadGrid",[{ page: 1}]);
}




</script>