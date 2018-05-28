var menuSetting = {
	async : {
		enable : false,
		url : getContext() + '/admin/menuRight/findMenusByUser.do',
		dataType : 'json',
		autoParam : [ "id" ]
	},
	check: {
		enable: false,
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
		beforeClick: doBeforeClick
	}
};

function initMenuTree(){
	$.tdsAjax({
		url:  getContext() + '/admin/menuRight/findMenusWithoutSkipByUser.do',
		dataType: 'json',
		success: function(data){
			var success = data.success;
			if(success){
				$.fn.zTree.init($('#all-menu-tree'), menuSetting, data.params.menus);
			}
		}
	});
}

function getSelectedMenu(){
	var tree = $.fn.zTree.getZTreeObj('all-menu-tree');
	var selectedNodes = null;
	if(tree){
		selectedNodes = tree.getSelectedNodes();
	}
	return selectedNodes;
}

function doBeforeClick(treeId,treeNode,clickFlag){
	return !treeNode.isParent;
}