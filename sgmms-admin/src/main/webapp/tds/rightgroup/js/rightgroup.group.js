var opretationGroupSetting = {
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
		}
	},
	key: {
		name: "name",
		id: "id",
		parentId: "parentId"
	},
	async: {
		enable: false,
		url: "${ctx }" + getJspParam('path') +  "/authority/operation/findRightGroup.do",
		autoParam: ["id"]
	},
	view: {
		showLine: false,
		fontCss: {'text-decoration': 'none'}
	},
	callback: {
		onClick: treeNodeOnClick
//		onRightClick: treeNodeOnRightClick
	}
};

function initAuthorityOperationGroup(treeHtmlId){
	findAuthorityOperationGroup(treeHtmlId,"");
}

function findAuthorityOperationGroup(treeId,parentId){
	var context = getJspParam('ctx');
	$.tdsAjax({
		url: context + getJspParam('path') + '/right/group/findRightGroup.do',
		data: {parentId:parentId},
		dataType: "json",
		success: function(returnValues){
			var tree = $.fn.zTree.init($('#'+treeId), opretationGroupSetting, returnValues);
			var treeNodes = tree.getNodes();
			var rootNotExist = !treeNodes || treeNodes.length == 0;
			var firstChildId = $('#'+treeId).children('li:first').attr('id');
			toggleOperationCreation(treeId,'auth-group-root',rootNotExist);
			if( isNotEmpty(firstChildId) ){
				var firstNode = tree.getNodeByTId(firstChildId);
				if(firstNode){
					tree.expandNode(firstNode,true,false,true);
					tree.selectNode(firstNode);
					initGroupContent(firstNode.id);
				}
			}else{
				initGroupContent('');
			}
		},
		error: function(){
			
		}
	});
}

function treeNodeOnClick(event, treeId, treeNode){
	var id = treeNode.id;
	initGroupContent(id);
}

function initGroupContent(groupId){
	var ctx = getJspParam('ctx');
	var url =  ctx + getJspParam('path') + '/right/group/findSingleGroup.do';
	var rightUrl = ctx + getJspParam('path') + '/right/group/findGroupRight.do';
	var oTreeUrl = ctx + getJspParam('path') + '/right/group/findGroupOrganization.do';
	var oTableUrl = ctx + getJspParam('path') + '/right/group/findGroupOrganizationTable.do';
	var uTableUrl = ctx + getJspParam('path') + '/right/group/findGroupUserTable.do';

	var group = {id:groupId,url:url,containerid:'current-authority'};
	var right = {id:groupId,url:rightUrl,containerid:'group-right'};
	var oTree = {id:groupId,url:oTreeUrl,containerid:'organization-content'};
	var oTable = {id:groupId,url:oTableUrl,containerid:'organization-table'};
	var uTable = {id:groupId,url:uTableUrl,containerid:'user-table'};
	$.fn.authority.init({group:group,right:right,oTree:oTree,oTable:oTable,uTable:uTable});
	
	//$.fn.authority.initOranizationTree({groupContent:{id:groupId,url: oTreeUrl,containerid:'organization-content'},});
}

function treeNodeOnRightClick(event, treeId, treeNode){
	var tree = $.fn.zTree.getZTreeObj(treeId);
	if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
		tree.cancelSelectedNode();
	} else if (treeNode && !treeNode.noR) {
		tree.selectNode(treeNode);
		showGroupMenu( event.clientX, event.clientY);
	}
}

function showGroupMenu( x, y) {
	$("#rMenu").show();
	$("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
	$("body").bind("mousedown", onBodyMouseDown);
}

function createGroupRoot(){
	initGroupContent('');
}

function switchOperation(option){
	if('add' == option){
		initGroupContent('');
		$("#rMenu").css({"visibility" : "hidden"});
	} else if('delete' == option){
		deleteGroup();
	} else if('refresh' == option){
		refreshGroupTree();
		$("#rMenu").css({"visibility" : "hidden"});
	} else{
		$("#rMenu").css({"visibility" : "hidden"});
	}
}

//util methods
function getSelectedId(){
	var id = '';
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var selectedNode = tree.getSelectedNodes()[0];
	if(selectedNode)
		id = selectedNode.id;
	return id;
}

//<![CDATA[
function getCheckedIds(){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var checkedNodes = tree.getCheckedNodes(true);
	var array = new Array;
	var ids = '';
	if( checkedNodes && checkedNodes.length > 0){
		$.each(checkedNodes,function(idx,aNode){
			array.push(aNode.id);
		});
		ids = array.join(',');
	}
	return ids;
}
//]]>

function toggleOperationCreation(treeHtmlId,itemId,rootNotExist){
	if(rootNotExist){
		$("#"+treeHtmlId).siblings("#"+itemId).show();
		$("#"+treeHtmlId).hide();
	} else{
		$("#"+treeHtmlId).siblings("#"+itemId).hide();
		$("#"+treeHtmlId).show();
	}
}

function updateGroupTreeSelectedNodeName(name){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var selectedNode = tree.getSelectedNodes()[0];
	if(selectedNode && selectedNode.name != name){
		selectedNode.name=name;
		tree.updateNode(selectedNode);
	}
}

function selectedNodeClick(){
	var id = getSelectedId();
	if(isNotNullAndEmpty(id)){
		initGroupContent(id);
	}
}

function addGroupNode(node){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var addNodes = tree.addNodes(null, node);
	tree.selectNode(addNodes[0],false);
}

function refreshGroupTree(){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	if(tree){
		tree.refresh();
		groupTreeFirstNodeClick();
	}
}

function groupTreeFirstNodeClick(){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	if(tree){
		var treeNodes = tree.getNodes();
		var rootNotExist = !treeNodes || treeNodes.length == 0;
		toggleOperationCreation('auth-group-tree','auth-group-root',rootNotExist);
		var firstChildId = $('#auth-group-tree').children('li:first').attr('id');
		if( isNotEmpty(firstChildId) ){
			var firstNode = tree.getNodeByTId(firstChildId);
			if(firstNode){
				tree.selectNode(firstNode);
				initGroupContent(firstNode.id);
			}
		}else{
			initGroupContent('');
		}
	}
}

function deleteGroupTreeNode(id){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var deletedNode = tree.getNodeByParam('id',id,null);
	if(deletedNode)
		tree.removeNode(deletedNode,false);
}

function isGroupTreeEmpty(){
	var tree = $.fn.zTree.getZTreeObj('auth-group-tree');
	var treeNodes = tree.getNodes();
	return treeNodes && treeNodes.length > 0;
}

function representGroupTree(){
	if(isGroupTreeEmpty())
		toggleOperationCreation('auth-group-tree','auth-group-root',false);
}