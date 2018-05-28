<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
${javascript}
$(function(){
	${initBeginJS}
	
	function initEndJS() {
		${initEndJS}
	}
	
	var gridster_options = {
			widget_margins: [${margin}, ${margin}],
			widget_base_dimensions: [${baseWidth}, ${baseHeight}],
			resize: {enabled: true},
			serialize_params : function($w, wgd) {
				return {
						posX: wgd.col,
						posY: wgd.row,
						sizeX: wgd.size_x,
						sizeY: wgd.size_y,
						widgetId : $w.attr("id").replace(/li_/ig, "") ,
						dbId : "${dbId}"
					}; 
			}
		};
	
	var gridster = $(".gridster > ul").gridster(gridster_options).data('gridster');
	
	var widgets = [${widgetContext}];
	$.each(widgets, function(i, widget) {
		gridster.add_widget.apply(gridster, widget)
	});
	initEndJS();
	
	//扩展jQuery方法 refreshGridster ，刷新gridster
	$.extend({
		refreshGridster : function() {
			gridster.destroy(true);
			$("<ul></ul>").appendTo($(".gridster"));
			gridster = $(".gridster > ul").gridster(gridster_options).data('gridster');
			$.each(widgets, function(i, widget){
				gridster.add_widget.apply(gridster, widget)
			});
			initEndJS();
		}
	});
	
	//组件编辑
	$("#widgetAdd").on("click", function() {
		var existId = [];
		$.each(gridster.serialize(), function(index, value) {
			existId.push(value.widgetId);
		});
		
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
	        message: $('<div></div>').load(ctx + "/admin/dashboard/showWidgetEditPage.do", {selectId : existId.join(",")}),
	        buttons : [
				{
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass: 'btn-primary',
					action : showSelected
				},{
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself){
						dialogItself.close();
					}
				}
	        ]
	    });
	});
	
	/**
	* 显示组件信息
	*/
	function showSelected(dialogItself) {
		var tree = $.fn.zTree.getZTreeObj("widget-selected-tree");
		if(!tree) {
			return;
		}
		var url = ctx + "/admin/dashboard/showDashboardWidgetEditPage.do",
		$form = $("<form></form>");
		$form.attr("action", url);
		$form.attr("method", "pose");
		$input1 = $("<input type='hidden' name='dbId' />")
		$input1.attr("value", "${dbId}");
		$form.append($input1)
		var checkNodes = tree.getCheckedNodes(true);
		if(checkNodes) {
			$.each(checkNodes, function(i, value) {
				$input = $("<input type='hidden' name='widgetIds' />")
				$input.attr("value", value.id);
				$form.append($input)
			})
		}
		$form.appendTo("body")
		$form.css('display','none')
		$form.submit()
	}
	
	//组件配置保存
	$("#widgetSave").on("click", function() {
		var values = gridster.serialize();
		$.ajax({
			url:ctx + "/admin/dashboard/saveDashboardToWidget.do",
			type : "POST",
			cache : false,
			contentType : 'application/json',
			dataType : "json",
			data : JSON.stringify({dbId : "${dbId}", dashboardToWidgets : values}),
			success: function(result) {
				if(result.success) {
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.alertTitle"/>',
			            size: BootstrapDialog.SIZE_SMALL,
			            type : BootstrapDialog.TYPE_INFO,
			            message: result.message,
			            buttons: [{
			                label: '<spring:message code="tds.common.label.close"/>',
			                action: function(dialogItself) {
			                    dialogItself.close();
			                }
			            }]
			        });
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
	});
	
	//返回
	$("#widgetBack").on("click", function() {
		var url = ctx + "/admin/dashboard/listDashboard.do",
		$form = $("<form></form>");
		$form.attr("action", url);
		$form.attr("method", "post");
		$form.appendTo("body")
		$form.css('display','none')
		$form.submit()
	});
});
</script>