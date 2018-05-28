<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title><spring:message code="tds.sys.property.title"/></title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
		
		<jsp:include page="/tds/workflow/js/process-start.js.jsp" />
		<style type="text/css">
		.vertical-space{margin-bottom: 10px; }
	    .module-header{height: 40px;vertical-align: middle;display: table-cell;}
	    .form-group .input-field{width: 50%;}
	   .ui-widget-content .link {color: #337ab7;text-decoration: underline;background-color: transparent;cursor: pointer;}
	   .ui-widget-content .link:hover{color: #23527c;}
		</style>
		<script type="text/javascript">
		function starts(){
			$("#formStart").submit();
			
		}
		
		
		</script>
		
	</head>
	<body>
		<div class="container-fluid">
			<div class="row module-header">
				<span><strong><i class="glyphicon glyphicon-list"></i> 发起流程JSP---测试页面</strong></span>
			</div>
			
		    <form id="formStart" action="${ctx}/admin/workflow/startProcess.do" method="post" >  
                <textarea rows="4" name="processDesc" id="processDesc">  </textarea>    
                <input id="processDefinitionId" name="processDefinitionId" value="${processDefinitionId}" type="hidden"/>
                <button id="start" onclick="starts()"> 提交</button><br>
                                 注意  ：  描述信息保存到  “processDesc”  属性里面...
            </form>
		</div>
	</body>
</html>


 