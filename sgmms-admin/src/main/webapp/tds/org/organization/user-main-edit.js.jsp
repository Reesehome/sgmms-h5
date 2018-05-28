<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/********************   用户编辑保存        ***********************/
$(function () {
	
	//保存用户编辑信息
	$("#btnEditUserSave").bind("click", function() {
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
		
		//获取数据权限信息
		var dataRightId = getDataRightTypeId();
		userInfo += "&dataRightId=" + dataRightId;
		var dataValues = getTreeSelected("authorityDataTree");
		userInfo += "&dataRightValues=" + dataValues;
		
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
	
	//获取数据权限Id
	function getDataRightTypeId() {
		var dataRightId = '';
		//数据权限
		var dataTypeTree = $.fn.zTree.getZTreeObj("authorityTypeTree");
		if(dataTypeTree) {
			var selectNodes = dataTypeTree.getSelectedNodes();
			if(selectNodes.length > 0 && !!!selectNodes[0].isParent) {
				dataRightId = selectNodes[0].id;
			}
		}
		return dataRightId;
	}
	
	//设置默认密码
	$("#btnSetDefaultPassword").bind("click", function() {
		BootstrapDialog.confirm("<spring:message code='tds.user.message.sure.set.default.password' />", function(result) {
			if(result == true) {
				$.tdsAjax({
					url:ctx + "/admin/orguser/updateOrgUserDefaultPassword.do",
					type : "POST",
					cache : false,
					dataType : "json",
					data : {userId : "${userId}"},
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
			}
		});
	});
	
});
</script>