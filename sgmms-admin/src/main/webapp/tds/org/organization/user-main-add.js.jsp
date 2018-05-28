<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/********************   新增用户编辑保存        ***********************/
$(function () {
	
	//保存用户新增信息
	$("#btnAddUserSave").bind("click", function() {
		//验证结果正确再提交
		var validResult = $("#userEditForm").valid();
		if(!validResult){
			return;
		}
		
		//用户信息
		var userInfo = $("#userEditForm").serialize();
		
		//所有部门
		var inDeptIds = getTreeSelected("userDepartmentTree");
		userInfo += "&inDeptIds=" + inDeptIds;
		
		//操作权限信息
		//操作权限组授权
		var rightGroupIds = getTreeSelected("rightGroupAuthorizedTree");
		userInfo += "&rightGroupIds=" + rightGroupIds;
		
		//单独授权
		var menuRightIds = getTreeSelected("rightItemAuthorizedTree");
		userInfo += "&menuRightIds=" + menuRightIds;
		
		$.tdsAjax({
			url:ctx + "/admin/orguser/saveOrgUser.do",
			type : "POST",
			cache : false,
			dataType : "json",
			data : userInfo,
			success: function(result) {
				if(result.success) {
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.alertTitle"/>',
			            size: BootstrapDialog.SIZE_SMALL,
			            type : BootstrapDialog.TYPE_INFO,
			            message: result.message,
			            buttons: [{
			                label: '<spring:message code="tds.common.label.close"/>',
			                action: function(dialogItself) {
			                	//加载编辑页面
			                	$.loadEditOrgUserPage("${orgId}", result.params.userId);
			                	//刷新人员表
			                	$("#buttomPersonTable").trigger("reloadGrid");
			                    dialogItself.close();
			                }
			            }]
			        });
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
	});
	
	//获取树选中节点信息
	function getTreeSelected(_treeId) {
		var selected = [];
		var menuTree = $.fn.zTree.getZTreeObj(_treeId);
		if(menuTree) {
			$.each(menuTree.getCheckedNodes(), function (index, value) {
				selected.push(value.id);
			});
		}
		return selected.join(",");
	}
	
});
</script>