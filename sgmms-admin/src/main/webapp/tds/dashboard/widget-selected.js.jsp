<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
$(function() {
	//树配置信息
	var setting = {
		check : {
			enable : true
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
	};
	
	$.tdsAjax({
		url : "${ctx}/admin/dashboard/findWidgetTreeNode.do",
		type : "POST",
		dataType : "json",
		success : function(data) {
			var _ztree = $.fn.zTree.init($("#widget-selected-tree"), setting, data);
			
			//设置树节点选中
			var _selectedIds = "${selectId}";
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
		}
	});
});
</script>