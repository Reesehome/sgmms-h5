<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ include file="/tds/workflow/activity-driver-mapper/js/pro-act-regist-edit.js.jsp"%>

<form class="form-horizontal" action="${ctx}/admin/ActivityDriverMapper/editProActRegist.do">
    <input type="hidden" id="processKey" name="processKey" value="${proActRegist.processKey}">
    <input type="hidden" id="seqnum" name="seqnum" value="${proActRegist.seqnum}">

    <br>
    流程节点信息：
    <hr style="margin-bottom: 5px;margin-top: 5px">
    <div class="form-group">
        <label class="col-md-2 control-label">节点名称</label>
        <div class="col-md-10">
            <input class="form-control" id="activityName" name="activityName" value="${proActRegist.activityName}" readonly="readonly">
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">节点编码</label>
        <div class="col-md-10">
            <input class="form-control" id="activityId" name="activityId" value="${proActRegist.activityId}" readonly="readonly">
        </div>
    </div>

    <%--<div class="form-group">
        <label class="col-md-2 control-label">排序</label>
        <div class="col-md-10">
            <input class="form-control" id="seqnum" name="seqnum" value="${proActRegist.seqnum}" readonly="readonly">
        </div>
    </div>--%>

    <div class="form-group">
        <label class="col-md-2 control-label">是否支持多人处理</label>
        <div class="col-md-10">
            <select class="form-control" id="multiSelect" name="multiSelect">
                <c:choose>
                    <c:when test="${proActRegist.multiSelect == 'Y'}">
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
        <label class="col-md-2 control-label">是否需要发邮件</label>
        <div class="col-md-10">
            <select class="form-control" id="sendEmail" name="sendEmail">
                <c:choose>
                    <c:when test="${proActRegist.sendEmail == 'Y'}">
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
</form>

<div class="panel panel-info">
    <div class="panel-heading clearfix">
        <span class="pull-left" style="padding-top: 8px;"><b>流程参与人配置</b></span>
        <div class="btn-group pull-right" role="group">
            <button type="button" class="btn btn-info" onclick="test()">测试</button>
            <button type="button" class="btn btn-primary" onclick="showSelectDriverWind('add')"><spring:message code="tds.sys.property.add"/></button>
            <button type="button" class="btn btn-success" onclick="showSelectDriverWind('update')"><spring:message code="tds.sys.property.update"/></button>
            <button type="button" class="btn btn-warning" id="btnDeleteMapper" ><spring:message code="tds.sys.property.delete"/></button>
        </div>
    </div>
    <div id="mainContainerBody" class="panel-body" style="min-height:350px;">
        <table id="list"></table>
    </div>
</div>