<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
<link rel="stylesheet" href="${ctx }/tds/static/scrollbar/css/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">


<script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>
<script type="text/javascript" src="${ctx }/tds/common/ztree-ext.js"></script>

<div class="row">&nbsp;</div>
<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-info">
				<div class="panel-body" style="height:400px;overflow: auto;">
					<ul id="widget-selected-tree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/tds/dashboard/widget-selected.js.jsp" />