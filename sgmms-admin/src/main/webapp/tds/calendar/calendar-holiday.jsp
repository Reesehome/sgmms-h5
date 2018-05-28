<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/**
 * 表格示例JS
 */
$(function () {
	$("#list").jqGrid({
		url:ctx + '/admin/calendar/holiday/queryCalendarHoliday.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          "id",
	   	          '<spring:message code="tds.calendar.holiday.label.holidayName"/>',
   	       		  '<spring:message code="tds.calendar.holiday.label.startDate"/>',
   	       		  '<spring:message code="tds.calendar.holiday.label.endDate"/>',
   	       		  '<spring:message code="tds.calendar.holiday.label.isLunar"/>',
	       		  '<spring:message code="tds.calendar.holiday.label.isYearPeriod"/>',
	   	          '<spring:message code="tds.calendar.holiday.label.year"/>',
	   	          '<spring:message code="tds.calendar.holiday.label.holidayDesc"/>'], //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   	    {name:'id',index:'id', hidden:true, width:150, title:false},
	   		{name:'holidayName',index:'holidayName', width:150, title:false},
			{name:'startDate',index:'startDate', width:80, formatter:'date', formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'Y-m-d'},align:'center'},
			{name:'endDate',index:'endDate', width:80, formatter:'date', formatoptions:{srcformat:'Y-m-d H:i:s',newformat:'Y-m-d'},align:'center'},
			{name:'isLunar',index:'isLunar', width:80, formatter:'select', editoptions:{value:"y:是;n:否"},align:'center'},
			{name:'isYearPeriod',index:'isYearPeriod', width:80, formatter:'select', editoptions:{value:"y:是;n:否"},align:'center'},
			{name:'year',index:'year', width:80,align:'center'},
	   		{name:'holidayDesc',index:'holidayDesc', align:'center'}		
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#gridpager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:275,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		multiselect: true,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'startDate',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
			//alert("成功了");
		}
	});
	
	initDelete();
});


/**
* 搜索示例数据
*/
function queryCalendarHoliday(){
	var params = $("#searchForm").serializeJson();
	$("#list").setGridParam({postData:params}).trigger("reloadGrid");
}

/**
* 加载内容并显示编辑窗口
*/
function showEdieWindow(type){
	var ids = $("#list").jqGrid('getGridParam','selarrrow');
	if("add" == type){
		ids = [];
	}else if(ids && ids.length == 0){
		BootstrapDialog.show({
			title: '<spring:message code="tds.common.label.errorMessage"/>',
            size: BootstrapDialog.SIZE_SMALL,
            type : BootstrapDialog.TYPE_WARNING,
            message: '<spring:message code="tds.demo.message.selectDemoForUpdate"/>',
            buttons: [{
                label: '关闭',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
		
		return;
	}
	
	BootstrapDialog.show({
		title : '<spring:message code="tds.common.label.editData"/>',
        message: $('<div></div>').load(ctx + "/admin/calendar/holiday/showEditCalendarHoliday.do?id=" + ids[0]),
        buttons : [
            {
         	   label : '<spring:message code="tds.common.label.submit"/>',
         	   cssClass: 'btn-primary',
         	   action : saveCalendarHoliday
            },
            {
         	   label : '<spring:message code="tds.common.label.close"/>',
         	   action : function(dialogItself){
         		   dialogItself.close();
         	   }
            }
        ]
    });
}

/**
* 编辑示例数据
*/
function saveCalendarHoliday(dialogItself){
	//验证结果正确再提交
	var validResult = $("#holidayForm").valid();
	if(validResult){
		var params = $("#holidayForm").serialize();
		$.tdsAjax({
			url:ctx + "/admin/calendar/holiday/saveCalendarHoliday.do",
			cache:false,
			dataType:"json",
			data:params,
			success: function(result){
				if(result.success) {
					 dialogItself.close();
					//重新加载列表数据
					$("#list").trigger("reloadGrid");
				} else{
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.errorMessage"/>',
			            size: BootstrapDialog.SIZE_SMALL,
			            type : BootstrapDialog.TYPE_WARNING,
			            message: result.message,
			            buttons: [{
			                label: '<spring:message code="tds.common.label.close"/>',
			                action: function(dialogItself){
			                    dialogItself.close();
			                }
			            }]
			        });
				}
			}
		});
	}
}

/**
* 删除示例数据
*/
function initDelete(){
	$('#btnDelete').confirmation({
		title:'<spring:message code="tds.common.message.confirmDelete"/>',
		btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
		btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
		onConfirm : function(){
			var ids = $("#list").jqGrid('getGridParam','selarrrow');
			var params = $.param({ids:ids},true);
			$.tdsAjax({
				url: ctx + "/admin/calendar/holiday/deleteCalendarHoliday.do",
				cache: false,
				dataType:"json",
				data:params,
				success: function(result){
					if(result.success)
						//重新加载列表数据
						$("#list").trigger("reloadGrid");
					else{
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself){
				                    dialogItself.close();
				                }
				            }]
				        });
					}
				}
			});
		}
	});
}

/**
* 清空表单
*/
function cleanForm(){
	$("#searchForm").cleanForm();
}
</script>