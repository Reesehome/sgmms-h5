/**
 * Auther
 * Date 2018/5/17
 * Description
 */
class Attendance {

    constructor(parent, meetingsId) {
        this.parent = parent;
        this.meetingsId = meetingsId;
        this.sortingMap = null;
        this.attendanceCreate = null;
        this.$attendanceTable = $("#meetings-attendance-table");
        this.$attendanceForm = $("#meetings-attendance-form");
        this.$attendanceModifyRow = $("#setting-attendance-row");
        this.$settingAttendanceIndex = this.$attendanceModifyRow.find("span[name='setting-attendance-index']");
        this.$attendanceModifyId = this.$attendanceModifyRow.find("input[name='setting-attendance-id']");
        this.$attendanceModifySolt = this.$attendanceModifyRow.find("select[name='setting-attendance-time-slot']");
        this.$attendanceModifyBegin = this.$attendanceModifyRow.find("select[name='setting-attendance-slot-start']");
        this.$attendanceModifyEnd = this.$attendanceModifyRow.find("select[name='setting-attendance-slot-end']");
        this.$attendanceModifyLateBegin = this.$attendanceModifyRow.find("select[name='setting-attendance-slot-late-start']");
        this.$attendanceModifyLateEnd = this.$attendanceModifyRow.find("select[name='setting-attendance-slot-late-end']");
        this._AM = Utils.getMinuteOfOneDay(0, 12, 15, "option");
        this._PM = Utils.getMinuteOfOneDay(12, 24, 15, "option");
        this.$showRowCache = null;
        this._modifyDate = null;
        this.requestAttendance();
        this.bindEvent();
    }

    getQrCodeUrl(conference_no, attendance_id) {
        return `${this.parent.h5domain}#/sign?cf=${conference_no}&at=${attendance_id}`;
    }

    bindEvent() {
        this.$attendanceModifySolt.on("change", event => {
            let ops = null;
            if ($(event.target).find("option:selected").val() === "AM") {
                ops = this._AM;
            } else {
                ops = this._PM;
            }
            this.$attendanceModifyBegin.html(ops);
            this.$attendanceModifyEnd.html(ops);
            this.$attendanceModifyLateBegin.html(ops);
            this.$attendanceModifyLateEnd.html(ops);
        });
    }

    createAttendance(id) {
        this.parent.showNormalDialog({
            option: {
                title: "添加考勤设置",
                type: BootstrapDialog.TYPE_PRIMARY,
                size: BootstrapDialog.SIZE_WIDE,
                msg: this.parent.$modifyDateBlock.load(`${ctx}/admin/meetings/setting/dialog/attendance.do${id ? '?meetingsId=' + id : ''}`),
                fn: dialogItself => {
                    try {
                        let vos = this.attendanceCreate.validate();
                        $.tdsAjax({
                            url: ctx + "/admin/meetings/setting/attendance/save",
                            cache: false,
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(vos),
                            type: "POST",
                            success: result => {
                                if (result.result) {
                                    dialogItself.close();
                                    //重新加载列表数据
                                    this.requestAttendance();
                                } else {
                                    throw new Error(result.msg);
                                }
                            }
                        });
                    } catch (e) {
                        BootstrapDialog.show({
                            title: '错误提示',
                            size: BootstrapDialog.SIZE_SMALL,
                            type: BootstrapDialog.TYPE_WARNING,
                            message: e.message,
                            buttons: [{
                                label: '关闭',
                                action: function (dialogItself) {
                                    dialogItself.close();
                                }
                            }]
                        });
                    }
                }
            }, btn: ["保存", "取消"]
        });
    }

    attendanceModifyRow(event, index) {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        let _el = event.target, _trEl = _el.parentNode.parentNode.parentNode, $trEl = $(_trEl), $tds = $trEl.find("td"),
            attendance = JSON.parse(_el.dataset.attendance || "{}");
        this.$settingAttendanceIndex.html(index);
        this.$showRowCache = $tds;
        $tds.hide();
        $trEl.before(this.$attendanceModifyRow);
        /*填充数据*/
        this.$attendanceModifySolt.find(`option[value='${attendance.slot}']`).get(0).selected = true;
        this.$attendanceModifySolt.change();
        this.$attendanceModifyBegin.find(`option[value='${attendance.begin}']`).get(0).selected = true;
        this.$attendanceModifyEnd.find(`option[value='${attendance.end}']`).get(0).selected = true;
        this.$attendanceModifyLateBegin.find(`option[value='${attendance.lateBegin}']`).get(0).selected = true;
        this.$attendanceModifyLateEnd.find(`option[value='${attendance.latenessEnd}']`).get(0).selected = true;
        this.$attendanceModifyId.val(attendance.id);
        this._modifyDate = attendance.date;
        /*结束数据填充*/
        this.$attendanceModifyRow.show();
    }

    cancelAttendance() {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        this.$attendanceModifyRow.hide();
        this.defaultAttendanceConfig();
    }

    defaultAttendanceConfig() {
        this.$attendanceModifySolt.find(`option:selected`).get(0).selected = false;
        this.$attendanceModifySolt.change();
        this.$attendanceModifyBegin.find(`option:selected`).get(0).selected = false;
        this.$attendanceModifyEnd.find(`option:selected`).get(0).selected = false;
        this.$attendanceModifyLateBegin.find(`option:selected`).get(0).selected = false;
        this.$attendanceModifyLateEnd.find(`option:selected`).get(0).selected = false;
        this.$attendanceModifyId.val(null);
        this._modifyDate = null;
    }

    saveAttendance() {

        try {
            let vo = this.validate();

            $.tdsAjax({
                url: ctx + "/admin/meetings/setting/attendance/modify",
                cache: false,
                dataType: "json",
                data: vo,
                type: "POST",
                success: result => {
                    if (result.result) {
                        /*重新请求参会人员列表*/
                        this.requestAttendance();
                    } else {
                        this.parent.showWarning(result.msg);
                    }
                }
            });
        } catch (e) {
            BootstrapDialog.show({
                title: '错误提示',
                size: BootstrapDialog.SIZE_SMALL,
                type: BootstrapDialog.TYPE_WARNING,
                message: e.message,
                buttons: [{
                    label: '关闭',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }]
            });
        }
    }

    validate() {
        let time = this.$attendanceForm.serializeJson(), date = this._modifyDate,
            meetingsId = meetingsSetting.meetingsId, result = {
                id: time["setting-attendance-id"],
                conferenceId: meetingsId,
                beginTime: date + ' ' + time["setting-attendance-slot-start"] + ':00',
                latenessBeginTime: date + ' ' + time["setting-attendance-slot-late-start"] + ':00',
                endTime: date + ' ' + time["setting-attendance-slot-end"] + ':00',
                latenessEndTime: date + ' ' + time["setting-attendance-slot-late-end"] + ':00',
            };
        if (!result.beginTime || !result.endTime || !result.latenessBeginTime || !result.latenessEndTime) {
            throw new TypeError(`时间段数据不能为空`);
        } else if ((result.beginTime >= result.endTime) || (result.latenessBeginTime >= result.latenessEndTime)) {
            throw new TypeError(`结束时间不能小于或等于开始时间`);
        } else if (((result.latenessBeginTime > result.endTime) || (result.latenessBeginTime < result.beginTime)) || ((result.latenessEndTime > result.endTime) || (result.latenessEndTime < result.beginTime))) {
            throw new TypeError(`迟到时间段必须在考勤时间段范围内`);
        }
        return result;
    }

    deleteAttendance(id) {
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/attendance/delete",
            cache: false,
            dataType: "json",
            data: {id},
            type: "get",
            success: result => {
                if (result.result) {
                    /*重新请求参会人员列表*/
                    this.requestAttendance();
                } else {
                    this.parent.showWarning(result.msg);
                }
            }
        });
    }

    requestAttendance() {
        let _this = this;
        /*请求所有考勤设置*/
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/attendance",
            cache: false,
            dataType: "json",
            async: false,
            data: {meetingsId: this.meetingsId},
            type: "get",
            success: result => {
                this.sortingMap = new Map();
                let el = "", dateOfDay = null;
                result.forEach((item, i) => {
                    dateOfDay = item.beginTime.split(" ")[0];
                    if (!this.sortingMap.get(dateOfDay)) {
                        this.sortingMap.set(dateOfDay, []);
                    }
                    this.sortingMap.get(dateOfDay).push(item);
                    /*let times = this.sortingMap.get(dateOfDay) || [];
                    times.push(item);
                    this.sortingMap.set(dateOfDay, times);*/
                });
                let keys = this.sortingMap.keys(), key = null, times = null, format = null;
                while ((key = keys.next().value)) {
                    times = this.sortingMap.get(key);
                    el += `<tr>
                               <td colspan="5" class="td-label" style="text-align: left">
                                   ${key} - 考勤: ${times.length}条
                               </td>
                           </tr>`;
                    times.forEach((time, index) => {
                        format = {
                            id: time.id,
                            date: key,
                            slot: new Date(time.beginTime).getHours() < 12 ? "AM" : "PM",
                            begin: time.beginTime.substring(11, 16),
                            end: time.endTime.substring(11, 16),
                            lateBegin: time.latenessBeginTime.substring(11, 16),
                            latenessEnd: time.latenessEndTime.substring(11, 16),
                        }
                        ;
                        el += `<tr>
                                   <td>${index + 1}</td>
                                   <td>${format.slot === "AM" ? "上午" : "下午"}</td>
                                   <td>${format.begin} 至 ${format.end}</td>
                                   <td>${format.lateBegin} 至 ${format.latenessEnd}</td>
                                   <td>
                                       <div class="btn-group" role="group" aria-label="">
                                           <button type="button" data-attendance='${JSON.stringify(format)}' onclick="meetingsSetting.attendance.attendanceModifyRow(event,${index + 1})" class="btn btn-primary">编辑</button>
                                           <button type="button" onclick="meetingsSetting.attendance.deleteAttendance('${time.id}')" class="btn btn-danger">删除</button>
                                           <button type="button" onclick="meetingsSetting.showQrCode(meetingsSetting.attendance.getQrCodeUrl('${time.conferenceCode}', '${time.id}'))" class="btn btn-success">生成二维码</button>
                                       </div>
                                   </td>
                               </tr>`;
                    })
                }
                this.$attendanceTable.find("tbody").html(el);
            }
        });
    }
}