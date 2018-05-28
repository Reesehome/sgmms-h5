<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************************发起流程页面**********************/
$(function () {
	$("#list").jqGrid({
		url:ctx + '/admin/workflow/find.do?isStart=Y',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          '流程名称',
	   	          '流程编号',
	   	          '版本号',
	   	          'XML',
	   	          '流程图',
	   	          '部署时间',
	   	          '操作'],     //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   	        {name:'name',index:'name', width:50,align:'center', title:false},
				{name:'key',index:'key', width:50,align:'center'},
		   		{name:'version',index:'version',width:20, align:'center'},
		   		{name:'resourceName',index:'resourceName',width:50, align:'center'},
		   		{name:'diagramResourceName',index:'diagramResourceName',width:50, align:'center',formatter:convertImg},
		   		
		   		{name:'deploymentTime',index:'deploymentTime',width:50, align:'center'},
		   		{name:'',index:'',width:30, align:'center',formatter:operate},
	   	 
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
		sortname: 'name',  //排序字段名
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





function operate(cellvalue, options, rowObject){
	return  "<button type='button' class='btn btn-primary btn-xs' onclick='startProcess(&quot;"+rowObject.startFormKey+"&quot; , &quot;"+rowObject.id+"&quot;)'> 发起</button>"; 
			
}

function convertImg(cellvalue, options, rowObject){
	return   "<a class='link' href='javascript:void(0);' onclick='getImg(&quot;"+rowObject.id+"&quot;)'>" + cellvalue + "</a>"; 
}

function startProcess(startFormKey,id){
	// 启动流程
	//$("#startProcess").attr("action",ctx+"/admin/workflow/startProcess.do?processDefinitionId="+id);
	//$("#startProcess").submit();
	
	//window.location.href= ctx + '/admin/workflow/public.do';
	//alert(startFormKey);return;
	window.location.href= ctx + startFormKey+"?processDefinitionId="+id;
}

// 根据流程定义id 获取流程图
function getImg(id){

	BootstrapDialog.show({
		title : '流程图',
		size: BootstrapDialog.SIZE_WIDE,
        message: $('<div></div>').load(ctx + "/admin/workflow/resource/reads.do?resourceType=image&processDefinitionId=" + id),
        buttons : [
                  
                   {
                	   label : '<spring:message code="tds.common.label.close"/>',
                	   action : function(dialogItself){
                		   dialogItself.close();
                	   }
                   }
        ]
    });
	
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