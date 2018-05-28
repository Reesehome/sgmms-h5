<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/********************      部门编辑保存        ***********************/
var ztreess;
$(function () {
	//如果是根节点
	if($("#fullParentOrganizationName").val()==null 
			|| ""== $("#fullParentOrganizationName").val()){
		$("#selectOrg").hide();
	}
	
	
	 ztreess = $.fn.zTree.getZTreeObj("tree");
	
	//保存部门编辑信息
	$("#btnDepEdit").on("click", function() {
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
				
				if($("#newParentId").val()!=null && ""!=$("#newParentId").val()){
					// 重新加载某节点
		           //$.reloadOrganizationNode (getRoot().id, $("#orgId").val());
					//$.reloadOrganizationNode ($("#parentOrgId").val(), $("#orgId").val());
					
					$.reloadOrganizationNode ($("#newParentId").val(), $("#orgId").val());
					
		           // 对原来的节点结构进行处理
		            var currnode=ztreess.getNodeByParam("id", $("#orgId").val());
		            var node=ztreess.getNodeByParam("id", $("#parentOrgId").val());
		            ztreess.removeNode(currnode);
		            ztreess.expandNode(node, true, true, true);
		          
		            
				}	
                

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
	
	
	function getRoot() {  
	    var treeObj = $.fn.zTree.getZTreeObj("tree");  
	    //返回一个根节点  
	   var node = treeObj.getNodesByFilter(function (node) { return node.level == 0; }, true);  
	    return node;
	}  
	
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
	
	
	
	

	///打开机构树弹出框
	$("#selectOrg").on("click", function(){
		 BootstrapDialog.show({
				 title : '请选择',
				 size: BootstrapDialog.SIZE_SMALL,
			     message: $('<div></div>').load(ctx+"/admin/organization/findOrganizationTreeRightData.do",{fireOrgId:$("#orgId").val()}),
				 buttons : [
						   {
								label : '<spring:message code="tds.common.label.submit"/>',
								cssClass: 'btn-primary',
								action : function(dialogItself){
									selectDepartment(dialogItself);
								}
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
	
	//提交选择机构
	function selectDepartment(dialogItself){
		var data=getDepartment();
		if(data){
			//alert(data.id+"=="+data.name); return;
			if(data.id==$("#orgId").val()){  //所选节点与当前节点 没有发生变化
				dialogItself.close();
			     return;
			}
			
			/* $.tdsAjax({
				url:ctx + "/admin/organization/changeOrganization.do",
				type : "POST",
				cache : false,
				dataType : "json",
				data : {orgId:data.id,orgName:data.name,currOrgId:$("#orgId").val()},
				success: function(result) {
					if(result.success) {
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.alertTitle"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_INFO,
				            message: '<spring:message code="tds.dataRight.label.operateSuccess"/>', 
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself) {
				                    dialogItself.close();
				                }
				            }]
				        });
						
						/// 刷新树节点
						 var nodes = ztreess.getSelectedNodes();
						 var node = nodes[0];
						 ztreess.updateNode(node);
						 ztreess.refresh();
						 ztreess.reAsyncChildNodes(null, "refresh");
						 var aa =zTree.getNodeByParam("id",$("#orgId").val(),null);
						 zTree.selectNode(aa,false);
						 
						
					} else{
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message:  '<spring:message code="tds.dataRight.label.operateFail"/>',
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself){
				                    dialogItself.close();
				                }
				            }]
				        });
					}
				}
			}); */
			
			$.tdsAjax({
				url:ctx + "/admin/organization/getFullOrgName.do",
				type : "POST",
				cache : false,
				dataType : "json",
				data : {orgId:data.id,orgName:data.name,currOrgId:$("#orgId").val()},
				success: function(result) {
					if(result.success) {
						if(result.params.fullName=="" || result.params.fullName==null){
							$("#fullParentOrganizationName").val(data.name);

						}else{
							$("#fullParentOrganizationName").val(result.params.fullName+"→"+data.name);
						}
						 $("#newParentId").val(data.id);
						
					} else{
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message:  '<spring:message code="tds.dataRight.label.operateFail"/>',
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
			
			dialogItself.close();
		}
	}
	
	
	function getDepartment(){
		var treeObj = $.fn.zTree.getZTreeObj("treeDia");
		if(treeObj == null || treeObj.length <= 0) {
			$("#alertTip").show();
			return null;
		}
		var treeData = treeObj.getSelectedNodes();	
		var datas={};  datas.name=treeData[0].name;datas.id=treeData[0].id;
		return datas;
		
	}
	
});


</script>