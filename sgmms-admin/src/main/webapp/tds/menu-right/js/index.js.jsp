<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
	var zTree;
	var readySelectNode;//临时准备选中的节点
	
	//树配置信息
	var setting = {
		async: {
			enable: true,
			url: "${ctx}/admin/menuRight/findChildren.do",
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
		callback : {
			onClick : nodeClickHandler,
			onRightClick : zTreeOnRightClick,
			onDrop : sort
		}
	};
	
	$(function(){
		zTree = $.fn.zTree.init($("#tree"), setting, null);
		
		//其它区域点击的时候隐藏菜单
		$("body").click(function(){
			$("#treeRightMenu").hide();
			$("#treePanelRightMenu").hide();
		});
	});
	
	function dropNode(treeId, nodes, targetNode) {
		return nodes[0].level == targetNode.level;
	}
	
	/**
	 * 树节点点击回调事件
	 */
	function nodeClickHandler(event, treeId, treeNode){
		$.tdsAjax({
			url:"${ctx}/admin/menuRight/showEdit.do",
			cache:false,
			data:{id:treeNode.id,executeType:'executeTypeUpdate'},
			success: function(pageHTML){
				$("#mainContainer").html(pageHTML);
			}
		});
	}
	
	/**
	 * 树节点右键点击回调事件
	 */
	function zTreeOnRightClick(event, treeId, treeNode) {
		showRightMenu(event,'treeRightMenu');
		readySelectNode = treeNode;
	}
	
	/**
	 * 树节点右键点击回调事件
	 */
	function showRightMenu(event,menuId) {
		$("#treeRightMenu").hide();
		$("#treePanelRightMenu").hide();
		
		//设置菜单坐标
		$("#" + menuId).css("left",event.clientX);
		$("#" + menuId).css("top",event.clientY);
		$("#" + menuId).show();
	}
	
	/**
	 * 添加同级菜单
	 */
	function addMenu(executeType) {
		var currentMenuId = "";
		
		if(executeType != "executeTypeAddTop"){
			currentMenuId = readySelectNode.id;
			zTree.selectNode(readySelectNode);
		}
		
		$.tdsAjax({
			url:"${ctx}/admin/menuRight/showEdit.do",
			cache:false,
			data : {id:currentMenuId,executeType:executeType},
			success: function(pageHTML){
				$("#mainContainer").html(pageHTML);
			}
		});
	}
	
	/**
	 * 排序回调事件
	 */
	function sort(event, treeId, treeNodes, targetNode, moveType){
		if(moveType == null)
			return;
		
		var node = treeNodes[0];
		
		$.tdsAjax({
			url:"${ctx}/admin/menuRight/updateSort.do",
			cache:false,
			data:{"currentId":node.id, "targetId":targetNode.id, "moveType":moveType},
			success: function(result){
				if(!result.success){
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
	
	/**
	 * 菜单删除回调事件
	 */
	function deleteMenu(){
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
			message : "<spring:message code='tds.menuRight.message.confirmDelete'/>",
			buttons : [ {
				label : '<spring:message code="tds.common.label.submit"/>',
				cssClass : 'btn-primary',
				action : function(dialogItself) {
					$.tdsAjax({
						url:"${ctx}/admin/menuRight/deleteMenuRight.do",
						cache:false,
						data:{"id":readySelectNode.id},
						success: function(result){
							if(result.success)
								zTree.removeNode(readySelectNode);
							else{
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
	
	/**
	 * 保存功能模块
	 */
	function editMenuRight() {
		
		if(!document.getElementById("menuRightForm"))
			return;
		
		//表单验证不通过退出方法
		if (!$("#menuRightForm").valid()) {
			BootstrapDialog.show({
				title : '<spring:message code="tds.common.label.warningTitle"/>',
				size : BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_WARNING,
				message : '<spring:message code="tds.common.message.formValidIncorrect"/>',
				buttons : [ {
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself) {
						//关闭窗口
						dialogItself.close();
					}
				}]
			});
			
			return;
		}
		
		//获取要提交的参数
		var params = $("#menuRightForm").serializeJson();
		var menuRightLangs = $("#list").jqGrid("getRowData");
		if(menuRightLangs && menuRightLangs.length > 0){
			$.each(menuRightLangs,function(i,menuRightLang){
				//把现在最新的值替换到参数中
				menuRightLang.name = $("#"+menuRightLang.lang).val();
				
				//删除多余的参数
				delete params[menuRightLang.lang];  
			});
			params.menuRightLangs = menuRightLangs;
		}
		
		$.tdsAjax({
			url : ctx + "/admin/menuRight/editMenuRight.do?executeType="+$("#executeType").val(),
			cache : false,
			dataType : "json",
			contentType : 'application/json',
			type : "POST",
			data : JSON.stringify(params),
			success : function(result) {
				if (result.success) {
					BootstrapDialog.show({
						title : '<spring:message code="tds.menuRight.label.executeSuccess"/>',
						size : BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_SUCCESS,
						message : result.message,
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
					var rightId = $("#rightId").val();
					
					//更新树节点的属性
					if (nodes && nodes.length == 1) {
						var node = nodes[0];
						if(node){
							//修改节点
							if(result.params.executeType == "executeTypeUpdate"){
								node.name = result.params.ztreeNode.name;
								node.icon =  $("#smallIcon").val();
								zTree.updateNode(node);
							}
							//增加顶级节点
							else if(result.params.executeType == "executeTypeAddTop"){
								zTree.addNodes(null,result.params.ztreeNode);
								zTree.reAsyncChildNodes(node, "refresh");
							}
							//增加同级节点
							else if(result.params.executeType == "executeTypeAddLevel"){
								var parentNode = node.getParentNode();
								zTree.addNodes(parentNode,result.params.ztreeNode);
								zTree.reAsyncChildNodes(node, "refresh");
							}
							//增加子级节点
							else if(result.params.executeType == "executeTypeAddSub"){
								zTree.addNodes(node,result.params.ztreeNode);
								zTree.reAsyncChildNodes(node, "refresh");
							}
						}
					}
					//增加顶级节点
					else  if(result.params.executeType == "executeTypeAddTop"){
						zTree.addNodes(null,result.params.ztreeNode);
						zTree.reAsyncChildNodes(null, "refresh");
					}
					
				} else {
					BootstrapDialog.show({
						title : '<spring:message code="tds.common.label.errorMessage"/>',
						size : BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_WARNING,
						message : result.message,
						buttons : [ {
							label : '<spring:message code="tds.common.label.close"/>',
							action : function(dialogItself) {
								dialogItself.close();
							}
						} ]
					});
				}
			}
		});
	}
</script>