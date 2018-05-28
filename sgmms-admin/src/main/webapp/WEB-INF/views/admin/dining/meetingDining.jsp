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
    <title>会议就餐</title>
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
        <strong><i class="glyphicon glyphicon-list"></i>会议就餐</strong>
    </div><!-- module-header -->
    <div>

        <div class="form-group">
            <table style="width: 100%;" border="1">
                <tr>
                    <td><label class="control-label col-md-6">会议编号</label></td><td>${ mmsConferenceMain.code }</td>
                    <td><label class="control-label col-md-6">会议名称</label></td><td>${ mmsConferenceMain.title }</td>
                    <td><label class="control-label col-md-6">会议时间</label></td><td>${ mmsConferenceMain.beginTime } - ${ mmsConferenceMain.endTime }</td>
                </tr>
                <tr>
                    <td><label class="control-label col-md-6">会议地址</label></td><td>${ mmsConferenceMain.venue }</td>
                    <td><label class="control-label col-md-6">会议人数</label></td><td>${ mmsConferenceMain.totalUsers }</td>
                    <td></td><td></td>
                </tr>
            </table>
        </div>

        <!-- 查询条件 -->
        <div class="panel panel-info">
            <div class="panel-heading" style="min-height: 45px;">
                <b><spring:message code="tds.common.label.searchForm"/></b>
                <form id="meeting-dining-form" class="form-horizontal">
                    <input type="hidden" name="conferenceId" value="${ mmsConferenceMain.id }">

                    <div class="form-group">
                        <label for="diningTime" class="col-sm-1 control-label">就餐时间</label>
                        <div class="col-sm-3">
                            <input id="diningTime"  name="diningTime" class="form-control" placeholder="请选择就餐时间段" readonly>
                        </div>

                        <div class="col-sm-3">
                           <button type="button" class="btn btn-info" id="query-dining-time" data-toggle="modal" data-target="#time-modal">选择就餐时间段</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userName" class="col-sm-1 control-label">参会人员姓名</label>
                        <div class="col-sm-3">
                            <input id="userName"  name="userName" class="form-control" placeholder="请输入参会人员姓名" >
                        </div>
                        <label for="userPhone" class="col-sm-1 control-label">手机号码</label>
                        <div class="col-sm-3">
                            <input id="userPhone"  name="userPhone" class="form-control" placeholder="请输入手机号码">
                        </div>

                        <div class="bottom" style="margin-left: 0px;float: right;clear: both;margin-right: 10px">
                            <button type="button" class="btn btn-info" id="query-meeting-dining" onclick="queryMeetingDining()">
                                &nbsp;查&nbsp;&nbsp;询&nbsp;
                            </button>
                            <button type="button" class="btn btn-warning" id="clear-meeting-dining" data-placement="bottom" onclick="clearMeetingDining()">
                                &nbsp;清&nbsp;&nbsp;空&nbsp;
                            </button>
                            <button type="button" class="btn btn-info" id="export-meeting-dining" onclick="exportDiningManger()">
                                &nbsp;导&nbsp;&nbsp;出&nbsp;
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
            <div class="panel-heading"><b>会议就餐列表</b></div>
            <div class="panel-body">
                <table id="meeting-dining-table"></table>
                <div id="meeting-dining-pager"></div>
            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="time-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div style="margin-top: 10px">
                <button type="button" class="btn btn-info">&nbsp;确&nbsp;&nbsp;定&nbsp;</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">&nbsp;关&nbsp;&nbsp;闭&nbsp;</button>
            </div>
            <div class="modal-body">
                <table style="width: 100%;" border="1">
                    <tr><th><input type="checkbox"></th><th>序号</th><th>就餐名称</th><th>就餐时间段</th></tr>
                    <tr><td><input type="checkbox"></td><td colspan="3">2018-02-26</td></tr>
                    <tr><td><input type="checkbox"></td><td>1</td><td>早餐</td><td>07:00 ~09:00</td></tr>
                    <tr><td><input type="checkbox"></td><td>2</td><td>午餐</td><td>14:00 ~15:00</td></tr>
                </table>
            </div>

        </div>
    </div>
</div>
<iframe id="ExportLoginLogFrame" name="ExportLoginLogFrame" style="display: none;"></iframe>
<script type="text/javascript" src="${ctx }/admin/dining/meetingDining.js"></script>
</body>
</html>
