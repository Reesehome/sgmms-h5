<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!doctype html>
<html>
<head>
<title>${title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/tds/common/ui-lib.jsp" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.css">
<link rel="stylesheet" type="text/css"
	href="${ctx}/tds/static/dashboard/gridsters/demo.css">
${dashboardCSS}
<script src="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.js"
	type="text/javascript" charset="utf-8"></script>
${dashboardJS}
<style type="text/css">
.dropdown-menu {
	left:;
}
</style>
<script type="text/javascript" id="code">
	${javascript}
	$(function(){
		${initBeginJS}
		
		function initEndJS() {
			${initEndJS}
		};
		
		var gridster_options = {
				widget_margins: [${margin}, ${margin}],
				widget_base_dimensions: [${baseWidth}, ${baseHeight}]
			};
		
		var gridster = $(".gridster > ul").gridster(gridster_options).data('gridster');
		
		var widgets = [${widgetContext}];
		$.each(widgets, function(i, widget){
			gridster.add_widget.apply(gridster, widget);
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
	});
</script>
</head>
<body>
	<div class="panel panel-default" style="border: 0px;">
		<div class="panel-body" style="padding: 5px;">
			<div class="gridster">
				<ul></ul>
			</div>
		</div>
	</div>
	${widgetHtml}
</body>
</html>
