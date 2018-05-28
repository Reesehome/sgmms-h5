var dashboardSetting = {
	async : {
		enable : false,
		url : getContext() + "/admin/dashboard/findDashboardTreeNode.do",
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
		showLine: false,
		fontCss: {'text-decoration': 'none'}
	},
	callback: {
		onClick: selectDashboard,
	}
};

/**
 * 初始化菜单树
 */
function initDashboardTree(){
	$.tdsAjax({
		url:  getContext() + '/admin/dashboard/findDashboardTreeNode.do',
		dataType: 'json',
		success: function(data){
				$.fn.zTree.init($('#personality-dashboard-tree'), dashboardSetting, data);
		}
	});
}

/**
 * 选择桌面
 * @param event
 * @param treeId
 * @param treeNode
 */
function selectDashboard(event, treeId, treeNode){
	var dashboardId = treeNode.id;
	var dashboardName = treeNode.name;
	$('#menuId').val(dashboardId);
	$('#menuName').val(dashboardName);
	$('#menuType').val('dashboard');
	$('body').click();
}