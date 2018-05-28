<%--
  Created by IntelliJ IDEA.
  User: QIAN
  Date: 2018/5/9
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>就餐管理</title>
    <jsp:include page="/tds/common/ui-lib.jsp" />
    <style>
        .vertical-space{margin-bottom: 10px; }
        .module-header{height: 40px;vertical-align: middle;display: table-cell;margin-left: -15px; }
        .ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
        .ui-widget-content .link:hover{color: #23527c;}
        .form-group .input-field{width: 180px;}
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="module-header">
        <strong><i class="glyphicon glyphicon-list"></i>就餐管理</strong>
    </div><!-- module-header -->
    <div>
        <!-- 查询条件 -->
        <div class="panel panel-info">
            <div class="panel-heading" style="min-height: 45px;">
                <b><spring:message code="tds.common.label.searchForm"/></b>
                <form id="dining-manager-form" class="form-horizontal">
                    <div class="form-group">
                        <label for="title" class="col-sm-1 control-label">会议名称</label>
                        <div class="col-sm-3">
                            <input id="title" name="title" class="form-control" placeholder="请输入会议名称">
                        </div>
                        <label for="status" class="col-sm-1 control-label">会议状态</label>
                        <div class="col-sm-3">
                            <select id="status" class="form-control input-field" name="status">
                                <option value="">全部</option>
                                <option value="UNSTART">未启动</option>
                                <option value="STARTED">启动</option>
                                <option value="ENDED">结束</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="beginTime" class="col-sm-1 control-label">开始时间</label>
                        <div class="col-sm-3">
                            <input id="beginTime" name="beginTime" class="form-control" placeholder="请输入开始时间" readonly>
                        </div>

                        <label for="endTime" class="col-sm-1 control-label">结束时间</label>
                        <div class="col-sm-3">
                            <input id="endTime" name="endTime" class="form-control" placeholder="请输入结束时间" readonly>
                        </div>

                        <div class="bottom" style="margin-left: 0px;float: right;clear: both;margin-right: 10px">
                            <button type="button" class="btn btn-warning" id="query-dining-manager" onclick="queryDiningManger()">
                                &nbsp;查&nbsp;&nbsp;询&nbsp;
                            </button>
                            <button type="button" class="btn btn-info" id="clear-dining-manager" data-placement="bottom" onclick="clearDiningManger()">
                                &nbsp;清&nbsp;&nbsp;空&nbsp;
                            </button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <div class="vertical-space"></div>
    <div>
        <div class="panel panel-info">
            <div class="panel-heading"><b>就餐管理列表</b></div>
            <div class="panel-body">
                <table id="dining-manager-table"></table>
                <div id="dining-manager-pager"></div>
            </div>
        </div>
    </div>
</div>
<iframe id="ExportLoginLogFrame" name="ExportLoginLogFrame" style="display: none;"></iframe>
<script type="text/javascript" src="${ctx }/admin/dining/diningManager.js"></script>
</body>
</html>
