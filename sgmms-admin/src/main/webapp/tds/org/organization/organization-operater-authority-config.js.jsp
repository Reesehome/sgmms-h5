<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
(function($){
	$(function() {
		//树配置信息
		var setting = {
			check : {
				enable : true
			},
			simpleData : {
				enable: true
			}
		};
		
		$.tdsAjax({
			url : "${ctx}/admin/orguser/findCurrUserOperationRightGroup.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				var zTree = $.fn.zTree.init( $("#operaterAuthorityTree"), setting, data);
				//设置树节点选中
				$.setTreeNodeSelected("operaterAuthorityTree", "${orgRightGroupAuthorize}");
			}
		});
	});
})($);
</script>