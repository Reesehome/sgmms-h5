<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">

<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>
<script type="text/javascript" src="${ctx }/tds/common/ztree-ext.js"></script>

<jsp:include page="/tds/common/work-flow/select-handler.js.jsp" />

<div class="container-fluid" style="padding: 0px">
    <div class="row" style="padding: 0px">
        <div class="col-sm-5" style="padding: 0px">
            <ul id="tree" class="ztree"></ul>
        </div>

        <div class="col-sm-7" style="padding: 0px">
            <table id="userTable"></table>
            <div id="userTablePager"></div>
        </div>
    </div>
</div>