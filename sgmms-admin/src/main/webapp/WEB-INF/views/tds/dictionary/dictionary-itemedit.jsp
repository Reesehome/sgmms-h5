<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
	.table thead tr th,.table tbody tr td{padding: 3px;}
</style>
</head>
<body>
	<form:form id="SaveDictionaryItemForm" class="form-horizontal" modelAttribute="dictionaryItem" role="form">
	   <div class="container-fluid" style="margin-top: 8px;">
		  <%-- <div class="form-group">
		    <label for="itemDictionaryName"class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.ofdictionary"/> </label>
		    <div class="col-sm-8">
		    	<form:input path="dictionaryName" class="form-control" readonly="readonly" id="itemDictionaryName"/>
		    </div>
		  </div> --%>
		  
		  <div class="form-group">
		    <label for="itemName"class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.name"></spring:message></label>
		    <div class="col-sm-8">
		    	<form:input path="name" class="required form-control" id="itemName"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="itemValue" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.value"></spring:message></label>
		    <div class="col-sm-8">
		    	<form:input path="value" class="required form-control" id="itemValue"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="itemDesc" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.description"></spring:message></label>
		    <div class="col-sm-8">
		    	<form:textarea rows="2" path="description" class="form-control" id="itemDesc"/>
		    </div>
		  </div>
	 
	 	<!-- lang -->
		  <div class="row">
		  	<div class="col-md-12"><strong><spring:message code="tds.dictionary.label.multipleLanguageConfig"/></strong></div>
		  </div>
		  <div class="row">
		  	<table class="table table-bordered">
		  		<thead>
		  			<th style="width: 30%;"><spring:message code="tds.common.label.lanauage"/></th>
		  			<th style="width: 30%;"><spring:message code="tds.common.label.lanauageCode"/></th>
		  			<th style="width: 40%;"><spring:message code="tds.dictionary.label.name"/></th>
		  		</thead>
		  		<tbody>
		  			<c:forEach items="${lang }" var="aLang">
		  				<tr>
			  				<td>${aLang.langName }</td>
			  				<td>${aLang.lang }</td>
			  				<td>
								<input type="text" value="${aLang.itemName }" name="itemName[]" class="form-control"/>
								<input type="hidden" value="${aLang.lang }" name="lang[]" class="form-control"/>
							</td>
						</tr>
		  			</c:forEach>
		  		</tbody>
		  	</table>
		  </div>
	  </div>
	  <form:hidden path="id" id="itemId"/>
	  <form:hidden path="parentId" id="parentId" />
	  <form:hidden path="dictionaryId" id="itemDictionaryId"/>
	  
	  <%-- 
	  <div class="btn-group" style="margin-left: 75%;">
	  	<button type="button" class="btn btn-primary" onclick="saveDictionaryItem();"><spring:message code="tds.common.label.save"/></button>
	 	<button type="button" class="btn btn-success" onclick="closeItemEditDialog();"><spring:message code="tds.common.label.cancel"/></button>
	  </div>
	  --%>
	</form:form>
	<script type="text/javascript">
		$(function(){
			$("#btnSave").off("click");
			$("#btnSave").on("click",saveDictionaryItem);
			
			initValidate();
		});
		
		function saveDictionaryItem(){
			if( $("#SaveDictionaryItemForm").valid() )
				doSaveItem();
		}
		
		function doSaveItem(){
			<%--
			var dictionaryId = $('#SaveDictionaryForm').find('input[name="id"]').val();
			if(!isNotEmpty(dictionaryId)){
				showAlert('<spring:message code="tds.dictionary.message.selectDictionary"/>');
				return;
			}
			
			var dictionaryValid = $('#SaveDictionaryForm').find('input[name="isValid"]').val();
			if('Y' != dictionaryValid){
				showAlert('<spring:message code="tds.dictionary.message.saveDictionaryFirst"/>');
				return;				
			}
			--%>
			
			var params = $("#SaveDictionaryItemForm").serializeJson();
			$.tdsAjax({
				url: ctx + getPath() + "/dictionary/saveDictionaryItem.do",
				data: params,
				dateType: "json",
				cache:false,
				type: 'post',
				success: function(returnValue){
					var key = returnValue.KEY;
					if(key == 'SUCCESS'){
						//closeItemEditDialog();
						//reloadDictionaryItemTable();
						
						//在字典类型下添加字典项
						if("addForDic" == "${operation}"){
							var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
							var selectedNode = tree.getSelectedNodes()[0];
							if(selectedNode){
								tree.reAsyncChildNodes(selectedNode, "refresh");
							}
						}
						
						
						if("addColleague" == "${operation}" || "addSub" == "${operation}"){
							
							var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
							var selectedNode = tree.getSelectedNodes()[0];
							if(selectedNode){
								var parentNode = selectedNode.getParentNode();
								if(parentNode)
									tree.reAsyncChildNodes(parentNode, "refresh");
							}
						}
						
						//在字典类型下添加字典项
						if("show" == "${operation}"){
							var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
							var selectedNode = tree.getSelectedNodes()[0];
							if(selectedNode){
								selectedNode.name = $("#itemName").val();
								tree.updateNode(selectedNode);
							}
						}
						
						showSuccess("<spring:message code="tds.menuRight.label.executeSuccess"/>");
					}else{
						showError( getResult(key) );
					}
				},
				error: function(){
					showError('<spring:message code="tds.dictionary.message.savingFailed"/>');
				}
			});
		}
		
		/**
		 * 初始化表单验证
		 */
		function initValidate(){
			//添加验证规则
			$.validator.addMethod("nameExist",function(value,element,params){
				
			},"名字已存在，请重命名！");
			
			//为inputForm注册validate函数
			$('#SaveDictionaryItemForm').validate({
				errorClass : 'help-block',
				focusInvalid : false,
				rules : {
					name:{
						required: true,
						maxlength : 64
					},
					value:{
						required: true,
						maxlength : 64
					}
				},
				messages : {
					name:{
						required: '<spring:message code="tds.dictionary.message.nameNotNull"/>',
						maxlength : '<spring:message code="tds.dictionary.message.nameMaxLength"/>'
					},
					value:{
						required: '<spring:message code="tds.dictionary.message.nameNotNull"/>',
						maxlength : '<spring:message code="tds.dictionary.message.nameMaxLength"/>'
					}
				},

				highlight : function(element) {
					$(element).parent('div').addClass('has-error');
				},

				success : function(label) {
					label.parent('div').removeClass('has-error');
					label.remove();
				},

				errorPlacement : function(error, element) {
					element.parent('div').append(error);
				}
			});
		}
	</script>
</body>
</html>