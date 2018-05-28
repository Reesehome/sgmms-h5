<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
$(function(){
	//树配置信息
	//已授权的权限组（通过部门授权获得）
	var has_setting = {
		simpleData : {
			enable: true
		}
	};
	//操作权限组树信息
	var group_setting = {
		check : {
			enable : true
		},
		simpleData : {
			enable: true
		}
	};
	//操作权限项树信息
	var item_setting = {
			check: {
				enable: true,
				chkboxType: { "Y": "", "N": "" }
			},
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId"
				},
				key: {
					name: "name",
					id: "id",
					parentId: "parentId",
					url : "_url"
				}
			},
			callback : {
				onRightClick : rightItemAuthorizedTreeOnRightClick
			}
		};
	
	//已拥有权限组数据加载(继承部门权限)
	$.tdsAjax({
		url : "${ctx}/admin/orguser/findUserHasOperationRightGroup.do",
		type : "POST",
		data : {userId : "${userId}", orgId : "${orgId}"},
		dataType : "json",
		success : function(data) {
			$.fn.zTree.init($("#hasBelongRightGroupTree"), has_setting, data);
		}
	});
	
	//操作权限组数据加载
	$.tdsAjax({
		url : "${ctx}/admin/orguser/findCurrUserOperationRightGroup.do",
		type : "POST",
		dataType : "json",
		success : function(data) {
			var _treeObject = $.fn.zTree.init($("#rightGroupAuthorizedTree"), group_setting, data);
			$.fn.zTree.getZTreeObj("rightGroupAuthorizedTree").expandAll(true);
			
			$.setTreeNodeSelected("rightGroupAuthorizedTree", "${rightGAuthorized}");
			//setSelect(_treeObject, "${rightGAuthorized}");
		}
	});
	
	//操作权限项数据加载
	$.tdsAjax({
		url : "${ctx}/admin/orguser/findUserOperationRightItem.do",
		type : "POST",
		data : {userId : "${userId}"},
		dataType : "json",
		success : function(data) {
			var _treeObject = $.fn.zTree.init($("#rightItemAuthorizedTree"), item_setting, data);
			$.fn.zTree.getZTreeObj("rightItemAuthorizedTree").expandAll(true);
			
			$.setTreeNodeSelected("rightItemAuthorizedTree", "${rightRAuthorized}");
			//setSelect(_treeObject, "${rightRAuthorized}");
		}
	});
	
	//设置选中
	function setSelect(_treeObject, _selectedIds) {
		if(_selectedIds) {
			var _selectedIdsArr = _selectedIds.split(",");
			for(var i=0; i<_selectedIdsArr.length; i++) {
				var node = _treeObject.getNodeByParam("id", _selectedIdsArr[i]);
				if(node) {
					_treeObject.checkNode(node, true, false);
				}
			}
		}
	}
	
	
	//************************** 右键操作菜单  *********************************
	$("body").click(function(){
		$("#right-item-authorized-menu").hide();
	});
	
	var rightSelectNode;
	//数据权限树右键点击事件
	function rightItemAuthorizedTreeOnRightClick(event, treeId, treeNode) {
		rightSelectNode = treeNode;
		//只有在节点上点击右键才显示菜单
		if(treeNode){
			//设置菜单坐标
			var rowObject = $("#right-item-authorized-div")[0];
			$("#right-item-authorized-menu").css("left", (event.clientX - rowObject.offsetLeft + 300));
			$("#right-item-authorized-menu").css("top", (event.clientY - rowObject.offsetTop + 25));
			$("#right-item-authorized-menu").show();
		}
	}
	
	//选择父节点
	$("#selectParent").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("rightItemAuthorizedTree");
		if(rightSelectNode){
			tree.checkParentNodes(rightSelectNode, true);
		}
	});
	
	//选择子节点
	$("#selectSon").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("rightItemAuthorizedTree");
		if(rightSelectNode){
			tree.checkSubNodes(rightSelectNode, true);
		}
	});
	
	//取消父节点
	$("#cancelParent").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("rightItemAuthorizedTree");
		if(rightSelectNode){
			tree.checkParentNodes(rightSelectNode, false);
		}
	});
	
	//取消子节点
	$("#cancelSon").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("rightItemAuthorizedTree");
		if(rightSelectNode){
			tree.checkSubNodes(rightSelectNode, false);
		}
	});
});
</script>