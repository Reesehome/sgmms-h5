<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************************发起流程页面**********************/
var urlMain="/admin/workflow/processinstance/monitor.do";

$(function () {
	$("#listTask").jqGrid({
		url:ctx + '/admin/workflow/todo/AllTask.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          '流水号',
	   	          '任务号',
	   	          '流程名称',
	   	          '当前处理环节',
	   	          '流程发起时间',
	   	          '发起时长',
	   	          '本环节开始时间',
	   	          '本环节时长',
	   	          '描述',
	   	          '动作'],     //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   	        {name:'pid',index:'pid', width:30,align:'center', title:false},
	   	        {name:'id',index:'id', width:30,align:'center', title:false},
				{name:'pdname',index:'pdname', width:50,align:'center'},
		   		{name:'name',index:'name',width:50, align:'center',formatter:currActivityTask},
		   		{name:'PinstranceStartTime',index:'PinstranceStartTime',width:50, align:'center'},
		   		{name:'PinstranceDateDifferent',index:'PinstranceDateDifferent',width:50, align:'center'},
		   		
		   		{name:'createTime',index:'createTime',width:50, align:'center'},
		   		{name:'taskTimeLength',index:'taskTimeLength',width:30, align:'center'},
		   		
		   		{name:'processDesc',index:'processDesc',width:50, align:'center'},
		   		{name:'',index:'',width:50, align:'center',formatter:operateTask}
	   	 
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#gridpagerTask',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:275,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		//multiselect: true,  //可多选，出现多选框
		//multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'name',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {
		$("#listTask").setGridWidth($("#tablePanelTask").width() - 5);
	}).trigger('resize');
	
	
	if($("#messageTask").val()!=null && $("#messageTask").val()!=""){
		alertDiaTask($("#messageTask").val(),"success");
	}
});


/// 操作
function operateTask(cellvalue, options, rowObject){
	return    "<a class='link' href='javascript:void(0);' onclick='backProcess(&quot;"+rowObject.pid+"&quot; , &quot;"+"N"+"&quot; , &quot;"+rowObject.id+"&quot;)'>" + "回退" + "</a>" +" | " 
	         + "<a class='link' href='javascript:void(0);' onclick='backProcess(&quot;"+rowObject.pid+"&quot; , &quot;"+"Y"+"&quot; ,&quot;"+rowObject.id+"&quot;)'>" + "跳转" + "</a>" +" | "    
	      //   +"<a class='link' href='javascript:void(0);' onclick='openSelectOther(&quot;"+rowObject.id+"&quot;)' >" + "转派"+ "</a>";
	         +"<a class='link' href='javascript:void(0);' onclick='doTurn(&quot;"+rowObject.id+"&quot;)' >" + "转派"+ "</a>";
}

function backProcess(pid,isAll,taskId){
	var title="";
	if("Y"==isAll){
		title="选择可跳转的环节";
	}else{
		title="选择可回退的环节";
	}
	BootstrapDialog.show({
		title : title,
        message: $('<div></div>').load(ctx + "/admin/workflow/backProcessPage.do?processInstanceId="+pid+"&isAll="+isAll+"&taskId="+taskId),
        buttons : [
			{
				label : '<spring:message code="tds.common.label.submit"/>',
				cssClass: 'btn-primary',
				action : function(dialogItself){
					 processBackOperate(dialogItself,pid,taskId);
				}
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

/// 查看流程跟踪图
function currActivityTask(cellvalue, options, rowObject){
	var pdid =rowObject.processDefinitionId;
	var activityId=rowObject.activityId;
	var a_Object=$("<a class='link' id='trace' href='#' onclick='graphTrace(&quot;"+rowObject.pid+"&quot;,&quot;"+pdid+"&quot;)' ></a>");
	a_Object.attr("pid",rowObject.pid);
	a_Object.attr("pdid",pdid);
	a_Object.attr("title","点击查看流程图");
	a_Object.html(cellvalue);
	return a_Object[0].outerHTML;
}

// 选择节点后的回退操作
function processBackOperate(dialogItself,pid,taskId){
	var selNode=getSelectNode();
	if(selNode==null){
		$("#tipId").show();
		return;
	}
	
	var datas={"taskId":taskId,"toActivityId":selNode.attr("activityId"),"type":"","pdeId":selNode.attr("pdeId")};
	
	$.ajax({
		url:ctx + '/admin/workflow/backOperate.do',
		cache:false,
		dataType:"json",
		data:datas,
		type: "POST",
		success: function(result){
			if(result.success) {
				alertDiaTask(result.message,"success",urlMain);
				dialogItself.close();
				//重新加载
				//$("#listTask").trigger("reloadGrid");
				//var mainContainer=parent.mainContainer;
				//location.href= ctx + urlMain;
				
			} else{
				alertDiaTask(result.message,"error");
				dialogItself.close();
			}
		}
	});
	
	
}

/// 获取所有节点
function getSelectNode(){
	var select=null;
	$("#nodelist").find("button").each(function(m){
		  if( $(this).attr("isSel")=="true"){
			  select=$(this);
		  }
	});
	return select;
}




// 提示警告框
function alertDiaTask(mess,type,urlMain){
	var Dialogtitle=""; Dialogtype="";
	if(type=="error"){
		Dialogtitle='<spring:message code="tds.common.label.errorMessage"/>';
		Dialogtype=BootstrapDialog.TYPE_WARNING;
	}else{
		Dialogtitle='<spring:message code="tds.dataRight.label.doSuccess"/>';
		Dialogtype=BootstrapDialog.TYPE_SUCCESS;
	}
	
	BootstrapDialog.show({
		title: Dialogtitle,
        size: BootstrapDialog.SIZE_SMALL,
        type : Dialogtype,
        message: mess,
        buttons: [{
            label: '<spring:message code="tds.common.label.close"/>',
            action: function(dialogItself){
                dialogItself.close();
                if(urlMain){
                	location.href= ctx + urlMain;
                }
            }
        }]
    });
}

   
</script>