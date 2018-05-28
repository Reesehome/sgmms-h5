<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
$(function(){
	var oldLoginName = $("#oldLoginName").val();
	var userId = $("#userId").val();
	
	//为inputForm注册validate函数
	 $('#userEditForm').validate({
         errorClass : 'help-block',
         focusInvalid : true,
         rules : {
        	 userType : {
                 required : true
             },
             userName : {
                 required : true
             },
             loginName : {
                 required : true,
                 remote: {
					url: "${ctx}/admin/orguser/isExistLoginName.do",
					type: "post",
					dataType: "json",
					data: {
						loginName : function () {
							return $("#loginName").val();
						}
                    },
					dataFilter: function (data) {
						var loginName = $("#loginName").val();
						if (data == "true") {
							if(userId == "")
								return false;
							else if(oldLoginName == loginName)
								return true;
							else 
								return false;
						}else {
							return true;
						}
					}
				}
			}
         },
         messages : {
        	 userType : {
                 required : "<spring:message code='tds.user.message.usertype.notnull' />"
             },
             loginName : {
                 required : "<spring:message code='tds.user.message.loginname.notnull' />",
                 remote:"登录名已存在！"
             },
             userName : {
                 required : "<spring:message code='tds.user.message.username.notnull' />"
             }
         },
         highlight : function(element) {
             $(element).closest('div').addClass('has-error');
         },
         success : function(label) {
             label.closest('div').removeClass('has-error');
             label.remove();
         },
         errorPlacement : function(error, element) {
             element.parent('div').append(error);
         }
     });
	
	//初始化时间组件
	$("#employDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1});
	$("#expiredDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1});
	
	//初始化值
	var employDate = '${orgUser.employDate}';
	if(employDate) {
		$("#employDate").val(employDate.substring(0, 10));
	}
	var expiredDate = '${orgUser.expiredDate}';
	if(expiredDate) {
		$("#expiredDate").val(expiredDate.substring(0, 10));
	}
	
	
	var isRequestInputUserRdn=$("#isRequestInputUserRdn").val();
	if(isRequestInputUserRdn=="Y"){
		$("#userRdn").rules("add",{required:true});
	}
	
});

</script>