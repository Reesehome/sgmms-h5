<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
$(function () {
	$("#dashboardTable").jqGrid({
		url:ctx + '/admin/dashboard/findDashboard.do',//请求数据的url地址
		datatype: 'json',  //请求的数据类型
		mtype: 'post',
		colNames:[
			'dbId',
			'userId',
			'默认名称',
			'面板图标',
			'组件间距',
			'组件基本宽度',
			'组件基本高度'
		], //数据列名称（数组）
		colModel:[//数据列各参数信息设置
			{name:'dbId', index:'dbId', hidden:true},
			{name:'userId', index:'userId', hidden:true},
			{name:'dbName',index:'dbName', width:80, align:'center', sortable:false},
			{name:'dbIcon',index:'dbIcon', width:180, sortable:false},
			{name:'margin',index:'margin', width:40, align:'center', sortable:false},
			{name:'baseWidth',index:'baseWidth', width:40, align:'center', sortable:false},
			{name:'baseHeight',index:'baseHeight', width:40,align:'center', sortable:false}
		],
	   	rowNum:10,//每页显示记录数
	   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
	   	pager : '#dashboardGridpager',  //表格数据关联的分页条，html元素
		autowidth: true, //自动匹配宽度
		height:400,   //设置高度
		gridview:true, //加速显示
	    viewrecords: true,  //显示总记录数
		multiselect: true,  //可多选，出现多选框
		multiselectWidth: 25, //设置多选列宽度
		loadComplete:function(data){ //完成服务器请求后，回调函数
		}
	});
	
	//新增面板
	$("#dashboardAdd").on("click", function() {
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
	        message: $('<div></div>').load(ctx + "/admin/dashboard/showDashboardEditPage.do"),
	        buttons : [
				{
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass: 'btn-primary',
					action : saveDashboard
				},{
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself){
						dialogItself.close();
					}
				}
	        ]
	    });
	});
	
	//编辑面板
	$("#dashboardEdit").on("click", function() {
		//必须有选择面板
		var selectId = $("#dashboardTable").jqGrid("getGridParam", "selrow");
		if(selectId == null || selectId.length <= 0) {
			BootstrapDialog.show({
				title: '<spring:message code="tds.common.label.errorMessage"/>',
				size: BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_SUCCESS,
				message: "请选择编辑面板",
				buttons: [{
					label: '<spring:message code="tds.common.label.close"/>',
					action: function(_dialogItself){
						_dialogItself.close();
					}
				}]
			});
			return;
		}
		//获取选中行的数据
		var rowData = $("#dashboardTable").jqGrid("getRowData", selectId);
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
	        message: $('<div></div>').load(ctx + "/admin/dashboard/showDashboardEditPage.do?dbId=" + rowData.dbId),
	        buttons : [
				{
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass: 'btn-primary',
					action : saveDashboard
				},
				{
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself){
						dialogItself.close();
					}
				}
	        ]
	    });
	});
	
	/**
	* 保存面板信息
	*/
	function saveDashboard(dialogItself) {
		if(!document.getElementById("dashboardForm"))
			return;
		
		//表单验证不通过退出方法
		if (!$("#dashboardForm").valid()) {
			/*
			BootstrapDialog.show({
				title : '<spring:message code="tds.common.label.warningTitle"/>',
				size : BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_WARNING,
				message : '<spring:message code="tds.common.message.formValidIncorrect"/>',
				buttons : [ {
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself) {
						//关闭窗口
						dialogItself.close();
					}
				}]
			});
			*/
			return;
		}
		
		//获取要提交的参数
		var params = $("#dashboardForm").serializeJson();
		var dashboardLangs = $("#langList").jqGrid("getRowData");
		if(dashboardLangs && dashboardLangs.length > 0){
			$.each(dashboardLangs, function(i, dashboardLang){
				//把现在最新的值替换到参数中
				dashboardLang.dbName = $("#" + dashboardLang.lang).val();
				
				//删除多余的参数
				delete params[dashboardLang.lang];  
			});
			params.dashboardLangs = dashboardLangs;
		}
		$.ajax({
			url : ctx + "/admin/dashboard/saveDashboard.do",
			cache : false,
			contentType : 'application/json',
			dataType : "json",
			data : JSON.stringify(params),
			type : "POST",
			success : function(result){
				if(result.success) {
					dialogItself.close();
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.systemMessage"/>',
						size: BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_SUCCESS,
						message: result.message,
						buttons: [{
							label: '<spring:message code="tds.common.label.close"/>',
							action: function(_dialogItself){
								_dialogItself.close();
							}
						}]
					});
					
					$("#dashboardTable").trigger("reloadGrid");
				} else{
					BootstrapDialog.show({
					title: '<spring:message code="tds.common.label.errorMessage"/>',
					size: BootstrapDialog.SIZE_SMALL,
					type : BootstrapDialog.TYPE_WARNING,
					message: result.message,
						buttons: [{
							label: '<spring:message code="tds.common.label.close"/>',
							action: function(dialogItself){
							    dialogItself.close();
							}
						}]
					});
				}
			}
		});
	}
	
	//面板组件编辑
	$("#dashboardWidgetEdit").on("click", function() {
		//必须有选择面板
		var selectId = $("#dashboardTable").jqGrid("getGridParam", "selrow");
		if(selectId == null || selectId.length <= 0) {
			BootstrapDialog.show({
				title: '<spring:message code="tds.common.label.errorMessage"/>',
				size: BootstrapDialog.SIZE_SMALL,
				type : BootstrapDialog.TYPE_SUCCESS,
				message: "请选择编辑面板",
				buttons: [{
					label: '<spring:message code="tds.common.label.close"/>',
					action: function(_dialogItself){
						_dialogItself.close();
					}
				}]
			});
			return;
		}
		//获取选中行的数据
		var rowData = $("#dashboardTable").jqGrid("getRowData", selectId);
		var _url = ctx + "/admin/dashboard/showDashboardWidgetEditPage.do",
		$form = $("<form></form>");
		$form.attr("action", _url);
		$form.attr("method", "post");
		$input1 = $("<input type='hidden' name='dbId' />")
		$input1.attr("value", rowData.dbId);
		$form.append($input1)
		$input2 = $("<input type='hidden' name='isFirstLoad' />")
		$input2.attr("value", "true");
		$form.append($input2)
		$form.appendTo("body")
		$form.css('display','none')
		$form.submit()
	});
	
	//删除面板
	$('#dashboardDelete').confirmation({
		title:'<spring:message code="tds.common.message.confirmDelete"/>',
		btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
		btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
		placement : "left",
		onShow : function() {
			var ids = $("#dashboardTable").jqGrid('getGridParam', 'selarrrow');
			if(ids == '') {
				BootstrapDialog.show({
					title: '<spring:message code="tds.common.label.systemMessage"/>',
					size: BootstrapDialog.SIZE_SMALL,
					type : BootstrapDialog.TYPE_WARNING,
					message: '<spring:message code="tds.common.message.select.delete.record"/>',
					buttons: [{
						label: '<spring:message code="tds.common.label.close"/>',
						action: function(dialogItself) {
							dialogItself.close();
						}
					}]
				});
				return false;
			}
			return true;
		},
		onConfirm : function() {
			var ids = $("#dashboardTable").jqGrid('getGridParam', 'selarrrow');
			var values = [];
			$(ids).each(function(index, value) {
				var rowData = $("#dashboardTable").jqGrid("getRowData", value);
				values.push(rowData.dbId);
			});
			var params = $.param({dbIds : values}, true);
			
			$.tdsAjax({
				url: ctx + "/admin/dashboard/deleteDashboard.do",
				cache : false,
				dataType : "json",
				data : params,
				type : "POST",
				success : function(result){
					if(result.success) {
						$("#dashboardTable").trigger("reloadGrid");
					}else {
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself){
				                    dialogItself.close();
				                }
				            }]
				        });
					}
				}
			});
		}
	});
});

</script>