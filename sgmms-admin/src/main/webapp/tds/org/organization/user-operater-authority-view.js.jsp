<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
//********************************** 用户操作权限一览  ************************************
$(function(){
	var setting = {
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId"
				},
				key: {
					name: "name",
					id: "id",
					parentId: "parentId",
					url : "_url"
				}
			}
		};
	
	$.tdsAjax({
		url : "${ctx}/admin/orguser/findUserOperaterAuthorityView.do",
		type : "POST",
		data : {userId : "${userId}", orgId : "${orgId}"},
		dataType : "json",
		success : function(data) {
			var ztree = $.fn.zTree.init($("#userOperaterRightView"), setting, data);
			ztree.expandAll(true);
		}
	});
});
</script>