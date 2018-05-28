<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!-- 	    <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.css" rel="stylesheet"> -->
<!-- 		<script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.1/jquery.qtip.js"></script> -->
		
		        <jsp:include page="/tds/workflow/processInstance/task-all-list.js.jsp" />
<%-- 		<jsp:include page="/tds/workflow/processInstance/workflow.js.jsp" /> --%>
                <jsp:include page="/tds/workflow/task/task-turn.js.jsp" />
	
			
		      
		        	<div class="panel panel-info">
						<div class="panel-heading">
							代办任务列表
						</div>
						<div id="tablePanelTask" class="panel-body">
					    	<table id="listTask"></table> 
					    	 <input id="messageTask" type="hidden" name="message" value="${message}"/>
   							<div id="gridpagerTask"></div> 
						</div>
					</div>
		    
	
