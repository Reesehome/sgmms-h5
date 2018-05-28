<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/tds/common/tree.common.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/tds/static/scrollbar/css/jquery.mCustomScrollbar.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/tds/common/ztree-ext.css">
    
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script> --%>
		
    <div id="alertTip" class="alert alert-warning" role="alert" style="display: none;">提示：请选择一个部门进行操作</div>
    <input type="hidden"  name="fireOrgId" id='fireOrgId' value="${fireOrgId}"  />
		<div class="tab-content">
			<div class="tab-pane in active">
				<ul id="treeDia" class="ztree"></ul>
			</div>
		</div>
<jsp:include page="/tds/org/organization/organizationTree-right.js.jsp" />