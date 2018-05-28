<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
	//要验证的控件和规则
	var rules = {};
	
	//验证提示信息
	var messages = {};
	
	//权限编号验证规则
	var rightCodeRules = {
		required: true,
		messages : {
			required:"权限编号不能为空！"
		}
	};


	$(function() {
		//初始化多语言
		initLanguageList();
	});
	
	/**
	 * 显示图标选择列表
	 */
	function showIconList() {
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
			message : $('<div></div>').load(ctx + "/admin/menuRight/showIconList.do"),
			buttons : [ {
				label : '<spring:message code="tds.common.label.submit"/>',
				cssClass : 'btn-primary',
				action : function(dialogItself) {

					//回填图标的路径到输入框中
					var icon = $("#iconListDiv .activity img").attr("icon");
					$("#smallIcon").val(icon);

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
	}
	
	/**
	 * 初始化表单验证
	 */
	function initVildateForm(){
		//为inputForm注册validate函数
		$('#menuRightForm').validate({
			errorClass : 'help-block',
			focusInvalid : false,
			rules : rules,
			messages : messages,

			highlight : function(element) {
				$(element).parent('div').addClass('has-error');
			},

			success : function(label) {
				label.parent('div').removeClass('has-error');
				label.remove();
			},

			errorPlacement : function(error, element) {
				element.parent('div').append(error);
			}
		});
	}
	
	/**
	 * 初始化多语言列表
	 */
	function initLanguageList(){
		var rightId = $("#rightId").val();
		$("#list").jqGrid({
			url:ctx + '/admin/menuRight/findMenuRightLangsByRightId.do?rightId='+rightId,//请求数据的url地址
			datatype: 'json',  //请求的数据类型
		   	colNames:[
		   	          '',
		   	          '<spring:message code='tds.common.label.lanauage'/>',
		   	          '<spring:message code='tds.common.label.lanauageCode'/>',
		   	          '<spring:message code='tds.dictionary.label.name'/>'], //数据列名称（数组）
		   	colModel:[ //数据列各参数信息设置
		   	    {name:'rightId',index:'rightId', hidden:true},
		   	    {name:'langName',index:'langName', align:'center', sortable:false},
				{name:'lang',index:'lang', align:'center', sortable:false},
		   		{name:'name',index:'name', align:'center', sortable:false, formatter:nameField}		
		   	],
		   	cellEdit : true,
			autowidth: true, //自动匹配宽度
			gridview:true, //加速显示
			loadComplete:function(data){ //完成服务器请求后，回调函数
				//初始化表单验证
				initVildateForm();
			
				//触发事件是否需要权限控制事件
				$("#isRight").change(function(){
					var isRight = $(this).val();
					
					//如果选择需要权限控制，就添加相应的验证规则
					if("Y" == isRight){
						$("#rightCode").rules("add",rightCodeRules);
					}else{
						$("#rightCode").rules("remove");
					}
				});
				$("#isRight").trigger("change");
			}
		});
		
		//窗口变化时自动适应大小
		$(window).bind('resize', function() {
			//$("#list").setGridWidth($("#tablePanel").width() - 5);
		}).trigger('resize');
		
		function nameField(cellvalue, options, rowObject){
			if(!cellvalue)
				cellvalue = '';
			
			//把控制加入到验证中
			var rule = {};
			rule.required = true;
			rule.maxlength = 25;
			rules[rowObject.lang] = rule;
			
			var message = {};
			message.required = "<spring:message code='tds.menuRight.message.nameCanNotEmpty'/>";
			message.maxlength = "<spring:message code='tds.menuRight.message.nameLimit25'/>";
			messages[rowObject.lang] = message;
			
			return "<div><input type='text' class='form-control input-sm' value='" + cellvalue + "' id='" + rowObject.lang + "' name='" + rowObject.lang + "'></div>";
		}
	}
</script>