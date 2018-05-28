<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************************数据权限授权*****************************/
jQuery(function($) {
	//权限类型 - 树配置信息
	var setting_type = {
		async : {
			enable : true,
			url : "${ctx}/admin/dataAuthority/findChildren.do",
			dataType : 'json',
			autoParam : [ "id" ]
		},
		edit : {
			enable : true,
			showRemoveBtn : false,
			showRenameBtn : false
		},
		data : {
			keep : {
				parent : true,
				leaf : true
			}
		},
		callback : {
			onClick : type_zTreeOnClick
		}
	};
	
	//权限数据 - 树配置信息
	var setting_data = {
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
				id: "id",
				name: "name",
				parentId: "parentId"
			}
		},
		callback : {
			onRightClick : dataTreeOnRightClick
		}
	};
	
	//权限类型树节点点击事件
	function type_zTreeOnClick(event, treeId, treeNode) {
		if(!treeNode.isParent) {
			$.fn.zTree.destroy("authorityDataTree");
			$.tdsAjax({
				url : "${ctx}/admin/organization/findRightDataTree.do",
				type : "POST",
				data : {objectId : "${objectId}", objectTypeId : "${objectTypeId}", dataRightId : treeNode.id},
				dataType : "json",
				success : function(data) {
					$.fn.zTree.init($("#authorityDataTree"), setting_data, data);
				}
			});
		}else {
			$.fn.zTree.destroy("authorityDataTree");
		}
	}
	
	var zTree_type = $.fn.zTree.init($("#authorityTypeTree"), setting_type, null);
	
	//************************** 权限数据  *********************************
	$("body").click(function(){
		$("#right-data-tree-menu").hide();
	});
	
	var rightSelectNode;
	//数据权限树右键点击事件
	function dataTreeOnRightClick(event, treeId, treeNode) {
		rightSelectNode = treeNode;
		//只有在节点上点击右键才显示菜单
		if(treeNode){
			//设置菜单坐标
			var rowObject = $("#data-right-div")[0];
			$("#right-data-tree-menu").css("left", (event.clientX - rowObject.offsetLeft + 130));
			$("#right-data-tree-menu").css("top", (event.clientY - rowObject.offsetTop + 25));
			$("#right-data-tree-menu").show();
		}
	}
	
	//选择父节点
	$("#selectRightDataParent").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("authorityDataTree");
		if(rightSelectNode){
			tree.checkParentNodes(rightSelectNode, true);
		}
	});
	
	//选择子节点
	$("#selectRightDataSon").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("authorityDataTree");
		if(rightSelectNode){
			tree.checkSubNodes(rightSelectNode, true);
		}
	});
	
	//取消父节点
	$("#cancelRightDataParent").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("authorityDataTree");
		if(rightSelectNode){
			tree.checkParentNodes(rightSelectNode, false);
		}
	});
	
	//取消子节点
	$("#cancelRightDataSon").on("click", function() {
		var tree = $.fn.zTree.getZTreeObj("authorityDataTree");
		if(rightSelectNode){
			tree.checkSubNodes(rightSelectNode, false);
		}
	});
	
});
</script>