<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
	
		       <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.css" rel="stylesheet">
		      <script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.js"></script>
<%-- 		<link href="${ctx }/tds/workflow/common/css/jquery.qtip.min.css" type="text/css" rel="stylesheet" /> --%>
<%--       <script src="${ctx}/tds/workflow/common/js/jquery.qtip.pack.js" type="text/javascript"></script>  --%>
<%-- 		<script src="${ctx}/tds/workflow/common/js/jquery.qtip.min.js" type="text/javascript"></script> --%>
		     <jsp:include page="/tds/workflow/processInstance/processInstance-running.js.jsp" />
		      <jsp:include page="/tds/workflow/processInstance/workflow.js.jsp" />

		       <div class="panel panel-info">
						<div class="panel-heading">
							流程实例列表
						</div>
						<div id="tablePanel" class="panel-body">
					    	<table id="list"></table> 
					    	 <input id="message" type="hidden" name="message" value="${message}"/>
   							<div id="gridpager"></div> 
						</div>
					</div>
