<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">

$(function () {
	$("#list").jqGrid({
		url:ctx + '/admin/sysProperty/find.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
	   	          '<spring:message code="tds.sys.property.key"/>',
	   	          '<spring:message code="tds.sys.property.value"/>',
	   	          '<spring:message code="tds.sys.property.remark"/>',
	   	          '<spring:message code="tds.sys.property.isnotdelete"/>'],     //数据列名称（数组）
	   	colModel:[ //数据列各参数信息设置
	   		{name:'propKey',index:'propKey', width:80, title:false,align:'center'},
			{name:'propValue',index:'propValue', width:80,align:'center'},
	   		{name:'remark',index:'remark', width:180, align:'left'}	,
	   		{name:'deletable',index:'deletable', width:40,formatter:convertDes,align:'center'}
	   	 
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
		sortname: 'propKey',  //排序字段名
	    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
		loadComplete:function(data){ //完成服务器请求后，回调函数
			//alert("成功了");
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {
		$("#list").setGridWidth($("#tablePanel").width() - 5);
	}).trigger('resize');
	
	
	//initDelete();
});


/**
* 搜索系统参数数据列表
*/
function searchSysProperty(){
	var params = $("#searchForm").serializeJson();
	$("#list").setGridParam({postData:null});
	$("#list").setGridParam({postData:params}).trigger("reloadGrid");
}

function convertDes(cellvalue, options, rowObject){
	var deletable="";
	if(cellvalue=="Y"){
		deletable="<spring:message code='tds.sys.property.yes'/>";
	}else if(cellvalue=="N"){
		deletable="<spring:message code='tds.sys.property.no'/>";
	}
	return deletable;
}


/**
* 加载内容并显示编辑窗口
*/
function showEdieWindow(type){
	var ids = $("#list").jqGrid('getGridParam','selarrrow');
	var obj=$("#list").jqGrid('getRowData', ids[0]);
	 //alert(obj.propKey);return ;
	
	if("add" == type){
		ids = [];obj.propKey=null;
	}else if( (ids && ids.length == 0) || (ids && ids.length >1) ){
		
		BootstrapDialog.show({
			title: '<spring:message code="tds.common.label.errorMessage"/>',
            size: BootstrapDialog.SIZE_SMALL,
            type : BootstrapDialog.TYPE_WARNING,
            message:'<spring:message code="tds.sys.property.onlyone"/>',
            
            buttons: [{
                label: '<spring:message code="tds.common.label.close"/>',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
		
		return;
	}
	
	BootstrapDialog.show({
		title : '<spring:message code="tds.common.label.editData"/>',
        message: $('<div></div>').load(ctx + "/admin/sysProperty/show-edit.do?id=" + obj.propKey),
        buttons : [
                   {
                	   label : '<spring:message code="tds.common.label.submit"/>',
                	   cssClass: 'btn-primary',
                	   action : editSysPerproty
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


function radioClick(type){
	if("yes"==type){
		$("#deletable").val("Y");
	}else{
		$("#deletable").val("N");
	}
}

/**
* 编辑
*/
function editSysPerproty(dialogItself){
	//验证结果正确再提交
	var validResult = $("#editForm").valid();
	
// 	if($("#deletable").is(":checked")){
// 		$("#deletable").val("Y");
// 	}else{
// 		$("#deletable").val("N");
// 	}

   //  alert( $("#key").val()+"----"+ $("#propKey-old").val()); return;
	
	if(validResult){
		var params = $("#editForm").serialize();
		params.deletable=$("#deletable").val();
		
		$.tdsAjax({
			url:ctx + "/admin/sysProperty/edit.do",
			cache:false,
			dataType:"json",
			data:params,
			type: "POST",
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


function deleteSys(){
	var ids = $("#list").jqGrid('getGridParam','selarrrow');
	
	var new_ids =new Array();var del_ids =new Array();
	if(ids){
		for ( var i = 0; i < ids.length; i++) {
			var obj=$("#list").jqGrid('getRowData', ids[i]);
			new_ids.push(obj.propKey);
			del_ids.push(obj.deletable);
		}
	}
	
	//没有选择数据 
	if(new_ids.length==0){
		BootstrapDialog.show({
			title: '<spring:message code="tds.common.label.errorMessage"/>',
            size: BootstrapDialog.SIZE_SMALL,
            type : BootstrapDialog.TYPE_WARNING,
            message: '<spring:message code="tds.sys.property.leastone"/>',
            buttons: [{
                label: '<spring:message code="tds.common.label.close"/>',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
		return;
	}
	
	
	//系统参数不可以删除
	if(new_ids.length>=1){
		var sys="";
		var mess=" <spring:message code='tds.sys.property.cannotDelete'/>";
		for ( var k = 0; k < del_ids.length; k++) {
			 var isDele=del_ids[k];
			// debugger;
			 if("N"==isDele || "否"==isDele){
				    sys +=new_ids[k]+",";
			  }
		}
	
		if(sys!=""){
			alertDia(sys+mess);
			return;
		}
	}
	
	
	//提示确认删除
	BootstrapDialog.show({
		title: '<spring:message code="tds.common.label.alertTitle"/>',
		size: BootstrapDialog.SIZE_SMALL,
		type : BootstrapDialog.TYPE_WARNING,
		message: '<spring:message code="tds.common.message.confirmDelete"/>',
		buttons: [{
			label: '<spring:message code="tds.common.label.delete"/>',
			cssClass : 'btn-primary',
			action: function(dialogItself){
				dialogItself.close();
				doDelete(new_ids);
			}
		},{
			label : '<spring:message code="tds.common.label.close"/>',
			action: function(dialogItself){
				dialogItself.close();
			}
		}]
	});
}

/**
* 删除
*/
function doDelete(new_ids){
	var params = $.param({ids:new_ids},true);
	$.tdsAjax({
		url: ctx + "/admin/sysProperty/delete.do",
		cache: false,
		dataType:"json",
		data:params,
		type: "POST",
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

/**
* 清空表单
*/
function cleanForm(){
	$("#searchForm").cleanForm();
}

function alertDia(mess){
	BootstrapDialog.show({
		title: '<spring:message code="tds.common.label.errorMessage"/>',
        size: BootstrapDialog.SIZE_SMALL,
        type : BootstrapDialog.TYPE_WARNING,
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