<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/**
 * 底部查询部门列表
 */
$(function () {
	$("#buttomSearchOrgTable").jqGrid({
		url : ctx + '/admin/organization/findOrganizations.do',//请求数据的url地址
		mtype : "POST",
		postData : {orgName : "${orgName}"},
		datatype: 'json',  //请求的数据类型
	   	colNames:[
			"orgId",
			"<spring:message code='tds.organization.label.department.name' />",
			"<spring:message code='tds.organization.label.parent.department.name' />"], //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
			{name:'orgId', index:'orgId', width : 100, hidden : true},
			{name:'orgName', index:'orgName', width : 100, algin:"center", formatter : showLink},
			{name:'parentName', index:'parentName', width : 100, algin:"center"}
	   	],
	   	rowNum:5,//每页显示记录数
	   	rowList:[5,10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#buttomSearchOrgGridPager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:175,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		//multiselect: true,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'orgName',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
	    rownumbers : true,
		loadComplete:function(data) { //完成服务器请求后，回调函数
			
		}
	});
	//$(window).on('resize.jqGrid', function () {$("#buttomPersonTable").jqGrid('setGridWidth', $(".tab-content").width()-25);});
	
	//新增部门
	$("#btnButtomDepAdd").click(function() {
		var id = $("#buttomSearchOrgTable").jqGrid("getGridParam", "selrow");
		if(id == null) {
			BootstrapDialog.show({
				title: '<spring:message code="tds.common.label.systemMessage"/>',
				size: BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_WARNING,
				message: '<spring:message code="tds.common.message.select.record" />',
				buttons: [{
					label: '<spring:message code="tds.common.label.close"/>',
					action: function(dialogItself) {
						dialogItself.close();
					}
				}]
			});
			return;
		}
		var rowData = $("#buttomSearchOrgTable").jqGrid("getRowData", id);
		//加载部门信息新增页面
		$.loadDepAddPage(rowData.orgId);
	});
	
	//新增用户
	$("#btnButtomUserAdd").click(function() {
		var id = $("#buttomSearchOrgTable").jqGrid("getGridParam", "selrow");
		if(id == null) {
			BootstrapDialog.show({
				title: '<spring:message code="tds.common.label.systemMessage"/>',
				size: BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_WARNING,
				message: '<spring:message code="tds.common.message.select.record" />',
				buttons: [{
					label: '<spring:message code="tds.common.label.close"/>',
					action: function(dialogItself) {
						dialogItself.close();
					}
				}]
			});
			return;
		}
		
		var rowData = $("#buttomSearchOrgTable").jqGrid("getRowData", id);
		
		//加载人员新增页面
		$.loadAddOrgUserPage(rowData.orgId);
	});
});

/**
 * 显示编辑部门超链接
 */
function showLink(cellValue, options, rowObject) {
	return "<a href='javascript:$.loadDepEditPage(\"" + rowObject.orgId + "\");linkClick(" + options.rowId + ");void(0);'>" + cellValue + "</a>";
}

function linkClick(_rowId) {
	$("#buttomSearchOrgTable").setSelection(_rowId);
}
</script>