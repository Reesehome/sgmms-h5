<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">

/************************系统参数 编辑页面js************************************************/

var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#editForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 propKey : {
                 required : true,
                 maxlength : 32,
                 remote:{
						type:"post",
						url:ctx + "/admin/sysProperty/isExists.do",
						data:{
							id:function(){
								return $("#key").val();
							},
							oldId:function(){
								return $("#propKey-old").val();
							}
						},
						dataFilter:function(data, type){
							if(data=="false"){//false, code 重复

								return false;
							}else{
								$("#key-error").parent().removeClass('has-error');
								$("#key-error").remove();
								return true;
							}
						}
					}
             },
             propValue : {
            	 required : true,
            	 maxlength : 32
             },
             remark:{
            	 maxlength : 60
             }
         },
         messages : {
        	 propKey : {
                 required : '<spring:message code="tds.sys.property.keynonull"/>',
                 remote: '<spring:message code="tds.dataRight.label.Exists"/>',
                 maxlength : '<spring:message code="tds.sys.property.key32"/>'
             },
             propValue : {
            	 required : '<spring:message code="tds.sys.property.valuenonull"/>',
            	 maxlength: '<spring:message code="tds.sys.property.value32"/>'
             },
             remark:{
            	 maxlength: '<spring:message code="tds.sys.property.remark60"/>'
             }
         },

         highlight : function(element) {
             $(element).closest('.form-group').addClass('has-error');
         },

         success : function(label) {
             label.closest('.form-group').removeClass('has-error');
             label.remove();
         },

         errorPlacement : function(error, element) {
             element.parent('div').append(error);
         }
     });
	
	if($("#deletable").val()=="" || $("#deletable").val()==null){
		$("#deletable").val("Y");
	}
});
</script>