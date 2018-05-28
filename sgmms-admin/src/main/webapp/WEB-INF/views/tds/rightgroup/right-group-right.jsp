<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
div#right-tree-menu {
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
	<%-- <div class="col-50 horizontal full-height">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
			<div class="panel-heading"><b><spring:message code="tds.authority.label.authorityGroup"/></b></div>
			<div class="panel-body">
				<form:form id="GroupForm" class="form-horizontal" modelAttribute="group" role="form">
					<div class="form-group">
				    	<label for="groupName"class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.name"></spring:message></label>
				   		<div class="col-sm-8">
					    	<form:input path="name" class="required form-control" id="groupName" value="${group.name }"/>
					    </div>
				  	</div>
				  	<div class="form-group">
				    	<label for="groupDesc" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.description"></spring:message></label>
				    	<div class="col-sm-8">
				    		<form:textarea rows="5" path="description" class="maxLength form-control" max-length="128" id="groupDesc"  value="${group.description }"/>
				    	</div>
				  	</div>
				  	<form:hidden path="id" value="${group.id }" id="groupId"/>
				  	<form:hidden path="isValid" value="${group.isValid }" id="isValid"/>
				  	<form:hidden path="sortOrder" value="${group.sortOrder }" id="sortOrder"/>
				  	<form:hidden path="creatorId" value="${group.creatorId }" id="creatorId"/>
				  	
				  	<input type="hidden" name="rightIds" value="" id="rightIds"/>
				  	<input type="hidden" name="orgIds" value="" id="orgIds"/>
				</form:form>
			</div>
		</div>
	</div> --%>
	<div class="horizontal full-height full-width">
		<div class="panel panel-info full-height" style="margin-bottom: 0px;">
<%-- 			<div class="panel-heading"><b><spring:message code="tds.authority.label.authorityItem"/></b></div> --%>
			<div class="panel-body panel-body-addition">
				<div class="panel-body-content" style="text-decoration: none;">
					<ul id="group-right-tree" class="ztree"/>
				</div>
			</div>
		</div>
	</div>
	
	<div id="right-tree-menu" class="list-group" style="visibility:hidden;">
		<a id="selectParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择父节点</a>
		<a id="selectSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 选择子节点</a>
		<a id="cancelParent" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消父节点</a>
		<a id="cancelSon" href="javascript:void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> 取消子节点</a>
	</div>
	
	<script type="text/javascript">
		var group_right_tree_settings = {
			check: {
				enable: true,
				chkStyle: "checkbox",
				chkboxType: { "Y": "p", "N": "p" }
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
		
		function initGroupRightTree(){
			var operations = '${operationJson }';
			var allOperations = '${allOperationJson }';
			if(isNotEmpty(allOperations)){
				var allOperationJson = eval('('+ allOperations +')');
				var tree = $.fn.zTree.init($('#group-right-tree'), group_right_tree_settings, allOperationJson);
				openFirstNode(tree,'group-right-tree');
				if(isNotEmpty(operations)){
					var operationJson = eval('('+ operations +')');
					$.each(operationJson, function(idx,aOperation){
						var aNode = tree.getNodeByParam('id',aOperation.id,null);
						if(aNode)
							tree.checkNode(aNode,true,true,false);
					});
				}
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
		
		$('#right-tree-menu a').click(function(){
			var id = $(this).attr('id');
			if('selectParent' == id)
				doSelectParent();
			else if('selectSon' == id)
				doSelectSon();
			else if('cancelParent' == id)
				doCancelParent();
			else if('cancelSon' == id)
				doCancelSon();
			$("#right-tree-menu").css({"visibility" : "hidden"});
		});
		
		function doSelectParent(){
			var tree = $.fn.zTree.getZTreeObj('group-right-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkParentNodes(selectedNode,true);
			}
		}
		
		function doSelectSon(){
			var tree = $.fn.zTree.getZTreeObj('group-right-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkSubNodes(selectedNode,true);
			}
		}
		
		function doCancelParent(){
			var tree = $.fn.zTree.getZTreeObj('group-right-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkParentNodes(selectedNode,false);
			}
		}
		
		function doCancelSon(){
			var tree = $.fn.zTree.getZTreeObj('group-right-tree');
			var selectedNode = tree.getSelectedNodes()[0];
			if(selectedNode){
				tree.checkSubNodes(selectedNode,false);
			}
		}
		
		function showOrgMenu( x, y) {
			$("#right-tree-menu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
		}
		
		initGroupRightTree();
		
	</script>
</body>
</html>