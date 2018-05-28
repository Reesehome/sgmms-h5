<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<jsp:include page="/tds/workflow/driver-config/js/driver-edit.js.jsp" />

<style type="text/css">
    .input-group {
        padding: 0px;
    }

    .form-horizontal {
        padding-right: 5px;
    }
</style>

<form id="driverConfigForm" class="form-horizontal">
    <div class="form-group">
        <label class="col-md-2 control-label">驱动编号</label>
        <div class="col-md-10">
            <div class="input-group input-sm">
                <span class="input-group-addon" style="color: red;">*</span>
                <input type="text" class="form-control" id="adapterId" name="adapterId" placeholder="请输入驱动编号" value="${driverConfig.adapterId}">
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">驱动名</label>
        <div class="col-md-10">
            <div class="input-group input-sm">
                <span class="input-group-addon" style="color: red;">*</span>
                <input type="text" class="form-control" id="adapterName" name="adapterName" placeholder="请输入驱动名" value="${driverConfig.adapterName}">
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">处理类</label>
        <div class="col-md-10">
            <div class="input-group input-sm">
                <span class="input-group-addon" style="color: red;">*</span>
                <input type="text" class="form-control" id="className" name="className" placeholder="请输入处理类名(类的全名字，包含包名)" value="${driverConfig.className}">
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">缺省参数</label>
        <div class="col-md-10">
            <div class="input-group input-sm">
                <span class="input-group-addon" style="color: red;">*</span>
                <textarea class="form-control input-sm" id="defaultParams" name="defaultParams" placeholder="请输入缺省参数，格式为:{attrName1:value1,attrName2:value2}">${driverConfig.defaultParams}</textarea>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 control-label">描述</label>
        <div class="col-md-10">
            <textarea class="form-control input-sm" id="note" name="note" placeholder="请输入使用说明">${driverConfig.note}</textarea>
        </div>
    </div>
</form>