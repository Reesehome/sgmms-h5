/**
 * 页面id
 * @type {{meetingDiningTable: *|jQuery|HTMLElement, meetingDiningForm: *|jQuery|HTMLElement, meetingDiningPager: string}}
 */
var idParams = {
    meetingDiningTable: $("#meeting-dining-table"),
    meetingDiningForm: $("#meeting-dining-form"),
    meetingDiningPager: '#meeting-dining-pager',
    queryDiningTime: $("#query-dining-time"),
}

/**
 * 查询
 */
function queryMeetingDining() {
    var params = idParams.meetingDiningForm.serializeJson();
    idParams.meetingDiningTable.setGridParam({postData: null});//清空之前的条件
    idParams.meetingDiningTable.setGridParam({postData: params}).trigger("reloadGrid",[{ page: 1}]);
}

/**
 * 清空
 */
function clearMeetingDining () {
    idParams.meetingDiningForm.cleanForm();
}

/**
 * 导出
 */
function exportDiningManger () {
    var params = idParams.meetingDiningForm.serializeJson();
    var url = ctx + "/admin/dining/exportMeal.do?conferenceId=" + params.conferenceId;
    if (params.userName) {
        url += "&userName=" + params.userName;
    }
    if (params.userPhone) {
        url += "&userPhone=" + params.userPhone;
    }
    window.location.href = url;
}


/**
 * 就餐管理列表
 */
function initMeetingDiningable() {
    var params = idParams.meetingDiningForm.serializeJson();
    idParams.meetingDiningTable.jqGrid({
        url: ctx + '/admin/dining/queryMealPage',//请求数据的url地址
        datatype: 'json',  //请求的数据类型
        mtype: 'post',
        postData: params,
        colNames: [
            '序号',
            '姓名',
            '手机号',
            '就餐日期',
            '就餐名称',
           /* '就餐标准',*/
            '就餐时间段',
            '就餐时间',
            '就餐地点'
        ], //数据列名称（数组）
        colModel: [//数据列各参数信息设置
            {name: 'userName', index: 'userName', width: 80, formatter: indexNumFormatter, align: 'center'},
            {name: 'userName', index: 'userName', width: 80, align: 'center'},
            {name: 'userPhone', index: 'userPhone', width: 80, align: 'center'},
            {name: 'date', index: 'date', width: 80, align: 'center'},
            {name: 'name', index: 'name', width: 80, align: 'center'},
           /* {name: 'standard',index: 'standard',width: 80,align: 'center'},*/
            {name: 'timeSlot',index: 'timeSlot',width: 80,align: 'center'},
            {name: 'time',index: 'time',width: 180,align: 'center'},
            { name: 'location',index: 'location',width: 180,align: 'center'}
        ],
        rowNum: 10,//每页显示记录数
        rowList: [10, 20, 30], //分页选项，可以下拉选择每页显示记录数
        pager: idParams.meetingDiningPager,  //表格数据关联的分页条，html元素
        autowidth: true, //自动匹配宽度
        height: 325,   //设置高度
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

$(function () {
    initMeetingDiningable();
});