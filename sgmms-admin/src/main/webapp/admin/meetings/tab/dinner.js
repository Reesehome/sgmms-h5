/**
 * Auther
 * Date 2018/5/17
 * Description
 */
class Dinner {

    constructor(parent, meetingsId) {
        this.parent = parent;
        this.meetingsId = meetingsId;
        this.sortingMap = null;
        this.dinnerCreate = null;
        this.$dinnerTable = $("#meetings-dinner-table");
        this.$dinnerForm = $("#meetings-dinner-form");
        this.$dinnerModifyRow = $("#setting-dinner-row");
        this.$settingDinnerIndex = this.$dinnerModifyRow.find("span[name='setting-dinner-index']");
        this.$dinnerModifyId = this.$dinnerModifyRow.find("input[name='setting-dinner-id']");
        this.$dinnerModifySolt = this.$dinnerModifyRow.find("select[name='setting-dinner-time-slot']");
        this.$dinnerModifyBegin = this.$dinnerModifyRow.find("select[name='setting-dinner-slot-start']");
        this.$dinnerModifyEnd = this.$dinnerModifyRow.find("select[name='setting-dinner-slot-end']");
        this.$dinnerModifyAddress = this.$dinnerModifyRow.find("input[name='setting-dinner-address']");
        this._TIME = Utils.getMinuteOfOneDay(0, 24, 15, "option");
        this.$showRowCache = null;
        this._modifyDate = null;
        this.requestDinner();
        this.initTimes();
    }

    getQrCodeUrl(conference_no, dinner_id) {
        return `${this.parent.h5domain}#/meal?cf=${conference_no}&ml=${dinner_id}`;
    }

    initTimes() {
        this.$dinnerModifyBegin.append(this._TIME);
        this.$dinnerModifyEnd.append(this._TIME);
    }

    createDinner(id) {
        this.parent.showNormalDialog({
            option: {
                title: "添加就餐设置",
                type: BootstrapDialog.TYPE_PRIMARY,
                size: BootstrapDialog.SIZE_WIDE,
                msg: this.parent.$modifyDateBlock.load(`${ctx}/admin/meetings/setting/dialog/dinner.do${id ? '?meetingsId=' + id : ''}`),
                fn: dialogItself => {
                    try {
                        let vos = this.dinnerCreate.validate();
                        $.tdsAjax({
                            url: ctx + "/admin/meetings/setting/dinner/save",
                            cache: false,
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(vos),
                            type: "POST",
                            success: result => {
                                if (result.result) {
                                    dialogItself.close();
                                    //重新加载列表数据
                                    this.requestDinner();
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

    dinnerModifyRow(event, index) {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        let _el = event.target, _trEl = _el.parentNode.parentNode.parentNode, $trEl = $(_trEl), $tds = $trEl.find("td"),
            dinner = JSON.parse(_el.dataset.dinner || "{}");
        this.$settingDinnerIndex.html(index);
        this.$showRowCache = $tds;
        $tds.hide();
        $trEl.before(this.$dinnerModifyRow);
        /*填充数据*/
        this.$dinnerModifySolt.find(`option[value='${dinner.name}']`).get(0).selected = true;
        this.$dinnerModifyBegin.find(`option[value='${dinner.begin}']`).get(0).selected = true;
        this.$dinnerModifyEnd.find(`option[value='${dinner.end}']`).get(0).selected = true;
        this.$dinnerModifyId.val(dinner.id);
        this.$dinnerModifyAddress.val(dinner.location);
        this._modifyDate = dinner.date;
        /*结束数据填充*/
        this.$dinnerModifyRow.show();
    }

    cancelDinner() {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        this.$dinnerModifyRow.hide();
        this.defaultDinnerConfig();
    }

    defaultDinnerConfig() {
        this.$dinnerModifySolt.find(`option:selected`).get(0).selected = false;
        this.$dinnerModifyBegin.find(`option:selected`).get(0).selected = false;
        this.$dinnerModifyEnd.find(`option:selected`).get(0).selected = false;
        this.$dinnerModifyAddress.val(null);
        this.$dinnerModifyId.val(null);
        this._modifyDate = null;
    }

    saveDinner() {

        try {
            let vo = this.validate();

            $.tdsAjax({
                url: ctx + "/admin/meetings/setting/dinner/modify",
                cache: false,
                dataType: "json",
                data: vo,
                type: "POST",
                success: result => {
                    if (result.result) {
                        /*重新请求参会人员列表*/
                        this.requestDinner();
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
        let dinner = this.$dinnerForm.serializeJson(), date = this._modifyDate,
            meetingsId = meetingsSetting.meetingsId, result = {
                id: dinner["setting-dinner-id"],
                conferenceId: meetingsId,
                beginTime: date + ' ' + dinner["setting-dinner-slot-start"] + ':00',
                name: dinner["setting-dinner-time-slot"],
                endTime: date + ' ' + dinner["setting-dinner-slot-end"] + ':00',
                location: dinner["setting-dinner-address"],
            };

        if (!result.name) {
            throw new TypeError(`餐名不能为空`);
        } else if (!result.beginTime || !result.endTime) {
            throw new TypeError(`时间段数据不能为空`);
        } else if (result.beginTime >= result.endTime) {
            throw new TypeError(`结束时间不能小于或等于开始时间`);
        } else if (!result.location) {
            throw new TypeError(`就餐地点不能为空`);
        }
        return result;
    }

    deleteDinner(id) {
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/dinner/delete",
            cache: false,
            dataType: "json",
            data: {id},
            type: "get",
            success: result => {
                if (result.result) {
                    /*重新请求参会人员列表*/
                    this.requestDinner();
                } else {
                    this.parent.showWarning(result.msg);
                }
            }
        });
    }

    requestDinner() {
        let _this = this;
        /*请求所有就餐设置*/
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/dinner",
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
                let keys = this.sortingMap.keys(), key = null, dinners = null, format = null;
                while ((key = keys.next().value)) {
                    dinners = this.sortingMap.get(key);
                    el += `<tr>
                               <td colspan="5" class="td-label" style="text-align: left">
                                   ${key} - 就餐: ${dinners.length}条
                               </td>
                           </tr>`;
                    dinners.forEach((dinner, index) => {
                        format = {
                            id: dinner.id,
                            date: key,
                            name: dinner.name,
                            begin: dinner.beginTime.substring(11, 16),
                            end: dinner.endTime.substring(11, 16),
                            location: dinner.location,
                        };
                        el += `<tr>
                                   <td>${index + 1}</td>
                                   <td>${format.name}</td>
                                   <td>${format.begin} 至 ${format.end}</td>
                                   <td>${format.location}</td>
                                   <td>
                                       <div class="btn-group" role="group" aria-label="">
                                           <button type="button" data-dinner='${JSON.stringify(format)}' onclick="meetingsSetting.dinner.dinnerModifyRow(event,${index + 1})" class="btn btn-primary">编辑</button>
                                           <button type="button" onclick="meetingsSetting.dinner.deleteDinner('${dinner.id}')" class="btn btn-danger">删除</button>
                                           <button type="button" onclick="meetingsSetting.showQrCode(meetingsSetting.dinner.getQrCodeUrl('${dinner.conferenceCode}', '${dinner.id}'))" class="btn btn-success">生成二维码</button>
                                       </div>
                                   </td>
                               </tr>`;
                    })
                }
                this.$dinnerTable.find("tbody").html(el);
            }
        });
    }
}