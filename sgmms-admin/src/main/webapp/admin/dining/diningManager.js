/**
 * 页面id
 * @type {{diningMamagerTable: *|jQuery|HTMLElement, diningManagerForm: *|jQuery|HTMLElement, beginTime: *|jQuery|HTMLElement, emdTime: *|jQuery|HTMLElement, diningManagerPager: string}}
 */
var idParams = {
    diningMamagerTable: $("#dining-manager-table"),     // 列表id
    diningManagerForm: $("#dining-manager-form"),       // form id
    beginTime: $("#beginTime"),                         // 开始时间id
    endTime: $("#endTime"),                             // 结束时间id
    diningManagerPager: '#dining-manager-pager'
}


/**
 * 查询
 */
function queryDiningManger() {
    var params = idParams.diningManagerForm.serializeJson();
    idParams.diningMamagerTable.setGridParam({postData: null});//清空之前的条件
    idParams.diningMamagerTable.setGridParam({postData: params}).trigger("reloadGrid",[{ page: 1}]);
}

/**
 * 清空
 */
function clearDiningManger () {
    idParams.diningManagerForm.cleanForm();
}

/**
 * 初始化时间组件
 */
function initDateWidget() {
//初始化时间控件
    idParams.beginTime.datetimepicker({
        format: 'yyyy-mm-dd hh:ii:ss',
        autoclose: true,
        todayBtn: true,
        clearBtn: true,
        language: 'zh-CN',
        minView: 0,
        weekStart: 1
    }).on('changeDate', function (ev) {
        var beginTimeText = idParams.beginTime.val();
        var beginTimeDate = convertToDate(beginTimeText);
        var beginTime = beginTimeDate.getTime();

        var endTimeText = $('#endTime').val();
        var endTimeDate = convertToDate(endTimeText);
        if (endTimeDate && beginTime > endTimeDate.getTime()) {
            idParams.beginTime.val('');
        } else {
            idParams.endTime.datetimepicker('setStartDate', ev.date);
        }
    });


    idParams.endTime.datetimepicker({
        format: 'yyyy-mm-dd hh:ii:ss',
        autoclose: true,
        todayBtn: true,
        clearBtn: true,
        language: 'zh-CN',
        minView: 0,
        weekStart: 1
    }).on('changeDate', function (ev) {
        var endTimeText = idParams.endTime.val();
        var endTimeDate = convertToDate(endTimeText);
        var endTime = endTimeDate.getTime();

        var beginTimeText = idParams.beginTime.val();
        var beginTimeDate = convertToDate(beginTimeText);
        if (beginTimeDate && beginTimeDate.getTime() > endTime) {
            idParams.endTime.val('');
        } else {
            idParams.beginTime.datetimepicker('setEndDate', ev.date);
        }
    });
}

function convertToDate(datetext) {
    if (datetext == null || datetext == '' || typeof datetext == 'undefined')
        return null;
    var seperatedArray = datetext.split(' ');
    var dateArray = seperatedArray[0].split('-');
    var year = Number(dateArray[0]);
    var month = Number(dateArray[1]) - 1;
    var day = Number(dateArray[2]);

    var timeArray = seperatedArray[1].split(':');
    ;
    var hour = Number(timeArray[0]);
    var minute = Number(timeArray[1]);
    var second = Number(timeArray[2]);

    return new Date(year, month, day, hour, minute, second);
}

/**
 * 就餐管理列表
 */
function initDiningManagerTable() {
    var params = idParams.diningManagerForm.serializeJson();
    idParams.diningMamagerTable.jqGrid({
        url: ctx + '/admin/meetings/queryMeetingsPage',//请求数据的url地址
        datatype: 'json',  //请求的数据类型
        mtype: 'post',
        postData: params,
        colNames: [
            '序号',
            '会议编号',
            '会议名称',
            '会议开始时间',
            '会议结束时间',
            '状态',
            '创建人',
            '创建时间'
        ], //数据列名称（数组）
        colModel: [//数据列各参数信息设置
            {name: 'index', index: 'index', width: 80, formatter: this.indexNumFormatter, align: 'center'},
            {name: 'code', index: 'code', width: 80, align: 'center', formatter: meetingCodeFormatter},
            {name: 'title', index: 'title', width: 80, align: 'center'},
            {name: 'beginTime', index: 'beginTime', width: 80, align: 'center'},
            {name: 'endTime', index: 'endTime', width: 80, align: 'center'},
            {name: 'status', index: 'status', width: 80, align: 'center'},
            {name: 'createBy', index: 'createBy', width: 80, align: 'center'},
            {name: 'createOn', index: 'createOn', width: 180, align: 'center'}
        ],
        rowNum: 10,//每页显示记录数
        rowList: [10, 20, 30], //分页选项，可以下拉选择每页显示记录数
        pager: idParams.diningManagerPager,  //表格数据关联的分页条，html元素
        autowidth: true, //自动匹配宽度
        height: 300,   //设置高度
        gridview: true, //加速显示
        viewrecords: true,  //显示总记录数
        multiselect: true,  //可多选，出现多选框
        multiselectWidth: 25, //设置多选列宽度
        sortable: false,  //可以排序
        sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
        loadComplete: function (data) { //完成服务器请求后，回调函数

        }
    });
}

/**
 * 序列
 * @param cellvalue
 * @param options
 * @param rowObject
 * @returns {*}
 */
function indexNumFormatter(cellvalue, options, rowObject) {
    return options.rowId;
}

/**
 * 会议编号
 * @param cellvalue
 * @param options
 * @param rowObject
 * @returns {*}
 */
function meetingCodeFormatter(cellvalue, options, rowObject) {
    var url = ctx + '/admin/dining/meeting.do?meetingCode=' + cellvalue;
    return '<a href = ' + url + ' style="text-decoration:underline;">' + cellvalue + '</a>';
}


$(function () {
    initDateWidget();
    initDiningManagerTable();
});