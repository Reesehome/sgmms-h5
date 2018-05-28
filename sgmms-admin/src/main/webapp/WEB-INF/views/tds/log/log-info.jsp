<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Log Info</title>
</head>
<body>
	<div class="panel panel-info">
		<div class="panel-heading"><b><spring:message code="baf.syslog.label.logList"/></b></div>
		<div class="panel-body">
			<table id="logInfo"></table> 
   			<div id="logInfoPager"></div> 
		</div>
	</div>
<script>
	function initLogInfo(){
		var loginId = '${login.loginId }';
		var params = {loginId:loginId };
		$("#logInfo").jqGrid({
			url:ctx + '/admin/log/querySysLog.do',//请求数据的url地址
			datatype: 'json',  //请求的数据类型
			mtype: 'post',
			postData: params,
			colNames:[
			          '<spring:message code="baf.syslog.label.operateUser"/>',
			          '<spring:message code="baf.syslog.label.logTime"/>',
			          '<spring:message code="baf.syslog.label.logSource"/>',
			          '<spring:message code="baf.syslog.label.logLevel"/>',
			          '<spring:message code="baf.syslog.label.logDesc"/>',
			          '<spring:message code="baf.syslog.label.logData"/>',
			          '<spring:message code="baf.syslog.label.exception"/>'
		   	          ], //数据列名称（数组）
		   	colModel:[//数据列各参数信息设置
		   	          {name:'userName',index:'userName', width:80, title:false},
		   	       	  {name:'logTime',index:'logTime', width:80, align:'center'},
		   	      	  {name:'logSourceDisplay',index:'logSourceDisplay', width:80, align:'center'},
		   	      	  {name:'logLevelDisplay',index:'logLevelDisplay', width:80, align:'center'},
		   	          {name:'logDesc',index:'logDesc', width:80,align:'center'},
		   	          {name:'logData',index:'logData', width:80,align:'center'},
		   	          {name:'exception',index:'exception', width:80,align:'center'}
		   	          ],
		   	rowNum:10,//每页显示记录数
		   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
		   	pager : '#logInfoPager',  //表格数据关联的分页条，html元素
			autowidth: true, //自动匹配宽度
			height:275,   //设置高度
			gridview:true, //加速显示
		    viewrecords: true,  //显示总记录数
			multiselect: true,  //可多选，出现多选框
			multiselectWidth: 25, //设置多选列宽度
			sortable:true,  //可以排序
			sortname: 'logTime',  //排序字段名
		    sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
			loadComplete:function(data){ //完成服务器请求后，回调函数
				var params = {widtharray:[5,10,15,10,15,15,15,15],tableid:'logInfo',pager:'logInfoPager'};
				resizeTable(params);
			}
		});
	}
	$(function(){
		initLogInfo();
	});
</script>			
</body>
</html>