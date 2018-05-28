<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
    $(function () {
        initValidate();
    });

    function initValidate(){
        //为inputForm注册validate函数
        validateForm = $('#selectDriverForm').validate({
            errorClass : 'help-block',
            focusInvalid : false,
            rules : {
                params : {
                    required : true,
                    maxlength : 1000
                }
            },
            messages : {
                params : {
                    required : "参数不能为为",
                    maxlength : "参数不能大于1000个文字！"
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
    }
    
    function setDefaultParam(driverConfigSelect){
    	var id = "driConf_" + driverConfigSelect.selectedIndex;
    	var defaultParams = $("#defaultParamsDIV").find("textarea");
    	
    	$.each(defaultParams,function(index,defaultParam){
    		if($(defaultParam).attr("id") == id)
    			$(defaultParam).show();
    		else
    			$(defaultParam).hide();
    	});
    }
</script>
<form id="selectDriverForm" class="form-horizontal">
	<input type="hidden" id="mapperId" name="mapperId"
		value="${activityDriverMapper.mapperId}">
	<div class="form-group">
		<label class="col-md-2 control-label">人员驱动</label>
		<div class="col-md-10">
			<select name="adapterId" class="form-control" onchange="setDefaultParam(this)">
				<c:forEach items="${driverConfigs}" var="driverConfig">
					<c:choose>
						<c:when
							test="${driverConfig.adapterId == activityDriverMapper.adapterId}">
							<option value="${driverConfig.adapterId}" selected>${driverConfig.adapterName}</option>
						</c:when>
						<c:otherwise>
							<option value="${driverConfig.adapterId}">${driverConfig.adapterName}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
	</div>

	<div class="form-group">
		<label class="col-md-2 control-label">默认参数</label>
		<div id="defaultParamsDIV" class="col-md-10">
			<c:forEach items="${driverConfigs}" var="driverConfig" varStatus="status">
				<c:choose>
					<c:when test="${status.index == 0}">
						<textarea id="driConf_${status.index}" class="form-control" readonly="readonly">${driverConfig.defaultParams}</textarea>
					</c:when>
					<c:otherwise>
						<textarea id="driConf_${status.index}" style="display: none;" class="form-control" readonly="readonly">${driverConfig.defaultParams}</textarea>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>

	<div class="form-group">
		<label class="col-md-2 control-label">参数</label>
		<div class="col-md-10">
			<textarea id="params" name="params" class="form-control" placeholder="请输入参数，格式为:{attrName1:value1,attrName2:value2}">${activityDriverMapper.params}</textarea>
		</div>
	</div>
</form>