<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
	$(function() {
		//组织树
		var zTreeDia;
		//临时准备选中的节点
		var readySelectNodeDia;
		
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
			async : {
				enable : true,
				url: "${ctx}/admin/organization/findAdminOrgByParentId.do",
				dataFilter: ajaxDataFilter,  //用于对 Ajax 返回数据进行预处理的函数
				autoParam: ["id"]
			}
		};
		
		//初始化组织机构树事件
		$.tdsAjax({
			url : "${ctx}/admin/organization/findAdminOrgByParentId.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				zTreeDia = $.fn.zTree.init($("#treeDia"), setting, data);
				var nodes = zTreeDia.getNodes();
				if (nodes.length > 0) {
					zTreeDia.expandNode(nodes[0], true, false, true);
					zTreeDia.selectNode(nodes[0], true);
				}else{
					$("#alertTip").html("提示：<br>没有权限查看！请让管理员配置。");
					$("#alertTip").show();
				}
			}
		});
		
		
		function updateNodeDisable(node,zTreeDia){
			zTreeDia.removeNode(node);
			if(node.children && node.children.length>0){
				var arrNodes=node.children;
				for( var i = 0; i < node.children.length; i++) {
					updateNodeDisable(arrNodes[i],zTreeDia);
				}
			}
		}
		
		
		function ajaxDataFilter(treeId, parentNode, responseData) {
			var copyData = new Array();
			var fireOrgId=$("#fireOrgId").val();
		    if(responseData) {
		      for(var i =0; i <responseData.length; i++) {
		    	  if(responseData[i].id !=fireOrgId){
		    		  copyData.push(responseData[i]);
		    	  }
		      }
		    }
		    return copyData;
		};
		
	});
	
</script>