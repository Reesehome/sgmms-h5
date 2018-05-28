<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<form:form id="SaveDictionaryForm" class="form-horizontal" modelAttribute="dictionary" role="form">
	  
	  	<div class="form-group">
		    <label for="parentName" class="col-sm-3 control-label">
		    	<c:if test="${dictionary.type eq 'D' }"><spring:message code="tds.dictionary.label.ofcategory"/> </c:if>
		    	<c:if test="${dictionary.type eq 'C' }"><spring:message code="tds.dictionary.label.superiorcategory"/></c:if>
		    </label>
		    <div class="col-sm-8">
		    	<form:input path="parentName" class="form-control" readonly="true" id="parentName"/>
		    </div>
	  	</div> 
	  
	  <div class="form-group">
	    <label for="dictionaryName"class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.name"></spring:message></label>
	    <div class="col-sm-8">
	    	<form:input path="name" class="required form-control" id="dictionaryName" />
	    </div>
	  </div>
	  
	  <c:if test="${dictionary.type eq 'D' }">
		  	<div class="form-group">
		    	<label for="dictionaryId" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.code"></spring:message></label>
			    <div class="col-sm-8">
			    	<form:input path="id" class="required form-control" id="dictionaryId"/>
			    </div>
			</div>
	  </c:if>
   	  <c:if test="${dictionary.type eq 'C' }">
   			<form:hidden path="id" id="dictionaryId"/>
   	  </c:if>
	  
	  <div class="form-group">
	    <label for="dictionaryDesc" class="col-sm-3 control-label"><spring:message code="tds.dictionary.label.description"></spring:message></label>
	    <div class="col-sm-8">
	    	<form:textarea rows="2" path="description" class="form-control" id="dictionaryDesc" />
	    </div>
	  </div>
	  <form:hidden path="parentId" id="dictionaryParentId"/>
	  <form:hidden path="sortOrder" id="dictionarySortOrder"/>
	  <form:hidden path="isValid" id="dictionaryIsValid"/>
	  <form:hidden path="treeCode" id="dictionaryTreeCode"/>
	  <form:hidden path="type" id="dictionaryType"/>
	  <input type="hidden" name="addOrUpdate" id="addOrUpdateDictionary" value="${addOrUpdate }"/>
	  <input type="hidden" name="originalId" id="originalDictionaryId" value="${dictionary.id }"/>
	</form:form>
	<script type="text/javascript">
		$(function(){
			$("#btnSave").off("click");
			$("#btnSave").on("click",saveDictionary);
			
			initValidate();
		});
	
		
		function saveDictionary(){
			if( $("#SaveDictionaryForm").valid() )
				doSave();
		}
		
		function doSave(){
			
			var id = $("#SaveDictionaryForm").find("input[name='id']").val();
			var originalId = $("#SaveDictionaryForm").find("input[name='originalId']").val();
			var name = $("#SaveDictionaryForm").find("input[name='name']").val();
			//var type = $("#SaveDictionaryForm").find("input[name='type']").val();
			var params = $("#SaveDictionaryForm").serialize();
			$.tdsAjax({
				url: ctx + getPath() + "/dictionary/saveDictionary.do",
				data: params,
				dateType: "json",
				cache:false,
				type: 'post',
				success: function(returnValue){
					var key = returnValue.KEY;
					if(key == 'SUCCESS'){
						var treeObj = $.fn.zTree.getZTreeObj("dictionaryTree");
						var treeNode = treeObj.getNodeByParam('id',id,null);
						var originalNode = treeObj.getNodeByParam('id',originalId,null);
						var newNode = returnValue.DICTIONARY;
						if( isNotEmpty(id) && treeNode ){
							treeNode.name = newNode.name;
							treeNode.id = newNode.id;
							treeObj.updateNode(treeNode);
						} else if( isNotEmpty(originalId) && originalNode ){
							originalNode.name = newNode.name;
							originalNode.id = newNode.id;
							treeObj.updateNode(originalNode);
						} else {
							var parentId = newNode.parentId;
							var parentNode = treeObj.getNodeByParam('id',parentId,null);
							if (parentNode) {
								var addNodes = treeObj.addNodes(parentNode, newNode);
								treeObj.selectNode(addNodes[0],false);
							} else {
								var addNodes = treeObj.addNodes(null, newNode);
								treeObj.selectNode(addNodes[0],false);
							}
						}
						toggleRootCreation("dictionaryTree",false);
						dictionaryClickEventHandler(newNode.id,newNode.params.type);
						
						showSuccess("<spring:message code="tds.menuRight.label.executeSuccess"/>");
					}else{
						showError( getResult(key) );
					}
					
					if(isNotEmpty(id)){
						var treeObj = $.fn.zTree.getZTreeObj("dictionaryTree");
						var treeNode = treeObj.getNodeByParam('id',id,null);
						treeNode.name=name;
						treeObj.updateNode(treeNode);
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
			//为inputForm注册validate函数
			$('#SaveDictionaryForm').validate({
				errorClass : 'help-block',
				focusInvalid : false,
				rules : {
					name:{
						required: true,
						maxlength : 64
					}
				},
				messages : {
					name:{
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