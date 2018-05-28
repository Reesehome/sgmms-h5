<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ include file="/tds/workflow/js/process-back.js.jsp"%>
<style type="text/css">
		.vertical-space{margin-bottom: 10px; }
</style>
    
    <div class="form-group has-error" id="tipId" style="display: none;">
      <label class="control-label" for="inputError1">提示：请选择一个环节进行操作</label>
    </div>

    <input id="pid" name="pid" value="${pid}" type="hidden"/>
    <input id="taskId" name="taskId" value="${taskId}" type="hidden"/>
    <input id="isAll" name="isAll" value="${isAll}" type="hidden"/>
	<div id="nodelist">
	</div>