<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
$(function(){
	//为inputForm注册validate函数
	 $('#depEditForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 orgName : {
                 required : true
             },
             typeId : {
                 required : true
             }
         },
         messages : {
        	 orgName : {
                 required : "<spring:message code='tds.organization.message.orgname.notnull'/>"
             },
             typeId : {
                 required : "<spring:message code='tds.organization.message.orgtype.notnull'/>"
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
	
	//部门编号聚焦事件
	$("#orgId").bind("focus", function() {
		if($("#operateFlag").val() == 'A') {
			var label = $("#orgId-error");
			if(label) {
				label.closest('div').removeClass('has-error');
	            label.remove();
			}
		}
	});
	
	//部门编号失去焦点事件
	$("#orgId").bind("blur", function() {
		//新增时才做处理
		if($("#operateFlag").val() == 'A') {
			var _orgId = $.trim($("#orgId").val());
			if(_orgId === '') {
				return;
			}
			$.tdsAjax({
				url:ctx + "/admin/organization/findOrgIdIsUnique.do",
				cache : false,
				dataType : "json",
				type : "POST",
				data : {orgId : _orgId},
				success: function(result) {
					if(!result.success) {
						$("#orgId").closest('div').addClass('has-error');
						var label = $("<label></label>").attr("id", "orgId-error").addClass("help-block").text("<spring:message code='tds.organization.message.enter.again'/>");
						$("#orgId").parent('div').append(label);
					}
				}
			});
		}
	});
	
	
	
	
	
	
	
	
});

</script>