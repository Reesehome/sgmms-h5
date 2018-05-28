<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#demoForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
             title : {
                 required : true,
                 maxlength : 25
             },
             price : {
            	 required : true,
            	 number : true,
            	 min : 0
             }
         },
         messages : {
             title : {
                 required : "标题不能为空！",
                 maxlength : "标题不能大于25个文字！"
             },
             price : {
            	 required : "价格不能为空！",
            	 number : "价格必须为数字！",
            	 min : "价格必须大于等于0！"
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