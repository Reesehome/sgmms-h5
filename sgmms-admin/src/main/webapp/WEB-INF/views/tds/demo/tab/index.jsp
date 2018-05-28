<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Tab示例</title>
		
		<jsp:include page="/tds/common/ui-lib.jsp" />
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" style="height:10%;padding-top:10px;padding-bottom: 10px;">
				<div class="col-sm-12">
		        	<span class="glyphicon glyphicon-wrench"></span> <strong>Tab示例</strong>
		        </div>
			</div>
			
		    <div class="row">
				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
				    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
				    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
				    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
				  </ul>
				
				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="home">
				    	<jsp:include page="/WEB-INF/views/tds/demo/tab/1.jsp"/>
				    </div>
				    <div role="tabpanel" class="tab-pane" id="profile">
				    	<jsp:include page="/WEB-INF/views/tds/demo/tab/2.jsp"/>
				    </div>
				    <div role="tabpanel" class="tab-pane" id="messages">
				    	<jsp:include page="/WEB-INF/views/tds/demo/tab/3.jsp"/>
				    </div>
				    <div role="tabpanel" class="tab-pane" id="settings">
						<jsp:include page="/WEB-INF/views/tds/demo/tab/4.jsp"/>
					</div>
				  </div>
		    </div>
		</div>
	</body>
</html>