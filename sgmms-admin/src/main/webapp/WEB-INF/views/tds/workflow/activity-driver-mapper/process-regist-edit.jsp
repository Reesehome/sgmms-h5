<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<form class="form-horizontal" action="${ctx}/admin/ActivityDriverMapper/editProcessRegist.do">
	<br>
    <div class="form-group">
        <label class="col-md-2 control-label">流程名</label>
        <div class="col-md-10">
            <input class="form-control" id="processName" name="processName" value="${processRegist.processName}" readonly="readonly">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">流程定义key</label>
        <div class="col-md-10">
            <input class="form-control" id="processKey" name="processKey" value="${processRegist.processKey}" readonly="readonly">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">是否可以启动</label>
        <div class="col-md-10">
            <select class="form-control" id="canStart" name="canStart">
                <c:choose>
                    <c:when test="${processRegist.canStart == 'Y'}">
                        <option value="Y">是</option>
                        <option value="N">否</option>
                    </c:when>
                    <c:otherwise>
                        <option value="N">否</option>
                        <option value="Y">是</option>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">工作流草稿打开的url</label>
        <div class="col-md-10">
            <input class="form-control" id="draftUrl" name="draftUrl" value="${processRegist.draftUrl}">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">小图标</label>
        <div class="col-md-10">
            <input class="form-control" id="smallIcon" name="smallIcon" value="${processRegist.smallIcon}">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">大图标</label>
        <div class="col-md-10">
            <input class="form-control" id="largeIcon" name="largeIcon" value="${processRegist.largeIcon}">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">流程描述</label>
        <div class="col-md-10">
            <textarea class="form-control" id="note" name="note">${processRegist.note}</textarea>
        </div>
    </div>
</form>