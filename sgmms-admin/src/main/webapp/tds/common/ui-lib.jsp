<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<link rel="icon" href="${ctx}/tds/static/images/common/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${ctx}/tds/static/images/common/favicon.ico" type="image/x-icon" />

<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${ctx}/tds/static/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/tds/static/bootstrap-submenu/dist/css/bootstrap-submenu.min.css">

<!-- jqgrid 所需要的 CSS 文件 -->
<link rel="stylesheet" href="${ctx}/tds/static/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet" href="${ctx}/tds/static/jqGrid_4.8.2/css/ui.jqgrid.css">

<!-- 日期控件所需要的 CSS 文件 -->
<link rel="stylesheet" href="${ctx}/tds/static/datetimepicker/css/bootstrap-datetimepicker.min.css">

<!-- bootstrap-dialog 所需要的 CSS 文件 -->
<link rel="stylesheet" href="${ctx}/tds/static/bootstrap3-dialog/css/bootstrap-dialog.min.css">

<link rel="stylesheet" type="text/css" href="${ctx}/tds/common/ui-lib.css">
<link rel="stylesheet" type="text/css" href="${ctx}/tds/common/jqgrid-ext.css">


<!-- 双层tab CSS 文件 -->
<link rel="stylesheet" type="text/css" href="${ctx}/tds/static/sub-tab/css/sub-tab.css">

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${ctx}/tds/static/jquery/jquery-1.11.3.min.js"></script>
<script src="${ctx}/tds/static/jquery/jquery-util.js"></script>
<script src="${ctx}/tds/static/jquery/jquery.form.js"></script>

<!-- jquery validate 核心 JavaScript 文件 -->
<script src="${ctx}/tds/static/jquery-validation/1.13.1/jquery.validate.min.js"></script>
<script src="${ctx}/tds/static/jquery-validation/1.13.1/additional-methods.min.js"></script>

<!--  Bootstrap 核心 JavaScript 文件 -->
<script src="${ctx}/tds/static/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="${ctx}/tds/static/bootstrap-submenu/dist/js/bootstrap-submenu.min.js"></script>

<!-- bootstrap3-dialog 核心 JavaScript 文件 -->
<script src="${ctx}/tds/static/bootstrap3-dialog/bootstrap-dialog.js"></script>

<!-- bootstrap-confirmation 核心 JavaScript 文件 -->
<script src="${ctx}/tds/static/bootstrap-confirmation/bootstrap-confirmation.js"></script>

<!-- 日期控件所需要的 JavaScript 文件 -->
<script src="${ctx}/tds/static/datetimepicker/js/bootstrap-datetimepicker.js"></script>
<%-- <script src="${ctx}/tds/static/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script> --%>

<!-- jqgrid 核心 JavaScript 文件 -->
<%-- <script src="${ctx}/tds/static/jqGrid_4.8.2/js/i18n/grid.locale-cn.js"></script> --%>

<c:choose>
	<c:when test="${langType eq 'zh_CN'}">
		<script src="${ctx}/tds/static/jqGrid_4.8.2/js/i18n/grid.locale-cn.js"></script>
		<script src="${ctx}/tds/static/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
		<script src="${ctx}/tds/static/jquery-validation/1.13.1/localization/messages_zh.min.js"></script>
	</c:when>	
	<c:when test="${langType eq 'zh_TW'}">
		<script src="${ctx}/tds/static/jqGrid_4.8.2/js/i18n/grid.locale-tw.js"></script>
		<script src="${ctx}/tds/static/datetimepicker/js/locales/bootstrap-datetimepicker.zh-TW.js"></script>
		<script src="${ctx}/tds/static/jquery-validation/1.13.1/localization/messages_zh_TW.min.js"></script>
	</c:when>
	<c:otherwise>
		<script src="${ctx}/tds/static/jqGrid_4.8.2/js/i18n/grid.locale-en.js"></script>
		<script src="${ctx}/tds/static/datetimepicker/js/locales/bootstrap-datetimepicker.de.js"></script>
	</c:otherwise>
</c:choose>

<script src="${ctx}/tds/static/jqGrid_4.8.2/js/jquery.jqGrid.src.js"></script>

<!-- jquery resize方法增强插件，可以绑定到任何元素，例如div,span等 -->
<script src="${ctx}/tds/static/jquery-resize.min.js"></script>
<script src="${ctx}/tds/static/iframeResizer.contentWindow.min.js"></script>

<!-- 双层tab js 文件 -->
<script src="${ctx}/tds/static/sub-tab/js/sub-tab.js"></script>

<script>
	var ctx = '${ctx}';
	$.ajaxSetup ({
	    cache: false, //关闭AJAX相应的缓存
	    type: "POST" //默认用post方式提交
	});
</script>