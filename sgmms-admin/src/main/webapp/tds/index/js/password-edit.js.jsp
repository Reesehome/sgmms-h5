<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
$(function(){
	//为inputForm注册validate函数
	$('#passwordForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 oldPassword : {
                 required : true,
                 maxlength : 30
             },
             newPassword : {
            	 required : true,
            	 maxlength : 30
             },
             newPassword2 : {
            	 required : true,
            	 maxlength : 30,
            	 equalTo : "#newPassword"
             }
         },
         messages : {
        	 oldPassword : {
                 required : "旧密码不能为空！",
                 maxlength : "旧密码不能大于30个文字！"
             },
             newPassword : {
                 required : "新密码不能为空！",
                 maxlength : "新密码不能大于30个文字！"
             },
             newPassword2 : {
            	 required : "新密码确认不能为空！",
            	 maxlength : "新密码确认不能大于30个文字！",
            	 equalTo : "两次输入密码不一致！"
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