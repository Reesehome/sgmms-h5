
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html>
<head>
  <title>基础平台面板</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="${ctx}/tds/static/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.css">
  <link rel="stylesheet" type="text/css" href="${ctx}/tds/static/dashboard/gridsters/demo.css">

<!--
  <link rel="stylesheet" type="text/css" href="assets/demo.css">
  <link rel="shortcut icon" href="echarts/asset/ico/favicon.png">
  <link href="echarts/asset/css/font-awesome.min.css" rel="stylesheet">
  <link href="echarts/asset/css/bootstrap.css" rel="stylesheet">
  <link href="echarts/asset/css/carousel.css" rel="stylesheet">
  <link href="echarts/asset/css/echartsHome.css" rel="stylesheet">
-->
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
   <!--[if lt IE 9]>
     <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
     <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
   <![endif]-->


  
  <script type="text/javascript" src="${ctx}/tds/static/jquery/jquery-1.11.3.min.js"></script>
  <script src="${ctx}/tds/static/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="${ctx}/tds/static/dashboard/gridsters/jquery.gridster.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/static/dashboard/echarts/dist/echarts-all.js"></script>
  <script src="${ctx}/tds/static/iframeResizer.contentWindow.min.js"></script>
  <style type="text/css">
  	.dropdown-menu {
  	left:;
  }
  </style>
 <!-- 
  <script src="echarts/dist/echarts-all.js"></script>
  <script src="echarts/www/js/echarts.js"></script>
/ <script src="echarts/asset/js/codemirror.js"></script>
  <script src="echarts/asset/js/javascript.js"></script>
  <link href="echarts/asset/css/codemirror.css" rel="stylesheet">
  <link href="echarts/asset/css/monokai.css" rel="stylesheet">
  <script type="text/javascript" src="echarts/asset/js/echartsHome.js"></script>
  <script src="echarts/asset/js/echartsExample.js"></script>
-->
  <script type="text/javascript" id="code">
    var gridster;
	var jqPieChart;
	function changeEchartsTheme(echart,theme){
		jqPieChart.setTheme(theme);
    }
    $(function(){
      gridster = $(".gridster > ul").gridster({
          widget_margins: [3, 3],
          widget_base_dimensions: [200, 150]
      }).data('gridster');
      var widgets = [
          ['<li>'+$('#barChart').html()+'</li>', 2, 2],
          ['<li>'+$('#pieChart').html()+'</li>', 2, 2],
          ['<li>'+$('#panel').html()+'</li>', 3, 1],
          ['<li>'+$('#panel').html()+'</li>', 1, 1],
          ['<li>'+$('#panel').html()+'</li>', 1, 1],
          ['<li>'+$('#panel').html()+'</li>', 1, 2],
          ['<li>'+$('#panel').html()+'</li>', 2, 1],
          ['<li>'+$('#panel').html()+'</li>', 1, 2],
          ['<li>'+$('#panel').html()+'</li>', 1, 1],
          ['<li>'+$('#panel').html()+'</li>', 2, 1],
          ['<li>'+$('#panel').html()+'</li>', 1, 1]
      ];

      $.each(widgets, function(i, widget){
          gridster.add_widget.apply(gridster, widget)
      });
	  var jqBarChart = echarts.init(document.getElementById('barChartId'));
//    barChart.setOption(barOption); 
//	  require.config({paths: {echarts: 'echarts/dist'}});
//	  require(['echarts','echarts/chart/bar'],function (ec) {
//            var barChart = ec.init(document.getElementById('barChartId')); 
			var barOption = {
			  tooltip: {show: true},
	//		  legend: {show:false,data:['销量']},
			  toolbox: {show : true, feature : {
				magicType : {show: true, type: ['line', 'bar']},
				restore : {show: true},
				saveAsImage : {show: true}
				}},
			 xAxis : [{type : 'category',data : ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]}],
			  yAxis : [{type : 'value'}],
			  series : [{"name":"销量","type":"bar","data":[5, 20, 40, 10, 10, 20]}
			  ]
			  };
		   jqBarChart.setOption(barOption); 
//		   });
//	  require.config({paths: {echarts: 'echarts/dist'}});
//	  require(['echarts','echarts/chart/pie'],function (ec) {
           jqPieChart = echarts.init(document.getElementById('pieChartId'));; 
			var pieOption = {
		 //   title : {text: '某站点用户访问来源',subtext: '纯属虚构',x:'center'},
			tooltip : {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
			legend: {orient : 'vertical',x : 'left',data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']},
			toolbox: {show : true,feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true,type: ['pie', 'funnel'],option: {funnel: {x: '25%',width: '50%',funnelAlign: 'left',max: 1548}}},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			series : [{name:'访问来源',type:'pie',radius : '55%',center: ['50%', '60%'],data:[
						{value:335, name:'直接访问'},
						{value:310, name:'邮件营销'},
						{value:234, name:'联盟广告'},
						{value:135, name:'视频广告'},
						{value:1548, name:'搜索引擎'}]}
			]};
//	var pieChart = echarts.init(document.getElementById('pieChartId'));
			jqPieChart.setOption(pieOption); 
//		});
/*	  
	  require.config({paths: {echarts: 'echarts/dist'}});
	  require(['echarts','echarts/chart/bar'],function (ec) {
                var myChart = ec.init(document.getElementById('echartId')); 
                var option = {
                    tooltip: {show: true},
                    legend: {data:['销量']},
                    xAxis : [{type : 'category',data : ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]}],
                    yAxis : [{type : 'value'}],
                    series : [{"name":"销量","type":"bar","data":[5, 20, 40, 10, 10, 20]}
                    ]
                };
                myChart.setOption(option); 
       });
	  */
	});

    </script>
</head>

<body>
<div class="panel panel-default">
   <div class="panel-heading">
      <h3 class="panel-title">
        桌面编辑器
      </h3>
		<div class="btn-group" style="float:right;top:-25px;vertical-align:top;">
			<button type="button" class="btn btn-default">添加组件</button>
			<button type="button" class="btn btn-default">保存配置</button>
		</div>
  </div>
   <div class="panel-body">
		<div class="gridster">
			<ul></ul>
		</div>
   </div>
</div>

	<div id="panel"  style="display:none;z-index:-100">
		<div  class="panel panel-default" style="height:100%">
			<div class="panel-heading">
				<h3 class="panel-title">组件标题</h3>
				<div class="btn-group" style="float:right;top:-23px;vertical-align:top;">
				<button type="button" class="btn btn-default btn-sm">刷新</button>
				<button type="button" class="btn btn-warning btn-sm">关闭</button>
				</div>
			</div>
			<div class="panel-body" style=" position: absolute;right:1px;left:1px;top:40px;bottom:36px;">
				这里是组件的内容区
			</div>
			<div class="panel-footer" style="position: absolute;right:1px;left:1px;bottom:0px;">
				组件下脚
			</div>
		</div>
	</div>
	<div id="barChart"  style="display:none;z-index:-100">
		<div  class="panel panel-default" style="height:100%">
			<div class="panel-heading">
				<h3 class="panel-title">销售量</h3>
				<div class="btn-group" style="float:right;top:-23px;vertical-align:top;">
				<button type="button" class="btn btn-default btn-sm">刷新</button>
				<button type="button" class="btn btn-warning btn-sm">关闭</button>
				</div>
			</div>
			<div class="panel-body" style=" position: absolute;right:1px;left:1px;top:40px;bottom:36px;">
					<div id="barChartId" style="height:100%"></div>
			</div>
			<div class="panel-footer" style="position: absolute;right:1px;left:1px;bottom:0px;">
				组件下脚
			</div>
		</div>
	</div>
	<div id="pieChart"  style="display:none;z-index:-100">
		<div  class="panel panel-default" style="height:100%">
			<div class="panel-heading" style="height:100%">
				<h3 class="panel-title">某站点用户访问来源</h3>
				<div class="btn-group" style="float:right;top:-23px;vertical-align:top;">
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle btn-sm" 
						 data-toggle="dropdown">主题
						  <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="z-index:100;">
						<li><a href="javascript:changeEchartsTheme('pieChartId','infographic');">infographic</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','shine');">shine</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','blue');">blue</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','dark');">dark</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','green');">green</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','red');">red</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','gray');">gray</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','helianthus');">helianthus</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','roma');">roma</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','mint');">mint</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','macarons2');">macarons2</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','sakura');">sakura</a></li>
						<li><a href="javascript:changeEchartsTheme('pieChartId','default');">default</a></li>
						<li><a href="#">green</a></li>
					  </ul>
					</div>	
					<button type="button" class="btn btn-default btn-sm" style="display:inline;">刷新</button>
					<button type="button" class="btn btn-warning btn-sm" style="display:inline;">关闭</button>
				</div>
			</div>
			<div class="panel-body" style=" position: absolute;right:1px;left:1px;top:40px;bottom:36px;">
					<div id="pieChartId" style="height:100%"></div>
			</div>
			<div class="panel-footer" style="position: absolute;right:1px;left:1px;bottom:0px;">
				组件下脚
			</div>
		</div>
	</div>
</body>
</html>
