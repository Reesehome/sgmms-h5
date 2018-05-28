/**
 * Auther
 * Date 2018/5/14
 * Description
 */
class MeetingsSetting {

    constructor() {
        this.meetingsId = $("#setting-meetings-id").val();
        this.tabInit();
        this.$modifyDateBlock = $('#modify-data-block');
        this.$qrCodeBlock = $('#qrcode-block').remove();
        this.$file = $("#file-upload-form");
        this.member = new Member(this, this.meetingsId);
        this.arrange = new Arrange(this, this.meetingsId);
        this.attendance = new Attendance(this, this.meetingsId);
        this.dinner = new Dinner(this, this.meetingsId);
        this.attachment = new Attachment(this, this.meetingsId);
        this.h5domain = h5Domain;
    }

    saveQrCode() {
        Utils.downloadFile("qr_code.png", this.$qrCodeBlock.find("canvas").get(0).toDataURL("image/png"))
    }

    tabInit() {
        let _this = this;
        $('#setting-tabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
            _this.member.cancelMember();
            _this.attendance.cancelAttendance();
        });
    }

    showWarning(msg) {
        let _this = this;
        BootstrapDialog.show({
            title: '错误提示',
            size: BootstrapDialog.SIZE_SMALL,
            type: BootstrapDialog.TYPE_WARNING,
            message: msg,
            buttons: [{
                label: '关闭',
                action: function (dialogItself) {
                    dialogItself.close();
                }
            }]
        });
    }

    showQrCode(text) {
        this.renderQrCode(text);
        this.showNormalDialog({
            option: {
                title: "生成二维码",
                type: BootstrapDialog.TYPE_PRIMARY,
                size: BootstrapDialog.SIZE_SMALL,
                msg: this.$qrCodeBlock.load(),
                fn: dialogItself => {
                    this.saveQrCode();
                    dialogItself.close();
                }
            }, btn: ["保存", "取消"]
        });
    }

    renderQrCode(text) {
        this.$qrCodeBlock.html("").qrcode({
            render: "canvas",
            text: text
        });
    }

    showAlert(title, msg) {
        BootstrapDialog.show({
            title: title,
            message: msg,
            size: BootstrapDialog.SIZE_SMALL,
            type: BootstrapDialog.TYPE_DANGER,
            buttons: [
                {
                    label: '确定',
                    cssClass: 'btn-primary',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }
            ]
        });
    }

    showNormalDialog({option, btn}) {
        BootstrapDialog.show({
            title: option.title,
            message: option.msg,
            size: option.size || BootstrapDialog.SIZE_SMALL,
            type: option.type || BootstrapDialog.TYPE_DANGER,
            buttons: [
                {
                    label: btn[0] || '确定',
                    cssClass: 'btn-primary',
                    action: option.fn,
                },
                {
                    label: btn[1] || '返回',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }
            ]
        });
    }
}

let meetingsSetting = new MeetingsSetting();