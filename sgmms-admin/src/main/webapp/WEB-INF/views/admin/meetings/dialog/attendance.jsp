<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2018/5/10
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/tds/common/tag-lib.jsp" %>
<style>
    .ul-float-center {
        position: relative;
        left: 7.5%;
    }
</style>
<div class="panel panel-info">
    <div class="panel-heading">
        <span class="pull-left">考勤日期:</span>
        <div class="btn-group pull-left" role="group" aria-label>
            <ul>
                <li><input id="attendance-create-beginTime" class="form-control"
                           placeholder="请输入开始日期">
                </li>
                <li>至</li>
                <li><input id="attendance-create-endTime" class="form-control"
                           placeholder="请输入结束日期"></li>
            </ul>
        </div>
        <div class="btn-group pull-right" role="group" aria-label>
            <button type="button" class="btn btn-primary" id="attendance-create-add-row">添加行</button>
        </div>
    </div>
    <div class="panel-body">
        <div>
            <form action="" id="meetings-attendance-create-form">
                <table id="meetings-attendance-create-table"
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
                    <tr name="meetings-attendance-create-row">
                        <td><span name="meetings-attendance-create-index"></span></td>
                        <td><label>
                            <select class="form-control input-field" name="meetings-attendance-create-time-slot">
                                <option value="">请选择时间段</option>
                                <option value="AM">上午</option>
                                <option value="PM">下午</option>
                            </select>
                        </label></td>
                        <td>
                            <ul class="ul-float-center">
                                <li><label>
                                    <select class="form-control input-field"
                                            name="meetings-attendance-create-slot-start">
                                        <option value="">时间段</option>
                                    </select>
                                </label>
                                </li>
                                <li>至</li>
                                <li><label>
                                    <select class="form-control input-field" name="meetings-attendance-create-slot-end">
                                        <option value="">时间段</option>
                                    </select>
                                </label></li>
                            </ul>
                        </td>
                        <td>
                            <ul class="ul-float-center">
                                <li><label>
                                    <select class="form-control input-field"
                                            name="meetings-attendance-create-slot-late-start">
                                        <option value="">时间段</option>
                                    </select>
                                </label>
                                </li>
                                <li>至</li>
                                <li><label>
                                    <select class="form-control input-field"
                                            name="meetings-attendance-create-slot-late-end">
                                        <option value="">时间段</option>
                                    </select>
                                </label></li>
                            </ul>
                        </td>
                        <td>
                            <div class="btn-group" role="group" aria-label>
                                <button type="button"
                                        class="btn btn-danger" name="attendance-create-del-row">删除
                                </button>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    class AttendanceCreate {
        constructor() {
            this.$startTime = $("#attendance-create-beginTime");
            this.$endTime = $("#attendance-create-endTime");
            this.$modifyTable = $("#meetings-attendance-create-table");
            this.$modifyRow = this.$modifyTable.find("tr[name='meetings-attendance-create-row']").remove();
            this._AM = Utils.getMinuteOfOneDay(0, 12, 15, "option");
            this._PM = Utils.getMinuteOfOneDay(12, 24, 15, "option");
            this.bindEvent();
            this.initDateWidget();
        }

        bindEvent() {
            this.$modifyRow.find("select[name='meetings-attendance-create-time-slot']").on('change', event => {
                let $tr = $(event.target.parentNode.parentNode.parentNode)
                    , $start = $tr.find("select[name='meetings-attendance-create-slot-start']")
                    , $end = $tr.find("select[name='meetings-attendance-create-slot-end']")
                    , $lateStart = $tr.find("select[name='meetings-attendance-create-slot-late-start']")
                    , $lateEnd = $tr.find("select[name='meetings-attendance-create-slot-late-end']"), ops = null;
                if ($(event.target).find("option:selected").val() === "AM") {
                    ops = this._AM;
                } else {
                    ops = this._PM;
                }
                $start.html(ops);
                $end.html(ops);
                $lateStart.html(ops);
                $lateEnd.html(ops);
            });

            this.$modifyRow.find("button[name='attendance-create-del-row']").on('click', event => {
                $(event.target.parentNode.parentNode.parentNode).remove();
            });

            $("#attendance-create-add-row").on('click', event => {
                let $clone = this.$modifyRow.clone(true);
                $clone.find("span[name='meetings-attendance-create-index']").html(this.$modifyTable.find("tbody > tr").length + 1);
                this.$modifyTable.find("tbody").append($clone);
            });
        }

        initDateWidget() {
            let option = {
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                clearBtn: true,
                language: 'zh-CN',
                minView: 0,
                weekStart: 1
            };

            this.$startTime.datetimepicker(option);
            this.$endTime.datetimepicker(option);
        }

        validate() {
            let vos = [], $row = null, startDate = this.$startTime.val(), endDate = this.$endTime.val(), times = [];
            if (!startDate || !endDate) {
                throw new TypeError("考勤日期不能为空");
            } else if (startDate > endDate) {
                throw new TypeError("考勤结束日期不能小于开始日期");
            }
            this.$modifyTable.find("tr[name='meetings-attendance-create-row']").each((i, row) => {
                let $row = $(row), start = $row.find("select[name='meetings-attendance-create-slot-start']").val()
                    , end = $row.find("select[name='meetings-attendance-create-slot-end']").val()
                    , lateStart = $row.find("select[name='meetings-attendance-create-slot-late-start']").val()
                    , lateEnd = $row.find("select[name='meetings-attendance-create-slot-late-end']").val();
                if (!start || !end || !lateStart || !lateEnd) {
                    throw new TypeError(`第${i + 1}行时间段不能为空`);
                } else if ((start >= end) || (lateStart >= lateEnd)) {
                    throw new TypeError(`第${i + 1}行结束时间不能小于或等于开始时间`);
                } else if (((lateStart > end) || (lateStart < start)) || ((lateEnd > end) || (lateEnd < start))) {
                    throw new TypeError(`第${i + 1}行迟到时间段必须在考勤时间段范围内`);
                }
                times.push({
                    start,
                    end,
                    lateStart,
                    lateEnd,
                });
            });
            let meetingsId = meetingsSetting.meetingsId;
            if (times.length > 0) {
                Utils.getDate2Date(startDate, endDate).forEach(date => {
                    times.forEach(time => {
                        vos.push({
                            conferenceId: meetingsId,
                            beginTime: date + ' ' + time.start + ':00',
                            latenessBeginTime: date + ' ' + time.lateStart + ':00',
                            endTime: date + ' ' + time.end + ':00',
                            latenessEndTime: date + ' ' + time.lateEnd + ':00',
                        });
                    })
                });
                return vos;
            } else {
                throw new TypeError("请至少添加一条考勤设置");
            }
        }
    }

    meetingsSetting.attendance.attendanceCreate = new AttendanceCreate();
</script>

