<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
//*************************** 新增领导  *********************************
$(document).ready(function(){
	$("#leaderSelectTable").jqGrid({
		url : ctx + '/admin/orguser/findUsers.do',//请求数据的url地址
		mtpye : "POST",
		datatype : 'local',  //请求的数据类型
		colNames : [
			"userId",
			"<spring:message code='tds.user.label.username' />",
			"<spring:message code='tds.user.label.loginname' />"], //数据列名称（数组）
		colModel:[ //数据列各参数信息设置 领导类型 0：队长，1：片长，2：工单管理员，3：领导
			{name:'userId', index:'userId', width : 100, hidden : true},
			{name:'userName', index:'userName', width : 100, algin:"center"},
			{name:'loginName', index:'loginName', width : 100, algin:"center"}
		],
		autowidth : true, //自动匹配宽度
		height : 250,   //设置高度
		multiselect : true,
		gridview : true, //加速显示
		viewrecords : true,  //显示总记录数
		rowNum : 10,//每页显示记录数
		rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
		pager : '#leaderSelectGridPager',  //表格数据关联的分页条，html元素
		rownumbers : true,
		beforeSelectRow : function (rowId, e) {
			$(this).jqGrid("resetSelection");
			return true;
		},
		loadComplete:function(data){ //完成服务器请求后，回调函数
			
		}
	});
	
	//隐藏表头多选框，和beforeSelectRow事件组成单选事件
	$("#cb_leaderSelectTable").hide();
	
	//设置表格的宽度
	$(window).resize(function (){$("#leaderSelectTable").jqGrid('setGridWidth', 338);}).trigger('resize');
	
	//领导名称聚焦事件
	$("#leaderUserName").bind("focus", function() {
		var label = $("#leaderUserName-error");
		if(label) {
			label.closest('div').removeClass('has-error');
            label.remove();
		}
	});
	
	//领导搜索
	$("#leaderUserSearch").on("click", function() {
		var leaderUserName = $("#leaderUserName").val();
		if(leaderUserName.length <= 0) {
			var label = $("#leaderUserName-error");
			if(label) {
				label.closest('div').removeClass('has-error');
	            label.remove();
			}
			//显示错误信息
			$("#leaderUserName").parent('div').parent('div').closest('div').addClass('has-error');
			var label = $("<label></label>").attr("id", "leaderUserName-error").addClass("help-block").text("<spring:message code='tds.user.message.enter.again'/>");
			$("#leaderUserName").parent('div').parent('div').append(label);
			return;
		}
		$("#leaderSelectTable").setGridParam({datatype:"json", postData : {userName : leaderUserName}}).trigger("reloadGrid");
	});
});
</script>