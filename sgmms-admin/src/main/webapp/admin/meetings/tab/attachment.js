/**
 * Auther
 * Date 2018/5/22
 * Description
 */

class Attachment {

    constructor(parent, meetingsId) {
        this.parent = parent;
        this.meetingsId = meetingsId;
        this.$fileForm = $("#meetings-attachment-form");
        this.$file = this.$fileForm.find("input[name='file']");
        this.$attachmentTable = $("#meetings-attachment-table");
        this.requestAttachment();
    }

    deleteAttachment(id) {
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/attachment/delete",
            cache: false,
            dataType: "json",
            data: {id},
            type: "get",
            success: result => {
                if (result.result) {
                    /*重新请求参会人员列表*/
                    this.requestAttachment();
                } else {
                    this.parent.showWarning(result.msg);
                }
            }
        });
    }

    requestAttachment() {
        let _this = this;
        /*请求所有就餐设置*/
        $.tdsAjax({
            url: ctx + "/admin/meetings/setting/attachment",
            cache: false,
            dataType: "json",
            async: false,
            data: {meetingsId: this.meetingsId},
            type: "get",
            success: result => {
                let el = '';
                result.forEach((data, index) => {
                    el += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${data.name}</td>
                        <td>${data.createBy}</td>
                        <td>${data.createOn}</td>
                        <td><a class="btn btn-primary" href="${data.uri}">附件链接</a></td>
                        <td>
                            <div class="btn-group">
                                <button type="button" onclick="meetingsSetting.attachment.deleteAttachment('${data.id}')" class="btn btn-danger">删除</button>
                            </div>
                        </td>
                    </tr>
                    `;
                });
                this.$attachmentTable.find("tbody").html(el);
            }
        });
    }

    uploadAttachment() {
        if (this.$file.val()) {
            let formData = new FormData(this.$fileForm.get(0));
            formData.append("meetingsId", this.meetingsId);
            $.tdsAjax({
                url: ctx + "/admin/meetings/setting/attachment/upload",
                cache: false,
                dataType: "json",
                data: formData,
                type: "post",
                processData: false,
                contentType: false,
                success: result => {
                    if (result.result) {
                        /*重新请求参会人员列表*/
                        this.requestAttachment();
                        this.$file.val(null);
                        this.parent.showAlert("成功", "附件上传成功")
                    } else {
                        this.parent.showWarning(result.msg);
                    }
                }
            });
        } else {
            this.parent.showWarning("请选择需要上传的会议附件");
        }
    }
}
