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
        <span class="pull-left">就餐日期:</span>
        <div class="btn-group pull-left" role="group" aria-label>
            <ul>
                <li><input id="dinner-create-beginTime" class="form-control"
                           placeholder="请输入开始日期">
                </li>
                <li>至</li>
                <li><input id="dinner-create-endTime" class="form-control"
                           placeholder="请输入结束日期"></li>
            </ul>
        </div>
        <div class="btn-group pull-right" role="group" aria-label>
            <button type="button" class="btn btn-primary" id="dinner-create-add-row">添加行</button>
        </div>
    </div>
    <div class="panel-body">
        <div>
            <form action="" id="meetings-dinner-create-form">
                <table id="meetings-dinner-create-table"
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
                    <tr name="meetings-dinner-create-row">
                        <td><span name="meetings-dinner-create-index"></span></td>
                        <td><label>
                            <select class="form-control input-field" name="meetings-dinner-create-time-slot">
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
                                            name="meetings-dinner-create-slot-start">
                                        <option value="">时间段</option>
                                    </select>
                                </label>
                                </li>
                                <li>至</li>
                                <li><label>
                                    <select class="form-control input-field" name="meetings-dinner-create-slot-end">
                                        <option value="">时间段</option>
                                    </select>
                                </label></li>
                            </ul>
                        </td>
                        <td>
                            <label>
                                <input class="form-control input-field"
                                       name="meetings-dinner-create-address"/>
                            </label>
                        </td>
                        <td>
                            <div class="btn-group" role="group" aria-label>
                                <button type="button"
                                        class="btn btn-danger" name="dinner-create-del-row">删除
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

    class DinnerCreate {
        constructor() {
            this.$startTime = $("#dinner-create-beginTime");
            this.$endTime = $("#dinner-create-endTime");
            this.$modifyTable = $("#meetings-dinner-create-table");
            this.$modifyRow = this.$modifyTable.find("tr[name='meetings-dinner-create-row']").remove();
            this._TIME = Utils.getMinuteOfOneDay(0, 24, 15, "option");
            this.bindEvent();
            this.initDateWidget();
            this.initTimes();
        }

        initTimes() {
            this.$modifyRow.find("select[name='meetings-dinner-create-slot-start']").append(this._TIME);
            this.$modifyRow.find("select[name='meetings-dinner-create-slot-end']").append(this._TIME);
        }

        bindEvent() {
            this.$modifyRow.find("button[name='dinner-create-del-row']").on('click', event => {
                $(event.target.parentNode.parentNode.parentNode).remove();
            });

            $("#dinner-create-add-row").on('click', event => {
                let $clone = this.$modifyRow.clone(true);
                $clone.find("span[name='meetings-dinner-create-index']").html(this.$modifyTable.find("tbody > tr").length + 1);
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
            let vos = [], $row = null, startDate = this.$startTime.val(), endDate = this.$endTime.val(), dinners = [];
            if (!startDate || !endDate) {
                throw new TypeError("就餐日期不能为空");
            } else if (startDate > endDate) {
                throw new TypeError("就餐结束日期不能小于开始日期");
            }
            this.$modifyTable.find("tr[name='meetings-dinner-create-row']").each((i, row) => {
                let $row = $(row)
                    , slot = $row.find("select[name='meetings-dinner-create-time-slot']").val()
                    , start = $row.find("select[name='meetings-dinner-create-slot-start']").val()
                    , end = $row.find("select[name='meetings-dinner-create-slot-end']").val()
                    , location = $row.find("input[name='meetings-dinner-create-address']").val();
                if (!slot) {
                    throw new TypeError(`第${i + 1}行餐名不能为空`);
                } else if (!start || !end) {
                    throw new TypeError(`第${i + 1}行时间段不能为空`);
                } else if (start >= end) {
                    throw new TypeError(`第${i + 1}行结束时间不能小于或等于开始时间`);
                } else if (!location) {
                    throw new TypeError(`第${i + 1}行就餐地点不能为空`);
                }
                dinners.push({
                    start,
                    end,
                    slot,
                    location,
                });
            });

            let meetingsId = meetingsSetting.meetingsId;
            if (dinners.length > 0) {
                Utils.getDate2Date(startDate, endDate).forEach(date => {
                    dinners.forEach(dinner => {
                        vos.push({
                            conferenceId: meetingsId,
                            beginTime: date + ' ' + dinner.start + ':00',
                            name: dinner.slot,
                            endTime: date + ' ' + dinner.end + ':00',
                            location: dinner.location,
                        });
                    })
                });
                return vos;
            } else {
                throw new TypeError("请至少添加一条就餐设置");
            }
        }
    }

    meetingsSetting.dinner.dinnerCreate = new DinnerCreate();
</script>

