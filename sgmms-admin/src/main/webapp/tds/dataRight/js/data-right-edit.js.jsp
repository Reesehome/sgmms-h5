<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">


/************************数据权限 编辑页面************************************/



	$(function() {
		//为inputForm注册validate函数
		$('#dataRightFactorForm').validate({
			errorClass : 'help-block',
			onkeyup:false,
			focusInvalid : false,
			rules : {
				dataRightName : {
					required : true,
					maxlength : 64
				},
// 				dataRightId : {
// 					required : true,
// 					maxlength : 32
// 				},
				
				dataRightId : {
					required : true,  
					maxlength : 32,
					remote:{
						type:"post",
						url:ctx + "/admin/dataAuthority/dataRight/isExists.do",
						data:{
							id:function(){
								return $("#dataRightId").val();
							},
							oldId:function(){
								return $("#dataRightId_old").val();
							}
						},
						dataFilter:function(data, type){
							if(data=="false"){//false, code 重复

								return false;
							}else{
								$("#dataRightId-error").parent().removeClass('has-error');
								$("#dataRightId-error").remove();
								return true;
							}
						}
					}
				},
				
				
				dataSource_sql: {
					maxlength : 1024
				},
				dataSource_java: {
					maxlength : 1024
				},
				remark:{
					maxlength : 128
				}
				
			},
			messages : {
				dataRightName : {
					required :  '<spring:message code="tds.dataRight.label.rightNameisnotNull"/>',
					maxlength : '<spring:message code="tds.dataRight.label.rightName64word"/>'
				},
				dataRightId : {
					required :  '<spring:message code="tds.dataRight.label.rightCodeisnotNull"/>',
					maxlength : '<spring:message code="tds.dataRight.label.rightCode64word"/>',
					remote: '<spring:message code="tds.dataRight.label.Exists"/>'
				},
				
				dataSource_sql: {
					maxlength:'<spring:message code="tds.dataRight.label.dataSource1024word"/>'
				},
				dataSource_java: {
					maxlength:'<spring:message code="tds.dataRight.label.dataSource1024word"/>'
				},
				remark:{
					maxlength :'<spring:message code="tds.dataRight.label.dataRightRemark128word"/>'
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
	 *  选择数据源
	*/
	function radioClick(type){
		if(type=="java"){
			$("#java_dataSource").show();
			$("#sql_dataSource").hide();
		}else{
			$("#java_dataSource").hide();
			$("#sql_dataSource").show();
		}
	}
	
	/**
	 * 保存前，处理页面其他元素
	*/
	function doOtherData(){
		if($("#isValid").is(":checked")){
			$("#isValid").val("Y");
		}else{
			$("#isValid").val("N");
		}
		var val=$('input:radio[name="dataSourceType"]:checked').attr("title");
		if(val!=null){
			if(val=="java"){
				$('input:radio[name="dataSourceType"]:checked').val("J");
			}else{
				$('input:radio[name="dataSourceType"]:checked').val("S");
			}
		}else{
			alert('<spring:message code="tds.dataRight.label.pleaseSelectdataSourceType"/>');
		}
		
	}
	
	
	/**
	 * 保存权限类型
	 */
	function otherValid(){
		var val=$('input:radio[name="dataSourceType"]:checked').attr("title");
		if(val!=null){
			if(val=="java"){
				$("#dataSource_java").rules('add', { required: true});  
			}else{
				$("#dataSource_sql").rules('add', { required: true});  
			}
		}
	}

	/**
	 * 保存权限因子类型
	 */
    function saveRightFactor(){
    	  otherValid();
     	 if($("#dataRightFactorForm").valid()) {
     		doOtherData();
     		var params = $("#dataRightFactorForm").serialize();
     		//params=params+"&isValid="+$("#isValid").val();
     		//alert(params+"&isValid="+$("#isValid").val());return;
    		 $.tdsAjax({
				url : ctx + "/admin/dataAuthority/dataRight/edit.do",
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
							var rightFactorId = $("#dataRightId_old").val();
							
							//更新树节点的属性
							if (nodes && nodes.length == 1) {
								var node = nodes[0];
								if(node){
									if(rightFactorId){//修改
										node.name = $("#dataRightName").val();
										node.id=$("#dataRightId").val();/////
										$("#dataRightId_old").val($("#dataRightId").val());
										zTree.updateNode(node);
									}else if(result.params.rightFactor){//新增
										var newNode=zTree.addNodes(node,result.params.rightFactor);
										zTree.refresh();
										///新增后，更新树节点 选中状态
										 var aa =zTree.getNodeByParam("id",result.params.rightFactor.id,node);
										 zTree.selectNode(aa,false);
										 $("#dataRightId").val(result.params.rightFactor.id);
										 
										 $("#dataRightId_old").val(result.params.rightFactor.id);
									}
								}
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