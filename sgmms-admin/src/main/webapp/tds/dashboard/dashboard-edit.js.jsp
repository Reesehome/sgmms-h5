<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
(function($) {
	//要验证的控件和规则
	var rules = {
			dbIcon : {
				required : true
			},
			margin : {
				required : true,
				digits : true,
				min : 0
			},
			baseWidth : {
				required : true,
				digits : true,
				min : 0
			},
			baseHeight : {
				required : true,
				digits : true,
				min : 0
			}
	};
	//验证提示信息
	var messages = {};
	
	//国际化语言列表
	$("#langList").jqGrid({
		url:ctx + '/admin/dashboard/findDashboardLangsByDbId.do?dbId=${dbId}',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
	   	colNames:[
			'',
			'<spring:message code="tds.common.label.lanauage"/>',
			'<spring:message code="tds.common.label.lanauageCode"/>',
			'<spring:message code="tds.dictionary.label.name"/>'], //数据列名称（数组）
		colModel:[ //数据列各参数信息设置
			{name:'dbId', index:'dbId', hidden:true},
			{name:'langName', index:'langName', align:'center', sortable:false},
			{name:'lang',index:'lang', align:'center', sortable:false},
			{name:'dbName',index:'dbName', align:'center', sortable:false, formatter:nameField}		
		],
	   	cellEdit : true,
		autowidth: true, //自动匹配宽度
		gridview:true, //加速显示
		loadComplete:function(data){ //完成服务器请求后，回调函数
			//为inputForm注册validate函数
			$('#dashboardForm').validate({
				errorClass : 'help-block',
				focusInvalid : false,
				rules : rules,
				messages : messages,
				highlight : function(element) {
					if($(element).parent('div').hasClass("input-group")) {
						$(element).parent('div').parent('div').addClass('has-error');
					}else {
						$(element).parent('div').addClass('has-error');
					}
				},
				success : function(label) {
					label.parent('div').removeClass('has-error');
					label.remove();
				},
				errorPlacement : function(error, element) {
					if($(element).parent('div').hasClass("input-group")) {
						element.parent('div').parent('div').append(error);
					}else {
						element.parent('div').append(error);
					}
				}
			});
		}
	});
	
	//窗口变化时自动适应大小
	$(window).bind('resize', function() {$("#langList").jqGrid('setGridWidth', 338);}).trigger('resize');
	
	function nameField(cellvalue, options, rowObject){
		if(!cellvalue)
			cellvalue = '';
		
		//把控制加入到验证中
		var rule = {};
		rule.required = true;
		rule.maxlength = 25;
		rules[rowObject.lang] = rule;
		
		return "<div><input type='text' class='form-control input-sm' value='" + cellvalue + "' id='" + rowObject.lang + "' name='" + rowObject.lang + "'></div>";
	}
	
	//选择图标
	$("#btnSelectIcon").on("click", function() {
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
			message : $('<div></div>').load(ctx + "/admin/menuRight/showIconList.do"),
			buttons : [ {
				label : '<spring:message code="tds.common.label.submit"/>',
				cssClass : 'btn-primary',
				action : function(dialogItself) {

					//回填图标的路径到输入框中
					var icon = $("#iconListDiv .activity img").attr("icon");
					$("#dbIcon").val(icon);

					//关闭窗口
					dialogItself.close();
				}
			}, {
				label : '<spring:message code="tds.common.label.close"/>',
				action : function(dialogItself) {
					dialogItself.close();
				}
			} ]
		});
	});
})($)
</script>