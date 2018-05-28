/**
* 搜索示例数据
*/
function searchLoginLog(){
	var params = $("#searchLoginForm").serializeJson();
	$("#loginLogGrid").setGridParam({postData: null});//清空之前的条件
	$("#loginLogGrid").setGridParam({postData:params}).trigger("reloadGrid");
}

/**
* 清空表单
*/
function cleanSearchForm(){
	$("#searchLoginForm").cleanForm();
}

/**
* 初始化时间组件
*/
function initDateWidget(){
	//初始化时间控件
	$("#beginTime").datetimepicker({
		format:'yyyy-mm-dd hh:ii:ss',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 0,
		weekStart: 1}).on('changeDate',function(ev){
			//var beginTime = ev.timeStamp;//date.valueOf();
			var beginTimeText = $("#beginTime").val();
			var beginTimeDate = convertToDate(beginTimeText);
			var beginTime = beginTimeDate.getTime();
			
			var endTimeText = $('#endTime').val();
			var endTimeDate = convertToDate(endTimeText);
			if(endTimeDate && beginTime > endTimeDate.getTime()){
				$("#beginTime").val('');
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
			
			var beginTimeText = $('#beginTime').val();
			var beginTimeDate = convertToDate(beginTimeText);
			if(beginTimeDate && beginTimeDate.getTime() > endTime){
				$("#endTime").val('');
			}else{
				$("#beginTime").datetimepicker('setEndDate', ev.date);
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

function initLoginLogTable(){
	var params = $("#searchLoginForm").serializeJson();
	$("#loginLogGrid").jqGrid({
		url: getContext() + '/admin/loginlog/findLoginLog.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
		mtype: 'post',
		postData: params,
		colNames:[
		          i18n.a,
		          i18n.b,
		          i18n.c,
		          i18n.d,
		          i18n.e,
		          i18n.f,
		          i18n.g,
		          i18n.h
	   	          ], //数据列名称（数组）
	   	colModel:[//数据列各参数信息设置
	   	          {name:'userName',index:'userName', width:80},
	   	          {name:'loginName',index:'loginName', width:80},
	   	       	  {name:'loginTime',index:'loginTime', width:80, align:'center'},
	   	       	  {name:'address',index:'address', width:80, align:'center'},
	   	      	  {name:'loginResultDisplay',index:'loginResult', width:80, align:'center',formatter: convertColumn},
	   	      	  {name:'timeLastHour',index:'timeLastHour', width:80, align:'center', formatter: convertTimeLast,sortable:false},
	   	          {name:'offlineStatusDisplay',index:'offlineStatus', width:80,align:'center', formatter: convertColumn},
	   	          {name:'logCount',index:'logCount', width:180,align:'center', formatter : showLoginLink,sortable:false}
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#loginLogGridPager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:275,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		multiselect: false,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'loginTime',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
			var params = {widtharray:[10,10,20,15,15,15,20,15],tableid:'loginLogGrid',pager:'loginLogGridPager'};
			resizeTable(params);
		}
	});
}

function showLoginLink(cellvalue, options, rowObject){
	//return "<a href='javascript:findLogInfo(\"" + cellvalue + "\");void(0);'>查看</a>";
	var loginId = rowObject.loginId;
	return "<span class='link' onclick='findLogInfo(\"" + loginId + "\");'>("+ cellvalue + ")</span>";
}

function convertColumn(cellvalue, options, rowObject){
	if(null == cellvalue || typeof cellvalue == 'undefined')
		return '';
	else 
		return cellvalue;
}

function convertTimeLast(cellvalue, options, rowObject){
	if(null == cellvalue || typeof cellvalue == 'undefined')
		return '';
	else{
		var hour = cellvalue;
		var min = rowObject.timeLastMin;
		return hour + i18n.l + min + i18n.m;
	}
}
function findLogInfo(loginId){
	BootstrapDialog.show({
		size: BootstrapDialog.SIZE_WIDE,
		title: i18n.j,
		buttons: [{
            label: i18n.k,
            cssClass: 'btn-primary',
            action: function(dialogRef){
                dialogRef.close();
            }
        }],
        message: function(dialog) {
            var $message = $('<div></div>');
            $message.load(getContext() + '/admin/loginlog/findLog.do',{loginId:loginId});
            return $message;
        }
    });
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

$(function(){
	initDateWidget();
	initLoginLogTable();
});