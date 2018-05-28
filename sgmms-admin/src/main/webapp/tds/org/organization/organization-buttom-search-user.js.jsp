<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/**
 * 底部人员列表
 */
$(function () {
	$("#buttomSearchUserTable").jqGrid({
		url : ctx + '/admin/orguser/findUsers.do',//请求数据的url地址
		mtype : "POST",
		postData : {userName : "${userName}"},
		datatype: 'json',  //请求的数据类型
	   	colNames:[
			"userId",
			"<spring:message code='tds.user.label.username' />",
			"<spring:message code='tds.user.label.loginname' />"], //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
			{name:'userId', index:'userId', width : 100, hidden : true},
			{name:'userName', index:'userName', width : 100, algin:"center", formatter : showLink},
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
			//alert("成功了");
		}
	});
	//$(window).on('resize.jqGrid', function () {$("#buttomPersonTable").jqGrid( 'setGridWidth', $(".tab-content").width()-25);});
	
	//删除用户
	$('#btnUserDel').confirmation({
		title:'<spring:message code="tds.common.message.confirmDelete"/>',
		btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
		btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
		placement : "left",
		onShow : function() {
			var ids = $("#buttomSearchUserTable").jqGrid('getGridParam','selarrrow');
			if(ids == '') {
				BootstrapDialog.show({
					title: '<spring:message code="tds.common.label.systemMessage"/>',
					size: BootstrapDialog.SIZE_SMALL,
					type : BootstrapDialog.TYPE_WARNING,
					message: '<spring:message code="tds.common.message.select.delete.record"/>',
					buttons: [{
						label: '<spring:message code="tds.common.label.close"/>',
						action: function(dialogItself) {
							dialogItself.close();
						}
					}]
				});
				return false;
			}
			return true;
		},
		onConfirm : function(){
			var ids = $("#buttomSearchUserTable").jqGrid('getGridParam','selarrrow');
			
			var values = [];
			$(ids).each(function(index, value) {
				var rowData = $("#buttomSearchUserTable").jqGrid("getRowData", value);
				values.push(rowData.userId);
			});
			var params = $.param({ids : values}, true);
			
			$.tdsAjax({
				url: ctx + "/admin/orguser/deleteOrgUser.do",
				cache : false,
				dataType : "json",
				data : params,
				type : "POST",
				success : function(result){
					if(result.success) {
						//重新加载列表数据
						$("#buttomSearchUserTable").trigger("reloadGrid");
						//右边加载部门编辑页面
						$.loadDepEditPage("${orgId}")
					}else{
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself){
				                    dialogItself.close();
				                }
				            }]
				        });
					}
				}
			});
		}
	});
});

/**
 * 显示编辑人员超链接
 */
function showLink(cellValue, options, rowObject) {
	return "<a href='javascript:$.loadEditOrgUserPage(\"${orgId}\",\"" + rowObject.userId + "\");void(0);'>" + cellValue + "</a>";
}
</script>