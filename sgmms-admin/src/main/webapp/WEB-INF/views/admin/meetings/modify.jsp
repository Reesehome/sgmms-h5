<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/5/10
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/tds/common/tag-lib.jsp" %>
<form id="modify-meetings-form" class="form-horizontal" novalidate="novalidate">
    <input id="modify-id" name="modify-id" value="${meetingsVo.id}" type="hidden">
    <div class="form-group">
        <label for="modify-code" class="col-sm-3 control-label">会议编号</label>
        <div class="col-sm-7">
            <input id="modify-code" name="modify-code" value="${meetingsVo.code}" class="form-control"
                   placeholder="请输入会议编号">
        </div>
    </div>

    <div class="form-group">
        <label for="modify-title" class="col-sm-3 control-label">会议名称</label>
        <div class="col-sm-7">
            <input id="modify-title" name="modify-title" value="${meetingsVo.title}" class="form-control"
                   placeholder="请输入会议名称">
        </div>
    </div>

    <div class="form-group">
        <label for="modify-venue" class="col-sm-3 control-label">会议地址</label>
        <div class="col-sm-7">
            <input id="modify-venue" name="modify-venue" class="form-control" placeholder="请输入会议地址"
                   value="${meetingsVo.venue}">
        </div>
    </div>

    <div class="form-group">
        <label for="modify-beginTime" class="col-sm-3 control-label">开始时间</label>
        <div class="col-sm-7">
            <input id="modify-beginTime" name="modify-beginTime"
                   value="<fmt:formatDate value="${meetingsVo.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   class="form-control"
                   placeholder="请输入会议开始时间">
        </div>
    </div>

    <div class="form-group">
        <label for="modify-endTime" class="col-sm-3 control-label">结束时间</label>
        <div class="col-sm-7">
            <input id="modify-endTime" name="modify-endTime" class="form-control" placeholder="请输入会议结束时间"
                   value="<fmt:formatDate value="${meetingsVo.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
        </div>
    </div>


    <div class="form-group">
        <label for="modify-status" class="col-sm-3 control-label">会议状态</label>
        <div class="col-sm-7">
            <%--<label class="radio-inline">
                <input type="radio" name="deletable_type" onclick="radioClick('yes')" checked="checked"> 是
            </label>
            <label class="radio-inline">
                <input type="radio" name="deletable_type" onclick="radioClick('no')">否
            </label>
            <input id="deletable" name="deletable" type="hidden" value="Y">--%>
            <select class="form-control input-field" id="modify-status" name="modify-status">
                <option value="UNSTART" <c:if test='${meetingsVo.status=="UNSTART" }'> selected="selected"</c:if> >未启动
                </option>
                <option value="STARTED" <c:if test='${meetingsVo.status=="STARTED" }'> selected="selected"</c:if> >启动
                </option>
                <option value="ENDED" <c:if test='${meetingsVo.status=="ENDED" }'> selected="selected"</c:if> >结束
                </option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="modify-comment" class="col-sm-3 control-label">会议备注</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="modify-comment" name="modify-comment"
                      placeholder="请输入会议备注">${meetingsVo.comment}</textarea>
        </div>
    </div>
</form>

<script type="text/javascript">

    class ModifyMeetings {
        constructor() {
            this.$startTime = $("#modify-beginTime");
            this.$endTime = $("#modify-endTime");
            this.initDateWidget();
            this.initValidate();
        }

        initDateWidget() {
            let option = {
                format: 'yyyy-mm-dd hh:ii:ss',
                autoclose: true,
                todayBtn: true,
                clearBtn: true,
                language: 'zh-CN',
                minView: 0,
                weekStart: 1
            };

            this.$startTime.datetimepicker(option).on('changeDate', ev => {
                let beginTimeText = this.$startTime.val();
                let beginTimeDate = meetings.convertToDate(beginTimeText);
                let beginTime = beginTimeDate.getTime();

                let endTimeText = this.$startTime.val();
                let endTimeDate = meetings.convertToDate(endTimeText);
                if (endTimeDate && beginTime > endTimeDate.getTime()) {
                    this.$startTime.val('');
                } else {
                    this.$endTime.datetimepicker('setStartDate', ev.date);
                }
            });


            this.$endTime.datetimepicker(option).on('changeDate', ev => {
                let endTimeText = this.$endTime.val();
                let endTimeDate = meetings.convertToDate(endTimeText);
                let endTime = endTimeDate.getTime();

                let beginTimeText = this.$startTime.val();
                let beginTimeDate = meetings.convertToDate(beginTimeText);
                if (beginTimeDate && beginTimeDate.getTime() > endTime) {
                    this.$endTime.val('');
                } else {
                    this.$startTime.datetimepicker('setEndDate', ev.date);
                }
            });
        }

        initValidate() {
            $('#modify-meetings-form').validate({
                errorClass: 'help-block',
                focusInvalid: false,
                rules: {
                    "modify-code": {
                        required: true,
                        maxlength: 45,
                        remote: {
                            type: "get",
                            url: ctx + "/admin/meetings/detail/validate",
                            data: {
                                id: function () {
                                    return $("#modify-id").val();
                                },
                                code: function () {
                                    return $("#modify-code").val();
                                }
                            },
                            dataFilter: function (data, type) {
                                return data;
                            }
                        }
                    },
                    "modify-title": {
                        required: true,
                        maxlength: 45
                    },
                    "modify-venue": {
                        required: true,
                        maxlength: 200
                    },
                    "modify-beginTime": {
                        required: true,
                    },
                    "modify-endTime": {
                        required: true,
                    }
                },
                messages: {
                    "modify-code": {
                        required: '变量值不能为空！',
                        maxlength: '变量值不能大于45个文字！',
                        remote: '会议编号已存在!',
                    },
                    "modify-title": {
                        required: '变量值不能为空！',
                        maxlength: '变量值不能大于45个文字！'
                    },
                    "modify-venue": {
                        required: '变量值不能为空',
                        maxlength: '变量值不能大于200个文字'
                    },
                    "modify-beginTime": {
                        required: '变量值不能为空',
                    },
                    "modify-endTime": {
                        required: '变量值不能为空',
                    }
                },

                highlight: function (element) {
                    $(element).closest('.form-group').addClass('has-error');
                },

                success: function (label) {
                    label.closest('.form-group').removeClass('has-error');
                    label.remove();
                },

                errorPlacement: function (error, element) {
                    element.parent('div').append(error);
                }
            });
        }
    }

    let modifyMeetings = new ModifyMeetings();
</script>

