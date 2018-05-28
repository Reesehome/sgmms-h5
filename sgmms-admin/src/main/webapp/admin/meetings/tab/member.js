/**
 * Auther
 * Date 2018/5/16
 * Description
 */
class Member {

    constructor(parent, meetingsId) {
        this.parent = parent;
        this.meetingsId = meetingsId;
        this.$memberTable = $("#meetings-member-table");
        this.$memberForm = $("#meetings-member-form");
        this.$memberModifyRow = $("#member-modify-row");
        this.$settingMemberIndex = this.$memberModifyRow.find("span[name='setting-member-index']");
        this.$company = this.$memberModifyRow.find("select[name='setting-member-company']");
        this.$dinner = this.$memberModifyRow.find("select[name='setting-member-dinner']");
        this.$user = this.$memberModifyRow.find("select[name='setting-member-user']");
        this.$memberModifyId = this.$memberModifyRow.find("input[name='setting-member-id']");
        this.$showRowCache = null;
        this.companyMap = new Map();
        this.requestMemberCompany();
        this.bindEvent();
        this.requestMemberList();
    }

    addMember() {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        let $last = this.$memberTable.find("tbody > tr:last-child");
        if ($last.attr("id") !== this.$memberModifyRow.attr("id")) {
            $last.after(this.$memberModifyRow);
        }
        this.defaultMemberConfig();
        this.$settingMemberIndex.html(this.$memberTable.find("tbody > tr").length);
        this.$memberModifyRow.show();
    }

    cancelMember() {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        this.$memberModifyRow.hide();
        this.defaultMemberConfig();
    }

    defaultMemberConfig() {
        this.$company.find(`option:selected`).get(0).selected = false;
        this.$company.change();
        this.$user.find(`option:selected`).get(0).selected = false;
        this.$user.change();
        this.$dinner.find(`option:selected`).get(0).selected = false;
        this.$memberModifyId.val(null);
    }

    saveMember() {
        let form = this.$memberForm.serializeJson();
        let vo = {
            id: form["setting-member-id"] || null,
            userId: form["setting-member-user"] || null,
            conferenceId: this.meetingsId,
            reserveMeal: form["setting-member-dinner"] || null,
        };
        if (!vo.userId) {
            this.parent.showWarning("请选择参会人员手机号.");
            return
        }
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/member/save",
            cache: false,
            dataType: "json",
            data: vo,
            type: "POST",
            success: result => {
                if (result.result) {
                    /*重新请求参会人员列表*/
                    this.requestMemberList();
                } else {
                    this.parent.showWarning(result.msg);
                }
            }
        });
    }

    deleteMember(id) {
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/member/delete",
            cache: false,
            dataType: "json",
            data: {id},
            type: "get",
            success: result => {
                if (result.result) {
                    /*重新请求参会人员列表*/
                    this.requestMemberList();
                } else {
                    this.parent.showWarning(result.msg);
                }
            }
        });
    }

    bindEvent() {
        this.$company.on('change', event => {
            this.requestUserByCompany(this.$company.find(":selected").val());
        });
        this.$user.on('change', event => {
            let user = this.$user.find(":selected").get(0);
            let data = user.value ? JSON.parse(user.dataset.user) : {};
            let spanEls = this.$memberModifyRow.find("span");
            if (spanEls.length >= 3) {
                this.$memberModifyRow.find("span[name='setting-member-name']").get(0).innerHTML = data.userName || null;
                if (data.gender) {
                    this.$memberModifyRow.find("span[name='setting-member-gender']").get(0).innerHTML = data.gender === 'M' ? "男" : "女";
                } else {
                    this.$memberModifyRow.find("span[name='setting-member-gender']").get(0).innerHTML = null;
                }
            }
        })
    }

    memberModifyRow(event, index) {
        if (this.$showRowCache) {
            this.$showRowCache.show();
        }
        let _el = event.target, _trEl = _el.parentNode.parentNode.parentNode, $trEl = $(_trEl), $tds = $trEl.find("td"),
            member = JSON.parse(_el.dataset.member || "{}");
        this.$settingMemberIndex.html(index);
        this.$showRowCache = $tds;
        $tds.hide();
        $trEl.before(this.$memberModifyRow);
        /*填充数据*/
        this.$company.find(`option[value='${member.companyId}']`).get(0).selected = true;
        this.$company.change();
        this.$user.find(`option[value='${member.userId}']`).get(0).selected = true;
        this.$user.change();
        this.$dinner.find(`option[value='${member.reserveMeal}']`).get(0).selected = true;
        this.$memberModifyId.val(member.id);
        /*结束数据填充*/
        this.$memberModifyRow.show();
    }

    requestMemberList() {
        this.cancelMember();
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/member",
            cache: false,
            dataType: "json",
            data: {meetingsId: this.meetingsId},
            type: "get",
            success: result => {
                this.$memberTable.find("tr[name='static']").remove();
                let el = '';
                result.forEach((data, index) => {
                    el += `
                    <tr name='static'>
                        <td>${index + 1}</td>
                        <td>${data.mobile}</td>
                        <td>${data.userName}</td>
                        <td>${data.gender === 'M' ? '男' : '女'}</td>
                        <td>${this.companyMap.get(data.companyId)}</td>
                        <td>${data.reserveMeal === 'Y' ? '是' : '否'}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label>
                                <button type="button" data-member='${JSON.stringify(data)}' onclick="meetingsSetting.member.memberModifyRow(event,${index + 1})" class="btn btn-primary">编辑</button>
                                <button type="button" onclick="meetingsSetting.member.deleteMember('${data.id}')" class="btn btn-danger">删除</button>
                            </div>
                        </td>
                    </tr>
                    `;
                });
                this.$memberModifyRow.parent().prepend(el);
            }
        });
    }

    requestMemberCompany() {
        /*请求所有单位名称*/
        $.tdsAjax({
            url: ctx + "/customer/company/all",
            cache: false,
            dataType: "json",
            async: false,
            type: "POST",
            success: result => {
                let el = '<option value="">请选择单位名称</option>';
                result.forEach(data => {
                    el += `<option value="${data.id}">${data.name}</option>`;
                    this.companyMap.set(data.id, data.name);
                });
                this.$company.html(el);
            }
        });
    }

    requestUserByCompany(id) {
        if (!id) {
            return
        }
        /*请求所有单位名称*/
        $.tdsAjax({
            url: ctx + "/customer/user/company/" + id,
            cache: false,
            dataType: "json",
            async: false,
            type: "get",
            success: result => {
                let el = '<option value="">请选择手机号</option>';
                result.forEach(data => {
                    el += `<option value='${data.id}' data-user='${JSON.stringify(data)}'>${data.mobile} - ${data.userName}</option>`;
                });
                this.$user.html(el);
            }
        });
    }
}