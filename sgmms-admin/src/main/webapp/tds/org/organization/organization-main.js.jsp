<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ taglib prefix="optRight" uri="/tags/operation-right.tld" %>

<script type="text/javascript">
(function($) {
	$.extend({
		loadDepEditPage : function(_orgId){
			//加载部门信息编辑页面
			$("#mainContainer").load(ctx + "/admin/organization/loadOrganizationDepartmentEditPage.do?orgId=" + _orgId);
		},
		loadDepAddPage : function(_parentOrgId){
			//加载部门信息新增页面
			$("#mainContainer").load(ctx + "/admin/organization/loadOrganizationDepartmentAddPage.do?parentOrgId=" + _parentOrgId);
		},
		loadEditOrgUserPage : function(_orgId, _userId) {
			//加载人员编辑页面
			$("#mainContainer").load(ctx + "/admin/orguser/loadEditOrgUserPage.do?orgId=" + _orgId + "&userId=" + _userId);
		},
		loadAddOrgUserPage : function(_orgId) {
			//加载人员新增页面
			$("#mainContainer").load(ctx + "/admin/orguser/loadAddOrgUserPage.do?orgId=" + _orgId);
		},
		loadButtomUserPage : function(_orgId) {
			//加载底部人员页面信息
			$("#buttomContainer").load(ctx + "/admin/organization/loadOrganizationButtomUserPage.do?orgId=" + _orgId);
		},
		loadButtomSearchUserPage : function(_params) {
			//加载底部查询人员页面信息
			$("#buttomContainer").load(ctx + "/admin/organization/loadOrganizationButtomSearchUserPage.do", _params);
		},
		loadButtomSearchOrgPage : function(_params) {
			//加载底部查询部门页面信息
			$("#buttomContainer").load(ctx + "/admin/organization/loadOrganizationButtomSearchOrgPage.do", _params);
		},
		setTreeNodeSelected : function(_treeId, _selectedIds) {
			var _ztree = $.fn.zTree.getZTreeObj(_treeId);
			if(_selectedIds && _ztree) {
				var _selectedArr = _selectedIds.split(",");
				for(var i=0; i<_selectedArr.length; i++) {
					var node = _ztree.getNodeByParam("id", _selectedArr[i]);
					if(node) {
						_ztree.checkNode(node, true, false);
						_ztree.selectNode(node);
						_ztree.cancelSelectedNode(node);
					}
				}
			}
		},
		reloadOrganizationNode : function(_parentOrgId, _orgId) {	//重新加载选中节点
			var ztree = $.fn.zTree.getZTreeObj("tree");
			if(ztree) {
				var pNode = ztree.getNodeByParam("id", _parentOrgId);
				if(pNode) {
					pNode.isParent = true;
					ztree.updateNode(pNode);
					ztree.reAsyncChildNodes(pNode, "refresh",false);
					
					//选中节点
					var interval;
					function initTreeSelected() {
						var node = ztree.getNodeByParam("id", _orgId);
						if(node) {
							ztree.selectNode(node);
							clearTimeout(interval);
						}
					}
					if(_orgId) {
						//重新加载部门编辑页面
						$.loadDepEditPage(_orgId);
						//重新加载底部人员页面
						$.loadButtomUserPage(_orgId);
						
						//选中节点
						interval = setInterval(initTreeSelected, "500");
					}
				}
			}
		}
	});
	
	$(function() {
		//组织树
		var zTree;
		//临时准备选中的节点
		var readySelectNode;
		
		//树配置信息
		var setting = {
			data : {
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "parentId",
					rootPid : null
				}
			},
			callback : {
				onClick : nodeClickHandler,
				onRightClick : zTreeOnRightClick
			},
			view: {
				fontCss: getFont,
				nameIsHTML: true
			},

			async : {
				enable : true,
				url: "${ctx}/admin/organization/findAdminOrgByParentId.do",
				autoParam: ["id"]
			}
		};
		
		/**
		 * 树节点点击回调事件
		 */
		function nodeClickHandler(event, treeId, treeNode, type){
			var currOrgId = treeNode.id;
			
			//加载部门信息编辑页面
			$.loadDepEditPage(currOrgId);
			//加载底部人员页面信息
			$.loadButtomUserPage(currOrgId);
		}
		
		/**
		 * 树节点右键点击回调事件
		 */
		function zTreeOnRightClick(event, treeId, treeNode){
			//只有在节点上点击右键才显示菜单
			if(treeNode){
				readySelectNode = treeNode;
				
				//设置菜单坐标
				$("#treeRightMenu").css("left",event.clientX);
				$("#treeRightMenu").css("top",event.clientY);
				
				//如果不是叶节点，就判断其子节点的类型来设置相应菜单的禁用状态
				if(treeNode.isParent){
					//禁用删除部门
					$("#deleteOrganization").addClass("disabled");
				}else {
					//取消禁用删除部门
					$("#deleteOrganization").removeClass("disabled");
				}
				
				/// 是否显示 禁用状态  和 解禁状态  2016
				if(treeNode.params.isEnable==null 
						|| treeNode.params.isEnable==""){
					$("#notEnableOrganization").show();
					$("#enableOrganization").hide();
				}else{
					$("#notEnableOrganization").hide();
					$("#enableOrganization").show();
				}
				
				
				$("#treeRightMenu").show();
			}
		}
		
		<optRight:hasOptRight rightCode="IDR_ORG_EDIT_ORG">
		/**
		 * 新增部门回调函数
		 */
		$("#addOrg").click(function() {
			var parentOrgId;
			if(readySelectNode) {
				parentOrgId = readySelectNode.id;
			}
			//加载部门信息新增页面
			$.loadDepAddPage(parentOrgId);
		});
		
		/**
		 * 删除部门回调函数
		 */
		$("#deleteOrganization").click(function() {
			if(!$(this).hasClass("disabled")) {
				BootstrapDialog.show({
					title : '<spring:message code="tds.common.label.editData"/>',
					message : '<spring:message code="tds.common.message.confirmDelete"/>',
					buttons : [ {
						label : '<spring:message code="tds.common.label.submit"/>',
						cssClass : 'btn-primary',
						action : function(dialogItself) {
							$.tdsAjax({
								url : "${ctx}/admin/organization/deleteOrganization.do",
								type : "POST",
								cache:false,
								data:{"orgId" : readySelectNode.id},
								success: function(result){
									if(result.success) {
										//加载部门信息新增页面
										$.loadDepAddPage(readySelectNode.parentId);
										zTree.removeNode(readySelectNode);
									}else{
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
		});
		
		function getFont(treeId, node) {
			return node.font ? node.font : {};
		}

		/**
		 * 禁用 点击
		 */
	    var iconParms="/tds/static/images/module-icon/server_key.png";
		$("#notEnableOrganization").click(function() {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if(readySelectNode){
				 // 更新后台数据
				 $.tdsAjax({
							url : "${ctx}/admin/organization/updateOrganizationStatus.do",
							type : "POST",
							cache:false,
							data:{"orgId" : readySelectNode.id,"status":"1"},
							success: function(result){
								    if(result.success) {
										// var fontJson={'background-color':'gray', 'color':'white'};
										 updateNodeStatus(readySelectNode,null,"1",iconParms);
										
										 alertDia('<spring:message code="tds.dataRight.label.operateSuccess"/>',"success");
									}else{
										alertDia('<spring:message code="tds.dataRight.label.operateFail"/>',"error");
									}
							}
				 });
				
			}
			
		});
		
		/**
		 * 递归更新节点状态
		 */
		function updateNodeStatus(readySelectNode,fontJson,isEnbleParams,iconParams){
			readySelectNode.icon =iconParams;
			readySelectNode.font=fontJson;
			readySelectNode.params.isEnable=isEnbleParams;
			zTree.updateNode(readySelectNode);
			
			if(readySelectNode.children && readySelectNode.children.length>0){
				var arrNodes=readySelectNode.children;
				for( var i = 0; i < readySelectNode.children.length; i++) {
					updateNodeStatus(arrNodes[i],fontJson,isEnbleParams,iconParams);
				}
			}
		}
		 
		 
		
		/**
		 * 解禁 点击
		 */
		$("#enableOrganization").click(function() {
			var zTree = $.fn.zTree.getZTreeObj("tree");
			if(readySelectNode){
				// 更新后台数据
				 $.tdsAjax({
							url : "${ctx}/admin/organization/updateOrganizationStatus.do",
							type : "POST",
							cache:false,
							data:{"orgId" : readySelectNode.id,"status":""},
							success: function(result){
								    if(result.success) {
										// var fontJson={'background-color':'white','color':'black'};
										 updateNodeStatus(readySelectNode,null,null,null);
										 alertDia('<spring:message code="tds.dataRight.label.operateSuccess"/>',"success");
									}else{
										 alertDia('<spring:message code="tds.dataRight.label.operateFail"/>',"error");
									}
							}
				 });
				
				
			}
			
		});
		
		
		/**
		 * 节点刷新点击绑定事件
		 */
		$("#nodeRefresh").click(function() {
			if(readySelectNode){
				zTree.reAsyncChildNodes(readySelectNode, "refresh");
			}
		});
		</optRight:hasOptRight>
		
		//初始化组织机构树事件
		$.tdsAjax({
			url : "${ctx}/admin/organization/findAdminOrgByParentId.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				zTree = $.fn.zTree.init($("#tree"), setting, data);
				//首次加载完后展开第一层节点信息
				var nodes = zTree.getNodes();
				if (nodes.length > 0) {
					zTree.expandNode(nodes[0], true, false, true);
					zTree.selectNode(nodes[0], true);
					//调用点击事件
					zTree.setting.callback.onClick(null, zTree.setting.treeId, nodes[0]);
				}
			}
		});
		
		//右键按钮隐蔽
		$("body").click(function() {
			$("#treeRightMenu").hide();
		});
		
		//查询类型改变事件
		$("input[name=searchType]").bind("change", function() {
			if($(this).attr("value") == "O") {
				$("#organization-search-content").show();
				$("#user-search-content").hide();
			}else {
				$("#organization-search-content").hide();
				$("#user-search-content").show();
			}
		});
		
		//查询
		$("#search").bind("click", function() {
			if($("input[name=searchType]:checked").val() == 'O') {
				//部门
				var orgInfo = $("#orgSearchForm").serialize();
				$.loadButtomSearchOrgPage(orgInfo);
			}else {
				//用户
				var userInfo = $("#userSearchForm").serialize();
				$.loadButtomSearchUserPage(userInfo);
			}
		});
	});
})(jQuery);





/**
*  小提示框
*/
function alertDia(mess,type){
	var Dialogtitle=""; Dialogtype="";
	if(type=="error"){
		Dialogtitle='<spring:message code="tds.common.label.errorMessage"/>';
		Dialogtype=BootstrapDialog.TYPE_WARNING;
	}else{
		Dialogtitle='<spring:message code="tds.dataRight.label.doSuccess"/>';
		Dialogtype=BootstrapDialog.TYPE_SUCCESS;
	}
	
	BootstrapDialog.show({
		title: Dialogtitle,
        size: BootstrapDialog.SIZE_SMALL,
        type : Dialogtype,
        closeByBackdrop: false,
        closeByKeyboard:false,
         closable:false,
        message: mess,
        buttons: [{
            label: '<spring:message code="tds.common.label.close"/>',
            action: function(dialogItself){
                dialogItself.close();
            }
        }]
    });
}

</script>