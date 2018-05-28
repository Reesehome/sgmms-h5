<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
/******************任务转派操作**********************************/
function doTurn(taskId) {
			        BootstrapDialog.show({
			    		title : '转派',
			    		size: BootstrapDialog.SIZE_NORMAL,
			    	     message: $('<div></div>').load(ctx+"/admin/workflow/toTurn.do"),
			    		 buttons : [
								   {
										label : '<spring:message code="tds.common.label.submit"/>',
										cssClass: 'btn-primary',
										action : function(dialogItself){
											selectPerson(dialogItself,taskId);
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




function selectPerson(dialogItself,taskId){
	var selectids=$("#buttomSearchUserTable").jqGrid("getGridParam", "selarrrow");
	if(selectids.length>1 ){
		$("#alertTip").show();
		return;
	}
	
	//alert(selectids.length); return;
	
	var selectId = $("#buttomSearchUserTable").jqGrid("getGridParam", "selrow");
	if(selectId == null || selectId.length <= 0) {
		$("#alertTip").show();
		return;
	}
	var rowData = $("#buttomSearchUserTable").jqGrid("getRowData", selectId);
	var datas={}; datas.taskId=taskId;   datas.userId=rowData.userId;
	$.ajax({
		url:ctx + '/admin/workflow/taskchange.do',
		cache:false,
		dataType:"json",
		data:datas,
		type: "POST",
		success: function(result){
			if(result.success) {
				dialogItself.close();
				alertDia(result.message,"success");
				//重新加载
				$("#listTask").trigger("reloadGrid");
			} else{
				alertDia(result.message,"error");
			}
		}
	});
	
}























</script>