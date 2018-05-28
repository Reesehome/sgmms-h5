<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css">
.table-attachment {
	width: 300px;
}

.tr-attachment {
	display: none;
}

.td-attachment {
	width: 300px;
	height: 60px;
}
</style>
<link href="${ctx}/tds/static/attachment/uploadify.css" rel="stylesheet"
	type="text/css" />
<script src="${ctx}/tds/static/attachment/jquery.uploadify.js"></script>
<%-- <script src="${ctx}/tds/static/attachment/jquery.uploadify.min.js"></script> --%>
<script src="${ctx}/tds/static/attachment/BigDecimal-all-last.min.js"></script>
<script type="text/javascript">

		var fileSize = 5242880;//默认为5*1024*1024 , 5M
		var fileType = "0";//默认上传文件类型
		var buttonText = '<spring:message code="tds.attachment.label.upload"/>'//默认上传按钮名称
		var fileTypeExts = '*.*';//默认为所有格式
		var dataImportType = "";//页面调用，一个参数
		
		
		$(document).ready(function() {  
			
			var attachmentTitle = '${param.attachmentTitle}';//设置标题（默认隐藏）
			var attachmentWidth = '${param.attachmentWidth}';//配置宽度（默认是300px）
			var attachmentSize = '${param.attachmentSize}';//上传文件大小(默认是5M,默认单位为B)
			var attachmentType = '${param.attachmentType}';//附件类型
			var attachmentButtonName = '${param.attachmentButtonName}';//按钮名称
			var attachmentTypeExts = '${param.attachmentTypeExts}';//文件格式（例如：'*.doc;*.pdf;*.rar',多个格式用分号隔开）
			
            if(attachmentTitle){
            	$(".tr-attachment").css({display:"inline-block"});
            	$("#title-attachment")[0].innerHTML = attachmentTitle;
            }
            if(attachmentWidth){
				$(".table-attachment").css({width:attachmentWidth});
			}
			if(attachmentSize){
				fileSize = attachmentSize;
			}
            if(attachmentType){
            	fileType = attachmentType;
            }
            if(attachmentButtonName){
            	buttonText = attachmentButtonName;
            }
            if(attachmentTypeExts){
            	fileTypeExts = attachmentTypeExts;
            }
            
            
            //下面写的方法，是单一上传文件，需要并发上传，则要另写
            var url = "${ctx}/admin/attachment/uploadFile.do";
             $("#uploadify").uploadify({
                 'uploader': url,
                 'swf': '${ctx}/tds/static/attachment/uploadify.swf',
                 'cancelImage': '${ctx}/tds/static/attachment/uploadify-cancel.png',
                 'queueID': 'fileQueue',
                 'fileSizeLimit' : fileSize ,
                 'multi': false,
                 'method': 'post',
                 'queueSizeLimit': 1,
                 'fileTypeExts':fileTypeExts,
                 'buttonText': buttonText,
                 'formData':{},
                 'onDialogClose':function (filesSelected, filesQueued, queueLength){
                	 if (this.queueData.filesErrored > 0) {
                		 option('<spring:message code="tds.attachment.label.fileFormat"/>' + fileTypeExts); 
     				}
                 },
                 'onSelect': function (file) {
                	 if(file.size > fileSize){//验证文件大小
                		 var size = new BigDecimal(fileSize);
                		 var excess = size.divide(new BigDecimal("1024"),2,BigDecimal.ROUND_HALF_UP).
                		 			divide(new BigDecimal("1024"),2,BigDecimal.ROUND_HALF_UP).toString();
                		 option('<spring:message code="tds.attachment.label.fileSize"/>' + excess + "M."); 
                		 $("#uploadify").uploadify('cancel', '*');//结束上传
                	 }else{
                		 $("#uploadify").uploadify('upload', '*');//上传
                	 }
                 },
                 'onUploadStart': function (file) {
                	 var element = {};
                	 element.fileType = fileType;
                	 element.objectType = dataImportType;
                	 $('#uploadify').uploadify('settings','formData',element);
                     //在onUploadStart事件中，也就是上传之前，把参数写好传递到后台。  
                	 
                	 $("#uploadify").uploadify('disable', true);
                	 $('#fileQueue').attr('style', 'top:200px;left:400px;width:400px;height :400px;visibility :visible');
                 },
                 'onUploadSuccess':function (file, data, response){
                	 $("#uploadify").uploadify('disable', false);
                	 $('#fileQueue').find('#'+file.id).remove();
                	 
                	 if(data == "1"){//上传文件成功并提示
                		 
                		 option('<spring:message code="tds.attachment.label.uploadSuccess"/>'); 
                	 }else if(data == "2"){//上传文件成功不提示
                		 
                	 }else if(data == "-2"){//非模版文件
//                 		 option('<spring:message code="tds.attachment.label.systemException"/>'); 
                		 alert("非模版文件");
                	 }
                	 else{//上传文件失败提示
                		 alert(data);
                		 option('<spring:message code="tds.attachment.label.systemException"/>'); 
                	 }
                 },
                 'onSelectError': function (file, errorCode, errorMsg) {
                	 if(errorCode != -130){
                		 option('<spring:message code="tds.attachment.label.uploadError"/>'); 
                	 }
                	 $("#uploadify").uploadify('disable', false);
                	 $('#fileQueue').find('#'+file.id).remove();
                 }
             });
             
//              $("#uploadify-button").removeClass("uploadify-button");
//              $("#uploadify-button").addClass("btn btn-primary");
//              $("#uploadify-button").css({"line-height": "initial",height: 34,width: 54});
		
		
		});
		
		
		
		
	function option(value){
		BootstrapDialog.show({
			title: '<spring:message code="tds.attachment.label.systemPrompt"/>',
            size: BootstrapDialog.SIZE_SMALL,
            type : BootstrapDialog.TYPE_WARNING,
            message: value,
            buttons: [{
                label: '<spring:message code="tds.common.label.close"/>',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
		
	}		
</script>


<div id="div-attachment">
	<table class="table-attachment">
		<tr class="tr-attachment ">
			<td id="title-attachment"></td>
		</tr>
		<tr>
			<td><input type="file" id="uploadify" name="uploadify" /><br /></td>
		</tr>
		<tr>
			<td class="td-attachment">
				<div id="fileQueue"></div>
			</td>
		</tr>
	</table>

</div>
