<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">


var model_url="/admin/workflow/model/model-desgin.do";
//var model_design="http://172.16.26.45:8092/kft-activiti-demo-no-maven/service/editor?id=";  //test
// var model_design='${path}'+'/service/editor?id=';  // 外部调用
 var model_design=ctx+'/service/editor?id=';
 
$(function () {
	$("#list").jqGrid({
		url:ctx + '/admin/workflow/model/list.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          '流程模型名称',
	   	          '流程模型编号',
	   	         // '版本号',
	   	          '创建时间',
	   	          '更新时间',
	   	          '操作'],     //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   	        {name:'name',index:'name', width:50,align:'center', title:false},
				{name:'key',index:'key', width:40,align:'center'},
		   		//{name:'version',index:'version',width:20, align:'center'},
		   		
		   		{name:'createTime',index:'createTime',width:50, align:'center'},
		   		{name:'lastUpdateTime',index:'lastUpdateTime',width:50, align:'center'},
		   		{name:'',index:'',width:60, align:'center',formatter:operate}
	   	 
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
		sortname: 'lastUpdateTime',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
			
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {
		$("#list").setGridWidth($("#tablePanel").width() - 5);
	}).trigger('resize');
	
	if($("#message").val()!=null && $("#message").val()!="" && $("#message").val()!="null"){
		alertDia($("#message").val());
	}
	
	 initMenuTree(); // 初始化菜单选中 状态
});

/**
 *  初始化菜单选中 状态( 为 流程设计菜单做准备)
 */
function initMenuTree(){
	var z_tree=parent.menuTree;
	//var nodes = z_tree.getSelectedNodes();
	//var node=nodes[0];
	 var nodeObj =z_tree.getNodeByParam("url",model_url,null);
	 z_tree.selectNode(nodeObj,false);
}

function operate(cellvalue, options, rowObject){
	var deploy=String(rowObject.id)+"*"+"deploy";
	var _delete=String(rowObject.id)+"*"+"delete";
	
	  return  " <a class='link' href= '"+model_design+rowObject.id+"'   target='_blank'>" + "编辑" + "</a>" +" | " 
			+ "<a class='link' href='javascript:void(0);' onclick='operateArea(&quot;"+deploy+"&quot;)'>"+ "部署" + "</a>" +" | "
			+ "<a class='link' href='export/"+ rowObject.id+ "' target='_blank'>" + "导出" + "</a>" +" | "
	        + "<a class='link' href='javascript:void(0);' onclick='operateArea(&quot;"+_delete+"&quot;)'>"+ "删除" + "</a>" ;
}


function operateArea(str){
	var arr=str.split("*");
	var url="";
	if('deploy'==arr[1]){
		    url=ctx + "/admin/workflow/model/deploy/"+arr[0]+".do";
		    commonAjax(url);
	}else if('delete'==arr[1]){
		    url=ctx + "/admin/workflow/model/delete/"+arr[0]+".do";
		    
			BootstrapDialog.show({
				title : '<spring:message code="tds.common.label.warningTitle"/>',  // 警告
				message : '<spring:message code="tds.demo.message.confirmDelete"/>',
				type : BootstrapDialog.TYPE_WARNING,// 警告
				 size: BootstrapDialog.SIZE_SMALL,//小
				buttons : [ {
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass : 'btn-primary',
					action : function(dialogItself) {
						commonAjax(url);
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
	
	
}


function commonAjax(url){
	
	$.ajax({
		url:url,
		cache:false,
		dataType:"json",
		type: "POST",
		success: function(result){
			if(result.success) {
				//重新加载列表数据
				alertDia(result.message,"success");
				$("#list").trigger("reloadGrid");
			} else{
				alertDia(result.message,"error");
			}
		}
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


function editModel(dialogItself){
	var validResult = $("#modelForm").valid();
	if(validResult){
		$('#modelForm').submit();
		  dialogItself.close();
		//重新加载列表数据
		$("#list").trigger("reloadGrid");
	}
}

function createModel(){
	
	BootstrapDialog.show({
		title : '创建新流程模型',
        message: $('<div></div>').load(ctx + '/admin/workflow/model/add-model.do'),
        buttons : [
                   {
                	   label : '<spring:message code="tds.common.label.submit"/>',
                	   cssClass: 'btn-primary',
                	   action : editModel
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
   
</script>