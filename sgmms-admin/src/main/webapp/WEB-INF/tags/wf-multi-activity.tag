<%@tag pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@attribute name="taskId" required="true" type="java.lang.String" description="当前任务ID" %>
<%@attribute name="processDefinitionKey" required="true" type="java.lang.String" description="流程定义的key" %>
<%@attribute name="draftActivityId" required="true" type="java.lang.String" description="起稿节点定义的ID，当taskId有值时，将忽略此属性"%>
<%@attribute name="agreeActivityKeys" required="false" type="java.util.List" description="当同意时流程走的节点的key，只有showAgree为true时才有效" %>
<%@attribute name="rejectActivityKeys" required="false" type="java.util.List" description="当不同意时流程走的节点的key，只有showAgree为true时才有效" %>

<%@attribute name="showHistroty" required="false"  type="java.lang.Boolean" description="是否显示历史轨迹" %>
<%@attribute name="showAgree" required="false" type="java.lang.Boolean" description="是否显示选择处理结果" %>
<%@attribute name="showattachment" required="false" type="java.lang.Boolean" description="是否显示附件列表" %>
<%@attribute name="hideNextActKeys" required="false" type="java.util.List" description="需要隐藏的一下步骤的activity key集合" %>
<%@attribute name="deviceParams" required="false" type="java.util.Map" description="传送到驱动的其它参数" %>


<!-- 设置默认值  -->
<c:if test="${empty showHistroty}">
	<c:set var="showHistroty" value="true"/>
</c:if>

<c:if test="${empty showAgree}">
	<c:set var="showAgree" value="true"/>
</c:if>

<c:if test="${empty showattachment}">
	<c:set var="showattachment" value="true"/>
</c:if>

<style>
    .handlers {
    	margin-top:10px;
        padding:5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
        transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
        min-height:70px;
        height:100%;
		overflow:hidden;
    }
    
    .ui-jqgrid tr.jqgrow td {
        white-space:pre-line;
        text-align: center;
    }
	
	.atta-file {
	    position: absolute;
	    width: 98%;
	    height:34px;
	    z-index: 1000;
	    opacity: 0;
	}
	
	.atta .input-group-btn {
	    display: inline;
	}
</style>

<script type="text/javascript">
	$(function () {
	
		<c:if test="${showHistroty}">
	    //初始化历史处理步骤
	    initHandleHistoryList();
	    </c:if>
	
	    //初始化下一步骤处理信息
	    initNextHandleList();
	
	    //初始化附件信息列表
	    initAttachmentList();
	});

	function showError(message){
		BootstrapDialog.alert({
			type: BootstrapDialog.TYPE_DANGER,
			title: '<spring:message code="tds.common.label.alertTitle"/>',
			message: message,
			buttonLabel: '<spring:message code="tds.common.label.alertButtonText"/>'
		});
	}
	
	/**
	 * 初始化历史处理步骤
	 */
	function initHandleHistoryList(){
	    $("#handleHistoryList").jqGrid({
	        url:'${pageContext.request.contextPath}/admin/workflow/runtime/findProcessHistory.do?taskId=${pageScope.taskId}',//请求数据的url地址
	        datatype: 'json',  //请求的数据类型
	        colNames:[
	            '<spring:message code="tds.wf.label.activityName"/>',
	            '<spring:message code="tds.wf.label.activityHandler"/>',
	            '<spring:message code="tds.wf.label.activityCreateTime"/>',
	            '<spring:message code="tds.wf.label.activityHandleTime"/>',
	            '<spring:message code="tds.wf.label.activityHandleInfo"/>'
	        ], //数据列名称（数组）
	        colModel:[ //数据列各参数信息设置
	            {name:'name',index:'name'},
	            {name:'handler',index:'handler'},
	            {name:'createTime',index:'createTime'},
	            {name:'handleTime',index:'handleTime'},
	            {name:'handleInfo',index:'handleInfo'}
	        ],
	        rowNum:1000,//每页显示记录数
	        autowidth: true, //自动匹配宽度
	        height:150,   //设置高度
	        gridview:true, //加速显示
	        multiselect: false,
	        gridComplete:function(data){ //完成服务器请求后，回调函数
		        
	        }
	    });
	
	    //窗口变化时自动适应大小
	    $(window).bind('resize', function() {
	        $("#handleHistoryList").setGridWidth($("#handleHistoryPanel").width() - 3);
	    }).trigger('resize');
	}
	
	/**
	 * 初始化下一步骤处理信息
	 */
	function initNextHandleList(){
		var params = {processDefinitionKey:'${pageScope.processDefinitionKey}',currentActivityId:'${pageScope.draftActivityId}',taskId:'${pageScope.taskId}'};

		<c:if test="${! empty hideNextActKeys}">
			params.hideNextActKeys = [];
			<c:forEach items="${hideNextActKeys}" var="hideNextActKey">
				params.hideNextActKeys.push('${hideNextActKey}');
			</c:forEach>
		</c:if>
		
		<c:if test="${! empty deviceParams}">
			params.params = {};
			<c:forEach items="${deviceParams}" var="deviceParam">
				params.params["${deviceParam.key}"] = "${deviceParam.value}";
			</c:forEach>
		</c:if>

		
        $.tdsAjax({
            url : "${pageContext.request.contextPath}/admin/workflow/runtime/findNextActivity.do",
            type : "POST",
            dataType : "json",
            contentType : 'application/json',
            data:JSON.stringify(params),
            success : function(activityInfos) {
                if(activityInfos){
                    $.each(activityInfos,function(i,activityInfo){
						var checked = "";
						if(i == 0){
							checked = "checked";
						}
                        
						var activityDIV = createActivityDIV(activityInfo.id,activityInfo.name,activityInfo.multiSelect,checked,activityInfo.sendEmail);
						$("#activityDIV").append(activityDIV);
						
						if(activityInfo.nextHandlers){
							$.each(activityInfo.nextHandlers,function(index,nextHandler){

								var display = "none";
								
								if(i == 0)
									display = "block";

								var handlerDIV = createHandlesDIV(activityInfo.id,nextHandler.id,nextHandler.userName,display);
									
								$(".handlers").append(handlerDIV);
								
							});
						} 
                    });
                }

              //选择同意
              <c:if test="${showAgree}">
              	agreeChangeState('Y');
              </c:if>
            }
        });
	}

	function createActivityDIV(activityId,activityName,multiSelect,checked,sendEmail){
		var activityDIV =  "<div class='col-sm-2 radio'>"+
							  "<label>"+
							      "<input type='radio' value='" + activityId + "' multiSelect='" + multiSelect + "' name='nextActivityId' sendEmail='" + sendEmail + "' onclick='activityChangeState(\"" + activityId + "\")' " + checked + "> " + activityName +
							  "</label>"+
							"</div>";

		return activityDIV;
	}

	/**
	 * 建处理人DIV
	 */
	function createHandlesDIV(activityId,userId,userName,display){
		var disabled = "";
		if(display == "none")
			disabled = "disabled"
			
		
		var handlerDIV = "<div id='" + activityId + "' style='display:" + display + "'>"+
							"<div style='padding: 2px;' class='col-sm-2' id='" + activityId + "-" + userId + "'>"+
								"<button style='margin-right:5px;' class='close' type='button' onclick='removeHandler(this)'>"+
									"<span style='font-size:12px;top:0px;' aria-hidden='true'>X</span>"+
								"</button>"+
								"<div style='margin: 2px 0px 0px 0px;' class='alert alert-success'>"+
									"<div class='text-center'>" + userName + "</div>"+
									"<input type='hidden' value='" + userId + "' name='nextHandler' " + disabled + ">"+
								"</div>"+
							"</div>"+
						"</div>";

		return handlerDIV;
	}

	/**
	* 为某个流程节点设置任务处理人
	* @param activityId 节点定义ID 
	* @param users 要添加的用户对象，对象属性：{id,userName}
	*/
	function setHandler(activityId,users){
		if(users && users.length >0){
			//当前选择的节点
			var currentActivity = $("input[name='nextActivityId']:checked").val();

			//如果当前选择的节点是要设置任务人的节点，那么就显示任务人，否则隐藏
			var display;
			if(currentActivity == activityId)
				display = "block";
			else
				display = "none";
			
			var handllers = "";
			$.each(users,function(i,user){
				var handller = createHandlesDIV(activityId,user.id,user.userName,display);
				handllers += handller;
			});

			//清空当前原来的处理人
			$(".handlers div[id='" + activityId + "']").remove();

			
			$(".handlers").append(handllers);
		}
	}

	/**
	* 获取当前选择的节点
	*/
	function getCurrentActivityId(){
		return $("input[name='nextActivityId']:checked").val();
	}
	
	/**
	 * 移除处理者
	 */
	function removeHandler(targetSource){
	    $(targetSource).parent().remove();
	}
	
	/**
	 * 显示选择任务处理者窗口
	 */
	function showSelectHandlerWindow(){
		var multiSelect = $("#activityDIV :checked").attr("multiSelect");
		var activityId = $("#activityDIV :checked").val();
		
	    BootstrapDialog.show({
	        title : '<spring:message code="tds.wf.label.selectHandler"/>',
	        message: $('<div></div>').load('${pageContext.request.contextPath}/admin/workflow/runtime/goSelectHandler.do?multiSelect='+multiSelect),
	        buttons : [ {
	            label : '<spring:message code="tds.common.label.close"/>',
	            action : function(dialogItself) {
	                //关闭窗口
	                dialogItself.close();
	            }
	        },{
	            label : '<spring:message code="tds.common.label.submit"/>',
	            action : function(dialogItself) {
		            var rowIds = [];
		            if(multiSelect == 'Y'){
		            	rowIds = $('#userTable').jqGrid('getGridParam','selarrrow');
			        } else {
			        	rowIds[0] = $('#userTable').jqGrid('getGridParam','selrow');
				    }
	                
	                
	                if(rowIds && rowIds.length > 0) {
	                	//获取原来的数据
                        //var nextHandlersDIV = $(".handlers").html();
                        
	                    $.each(rowIds,function(index,rowId){
	                        var rowData = $('#userTable').jqGrid('getRowData',rowId);
	                        var userName = rowData.userName;
	                        var userId = rowData.userId;

	                     	//获取原来的数据
                        	var nextHandlersDIV = createHandlesDIV(activityId,userId,userName,"");
	                        
							//如果是多选，就把旧数据加上	
	                        if(multiSelect == 'Y'){
	                        	//判断当前处理人是否已存在
	    						var isHas = $(".handlers").find("div[id='" + userId + "']");
	    						if(!isHas.val()){
	    							$(".handlers").append(nextHandlersDIV);
	    						}
	                        }else{
	                        	$("#"+activityId).remove();
	                        	$(".handlers").append(nextHandlersDIV);
	                        }
	                    });
	                }
	
	                //关闭窗口
	                dialogItself.close();
	            }
	        }]
	    });
	}


	<c:if test="${showattachment}">
	
	/**
	 * 初始化附件信息列表
	 */
	function initAttachmentList(){
	    $("#attachmentList").jqGrid({
	        url:'${pageContext.request.contextPath}/admin/workflow/runtime/findAttachments.do?taskId=${pageScope.taskId}',//请求数据的url地址
	        datatype: 'json',  //请求的数据类型
	        colNames:[
	            '<spring:message code="tds.wf.label.attaName"/>',
	            '<spring:message code="tds.wf.label.uploadUser"/>',
	            '<spring:message code="tds.wf.label.uploadDate"/>',
	            '<spring:message code="tds.organization.label.remark"/>',
	            '<spring:message code="tds.wf.label.actions"/>'
	        ], //数据列名称（数组）
	        colModel:[ //数据列各参数信息设置
	            {name:'fileName',index:'fileName'},
	            {name:'editorName',index:'editorName'},
	            {name:'editDate',index:'editDate'},
	            {name:'remark',index:'remark'},
	            {name:'action',formatter:initAttaAction,width:75,algin:"center"}
	        ],
	        rowNum:1000,//每页显示记录数
	        autowidth: true, //自动匹配宽度
	        height:150,   //设置高度
	        gridview:true, //加速显示
	        multiselectWidth: 25, //设置多选列宽度
	        gridComplete:function(data){ //完成服务器请求后，回调函数
	        	
	        }
	    });
	
	    //窗口变化时自动适应大小
	    $(window).bind('resize', function() {
	        $("#attachmentList").setGridWidth($("#attachmentListPanel").width() - 3);
	    }).trigger('resize');
	}

	/**
	 * 初始化附件操作列
	 */
	function initAttaAction(cellvalue, options, rowObject){
		var btns;
		var downloadUrl = "${pageContext.request.contextPath}/admin/workflow/runtime/downloadFile.do?attaId="+rowObject.attaId;
		var downloadBtn = "<a class='btn btn-sm btn-primary' href='" + downloadUrl + "'><spring:message code='tds.attachment.label.download'/></a>";

		btns = downloadBtn;

		<%--
		var currentUserId = "${loginUser.id}";
		if(currentUserId == rowObject.editor){
			var deleteBtn = "<a id='"+ rowObject.attaId +"' class='btn btn-sm btn-primary' "+ 
							"data-toggle='confirmation' data-placement='left' "+
							"onclick='deleteAtta(\"" + options.rowId + "\",\"" + rowObject.attaId + "\")'><spring:message code='tds.common.label.delete'/></a>";
			btns = btns + " " + deleteBtn; 
		}
		--%>

		return btns;
	}
	
	/**
	 * 删除附件
	 */
	function deleteAtta(rowId,attaId){
		BootstrapDialog.confirm("<spring:message code='tds.wf.message.isDeleteAtta'/>", function(result){
			if(result) {
				$.tdsAjax({
    	            url : "${pageContext.request.contextPath}/admin/workflow/runtime/deleteAttachment.do",
    	            type : "POST",
    	            dataType : "json",
    	            data:{"attaId":attaId},
    	            success : function(result) {
    		            if(result.success){
    		            	 $("#attachmentList").jqGrid('delRowData',rowId);
    			        }else{
							showError(result.message);
						}
					}
				});
			}
        });
	}

	/**
	 * 添加附件控件
	 */
	function addAttaField(){
		var attaField = '<div class="form-group">'+
							'<div class="col-sm-1 control-label"><spring:message code="tds.wf.label.atta"/>:</div>'+
							'<div class="col-sm-4 attaFile">'+
								'<input type="file" onchange="setAttaFieldValue(this)" class="atta-file" name="wfAttachments">'+
								'<input type="text" class="form-control" placeholder=\"<spring:message code="tds.wf.message.clickSelectFile"/>\" disabled="disabled" name="attaText">'+
							'</div>'+
							'<div class="col-sm-1 control-label"><spring:message code="tds.organization.label.remark"/>:</div>'+
							'<div class="col-sm-4">'+
								'<input type="text" class="form-control" placeholder=\"<spring:message code="tds.wf.message.pleaseInputRemark"/>\" name="wfAttaRemark">'+
							'</div>'+
							'<div class="col-sm-1">'+
								'<button class="btn btn-default" onclick="removeAttaField(this)"><spring:message code="tds.common.label.delete"/></button>'+
							'</div>'+
						'</div>';

		$(".atta").append(attaField);
	}

	/**
	 * 移除附件控件
	 */
	function removeAttaField(attaField){
		$(attaField).parent().parent().remove()
	}

	function setAttaFieldValue(attaField){

		//检测是否有同名的附件，如果有就清空相关的控件值
		var attaFiles = $(".atta-file");
		if(attaFiles && attaFiles.length > 0){
			for(i=0;i<attaFiles.length;i++){
				var item = attaFiles[i];
				if(item != attaField && item.value == attaField.value){
					showError("<spring:message code='tds.wf.message.hadSameAtta'/>");
					
					return;
				}
			}
		}

		var attaGirdData = $("#attachmentList").jqGrid('getRowData');
		if(attaGirdData && attaGirdData.length > 0){
			for(j=0;j<attaGirdData.length;j++){
				var attachment = attaGirdData[j];
				if(attachment.fileName == attaField.value){
					showError("<spring:message code='tds.wf.message.hadSameAtta'/>");
					return;
				}
			}
		}
		
		$(attaField).parent().find("input[name=attaText]").val(attaField.value);
		$(attaField).parent().parent().find("input[name^=wfAttaRemark]").attr("name","wfAttaRemark_" + attaField.value);
	}
	
	</c:if>

	
	
	<c:if test="${showAgree}">
	/**
	 * 是否同意单选按钮点击事件
	 */
	function agreeChangeState(state) {
		var handleInfo = $("#handleInfo").val();

	    if("Y" == state){
	    	if(handleInfo && handleInfo == "<spring:message code='tds.wf.label.rejection'/>" || handleInfo.trim() == "")
	    		$("#handleInfo").val("<spring:message code='tds.wf.label.agree'/>");

	    	//显示所有节点
			if("${agreeActivityKeys}" == ""){
				showAllActivity();
			}else{
				var agreeActivityKeys = [];
				<c:if test="${! empty agreeActivityKeys}">
					<c:forEach items="${agreeActivityKeys}" var="agreeActivityKey">
						agreeActivityKeys.push('${agreeActivityKey}');
					</c:forEach>
				</c:if>

				toggleActivity(agreeActivityKeys);
			}
		}else{
			if(handleInfo && handleInfo == "<spring:message code='tds.wf.label.agree'/>" || handleInfo.trim() == "")
				$("#handleInfo").val("<spring:message code='tds.wf.label.rejection'/>");

			//显示所有节点
			if("${rejectActivityKeys}" == ""){
				showAllActivity();
			}else{
				var rejectActivityKeys = [];
				<c:if test="${! empty rejectActivityKeys}">
					<c:forEach items="${rejectActivityKeys}" var="rejectActivityKey">
						rejectActivityKeys.push('${rejectActivityKey}');
					</c:forEach>
				</c:if>

				toggleActivity(rejectActivityKeys);
			}
		}
	}

	/**
	* 当处理意见失去焦点时设置相应的值
	*/
	function setHandleInfo(){
		var handleInfo = $("#handleInfo").val();
		var state = $("input[name='agree']:checked").val();

		if(handleInfo && handleInfo.trim() == ""){
			if("Y" == state){
		    	$("#handleInfo").val("<spring:message code='tds.wf.label.agree'/>");
			}else{
				$("#handleInfo").val("<spring:message code='tds.wf.label.rejection'/>");
			}
		}
	}
	</c:if>

	/**
	 * 切换任务处理人
	 */
	function activityChangeState(activityId){
		var handlerDivs = $(".handlers").children();
		$.each(handlerDivs,function(i,handlerDiv){
			if($(this).prop("id") == activityId){
				$(this).show();
				$(this).find("input").removeProp("disabled");
			} else {
				$(this).hide();
				$(this).find("input").prop("disabled","disabled");
			}
		});

		//设置是否发送邮件的值
		var sendEmail = $("#activityDIV :checked").attr("sendEmail");
		if("Y" == sendEmail){
			$("#sendEmailDIV").show();
			$("#sendEmail").removeAttr("disabled");
		}else{
			$("#sendEmailDIV").hide();
			$("#sendEmail").attr("disabled","disabled");
		}
	}

	/**
	 * 切换任务处理人
	 */
	function toggleActivity(activityIds) {

		var activityRads = $("#activityDIV").find("input[type='radio']");

		//显示相应的节点
		for(i=0; i<activityIds.length; i++) {
			var activityId = activityIds[i];
			
			for(j=0; j<activityRads.length; j++) {
				var activityRad = activityRads[j];
				if(activityRad && activityRad != "undefined" && $(activityRad).val() == activityId){
					$(activityRad).parent().parent().show();

					//选中第一个节点
					if(i == 0){
						$(activityRad).prop("checked",true);
						$(activityRad).click();
					}

					//把已经显示的从数据组中删除，剩下的数组元素是要隐藏的节点
					delete activityRads[j];
					
					break;
				}
			}
		}

		//隐藏不相关的节点
		for(k=0; k<activityRads.length; k++) {
			var hideAactivity = activityRads[k];
			if(hideAactivity && hideAactivity != "undefined"){
				$(hideAactivity).parent().parent().hide();
			}
		}
	}

	/**
	 * 显示所有的节点
	 */
	function showAllActivity() {
		var activityRads = $("#activityDIV").find("input[type='radio']");
		
		for(i=0; i<activityRads.length; i++) {
			var activityRad = activityRads[i];
			$(activityRad).parent().parent().show();
		}
	}
</script>

<div>
    <input type="hidden" name="taskId" value="${pageScope.taskId}">
    
    <br>
    <span style="margin-top: 20px;"><spring:message code="tds.wf.label.workFlowInfo"/>：</span>
    
    <hr style="margin-top: 4px;">

	<c:if test="${showHistroty}">
	    <div class="panel panel-default">
	        <div class="panel-heading">
	 			<spring:message code="tds.wf.label.handleStep"/>
	        </div>
	        <div id="handleHistoryPanel" class="panel-body">
	            <table id="handleHistoryList"></table>
	        </div>
	    </div>
	    
	    <br>
    </c:if>


	<c:if test="${showAgree}">
	    <div class="panel panel-default">
	        <div class="panel-heading">
				<spring:message code="tds.wf.label.handleInfo"/>
	        </div>
	        <div class="panel-body">
	            <div class="form-group">
	                <div class="col-sm-2 control-label"><spring:message code="tds.wf.label.selectHandleMode"/></div>
	                <div class="col-sm-10">
	                    <div class="col-sm-1 radio">
	                        <label>
	                            <input type="radio" value="Y" name="agree" onclick="agreeChangeState('Y')" checked> <spring:message code="tds.wf.label.agree"/>
	                        </label>
	                    </div>
	
	                    <div class="col-sm-2 radio">
	                        <label>
	                            <input type="radio" value="N" name="agree" onclick="agreeChangeState('N')"> <spring:message code="tds.wf.label.rejection"/>
	                        </label>
	                    </div>
	                </div>
	            </div>
				
	            <div class="form-group">
	                <div class="col-sm-2 control-label"><spring:message code="tds.wf.label.handleInfo"/></div>
	                <div class="col-sm-10 control-label">
	                    <textarea class="form-control" id="handleInfo" name="handleInfo" onblur="setHandleInfo()"></textarea>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <br>
    </c:if>

    <div class="panel panel-default">
        <div class="panel-heading">
			<div class="panel-heading clearfix">
				<span class="pull-left" style="padding-top: 7.5px;"><b><spring:message code="tds.wf.label.TransitionInfo"/></b></span>
				<button type="button" class="btn btn-primary pull-right" onclick="showSelectHandlerWindow()">
					<spring:message code="tds.wf.label.addHandler"/>
				</button>
			</div>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-2 control-label"><spring:message code="tds.wf.label.nextStep"/></label>
                <div class="col-sm-10" id="activityDIV">
                    <!-- <div class="col-sm-2 radio">
                        <label>
                            <input type="radio" value="Y" name="nextSetup" onclick="activityChangeState('1')" checked> 部门审批
                        </label>
                    </div>

                    <div class="col-sm-2 radio">
                        <label>
                            <input type="radio" value="N" name="nextSetup" onclick="activityChangeState('2')"> 返回销售
                        </label>
                    </div>

                    <div class="col-sm-2 radio">
                        <label>
                            <input type="radio" value="N" name="nextSetup" onclick="activityChangeState('3')"> 财务审批
                        </label>
                    </div> -->
                </div>
            </div>
            
            <div id="sendEmailDIV" class="form-group">
            	<label class="col-sm-2 control-label"><spring:message code="tds.wf.label.sendEmail"/></label>
            	<div class="col-sm-10 checkbox">
           			<label style="margin-left: 5px">
           				<input type="checkbox" id="sendEmail" name="sendEmail" value="Y">
           			</label>
            	</div>
            </div>
			
            <div class="form-group">
                <label class="col-md-2 control-label"><spring:message code="tds.wf.label.handler"/></label>
				<div class="col-md-10">
					<div class="handlers">
						<!-- <div id="1">
							<div style="padding: 2px;" class="col-sm-2" id="ae4f9620988e45b091f918f5024c083d">
								<button style="margin-right:5px;" class="close" type="button" onclick="removeHandler('deparment_appraisal-ae4f9620988e45b091f918f5024c083d')">
									<span style="font-size:12px;top:0px;" aria-hidden="true">X</span>
								</button>
								<div style="margin: 2px 0px 0px 0px;" class="alert alert-success">
									<div class="text-center">小明</div>
									<input type="hidden" value="小明" name="nextHandler">
								</div>
							</div>
						</div>
						
						<div id="2" style="display: none;">
							<div style="padding: 2px;" class="col-sm-2" id="ae4f9620988e45b091f918f5024c083d">
								<button style="margin-right:5px;" class="close" type="button" onclick="removeHandler('deparment_appraisal-ae4f9620988e45b091f918f5024c083d')">
									<span style="font-size:12px;top:0px;" aria-hidden="true">X</span>
								</button>
								<div style="margin: 2px 0px 0px 0px;" class="alert alert-success">
									<div class="text-center">笨笨</div>
									<input type="hidden" value="笨笨" name="nextHandler">
								</div>
							</div>
						</div>
						
						<div id="3" style="display: none;">
							<div style="padding: 2px;" class="col-sm-2" id="ae4f9620988e45b091f918f5024c083d">
								<button style="margin-right:5px;" class="close" type="button" onclick="removeHandler('deparment_appraisal-ae4f9620988e45b091f918f5024c083d')">
									<span style="font-size:12px;top:0px;" aria-hidden="true">X</span>
								</button>
								<div style="margin: 2px 0px 0px 0px;" class="alert alert-success">
									<div class="text-center">小张</div>
									<input type="hidden" value="小张" name="nextHandler">
								</div>
							</div>
						</div> -->
					</div>
				</div>
            </div>
        </div>
    </div>

	<c:if test="${showattachment}">
		<br>
		
	    <div class="panel panel-default">
	        <div class="panel-heading">
				 <spring:message code='tds.wf.label.attaManage'/>
	        </div>
	        <div id="attachmentListPanel" class="panel-body">
	        	<br>
	        	<button type="button" class="btn btn-default btn-primary" onclick="addAttaField();">
	        		<spring:message code='tds.wf.label.addAtta'/>
	        	</button>
				<hr style="border-top:1px solid #CCCCCC;margin-top: 1px;margin-bottom: 10px;">
				
				<!-- <div class="atta">
					<div class="form-group">
						<div class="col-sm-2 control-label">附件名:</div>
						<div class="input-group col-sm-4">
							<input type="file" onchange="setAttaFieldValue(this)" class="atta-file" name="wfAttachments">
							<input type="text" class="form-control" placeholder="点击选择文件..." disabled="disabled" name="attaText">
							<span class="input-group-btn">
								<button class="btn btn-default" onclick="removeAttaField(this)">删除</button>
							</span>
						</div>
					
						<div class="col-sm-2 control-label">备注:</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="请输入备注" name="desc">
						</div>
					</div>
				</div> -->
				<div class="atta">
					<div class="form-group">
						<div class="col-sm-1 control-label"><spring:message code='tds.wf.label.atta'/>:</div>
						<div class="col-sm-4 attaFile">
							<input type="file" onchange="setAttaFieldValue(this)" class="atta-file" name="wfAttachments">
							<input type="text" class="form-control" placeholder="<spring:message code='tds.wf.message.clickSelectFile'/>" disabled="disabled" name="attaText">
						</div>
					
						<div class="col-sm-1 control-label"><spring:message code='tds.organization.label.remark'/>:</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="<spring:message code='tds.wf.message.pleaseInputRemark'/>" name="wfAttaRemark">
						</div>
						
						<div class="col-sm-1">
							<button class="btn btn-default" onclick="removeAttaField(this)">
								<spring:message code="tds.common.label.delete"/>
							</button>
						</div>
					</div>
				</div>
	        	
	        	<br><br>
	        
	        	<spring:message code="tds.wf.label.attaList"/>：
	        	<hr style="border-top:1px solid #CCCCCC;margin-top: 1px;margin-bottom: 10px;">
	            <table id="attachmentList"></table>
	        </div>
	    </div>
    </c:if>
</div>