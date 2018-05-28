<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<!doctype html>
<html>
<head>
  <title>${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <jsp:include page="/tds/common/ui-lib.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.css">
  <link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/demo.css">
${dashboardCSS}  
  <script src="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.js" type="text/javascript" charset="utf-8"></script>
${dashboardJS}  
 <style type="text/css">
  	.dropdown-menu {
  	left:;
  }
  </style>
  <script type="text/javascript" id="code">
${javascript}
    var gridster;
     $(function(){
${initBeginJS}
      gridster = $(".gridster > ul").gridster({
          widget_margins: [${margin}, ${margin}],
          widget_base_dimensions: [${baseWidth}, ${baseHeight}],
		  resize: {enabled: true}
      }).data('gridster');
      var widgets = [${widgetContext}];
      $.each(widgets, function(i, widget){
          gridster.add_widget.apply(gridster, widget)
      });
${initEndJS}
	});
    </script>
</head>

<body>
<div class="panel panel-default">
   <div class="panel-heading " style="height:40px">
      <h3 class="panel-title" >
        ${editorTitle}
      </h3>
		<div class="btn-group pull-right" style="top:-19px;">
			<button type="button" class="btn btn-default">添加</button>
			<button type="button" class="btn btn-default">保存</button>
		</div>
  </div>
   <div class="panel-body">
		<div class="gridster">
			<ul>
${widgetHtml}
			</ul>
		</div>
   </div>
</div>
</body>
</html>
