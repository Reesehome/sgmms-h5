<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************流程监控页面**********************************/

$(function () {
	$("#list").jqGrid({
		url:ctx + '/admin/workflow/processinstance/processInstanceList.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          '流水号',
	   	          '流程实例号',
	   	         // '流程实例ID',
	   	         // '流程定义ID',
	   	          '流程名称',
	   	          '当前处理环节',
	   	          '流程发起时间',
	   	          '发起时长',
	   	          '描述',
	   	          '是否挂起',
	   	          '动作'],     //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   	        {name:'sheetId',index:'sheetId', width:30,align:'center', title:false},   
	   	        {name:'id',index:'id', width:30,align:'center', title:false},
				//{name:'processInstanceId',index:'processInstanceId', width:50,align:'center'},
		   		//{name:'processDefinitionId',index:'processDefinitionId',width:20, align:'center'},
		   		
		   		{name:'processVariables.Pname',index:'processVariables.Pname',width:50, align:'center'},// 流程名称
		   		{name:'processVariables.activityName',index:'processVariables.activityName',width:50, align:'center',formatter:currActivity}, //当前处理环节
		   		{name:'processVariables.PinstranceStartTime',index:'processVariables.PinstranceStartTime',width:60, align:'center'},//流程发起时间
		   		{name:'processVariables.DateDifferent',index:'processVariables.DateDifferent',width:65, align:'center'},//发起时长
		   		{name:'processVariables.processDesc',index:'processVariables.processDesc',width:70, align:'center'},  //描述, 注意：processDesc ，是开发人员在发起流程中的约定好的变量
		   		
		   		{name:'suspended',index:'suspended',width:30, align:'center',formatter:convertA},
		   		{name:'',index:'',width:50, align:'center',formatter:operate},
	   	 
	   	],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#gridpager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:275,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		//multiselect: true,  //可多选，出现多选框
		//multiselectWidth: 25, //设置多选列宽度
		sortable:true,  //可以排序
		sortname: 'id',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {
		$("#list").setGridWidth($("#tablePanel").width() - 5);
	}).trigger('resize');

	
	if($("#message").val()!=null && $("#message").val()!=""){
		alertDia($("#message").val(),"success");
	}
	
});


function convertA(cellvalue, options, rowObject){
	if(cellvalue){
		return "<a class='link' href='update/active/"+ rowObject.processInstanceId+ "'>" + "激活" + "</a>";
	}else{
		return "<a class='link' href='update/suspend/"+ rowObject.processInstanceId+ "'>" + "挂起" + "</a>";
    }
}


function operate(cellvalue, options, rowObject){
	         //   "<a class='link' href='endProcess/"+rowObject.processInstanceId+"'>" + "终止" + "</a>" ;
   return    "<a class='link' href='javascript:void(0);' onclick='endProcessInstance(&quot;"+rowObject.processInstanceId+"&quot;)'>"+ "终止" + "</a>" ;
}

function endProcessInstance(processInstanceId){
	BootstrapDialog.show({
		title : '<spring:message code="tds.common.label.warningTitle"/>',  // 警告
		message : '<spring:message code="tds.demo.message.confirmDelete"/>',
		type : BootstrapDialog.TYPE_WARNING,// 警告
		 size: BootstrapDialog.SIZE_SMALL,//小
		buttons : [ {
			label : '<spring:message code="tds.common.label.submit"/>',
			cssClass : 'btn-primary',
			action : function(dialogItself) {
				var url = "${ctx}/admin/workflow/processinstance/endProcess/"+processInstanceId;
				$.ajax({
					url:url,
					cache:false,
					success: function(result){
						if(result.success){
							//重新加载列表数据
							$("#list").trigger("reloadGrid");
							alertDia(result.message,"success");
						}else{
							alertDia(result.message,"error");
						}
						
					}
				});
				//关闭窗口
				dialogItself.close();
			}
		}, {
			label : '<spring:message code="tds.common.label.close"/>',
			action : function(dialogItself) {
				dialogItself.close();
			}
		} ]
	});
	
}

function currActivity(cellvalue, options, rowObject){
	var pdid =rowObject.processDefinitionId;
	var activityId=rowObject.activityId;
	var a_Object=$("<a class='link' id='trace' href='#' onclick='graphTrace(&quot;"+rowObject.id+"&quot;,&quot;"+pdid+"&quot;)' ></a>");
	a_Object.attr("pid",rowObject.id);
	a_Object.attr("pdid",pdid);
	a_Object.attr("title","点击查看流程图");
	a_Object.html(cellvalue);
	return a_Object[0].outerHTML;
}


// 提示警告框
function alertDia(mess,type){
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
            }
        }]
    });
}

   
</script>