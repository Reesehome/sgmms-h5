<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">

 /******************************数据权限树*****************************/
 
 
    var dataRightTypeInfo='<spring:message code="tds.dataRight.label.RightTypeDedails"/>';
    var dataRightInfo='<spring:message code="tds.dataRight.label.DataRightDedails"/>';
	var zTree;
	var readySelectNode;//临时准备选中的节点
	
	//树配置信息
	var setting = {
		async: {
			enable: true,
			url: "${ctx}/admin/dataAuthority/findChildren.do",
			dataType:'json',
			autoParam: ["id"]
		},
		edit: {
			drag : {
				prev: dropNode,
				inner: false,
				next: dropNode
			},
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		data: {
			keep: {
				parent: true,
				leaf: true
			}
		},
		
		callback : {
			onClick : function(event, treeId, treeNode){
				nodeClickHandler(event, treeId, treeNode,"update");
			},
			onAsyncSuccess: zTreeOnAsyncSuccess,
			onRightClick : zTreeOnRightClick
		}
	};
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		zTree.updateNode(treeNode);
	};
	
	/**
	 * 树节点点击回调事件
	 */
	function nodeClickHandler(event, treeId, treeNode,type){
		//加载权限类型编辑页面
		if("DataRightType" == treeNode.params.type || ("DataRight" == treeNode.params.type && type=="addTop")){
			$.tdsAjax({
				url:"${ctx}/admin/dataAuthority/dataRightType/showEdit.do",
				cache:false,
				data:{"id":treeNode.id,"type":type},
				success: function(pageHTML){
					$("#mainContainer").html(pageHTML);
					$("#right-panel b").html(dataRightTypeInfo);
					$("#cumBtn-temple").attr("onclick","saveRightType()");
					
					
				}
			});
		}
		//加载权限编辑页面
		else {
			$.tdsAjax({
				url:"${ctx}/admin/dataAuthority/dataRight/showEdit.do",
				cache:false,
				data:{"id":treeNode.id,"type":type},
				success: function(pageHTML){
					$("#mainContainer").html(pageHTML);
					//$("#right-panel").html("<b>"+dataRightInfo+"</b>");
					$("#right-panel b").html(dataRightInfo);
					$("#cumBtn-temple").attr("onclick","saveRightFactor()");
					initRadio();
				}
			});
		}
	}
	
	$(function(){
		zTree = $.fn.zTree.init( $("#tree"), setting, null);
		$("body").click(function(){
			$("#treeRightMenu").hide();
			$("#root").hide();
		});
		
		$('#treePanel').bind('contextmenu',function(){
	        return false;
	    }); 
	
	});
	
	function dropNode(treeId, nodes, targetNode) {
		return nodes[0].level == targetNode.level;
	}
	
	/**
	 * 树节点右键点击回调事件
	 */
	function zTreeOnRightClick(event, treeId, treeNode){
		if(treeNode){
			readySelectNode = treeNode;
			
			$("#treeRightMenu").css("left",event.clientX);
			$("#treeRightMenu").css("top",event.clientY);
			
			$("#menuRightFactor").removeClass("disabled");
			$("#menuRightFactor").attr("onclick","addRightFactor()");
			$("#menuRightFactorTypeSub").removeClass("disabled");
			$("#menuRightFactorTypeSub").attr("onclick","addRightFactorType('addSub')");
			if(treeNode.isParent){
			 <%--	var treeNodes = zTree.getNodesByParam("parentId", treeNode.id, treeNode);
				if(treeNodes.length == 0 && !treeNode.zAsync){
					$.tdsAjax({
						url: "${ctx}/admin/dataAuthority/findChildren.do",
						cache:false,
						async:false,
						data:{"id":treeNode.id},
						success: function(subNodes){
							treeNode.zAsync = true;
							zTree.updateNode(treeNode);
							
							if(subNodes.length > 0)
								zTree.addNodes(treeNode,subNodes,true);
							treeNodes = subNodes;
						}
					});
				}
				//判断其子节点的类型来设置相应菜单的禁用状态
				if(treeNodes && treeNodes.length > 0){
					if(treeNodes[0].params.type == "DataRightType"){
						$("#menuRightFactor").addClass("disabled");
						$("#menuRightFactor").attr("onclick","");
					}else{
						$("#menuRightFactorTypeSub").addClass("disabled");
						$("#menuRightFactorTypeSub").attr("onclick","");
					}
				}else{ // 是父对象，却没有孩子， 判断该对象是否有父亲
					if(treeNode.parentId){ // 则是 普通 因子类型
						$("#menuRightFactorTypeSub").addClass("disabled");
						$("#menuRightFactorTypeSub").attr("onclick","");
					}
					
				} --%>
				
				
				
			}else{  ///权限，叶子节点
				$("#menuRightFactor").addClass("disabled");
				$("#menuRightFactor").attr("onclick","");
				$("#menuRightFactorTypeSub").addClass("disabled");
				$("#menuRightFactorTypeSub").attr("onclick","");
			}
			
			$("#treeRightMenu").show();
		}
	}
	
	
	/**
	 *  添加 权限类型
	 */
	function addRightFactorType( type){
		if(type=="root"){
			$.tdsAjax({
				url:"${ctx}/admin/dataAuthority/dataRightType/showEdit.do",
				cache:false,
				data:{"id":"","type":"DataRightType"},
				success: function(pageHTML){
					$("#mainContainer").html(pageHTML);
					$("#right-panel b").html(dataRightTypeInfo);
					$("#cumBtn-temple").attr("onclick","saveRightType()");
					
				}
			});
		}else{
			
			zTree.selectNode(readySelectNode);
			nodeClickHandler(null,null,readySelectNode,type);
		}
        
	}
	
	
	/**
	 *  copy 节点
	*/
	function copyTreeNode( treeNode){
		var obj= new Object();
		obj.id=treeNode.id;
		obj.parentId=treeNode.parentId;
		obj.name=treeNode.name;
		obj.params=treeNode.params;
		obj.checked=treeNode.checked;
		obj.isParent=treeNode.isParent;
		return obj;
	}
	
	
	/**
	 *  添加 权限
	 */
	function addRightFactor(){
        zTree.selectNode(readySelectNode);
		var params = {"type":"add"};
		if(readySelectNode.params.type == "DataRightType"){
			params.factorTypeId = readySelectNode.id;
			params.factorTypeCode = readySelectNode.params.factorTypeCode;
		} 
	
		$.tdsAjax({
			url:"${ctx}/admin/dataAuthority/dataRight/showEdit.do",
			cache:false,
			type:"POST",
			data:params,
			success: function(pageHTML){
				$("#mainContainer").html(pageHTML);
				//$("#right-panel").html("<b>"+dataRightInfo+"</b>");
				$("#right-panel b").html(dataRightInfo);
					$("#cumBtn-temple").attr("onclick","saveRightFactor()");
				initRadio();
			}
		});
		
	}
	
	/**
	 *  删除节点
	 */
	function deleteTreeNode(){
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
			message : '<spring:message code="tds.common.message.confirmDelete"/>',
			buttons : [ {
				label : '<spring:message code="tds.common.label.submit"/>',
				cssClass : 'btn-primary',
				action : function(dialogItself) {
					if("DataRightType" == readySelectNode.params.type)
						url = "${ctx}/admin/dataAuthority/dataRightType/delete.do";
					else
						url = "${ctx}/admin/dataAuthority/dataRight/delete.do";
					$.tdsAjax({
						url:url,
						cache:false,
						data:{"id":readySelectNode.id},
						success: function(result){
							if(result.success)
							  {	
								zTree.removeNode(readySelectNode);
								$("#mainContainer").html(null);
								//$("#right-panel").html("<b>"+'<spring:message code="tds.dataRight.label.dataRightInfo"/>'+"</b>");
								bingBtnClick("");
							  }
							else{
								BootstrapDialog.show({
									title: '<spring:message code="tds.common.label.errorMessage"/>',
						            size: BootstrapDialog.SIZE_SMALL,
						            type : BootstrapDialog.TYPE_WARNING,
						            message: convertTip(result.message),
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

					//关闭窗口
					dialogItself.close();
				}
			}, {
				label : '<spring:message code="tds.common.label.close"/>',
				action : function(dialogItself) {
					dialogItself.close();
				}
			} ]
		});
	}
	
	
	
	function initRadio(){
		var val=$('input:radio[name="dataSourceType"]:checked').attr("title");
		if(val!=null){
			if(val=="java"){
				$("#java_dataSource").show();
				$("#sql_dataSource").hide();
			}else{
				$("#java_dataSource").hide();
				$("#sql_dataSource").show();
			}
		}
	}
	
	
	function convertTip(tip){
		 var flag="";
		 var deleteChildTip="删除失败，当前节点不为空，先删除此节点下的子节点才能删除";
		 var deleteSuccess="删除数据成功";
		 if(deleteSuccess==tip){
			 flag='<spring:message code="tds.dataRight.label.deleteSuccess"/>';
		 }else if(deleteChildTip==tip){
			 flag='<spring:message code="tds.dataRight.label.deleteChildTip"/>';
		 }else{
			 flag='<spring:message code="tds.dataRight.label.operateFail"/>';
		 }
		 return flag;
	}
	
	function getFisrtTreeMenu(){
		
		$("#root").css("left",event.clientX);
		$("#root").css("top",event.clientY);
// 		$("#menuRightFactor").addClass("disabled");
// 		$("#menuRightFactor").attr("onclick","");
// 		$("#menuRightFactorTypeSub").addClass("disabled");
// 		$("#menuRightFactorTypeSub").attr("onclick","");
		
		
// 		$("#deleteTreeNode").addClass("disabled");
// 		$("#deleteTreeNode").attr("onclick","");
		
		$("#root").show();
	}
	
	 function bingBtnClick(type){
		 
		 if("DataRightType"==type){
			 $("#cumBtn").click(function(){
				  saveRightType();
			   });
		 }else if("DataRight"==type){
			 $("#cumBtn").click(function(){
				 saveRightFactor();
			 });
		 }else{
			 $("#cumBtn").unbind();
		 }
		
		 
	 }
	  
	
</script>