<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/tds/common/tag-lib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>会议设置</title>
    <jsp:include page="/tds/common/ui-lib.jsp"/>
    <style type="text/css">
        .vertical-space {
            margin-bottom: 10px;
        }

        .module-header {
            height: 40px;
            vertical-align: middle;
            display: table-cell;
            margin-left: -15px;
        }

        .ui-widget-content .link {
            color: #337ab7;
            text-decoration: underline;
            background-color: transparent;
            cursor: pointer;
        }

        .ui-widget-content .link:hover {
            color: #23527c;
        }

        .form-group .input-field {
            width: 180px;
        }
    </style>
    <link rel="stylesheet" href="${ctx}/admin/common/css/el/el-global.css">
    <link rel="stylesheet" href="${ctx}/admin/meetings/setting.css">

    <%--SummerNote Libs Start--%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"
            type="text/javascript"></script>
    <%--SummerNote Libs End--%>
</head>
<body>
<div class="container-fluid" id="meetings-setting">
    <label for="setting-meetings-id"></label><input id="setting-meetings-id" style="display: none"
                                                    value="${meetingsId}"/>
    <div class="module-header">
        <strong><a style="cursor: pointer" href="${entry}"><i
                class="glyphicon glyphicon-chevron-left"></i>返回会议列表</a></strong>
    </div><!-- module-header -->
    <div>
        <div class="panel panel-info">
            <div class="panel-heading">
                <span class="pull-left">会议基本信息</span>
            </div>
            <div class="panel-body">
                <div>
                    <table class="form-table pull-left form-table-x">
                        <tr>
                            <td class="td-label">会议编号</td>
                            <td>${meetingsVo.code}</td>
                            <td class="td-label">会议名称</td>
                            <td>${meetingsVo.title}</td>
                            <td class="td-label">会议时间</td>
                            <td><fmt:formatDate value="${meetingsVo.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/> - <fmt:formatDate
                                    value="${meetingsVo.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr>
                            <td class="td-label">会议地址</td>
                            <td>${meetingsVo.venue}</td>
                            <td class="td-label">会议人数</td>
                            <td>${meetingsVo.totalUsers}</td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="vertical-space"></div>
    <div>
        <div class="panel panel-info">
            <div class="panel-heading">
                <span class="pull-left">会议详细设置</span>
            </div>
            <div class="panel-body">
                <div class="pull-left" style="width: 100%">
                    <nav>
                        <ul class="nav nav-pills" id="setting-tabs" role="tablist">
                            <li role="presentation" class="active"><a
                                    href="#member" toggle="tab" role="tab">参会人员管理</a>
                            </li>
                            <li role="presentation"><a href="#arrange" toggle="tab"
                                                       role="tab">会议安排</a></li>
                            <li role="presentation"><a href="#attendance" toggle="tab"
                                                       role="tab">考勤设置</a></li>
                            <li role="presentation"><a href="#dinner" toggle="tab"
                                                       role="tab">就餐设置</a></li>
                            <li role="presentation"><a href="#files" toggle="tab"
                                                       role="tab">会议附件</a></li>
                        </ul>
                    </nav>
                </div>
                <!-- Tab panes -->
                <div class="tab-content pull-left" style="margin-top: .5rem;">
                    <div role="tabpanel" class="tab-pane active" id="member">
                        <div class="panel panel-info pull-left">
                            <div class="panel-heading">
                                <span class="pull-left">添加参会人员</span>
                                <div class="btn-group pull-right" role="group" aria-label>
                                    <button type="button" class="btn btn-info"
                                            onclick="meetingsSetting.member.addMember();">
                                        添加
                                    </button>
                                    <button type="button" class="btn btn-primary">导入Excel</button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <form action="" id="meetings-member-form">
                                        <table id="meetings-member-table"
                                               class="form-table hover pull-left form-table-s"
                                               style="text-align: center">
                                            <thead>
                                            <tr>
                                                <th style="width: 5rem;">序号</th>
                                                <th>手机号</th>
                                                <th>姓名</th>
                                                <th>性别</th>
                                                <th>单位名称</th>
                                                <%--<th>部门</th>--%>
                                                <th>是否就餐</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr id="member-modify-row" style="display: none">
                                                <td><span name="setting-member-index"></span></td>
                                                <td><label>
                                                    <select class="form-control input-field" name="setting-member-user">
                                                        <option value="">请选择手机号</option>
                                                    </select>
                                                </label></td>
                                                <td><span name="setting-member-name"></span></td>
                                                <td><span name="setting-member-gender"></span></td>
                                                <td><label>
                                                    <select class="form-control input-field"
                                                            name="setting-member-company">
                                                        <option value="">请选择单位名称</option>
                                                    </select>
                                                </label></td>
                                                <%--<td><label>
                                                    <input class="form-control"/>
                                                </label></td>--%>
                                                <td><label>
                                                    <select class="form-control input-field"
                                                            name="setting-member-dinner">
                                                        <option value="Y">是</option>
                                                        <option value="N">否</option>
                                                    </select>
                                                </label></td>
                                                <td>
                                                    <div class="btn-group" role="group" aria-label>
                                                        <button type="button" class="btn btn-success"
                                                                onclick="meetingsSetting.member.saveMember();">保存
                                                        </button>
                                                        <button type="button"
                                                                onclick="meetingsSetting.member.cancelMember();"
                                                                class="btn btn-danger">取消
                                                        </button>
                                                    </div>
                                                </td>
                                                <td style="display: none"><label>
                                                    <input name="setting-member-id" readonly/>
                                                </label></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="arrange">
                        <div class="panel panel-info pull-left">
                            <div class="panel-heading">
                                <span class="pull-left">议程安排</span>
                                <div class="btn-group pull-right" role="group" aria-label>
                                    <button type="button" onclick="meetingsSetting.arrange.saveAgendaContent()"
                                            class="btn btn-success">保存
                                    </button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <div name="arrange-agenda"></div>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-info pull-left" style="margin-top: 10px">
                            <div class="panel-heading">
                                <span class="pull-left">注意事项</span>
                                <div class="btn-group pull-right" role="group" aria-label>
                                    <button type="button" onclick="meetingsSetting.arrange.saveAttentionContent()"
                                            class="btn btn-success">保存
                                    </button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <div name="arrange-attention"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="attendance">
                        <div class="panel panel-info pull-left">
                            <div class="panel-heading">
                                <span class="pull-left">考勤设置</span>
                                <div class="btn-group pull-right" role="group" aria-label>
                                    <button type="button" class="btn btn-info"
                                            onclick="meetingsSetting.attendance.createAttendance()">
                                        添加
                                    </button>
                                    <button type="button" class="btn btn-primary">导入Excel</button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <form action="" id="meetings-attendance-form">
                                        <table id="meetings-attendance-table"
                                               class="form-table hover pull-left form-table-s"
                                               style="text-align: center">
                                            <thead>
                                            <tr>
                                                <th style="width: 5rem;">序号</th>
                                                <th>考勤</th>
                                                <th>考勤时间段</th>
                                                <th>迟到时间段</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr id="setting-attendance-row" style="display: none">
                                                <td><span name="setting-attendance-index"></span></td>
                                                <td><label>
                                                    <select class="form-control input-field"
                                                            name="setting-attendance-time-slot">
                                                        <option value="">请选择时间段</option>
                                                        <option value="AM">上午</option>
                                                        <option value="PM">下午</option>
                                                    </select>
                                                </label></td>
                                                <td>
                                                    <ul class="ul-float-center">
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-attendance-slot-start">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label>
                                                        </li>
                                                        <li>至</li>
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-attendance-slot-end">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label></li>
                                                    </ul>
                                                </td>
                                                <td>
                                                    <ul class="ul-float-center">
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-attendance-slot-late-start">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label>
                                                        </li>
                                                        <li>至</li>
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-attendance-slot-late-end">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label></li>
                                                    </ul>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group" aria-label>
                                                        <button type="button" class="btn btn-success"
                                                                onclick="meetingsSetting.attendance.saveAttendance();">
                                                            保存
                                                        </button>
                                                        <button type="button"
                                                                onclick="meetingsSetting.attendance.cancelAttendance();"
                                                                class="btn btn-danger">取消
                                                        </button>
                                                    </div>
                                                </td>
                                                <td style="display: none"><label>
                                                    <input name="setting-attendance-id" readonly/>
                                                </label></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="dinner">
                        <div class="panel panel-info pull-left">
                            <div class="panel-heading">
                                <span class="pull-left">就餐设置</span>
                                <div class="btn-group pull-right" role="group" aria-label>
                                    <button type="button" class="btn btn-info"
                                            onclick="meetingsSetting.dinner.createDinner()">
                                        添加
                                    </button>
                                    <button type="button" class="btn btn-primary">导入Excel</button>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <form action="" id="meetings-dinner-form">
                                        <table id="meetings-dinner-table"
                                               class="form-table hover pull-left form-table-s"
                                               style="text-align: center">
                                            <thead>
                                            <tr>
                                                <th style="width: 5rem;">序号</th>
                                                <th>餐名</th>
                                                <th>就餐时间段</th>
                                                <th>就餐地点</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr id="setting-dinner-row" style="display: none">
                                                <td><span name="setting-dinner-index"></span></td>
                                                <td><label>
                                                    <select class="form-control input-field"
                                                            name="setting-dinner-time-slot">
                                                        <option value="">请选择时间段</option>
                                                        <option value="早餐">早餐</option>
                                                        <option value="午餐">午餐</option>
                                                        <option value="晚餐">晚餐</option>
                                                    </select>
                                                </label></td>
                                                <td>
                                                    <ul class="ul-float-center">
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-dinner-slot-start">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label>
                                                        </li>
                                                        <li>至</li>
                                                        <li><label>
                                                            <select class="form-control input-field"
                                                                    name="setting-dinner-slot-end">
                                                                <option value="">时间段</option>
                                                            </select>
                                                        </label></li>
                                                    </ul>
                                                </td>
                                                <td>
                                                    <label>
                                                        <input class="form-control input-field"
                                                               name="setting-dinner-address"/>
                                                    </label>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group" aria-label>
                                                        <button type="button" class="btn btn-success"
                                                                onclick="meetingsSetting.dinner.saveDinner();">
                                                            保存
                                                        </button>
                                                        <button type="button"
                                                                onclick="meetingsSetting.dinner.cancelDinner();"
                                                                class="btn btn-danger">取消
                                                        </button>
                                                    </div>
                                                </td>
                                                <td style="display: none"><label>
                                                    <input name="setting-dinner-id" readonly/>
                                                </label></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="files">
                        <div class="panel panel-info pull-left">
                            <div class="panel-heading">
                                <span class="pull-left">添加会议附件</span>
                                <div class="pull-right" aria-label>
                                    <form action="" style="line-height: normal" id="meetings-attachment-form"
                                          enctype="multipart/form-data">
                                        <span style="vertical-align: middle;color: red">选择上传附件(不大于30M) : <input
                                                type="file" name="file"
                                                style="display: unset;"/></span>
                                        <button type="button" class="btn btn-info"
                                                onclick="meetingsSetting.attachment.uploadAttachment()">上传
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <table id="meetings-attachment-table"
                                           class="form-table pull-left hover form-table-s" style="text-align: center">
                                        <thead>
                                        <tr>
                                            <th style="width: 5rem;">序号</th>
                                            <th>文件名称</th>
                                            <th>上传人</th>
                                            <th>上传时间</th>
                                            <th>附件地址</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="modify-data-block">
    <%--数据操作区域--%>
</div>

<%--显示二维码区域--%>
<div id="qrcode-block">

</div>

<form action="" id="file-upload-form" enctype="multipart/form-data" style="display: none;">
    <input type="file" name="file"/>
</form>
<script type="text/javascript">
    let h5Domain = '${h5Domain}';
</script>

<script src="${ctx}/admin/common/libs/jquery.qrcode.min.js" type="text/javascript"></script>
<script src="${ctx}/admin/common/js/prototype.js" type="text/javascript"></script>
<script src="${ctx}/admin/common/js/utils.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/tab/member.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/tab/arrange.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/tab/attendance.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/tab/dinner.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/tab/attachment.js" type="text/javascript"></script>
<script src="${ctx}/admin/meetings/setting.js" type="text/javascript"></script>
</body>
</html>