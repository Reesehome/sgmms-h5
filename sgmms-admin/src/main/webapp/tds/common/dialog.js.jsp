<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<script type="text/javascript">
		function showAlert(message){
			BootstrapDialog.alert({
				type: BootstrapDialog.TYPE_PRIMARY,
				title: '<spring:message code="tds.common.label.alertTitle"/>',
				message: message,
				buttonLabel: '<spring:message code="tds.common.label.alertButtonText"/>'
			});
		}
		
		function showSuccess(message){
			BootstrapDialog.alert({
				type: BootstrapDialog.TYPE_SUCCESS,
				title: '<spring:message code="tds.common.label.alertTitle"/>',
				message: message,
				buttonLabel: '<spring:message code="tds.common.label.alertButtonText"/>'
			});
		}
		
		function showError(message){
			BootstrapDialog.alert({
				type: BootstrapDialog.TYPE_DANGER,
				title: '<spring:message code="tds.common.label.alertTitle"/>',
				message: message,
				buttonLabel: '<spring:message code="tds.common.label.alertButtonText"/>'
			});
		}
	</script>
</body>
</html>