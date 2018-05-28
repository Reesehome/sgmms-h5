<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">


/************************数据权限类型  编辑页面************************************/



	$(function() {
		//为inputForm注册validate函数
		$('#dataRightFactorTypeForm').validate({
			errorClass : 'help-block',
			focusInvalid : false,
			rules : {
				rightTypeName : {
					required : true,
					maxlength : 64
				},
				remark:{
					maxlength : 128
				}
			},
			messages : {
				rightTypeName : {
					required : '<spring:message code="tds.dataRight.label.dataRightTypeNoNULL"/>' ,
					maxlength : '<spring:message code="tds.dataRight.label.dataRightType64word"/>'
				},
				remark:{
					maxlength : '<spring:message code="tds.dataRight.label.Remark128word"/>'
				}
			},

			highlight : function(element) {
				$(element).parent('div').addClass('has-error');
			},

			success : function(label) {
				label.parent('div').removeClass('has-error');
				label.remove();
			},

			errorPlacement : function(error, element) {
				element.parent('div').append(error);
			}
		});
	});

	

	/**
	 * 保存权限类型
	 */
    function saveRightType(){
     	 if($("#dataRightFactorTypeForm").valid()) {
     		var params = $("#dataRightFactorTypeForm").serialize();
    		 $.tdsAjax({
				url : ctx + "/admin/dataAuthority/dataRightType/edit.do",
				cache : false,
				dataType : "json",
				type : "POST",
				data : params,
				success : function(result) {
					
					if (result.success) {
							BootstrapDialog.show({
								title : '<spring:message code="tds.dataRight.label.doSuccess"/>',
								size : BootstrapDialog.SIZE_SMALL,
								type : BootstrapDialog.TYPE_SUCCESS,
								message : '<spring:message code="tds.dataRight.label.operateSuccess"/>',
								buttons : [ {
									label : '<spring:message code="tds.common.label.close"/>',
									action : function(dialogItself) {
										//关闭窗口
										dialogItself.close();
									}
								}]
							});
							
							var zTree = $.fn.zTree.getZTreeObj("tree");
							var nodes = zTree.getSelectedNodes();
							var factorTypeId = $("#rightTypeId").val();
						
							if (nodes && nodes.length == 1) {
								var node = nodes[0];
								if(node){
									if(factorTypeId){
										node.name = $("#rightTypeName").val();
										zTree.updateNode(node);
									}else if(result.params.rightFactorType){
										if(result.params.rightFactorType.parentId){
											zTree.addNodes(node,result.params.rightFactorType);
										}else{
											 zTree.addNodes(null,result.params.rightFactorType);  //顶级节点
										}
										
										 zTree.refresh();
										 ///新增后，更新树节点 选中状态
										 var aa =zTree.getNodeByParam("id",result.params.rightFactorType.id,null);
										 zTree.selectNode(aa,false);
										 $("#rightTypeId").val(result.params.rightFactorType.id);
										 $("#treeCode").val(result.params.rightFactorType.params.treeCode);
										 $("#parentId").val(result.params.rightFactorType.parentId);
									}
								}
							}else{  /// 新增root节点
								 zTree.addNodes(null,result.params.rightFactorType);  //顶级节点
								///新增后，更新树节点 选中状态
								 var aa =zTree.getNodeByParam("id",result.params.rightFactorType.id,null);
								 zTree.selectNode(aa,false);
								 $("#rightTypeId").val(result.params.rightFactorType.id);
								 $("#treeCode").val(result.params.rightFactorType.params.treeCode);
								 $("#parentId").val(result.params.rightFactorType.parentId);
								
							}
							
				     } else {//失败
								BootstrapDialog.show({
									title : '<spring:message code="tds.common.label.errorMessage"/>',
									size : BootstrapDialog.SIZE_SMALL,
									type : BootstrapDialog.TYPE_WARNING,
									message : '<spring:message code="tds.dataRight.label.operateFail"/>',
									buttons : [ {
										label : '<spring:message code="tds.common.label.close"/>',
										action : function(dialogItself) {
											dialogItself.close();
										}
									} ]
								});
					 }//else
				 }//success
			});
    	}
    }


</script>