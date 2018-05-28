var homepageSetting = {
	async : {
		enable : false,
		url : getContext() + "/admin/menuRight/findChildren.do",
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
		onClick: selectHomepage,
	}
};

/**
 * 初始化菜单树
 */
function initHomepageTree(){
	$.tdsAjax({
		url:  getContext() + '/admin/menuRight/findMenusWithoutSkipByUser.do',
		dataType: 'json',
		success: function(data){
			var success = data.success;
			if(success)
				$.fn.zTree.init($('#personality-homepage-tree'), homepageSetting, data.params.menus);
		}
	});
}

/**
 * 选择菜单
 * @param event
 * @param treeId
 * @param treeNode
 */
function selectHomepage(event, treeId, treeNode){
	var menuId = treeNode.id;
	var menuName = getParentName(treeNode.name,treeNode.parentId);
	$('#menuId').val(menuId);
	$('#menuName').val(menuName);
	$('#menuType').val('menu');
	$('body').click();
}

/**
 * 查询自顶向下的菜单名称
 * @param childName
 * @param myId
 * @returns
 */
function getParentName(childName,myId){
	if(myId == null || myId == '' || typeof myId == 'undefined') return childName;
	var tree = $.fn.zTree.getZTreeObj('personality-homepage-tree');
	var me = tree.getNodeByParam("id", myId, null);
	if(!me) return childName;
	var nameTemp = me.name + '->' + childName;
	var parentId = me.parentId;
	return getParentName(nameTemp,parentId);
}