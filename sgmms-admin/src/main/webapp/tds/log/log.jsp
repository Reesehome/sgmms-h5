<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/**
 * 表格示例JS
 */
$(function () {
	initTable();
	//初始化时间组件
	initDateWidget();
});

function initTable(){
	var params = $("#searchForm").serializeJson();
	$("#list").jqGrid({
		url:ctx + '/admin/log/querySysLog.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
		mtype: 'post',
		postData: params,
		colNames:[
		          '<spring:message code="baf.syslog.label.operateUser"/>',
		          '<spring:message code="baf.syslog.label.logTime"/>',
		          '<spring:message code="baf.syslog.label.logSource"/>',
		          '<spring:message code="baf.syslog.label.logLevel"/>',
		          '<spring:message code="baf.syslog.label.logDesc"/>',
		          '<spring:message code="baf.syslog.label.logData"/>',
		          '<spring:message code="baf.syslog.label.exception"/>',
		          '<spring:message code="baf.syslog.label.loginStatus"/>'
	   	          ], //数据列名称（数组）
	   	colModel:[//数据列各参数信息设置
	   	          {name:'userName',index:'userName', width:80},
	   	       	  {name:'logTime',index:'logTime', width:80, align:'center'},
	   	      	  {name:'logSourceDisplay',index:'logSource', width:80, align:'center'},
	   	      	  {name:'logLevelDisplay',index:'logLevel', width:80, align:'center'},
	   	          {name:'logDesc',index:'logDesc', width:80,align:'center'},
	   	       	  {name:'logData',index:'logData', width:80,align:'center'},
	   	          {name:'exception',index:'exception', width:80,align:'center'},
	   	          {name:'loginId',index:'loginId', width:180,align:'center', formatter : showLoginLink,sortable:false}
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#gridpager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:275,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		multiselect: false,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'logTime',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
			var params = {widtharray:[5,15,15,10,15,15,15,10],tableid:'list',pager:'gridpager'};
			resizeTable(params);
		}
	});
}

/**
* 搜索示例数据
*/
function searchLog(){
	var params = $("#searchForm").serializeJson();
	$("#list").setGridParam({postData: null});//清空之前的条件
	$("#list").setGridParam({postData:params}).trigger("reloadGrid");
}

/**
* 初始化时间组件
*/
function initDateWidget(){
	//初始化时间控件
	$("#startTime").datetimepicker({
		format:'yyyy-mm-dd hh:ii:ss',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 0,
		weekStart: 1}).on('changeDate',function(ev){
			//var startTime = ev.timeStamp;//date.valueOf();
			var startTimeText = $("#startTime").val();
			var startTimeDate = convertToDate(startTimeText);
			var startTime = startTimeDate.getTime();
			
			var endTimeText = $('#endTime').val();
			var endTimeDate = convertToDate(endTimeText);
			if(endTimeDate && startTime > endTimeDate.getTime()){
				$("#startTime").val('');
			}else{
				$("#endTime").datetimepicker('setStartDate',ev.date);
			}
	});
		
	$("#endTime").datetimepicker({
		format:'yyyy-mm-dd hh:ii:ss',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 0,
		weekStart: 1}).on('changeDate',function(ev){
			//var endTime = ev.timeStamp;//date.valueOf();
			var endTimeText = $("#endTime").val();
			var endTimeDate = convertToDate(endTimeText);
			var endTime = endTimeDate.getTime();
			
			var startTimeText = $('#startTime').val();
			var startTimeDate = convertToDate(startTimeText);
			if(startTimeDate && startTimeDate.getTime() > endTime){
				$("#endTime").val('');
			}else{
				$("#startTime").datetimepicker('setEndDate', ev.date);
			}
	});
}

function convertToDate(datetext){
	if(datetext == null || datetext == '' || typeof datetext == 'undefined')
		return null;
	var seperatedArray = datetext.split(' ');
	var dateArray = seperatedArray[0].split('-');
	var year = Number(dateArray[0]);
	var month = Number(dateArray[1])-1;
	var day = Number(dateArray[2]);
	
	var timeArray = seperatedArray[1].split(':');;
	var hour = Number(timeArray[0]);
	var minute = Number(timeArray[1]);
	var second = Number(timeArray[2]);
	
	return new Date(year,month,day,hour,minute,second);
}

/**
* 清空表单
*/
function cleanForm(){
	$("#searchForm").cleanForm();
}

function resizeTable(params){
	$("#gbox_"+params.tableid).css("width","100%");
	$("#gbox_"+params.tableid).css("margin-right","0px");
	$("#gview_"+params.tableid).css("width","100%");
	$("#gview_"+params.tableid+ " .ui-jqgrid-hdiv").css("width","100%");
	$("#gview_"+params.tableid + " .ui-jqgrid-hdiv .ui-jqgrid-hbox").css("width","100%");
	var htable = $("#gview_"+params.tableid + " .ui-jqgrid-hdiv .ui-jqgrid-hbox .ui-jqgrid-htable");
	htable.css("width","100%");
	var widthparams = params.widtharray;
	$.each(widthparams , function(idx,aParam){
		htable.children("thead").children("tr").children("th:eq("+idx+")").css("width",aParam+"%");
	});
	
	$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").css("width","100%");
	$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").children(":first").width(htable.width());
	var table = $("#"+params.tableid);
	table.css("width","100%");
	
	$.each(widthparams , function(idx,aParam){
		table.children("tbody").children("tr").children("td:eq("+idx+")").css("width",aParam+"%");
	});
	
	$("#"+params.pager).width($("#gview_"+params.tableid).width());
}

function showLoginLink(cellvalue, options, rowObject){
	//return "<a href='javascript:findLoginInfo(\"" + cellvalue + "\");void(0);'>查看</a>";
	return "<span class='link' onclick='findLoginInfo(\"" + cellvalue + "\");'><spring:message code='tds.common.label.view'/></span>";
}

function findLoginInfo(loginId){
	var showloginDialog = BootstrapDialog.show({
		title: '<spring:message code="baf.syslog.label.loginInfo"/>',
		buttons: [{
            label: '<spring:message code="tds.common.label.close"/>',
            cssClass: 'btn-primary',
            action: function(dialogRef){
                dialogRef.close();
            }
        }],
        message: function(dialog) {
            var $message = $('<div></div>');
            $message.load(ctx + '/admin/loginlog/findOneLoginLog.do',{loginId:loginId});
            return $message;
        }
    });
}

</script>