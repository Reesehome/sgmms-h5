/**
 * Auther
 * Date 2018/5/9
 * Description
 */
class Meetings {

    constructor() {
        this.$startTime = $("#beginTime");
        this.$endTime = $("#endTime");
        this.$meetingsTable = $("#meetings-table");
        this.$meetingsForm = $("#meetings-form");
        this.$modifyDateBlock = $('#modify-data-block');
        this._entry = window.parent.document.getElementById("mainContainer") ? window.parent.document.getElementById("mainContainer").src.replace(window.location.origin, "") : window.location.href;
    }

    render() {
        this.initDateWidget();
        this.initMeetingsTable();
        return this;
    }

    queryMeetings() {
        let params = this.$meetingsForm.serializeJson();
        this.$meetingsTable.setGridParam({postData: null});//清空之前的条件
        this.$meetingsTable.setGridParam({postData: params}).trigger("reloadGrid",[{ page: 1}]);
    }

    clearMeetings() {
        this.$meetingsForm.cleanForm();
    }

    initDateWidget() {
        let _this = this, option = {
            format: 'yyyy-mm-dd hh:ii:ss',
            autoclose: true,
            todayBtn: true,
            clearBtn: true,
            language: 'zh-CN',
            minView: 0,
            weekStart: 1
        };

        _this.$startTime.datetimepicker(option);
        _this.$endTime.datetimepicker(option);
    }

    static convertToDate(datetext) {
        if (datetext === null || datetext === '' || typeof datetext === 'undefined')
            return null;
        let seperatedArray = datetext.split(' ');
        let dateArray = seperatedArray[0].split('-');
        let year = Number(dateArray[0]);
        let month = Number(dateArray[1]) - 1;
        let day = Number(dateArray[2]);

        let timeArray = seperatedArray[1].split(':');
        let hour = Number(timeArray[0]);
        let minute = Number(timeArray[1]);
        let second = Number(timeArray[2]);

        return new Date(year, month, day, hour, minute, second);
    }

    initMeetingsTable() {
        let params = this.$meetingsForm.serializeJson();
        this.$meetingsTable.jqGrid({
            url: ctx + '/admin/meetings/queryMeetingsPage',//请求数据的url地址
            datatype: 'json',  //请求的数据类型
            mtype: 'post',
            postData: params,
            colNames: [
                'ID',
                '会议编号',
                '会议名称',
                '会议开始时间',
                '会议结束时间',
                '状态',
                '创建人',
                '创建时间'
            ], //数据列名称（数组）
            colModel: [//数据列各参数信息设置
                /*formatter: Meetings.indexNumFormatter*/
                {name: 'id', index: 'id', width: 180, align: 'center'},
                {
                    name: 'code', index: 'code', width: 80, formatter: (cellValue, cell) => {
                        return `<a style="cursor: pointer;color: #0d5aa7;text-decoration:underline;" href="${ctx}/admin/meetings/setting.do?meetingsId=${cell.rowId}&entry=${this._entry}">${cellValue}</a>`
                    }, align: 'center'
                },
                {name: 'title', index: 'title', width: 180, align: 'center'},
                {name: 'beginTime', index: 'beginTime', width: 120, align: 'center'},
                {name: 'endTime', index: 'endTime', width: 120, align: 'center'},
                {name: 'status', index: 'status', align: 'center'},
                {name: 'createBy', index: 'createBy', width: 80, align: 'center'},
                {name: 'createOn', index: 'createOn', width: 120, align: 'center'}
            ],
            rowNum: 10,//每页显示记录数
            rowList: [10, 20, 30], //分页选项，可以下拉选择每页显示记录数
            pager: '#meetings-pager',  //表格数据关联的分页条，html元素
            autowidth: true, //自动匹配宽度
            height: 300,   //设置高度
            gridview: true, //加速显示
            viewrecords: true,  //显示总记录数
            multiselect: true,  //可多选，出现多选框
            /*multiselectWidth: 25, //设置多选列宽度*/
            sortable: false,  //可以排序
            // sortname: 'loginTime',  //排序字段名
            sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
            loadComplete: data => { //完成服务器请求后，回调函数
                // let params = {
                //     widtharray: [10, 10, 20, 15, 15, 15, 20, 15],
                //     tableid: 'meetings-table',
                //     pager: 'meetings-pager'
                // };
                // resizeTable(params);

                /*this.resizeTable(params);*/
            }
        });
    }

    static indexNumFormatter(cellvalue, options) {
        return options.pos;
    }

    /*resizeTable(params) {
        let $gbox = $("#gbox_" + params.tableid), $gview = $("#gview_" + params.tableid),
            $gviewdiv = $gview.find(".ui-jqgrid-hdiv");
        $gbox.css("width", "100%");
        $gbox.css("margin-right", "0px");
        $gview.css("width", "100%");
        $gviewdiv.css("width", "100%");
        $gview.find(".ui-jqgrid-hdiv .ui-jqgrid-hbox").css("width", "100%");
        let hTable = $gview.find(".ui-jqgrid-hdiv .ui-jqgrid-hbox .ui-jqgrid-htable");
        hTable.css("width", "100%");
        let widthParams = params.widtharray;
        $.each(widthParams, function (idx, aParam) {
            hTable.children("thead").children("tr").children("th:eq(" + idx + ")").css("width", aParam + "%");
        });

        $gviewdiv.css("width", "100%");
        $gviewdiv.children(":first").width(hTable.width());
        let table = $("#" + params.tableid);
        table.css("width", "100%");

        $.each(widthParams, function (idx, aParam) {
            table.children("tbody").children("tr").children("td:eq(" + idx + ")").css("width", aParam + "%");
        });

        $("#" + params.pager).width($gviewdiv.width());
    }*/

    static showWarning(msg) {
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

    static showNormalDialog({option}) {
        BootstrapDialog.show({
            title: option.title,
            message: option.msg,
            size: BootstrapDialog.SIZE_SMALL,
            type: option.type || BootstrapDialog.TYPE_DANGER,
            buttons: [
                {
                    label: '确定',
                    cssClass: 'btn-primary',
                    action: option.fn,
                },
                {
                    label: '返回',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }
            ]
        });
    }

    static getSelectedId() {
        let ids = $("#meetings-table").jqGrid('getGridParam', 'selarrrow');
        if (ids && ids.length > 1) {
            this.showWarning('无法操作多条数据.');
            return -1;
        }
        return ids && ids.length > 0 ? ids[0] : null;
    }

    modifyMeetings() {
        let id = Meetings.getSelectedId();
        if (id === -1) {
            return;
        }
        BootstrapDialog.show({
            title: '<span>开设会议</span>',
            message: this.$modifyDateBlock.load(`${ctx}/admin/meetings/modify.do${id ? '?meetingsId=' + id : ''}`),
            buttons: [
                {
                    label: '保存',
                    cssClass: 'btn-primary',
                    action: this.submitMeetings,
                },
                {
                    label: '返回',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                }
            ]
        });
    }

    submitMeetings(dialogItself) {
        //验证结果正确再提交
        let $form = $("#modify-meetings-form"), validResult = $form.valid();
        if (validResult) {
            let params = $form.serializeJson(), data = {};
            Object.keys(params).forEach(key => {
                data[key.substring(7, key.length)] = params[key];
            });
            $.tdsAjax({
                url: ctx + "/admin/meetings/detail/save",
                cache: false,
                dataType: "json",
                data: data,
                type: "POST",
                success: function (result) {
                    if (result.id) {
                        dialogItself.close();
                        //重新加载列表数据
                        $("#meetings-table").trigger("reloadGrid");
                    } else {
                        BootstrapDialog.show({
                            title: '错误提示',
                            size: BootstrapDialog.SIZE_SMALL,
                            type: BootstrapDialog.TYPE_WARNING,
                            message: "保存数据失败,请稍后重试.",
                            buttons: [{
                                label: '关闭',
                                action: function (dialogItself) {
                                    dialogItself.close();
                                }
                            }]
                        });
                    }
                }
            });
        }
    }

    delMeetings() {

        let id = Meetings.getSelectedId();

        if (!id) {
            Meetings.showWarning('请选择需要一条删除的会议记录数据.');
            id = -1;
        }

        if (id === -1) {
            return;
        }

        Meetings.showNormalDialog({
            option: {
                title: "删除确认",
                msg: `确认删除ID[${id}]的会议记录吗?`,
                fn(dialogItself) {
                    $.tdsAjax({
                        url: ctx + "/admin/meetings/delete/" + id,
                        cache: false,
                        dataType: "json",
                        type: "get",
                        success: function (result) {
                            if (result.result) {
                                dialogItself.close();
                                //重新加载列表数据
                                $("#meetings-table").trigger("reloadGrid");
                            } else {
                                Meetings.showWarning(`会议ID[${id}]记录删除失败,原因${result.msg}.`)
                            }
                        }
                    });
                }
            }
        });
    }

    startMeetings() {

        let id = Meetings.getSelectedId();

        if (!id) {
            Meetings.showWarning('请选择需要一条启动的会议记录数据.');
            id = -1;
        }

        if (id === -1) {
            return;
        }

        Meetings.showNormalDialog({
            option: {
                title: "启动确认",
                msg: `确认启动ID[${id}]的会议记录吗?`,
                type: BootstrapDialog.TYPE_PRIMARY,
                fn(dialogItself) {
                    $.tdsAjax({
                        url: ctx + "/admin/meetings/start/" + id,
                        cache: false,
                        dataType: "json",
                        type: "get",
                        success: function (result) {
                            if (result.result) {
                                dialogItself.close();
                                //重新加载列表数据
                                $("#meetings-table").trigger("reloadGrid");
                            } else {
                                Meetings.showWarning(`会议ID[${id}]启动失败,原因[${result.msg}].`)
                            }
                        }
                    });
                }
            }
        });
    }

    endMeetings() {

        let id = Meetings.getSelectedId();

        if (!id) {
            Meetings.showWarning('请选择需要一条结束的会议记录数据.');
            id = -1;
        }

        if (id === -1) {
            return;
        }

        Meetings.showNormalDialog({
            option: {
                title: "结束确认",
                msg: `确认结束ID[${id}]的会议记录吗?`,
                type: BootstrapDialog.TYPE_PRIMARY,
                fn(dialogItself) {
                    $.tdsAjax({
                        url: ctx + "/admin/meetings/finish/" + id,
                        cache: false,
                        dataType: "json",
                        type: "get",
                        success: function (result) {
                            if (result.result) {
                                dialogItself.close();
                                //重新加载列表数据
                                $("#meetings-table").trigger("reloadGrid");
                            } else {
                                Meetings.showWarning(`会议ID[${id}]结束失败,原因[${result.msg}].`)
                            }
                        },
                        error: function (error) {
                            console.error(error);
                        }
                    });
                }
            }
        });
    }

    meetingsNotify() {

        let id = Meetings.getSelectedId();

        if (!id) {
            Meetings.showWarning('请选择需要一条删除的会议记录数据.');
            id = -1;
        }

        if (id === -1) {
            return;
        }

        /* Meetings.showNormalDialog({
             option: {
                 title: "删除确认",
                 msg: `确认删除ID[${id}]的会议记录吗?`,
                 fn(dialogItself) {
                     $.tdsAjax({
                         url: ctx + "/admin/meetings/delete/" + id,
                         cache: false,
                         dataType: "json",
                         type: "get",
                         success: function (result) {
                             if (result) {
                                 dialogItself.close();
                                 //重新加载列表数据
                                 $("#meetings-table").trigger("reloadGrid");
                             } else {
                                 Meetings.showWarning(`会议ID[${id}]记录删除失败.`)
                             }
                         }
                     });
                 }
             }
         });*/
    }
}

let meetings = new Meetings().render();