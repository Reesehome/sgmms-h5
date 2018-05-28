<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************流程监控主界面**********************************/

$(function () {
	$("#processListTabMainbox").load(ctx + "/admin/workflow/processinstance/processInstanceRunning.do");
});

function allTaskTab(){
	$("#allTaskTabMainbox").load(ctx + "/admin/workflow/processinstance/allTaskTab.do");
}

function processListTab(){
	$("#processListTabMainbox").load(ctx + "/admin/workflow/processinstance/processInstanceRunning.do");
}
</script>