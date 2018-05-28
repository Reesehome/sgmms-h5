/**
 * Auther
 * Date 2018/5/16
 * Description
 */
class Arrange {
    constructor(parent, meetingsId) {
        this.parent = parent;
        this.meetingsId = meetingsId;
        this.$arrangeBlock = $('#arrange');
        this.$arrangeAgenda = this.$arrangeBlock.find("div[name='arrange-agenda']");
        this.$arrangeAttention = this.$arrangeBlock.find("div[name='arrange-attention']");
        this.renderEditor();
        this.requestArrange();
    }

    requestArrange() {
        let _this = this;
        /*请求所有单位名称*/
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/arrange",
            cache: false,
            dataType: "json",
            async: false,
            data: {meetingsId: this.meetingsId},
            type: "get",
            success: result => {
                this.$arrangeAgenda.summernote("code", result.agendum);
                this.$arrangeAttention.summernote("code", result.attention);
            }
        });
    }

    saveAgendaContent() {
        this.saveArrange({
            conferenceId: this.meetingsId,
            agendum: this.$arrangeAgenda.summernote("code")
        })
    }

    saveAttentionContent() {
        this.saveArrange({
            conferenceId: this.meetingsId,
            attention: this.$arrangeAttention.summernote("code")
        })
    }

    saveArrange(data) {
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/arrange/save",
            cache: false,
            dataType: "json",
            data: data,
            type: "post",
            success: result => {
                this.parent.showWarning(result.msg);
            }
        });
    }

    renderEditor() {
        this.$arrangeAgenda.summernote({
            placeholder: '输入会议议程安排',
            tabsize: 2,
            height: 300
        });
        this.$arrangeAttention.summernote({
            placeholder: '输入会议注意事项',
            tabsize: 2,
            height: 300
        });
    }
}