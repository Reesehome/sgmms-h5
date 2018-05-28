<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
/******************************发起流程页面**********************/
var baseUrl;

$(function () {
	$("#listTask").jqGrid({
		url:ctx + '/admin/workflow/todo/list.do',//请求数据的url地址
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
		   		{name:'name',index:'name',width:50, align:'center',formatter:currActivity},
		   		{name:'PinstranceStartTime',index:'PinstranceStartTime',width:50, align:'center'},
		   		{name:'PinstranceDateDifferent',index:'PinstranceDateDifferent',width:50, align:'center'},
		   		
		   		{name:'createTime',index:'createTime',width:50, align:'center'},
		   		{name:'taskTimeLength',index:'taskTimeLength',width:30, align:'center'},
		   		
		   		{name:'processDesc',index:'processDesc',width:50, align:'center'},
		   		{name:'',index:'',width:30, align:'center',formatter:operate}
	   	 
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
		sortname: 'pid',  //排序字段名
	    sortorder: "asc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {
		$("#listTask").setGridWidth($("#tablePanelTask").width() - 5);
	}).trigger('resize');
	
	
	if($("#messageTask").val()!=null && $("#messageTask").val()!=""){
		alertDia($("#messageTask").val(),"success");
	}
	
});


/// 操作
function operate(cellvalue, options, rowObject){
	if(rowObject.status=="todo"){
		return  "<a class='link' href='javascript:void(0);' onclick='openOperateJSP(&quot;"+rowObject.formKey+"&quot; , &quot;"+rowObject.id+"&quot;)'>" + "处理" + "</a>" +" | " 
		//  +"<a class='link' href='javascript:void(0);' onclick='openSelectOther(&quot;"+rowObject.id+"&quot;)' >" + "转派"+ "</a>";
		        +"<a class='link' href='javascript:void(0);' onclick='doTurn(&quot;"+rowObject.id+"&quot;)' >" + "转派"+ "</a>";
	}else{
		return  "<a class='link' href='task/claim/"+rowObject.id+"' >" + "领取" + "</a>";
	}
}



/// 根据formkey 打开 页面
function openOperateJSP(startFormKey,taskId){
	//alert(ctx + startFormKey+"?taskId="+taskId);return;
	//window.location.href= ctx + startFormKey+"?taskId="+taskId;
	window.location.href= ctx + startFormKey+"?taskId="+taskId+"&processInstanceId="+pid;
}

var baseUrl='';
/// 查看流程跟踪图
function currActivity(cellvalue, options, rowObject){
	//baseUrl=rowObject.path;  ///  调用外部项目时用
	var pdid =rowObject.pdid;
	var activityId=rowObject.activityId;
	var a_Object=$("<a class='link' id='trace' href='#' onclick='graphTraces(&quot;"+rowObject.pid+"&quot;,&quot;"+pdid+"&quot;)' ></a>");
	//  var a_Object=$("<a class='link' id='trace' href= '${ctx}/admin/workflow/resource/process-instance-img.do?pid="+rowObject.pid+"&pdid="+pdid + "'></a>");

	a_Object.attr("pid",rowObject.pid);
	a_Object.attr("pdid",pdid);
	a_Object.attr("title","点击查看流程图");
	a_Object.html(cellvalue);
	return a_Object[0].outerHTML;
}


function graphTraces(pid, pdid) {
	    var iWidth = document.body.clientWidth;
	    var iHeight = document.body.clientHeight;
	    
	    var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	    var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	    
	    var features = "height=478" + ",width="+"1100"+",toolbar=no,menubar=no,status=no,resizable=no,location=no"
	                  +",top="+(iTop)+", left="+(iLeft);  /// 30  120
	    var url= "<%=request.getContextPath()%>/tds/workflow/diagram-viewer/index2.jsp?processInstanceId="+pid+"&processDefinitionId="+pdid+"&path="+baseUrl;
		window.open(url,"流程跟踪",features);
        
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