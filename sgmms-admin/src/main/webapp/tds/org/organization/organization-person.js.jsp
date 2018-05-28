<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/**
 * 领导信息列表
 */
$(function () {
	$("#personTable").jqGrid({
		url:ctx + '/admin/organization/findOrganizationUsers.do?orgId=${orgId}',//请求数据的url地址
		mtype : "POST",
		datatype: 'json',  //请求的数据类型
	   	colNames:[
			"userId",
			"<spring:message code='tds.user.label.username' />",
			"<spring:message code='tds.user.label.loginname' />",
			"<spring:message code='tds.user.label.gender' />",
			"<spring:message code='tds.user.label.usertype' />",
			"<spring:message code='tds.user.label.office.phone' />",
			"<spring:message code='tds.user.label.mobile.phone' />",
			"<spring:message code='tds.user.label.email' />"], //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
			{name:'userId',index:'userId', width : 100, hidden : true},
			{name:'userName',index:'userName', width : 100, algin:"center"},
			{name:'loginName',index:'loginName', width : 100, algin:"center"},
			{name:'gender',index:'gender', width : 100, algin:"center", formatter : genderConvertFun},
			{name:'userType',index:'userType', width : 100, algin:"center", formatter : userTypeConvertFun},
			{name:'officePhone',index:'officePhone', width : 100, algin:"center"},
			{name:'mobilePhone',index:'mobilePhone', width : 100, algin:"center"},
			{name:'email',index:'email', width : 100, algin:"center"}
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#personGridPager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:350,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		//multiselect: true,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'startDate',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
	    rownumbers : true,
		loadComplete:function(data){ //完成服务器请求后，回调函数
			//alert("成功了");
		}
	});
	
	$(window).on('resize.jqGrid', function (){$("#personTable").jqGrid('setGridWidth', $("#department-tab-content").width() - 10);});
});

/**
 * 性别转换函数
 */
function genderConvertFun(cellvalue, options, rowObject) {
	return $("#person-genderType option[value='" + cellvalue + "']").text();
}

/**
 * 用户类型转换函数
 */
function userTypeConvertFun(cellvalue, options, rowObject) {
	return $("#person-userType option[value='" + cellvalue + "']").text();
}

</script>