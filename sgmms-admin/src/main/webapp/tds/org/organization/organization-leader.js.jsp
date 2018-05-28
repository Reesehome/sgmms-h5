<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<script type="text/javascript">
//*************************** 领导信息列表  *********************************
jQuery(function ($) {
	$("#leaderTable").jqGrid({
		url : ctx + '/admin/orgleader/findOrganizationLeaders.do?orgId=${orgId}',//请求数据的url地址
		mtype : 'POST',
		datatype : 'json',  //请求的数据类型
		colNames : [
			"orgId",
			"userId",
			"<spring:message code='tds.user.label.username' />",
			"<spring:message code='tds.user.label.leader.type' />"], //数据列名称（数组）
		colModel:[ //数据列各参数信息设置 领导类型 0：队长，1：片长，2：工单管理员，3：领导
			{name:'orgId',index:'orgId', hidden:true},
			{name:'userId',index:'userId', hidden:true},
			{name:'userName',index:'userName', width:250, sortable : false},
			{name:'leaderType',index:'leaderType', width:250, sortable : false, formatter : leaderTypeConvertFun}
		],
		autowidth : true, //自动匹配宽度
		height : 350,   //设置高度
		gridview : true, //加速显示
		viewrecords : true,  //显示总记录数
		sortable : false,  //禁止排序
		multiselect : true,
		//sortname : 'startDate',  //排序字段名
		//sortorder : "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		rownumbers : true,
		loadComplete:function(data){ //完成服务器请求后，回调函数
		}
	});
	
	$(window).resize(function (){$("#leaderTable").jqGrid('setGridWidth', $("#department-tab-content").width() - 10);}).trigger('resize');
	
	//领导搜索
	$("#leaderSearch").on("click", function() {
		var params = $("#leaderSearchForm").serializeJson();
		$("#leaderTable").setGridParam({postData:params}).trigger("reloadGrid");
	});
	
	<optRight:hasOptRight rightCode="IDR_ORG_EDIT_LEADER">
	//领导新增
	$("#leaderAdd").on("click", function() {
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
	        message: $('<div></div>').load(ctx + "/admin/organization/loadOrganizationLeaderAddPage.do"),
	        buttons : [
				{
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass: 'btn-primary',
					action : saveLeader
				},
				{
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself){
						dialogItself.close();
					}
				}
	        ]
	    });
	});
	
	/**
	* 保存领导新增信息
	*/
	function saveLeader(dialogItself) {
		//必须有选择用户
		var selectId = $("#leaderSelectTable").jqGrid("getGridParam", "selrow");
		if(selectId == null || selectId.length <= 0) {
			//显示错误信息
			$("#leaderUserName").parent('div').parent('div').closest('div').addClass('has-error');
			var label = $("<label></label>").attr("id", "leaderUserName-error").addClass("help-block").text("请选择用户");
			$("#leaderUserName").parent('div').parent('div').append(label);
			return;
		}
		var rowData = $("#leaderSelectTable").jqGrid("getRowData", selectId);
		
		var params = {};
		params["leaderType"] = $("#leaderType").val();
		params["userId"] = rowData.userId;
		params["orgId"] = "${orgId}";
		
		$.tdsAjax({
			url : ctx + "/admin/orgleader/saveOrganizationLeaders.do",
			cache : false,
			dataType : "json",
			data : params,
			success : function(result){
				if(result.success) {
					dialogItself.close();
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.errorMessage"/>',
						size: BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_SUCCESS,
						message: result.message,
						buttons: [{
							label: '<spring:message code="tds.common.label.close"/>',
							action: function(_dialogItself){
								_dialogItself.close();
							}
						}]
					});
					
					//重新加载领导信息
					$("#leaderTable").trigger("reloadGrid");
				} else{
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
	
	//领导删除
	$('#leaderDelete').confirmation({
		title:'<spring:message code="tds.common.message.confirmDelete"/>',
		btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
		btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
		placement : "left",
		onShow : function() {
			var ids = $("#leaderTable").jqGrid('getGridParam', 'selarrrow');
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
		onConfirm : function() {
			var ids = $("#leaderTable").jqGrid('getGridParam', 'selarrrow');
			var values = [];
			$(ids).each(function(index, value) {
				var rowData = $("#leaderTable").jqGrid("getRowData", value);
				values.push(rowData.userId);
			});
			var params = $.param({orgId : "${orgId}", userIds : values}, true);
			
			$.tdsAjax({
				url: ctx + "/admin/orgleader/deleteLeaders.do",
				cache : false,
				dataType : "json",
				data : params,
				type : "POST",
				success : function(result){
					if(result.success) {
						//重新加载领导信息，其实可以直接在表格中删除，这样就不需要再向后台请求查询
						$("#leaderTable").trigger("reloadGrid");
					}else {
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
	</optRight:hasOptRight>
});

/**
 * 领导类型转换函数
 */
function leaderTypeConvertFun(cellvalue, options, rowObject) {
	return $("#leader-leaderType option[value='" + cellvalue + "']").text();
}
</script>