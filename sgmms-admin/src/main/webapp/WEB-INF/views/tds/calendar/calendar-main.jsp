<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>日历管理页面</title>
	<jsp:include page="/tds/common/ui-lib.jsp" />
	
	<style type="text/css">
		html,body{height: 100%;}
		.row{height: 100%;}
		.height100{height: 100%;}
		.shadow{box-shadow:-2px 0px 4px 0px #f1f1f3;border-left: 1px solid #dae3e9;}
	</style>
</head>
<body>
	<div class="container-fluid height100">
		<div class="row">
			<div class="col-md-9" role="main" id="calendarMain">
				
			</div>
			<div class="col-md-3 height100 shadow" role="complementary">
				<div>
					<ul class="nav nav-list">
						<li class="active">
							<a href="javascript:void(0);" id="holiday">节假日配置</a>
						</li>
						<li class="">
							<a href="javascript:void(0);" id="worktime">
								<span class="menu-text">工作时间配置</span>
							</a>
						</li>
						<li class="active">
							<a href="javascript:void(0);" id="holidayadj">调班调休配置</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$("#holiday").click(function() {
			$("#calendarMain").load(ctx + "/admin/calendar/holiday/forwardHolidayMain.do");
		});
		$("#worktime").click(function() {
			$("#calendarMain").load(ctx + "/admin/calendar/worktime/forwardWorktimeMain.do");
		});
		$("#holidayadj").click(function() {
			$("#calendarMain").load(ctx + "/admin/calendar/holidayadj/forwardHolidayAdjMain.do");
		});
		
		$("#holiday").click();
	});
</script>
</html>