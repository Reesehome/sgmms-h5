<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/********************      部门编辑保存        ***********************/
$(function () {
	
	//保存部门编辑信息
	$("#btnDepAdd").on("click", function() {
		//验证结果正确再提交
		var validResult = $("#depEditForm").valid();
		if(!validResult){
			return;
		}
		
		//部门信息
		var depInfo = $("#depEditForm").serialize();
		
		//操作权限配置信息
		var operateConfigInfo = getOperateConfigInfo();
		depInfo += "&operRightGroupIds=" + operateConfigInfo;
		
		//获取数据权限信息
		var dataRightId = getDataRightTypeId();
		depInfo += "&dataRightId=" + dataRightId;
		var dataValues = getDataRightValue();
		depInfo += "&dataRightValues=" + dataValues;
		
		$.tdsAjax({
			url:ctx + "/admin/organization/saveOrganization.do",
			type : "POST",
			cache : false,
			dataType : "json",
			data : depInfo,
			success: function(result) {
				//保存成功 
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
					
					//
					$.reloadOrganizationNode("${parentOrgId}", result.params.organizationInfo.orgId);
				} else{
					//校验部门编号唯一性
					if(result.params.saveCheckFlag) {
						$("#orgId").closest('div').addClass('has-error');
						var label = $("<label></label>").attr("id", "orgId-error").addClass("help-block").text("<spring:message code='tds.organization.message.enter.again'/>");
						$("#orgId").parent('div').append(label);
						return;
					}
					
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
	
	//获取操作权限配置选中Id集合
	function getOperateConfigInfo() {
		var selected = [];
		$.each($.fn.zTree.getZTreeObj("operaterAuthorityTree").getCheckedNodes(), function (index, value) {
			selected.push(value.id);
		});
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
	
	//获取数据权限值
	function getDataRightValue() {
		var dataSelectValue = [];
		var dataValueTree = $.fn.zTree.getZTreeObj("authorityDataTree");
		if(dataValueTree) {
			$.each(dataValueTree.getCheckedNodes(), function (index, value) {
				dataSelectValue.push(value.id);
			});
		}
		
		return dataSelectValue.join(",");
	}
	
});
</script>