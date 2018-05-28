<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Authority Organization Tree</title>
<style type="text/css">
div#org-tree-menu {
	position:absolute;
	visibility:hidden;
	top:0; 
	border: 1px solid #337ab7;
	text-align: left;
	padding: 2px;
	background-color: white;
}
</style>
</head>
<body>
	<div class="horizontal full-height full-width">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
<%-- 			<div class="panel-heading"><b><spring:message code="tds.authority.label.organizationAuthority"/></b></div> --%>
			<div class="panel-body panel-body-addition">
				<div class="panel-body-content">
					<ul id="auth-group-org-tree" class="ztree"/>
				</div>
			</div>
		</div>
	</div>
	<div id="org-tree-menu" class="list-group" style="visibility:hidden;">
		<a id="selectParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择父节点</a>
		<a id="selectSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择子节点</a>
		<a id="cancelParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消父节点</a>
		<a id="cancelSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消子节点</a>
	</div>
	<script>
		var group_org_tree_settings = {
			check: {
				enable: true,
				chkStyle: "checkbox",
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
					parentId: "parentId"
				}
			},
			view: {
				fontCss: {'text-decoration': 'none'}
			},
			callback: {
				onRightClick: orgNodeOnRightClick
			}
		};
		
		function initOrgTree(){
			var allOrganization = '${allOrganizationJson }';
			if(isNotNullAndEmpty(allOrganization)){
				var allOrganizationJson = eval('(' + allOrganization + ')');
				var tree = $.fn.zTree.init($('#auth-group-org-tree'), group_org_tree_settings, allOrganizationJson);
				openFirstNode(tree,'auth-group-org-tree');
				var groupOrganization = '${groupOrganizationJson }';
				if(isNotNullAndEmpty(groupOrganization)){
					var groupOrganizationJson = eval('(' + groupOrganization + ')');
					$.each(groupOrganizationJson, function(idx,aOrganization){
						var aNode = tree.getNodeByParam('id',aOrganization.id,null);
						if(aNode)
							tree.checkNode(aNode,true,true,false);
					});
				}
			}
		}
		
		$('#org-tree-menu a').click(function(){
			var id = $(this).attr('id');
			if('selectParent' == id)
				doSelectParent();
			else if('selectSon' == id)
				doSelectSon();
			else if('cancelParent' == id)
				doCancelParent();
			else if('cancelSon' == id)
				doCancelSon();
			$("#org-tree-menu").css({"visibility" : "hidden"});
		});
		
		function doSelectParent(){
			var tree = $.fn.zTree.getZTreeObj('auth-group-org-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkParentNodes(selectedNode,true);
			}
		}
		
		function doSelectSon(){
			var tree = $.fn.zTree.getZTreeObj('auth-group-org-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkSubNodes(selectedNode,true);
			}
		}
		
		function doCancelParent(){
			var tree = $.fn.zTree.getZTreeObj('auth-group-org-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkParentNodes(selectedNode,false);
			}
		}
		
		function doCancelSon(){
			var tree = $.fn.zTree.getZTreeObj('auth-group-org-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkSubNodes(selectedNode,false);
			}
		}
		
		function showOrgMenu( x, y) {
			$("#org-tree-menu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
			//$("body").bind("mousedown", onOrgMenuOut);
		}
		
		function onOrgMenuOut(event){
			if (!(event.target.id == "org-tree-menu" || $(event.target).parents("#org-tree-menu").length>0)) {
				$("#org-tree-menu").css({"visibility" : "hidden"});
			}
		}
		
		function orgNodeOnRightClick(event, treeId, treeNode){
			var tree = $.fn.zTree.getZTreeObj(treeId);
			if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
				tree.cancelSelectedNode();
			} else if (treeNode && !treeNode.noR) {
				tree.selectNode(treeNode);
				var topParent = $('#authority-content')[0];
				var x = topParent?(event.clientX - topParent.offsetLeft):event.clientX;
				var y = topParent?(event.clientY - topParent.offsetTop):event.clientY;
				showOrgMenu( x, y);
			}
		}
		
		initOrgTree();
	</script>
</body>
</html>