<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#modelForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 name : {
                 required : true,
                 maxlength : 32
             },
             key : {
            	 required : true,
            	 maxlength : 32,
            	 remote:{
						type:"post",
						url:ctx + "/admin/workflow/model/isExists.do",
						data:{
							id:function(){
								return $("#key").val();
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
             description:{
            	 maxlength : 60
             }
         },
         messages : {
        	 name : {
                 required : '不能为空！',
                 maxlength : '长度不能超过32个文字'
             },
             key : {
            	 required : '不能为空',
            	 maxlength: '长度不能超过32个文字',
            	 remote: "已经存在！"
             },
             description:{
            	 maxlength: '长度不能超过60个文字'
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
	
	
});
</script>