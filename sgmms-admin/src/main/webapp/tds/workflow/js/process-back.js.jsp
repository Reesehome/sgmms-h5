<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">

/*********************流程回退选择**********************/

$(function () {
	var pid=$("#pid").val(); var isAll=$("#isAll").val(); var taskId=$("#taskId").val();
	var datas={"processInstanceId":pid,"isAll":isAll,"taskId":taskId};
	$.ajax({
		url:ctx + '/admin/workflow/getActivityImpls.do',
		cache:false,
		dataType:"json",
		data:datas,
		type: "POST",
		success: function(result){
			var lineNum=4; var rowlist=$("#nodelist");
			if(result.length==0){
				$("#tipId").find("label").text("提示：没有可选择的节点来进行回退或者跳转操作！");
				$("#tipId").show();
				return;
			}
			for ( var i = 0; i < result.length; i=i+lineNum) {
				var $row=createRow();
				for ( var k = i; k < i+lineNum; k++) {
					if(k<result.length){
						var $col=createCol(result[k]);
						$row.append($col);
					}
				}
			
				rowlist.append(createRowSpace());
				rowlist.append($row);
			}
		}
	});
	
});


function createCol(obj){
	var $col=$('<div class="col-md-3"><button type="button"  class="btn btn-success btn-block"></button></div>');
	var $btn=$col.find("button");
	$btn.html(obj.activityName);
	$btn.attr("activityId",obj.activityId);
	$btn.attr("type",obj.type);
	$btn.attr("pdeId",obj.pdeId);
	$btn.attr("isSel","false");
	$btn.click(function(){
		  updateOtherBtn();
		  $(this).attr("class","btn btn-warning btn-block");
		  $(this).attr("isSel","true");
		  $("#tipId").hide();
	});
	return $col;
}


function updateOtherBtn(){
	$("#nodelist").find("button").each(function(m){
		   $(this).attr("isSel","false");
		   $(this).attr("class","btn btn-success btn-block");
	});
}


function createRow(){
	var row=$('<div class="row" align="center"></div>');
	return row;
}

function createRowSpace(){
	var space=  $('<div class="vertical-space"></div>') ;  
	return space;
}
   
</script>