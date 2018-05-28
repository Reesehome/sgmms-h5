<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************************部门岗位配置*****************************/
$(function() {
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
		check : {
			enable : true,
			chkboxType: { "Y": "", "N": "" }
		}
	};
	
	var orgIds = "${orgIds}";
	function initTreeSelected() {
		if(orgIds) {
			var orgIdArr = orgIds.split(",");
			for(var i=0; i<orgIdArr.length; i++) {
				var node = zTree.getNodeByParam("id", orgIdArr[i]);
				if(node) {
					zTree.checkNode(node, true, false);
					zTree.selectNode(node);
					zTree.cancelSelectedNode(node);
				}
			}
		}
		var node = zTree.getNodeByParam("id", "${orgId}");
		if(node) {
			zTree.checkNode(node, true, false);
		}
	}
	
	//初始化组织机构树事件
	$.tdsAjax({
		url : "${ctx}/admin/organization/findOrganizationTree.do",
		type : "POST",
		dataType : "json",
		success : function(data) {
			zTree = $.fn.zTree.init($("#userDepartmentTree"), setting, data);
			//首次加载完后展开第一层节点信息
			var nodes = zTree.getNodes();
			if (nodes.length > 0) {
				zTree.expandNode(nodes[0], true, false, true);
			}
			
			initTreeSelected();
		}
	});
});
</script>