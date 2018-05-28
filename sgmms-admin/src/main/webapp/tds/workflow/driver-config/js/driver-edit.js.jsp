<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#driverConfigForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
             adapterId : {
                 required : true,
                 maxlength : 255
             },
             adapterName : {
                 required : true,
                 maxlength : 255
             },
             className : {
                 required : true,
                 maxlength : 255
             },
             defaultParams : {
                 required : true,
                 maxlength : 255
             }
         },
         messages : {
             adapterId : {
                 required : "驱动编号不能为为",
                 maxlength : "驱动编号不能大于255个文字！"
             },
             adapterName : {
            	 required : "驱动名字不能为空！",
                 maxlength : "驱动名字不能大于255个文字！"
             },
             className : {
                 required : "处理类不能为空！",
                 maxlength : "处理类不能大于255个文字！"
             },
             defaultParams : {
                 required : "缺省参数不能为空！",
                 maxlength : "缺省参数不能大于255个文字！"
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
             element.parent('div').parent('div').append(error);
         }
     });
});
</script>