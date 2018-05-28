<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dictionary</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<link rel="stylesheet" href="${ctx }/tds/dictionary/css/dictionary.css"/>
<link rel="stylesheet" href="${ctx }/tds/static/scrollbar/css/jquery.mCustomScrollbar.css">
<style>
	html,body{height: 100%;}
	.row{height: 100%;}
	.height100{height: 100%;}
	.tree-font-color{color: rgb(110, 130, 155);}
	.form-group{margin-bottom: 5px;}
	.module-header{height: 40px;vertical-align: middle;display: table-cell;margin-left: -15px;}
	.module-body{padding-top: 40px;margin-top: -40px;}
	.col-sm-3,.col-sm-9{padding-left: 2px;padding-right: 2px;}
</style>
</head>
<body>
	<c:set var="path" value="/admin"></c:set>
	<div id="DictionaryContainer" class="container-fluid height100" style="min-width: 1000px;">
	  <div class="module-header">
	  	<span class="glyphicon glyphicon-book"></span> <strong> <spring:message code="tds.dictionary.label.dictionaryModule"/></strong>
	  </div>
	  <div class="module-body height100">
	    <!-- 类别树 -->
	    <div class="layout-horizontal col-sm-3 height100">
	    	<div id="DictionaryTreePanel" class="panel panel-info height100">
	    		<div class="panel-heading" style="min-height: 45px;">
	    			<div class="btn-group pull-right">
	    				<button type="button"  class="btn btn-primary" onclick="exportScript();"><spring:message code="tds.dictionary.label.exportScript"/></button>
	    			</div>
	    			<strong><spring:message code="tds.dictionary.label.category"/></strong>
	    		</div>
	    		<div class="panel-body tree-panel-body">
	    			<div class="tree-panel-body-content">
		    			<ul id="dictionaryTree" class="ztree"></ul>
						<ul id="createRootItem" style="list-style: none;">
							<li><a href="javascript:void(0);" onclick="createRoot();"><spring:message code="tds.dictionary.label.newTop"/></a>
						</ul>
					</div>
				</div>
	    	</div>
	    </div>
	    <div class="layout-horizontal col-sm-9 height100">
	    	<!-- 类别显示与编辑 -->
	    	<div id="DictionaryPanel" class="panel panel-info">
	    		<div class="panel-heading" style="min-height: 45px;">
	    			<div class="btn-group pull-right">
	    				<button id="btnSave" type="button" class="btn btn-primary"><spring:message code="tds.common.label.save"/></button>
	    			</div>
	    			<strong><spring:message code="tds.dictionary.label.category"/></strong>
	    		</div>
	    		<div class="panel-body">
				</div>
	    	</div>
	    	
	    	<%-- 
	    	<div id="DictionaryItemPanel" class="panel panel-info" style="margin-bottom: 0px;margin-top: 5px;">
				<div class="panel-heading" style="min-height: 45px;">
					<div class="btn-group pull-right"><button type="button"  class="btn btn-primary" onclick="editDictionaryItem({'type':'add'});"><spring:message code="tds.common.label.add"></spring:message></button>
						<button type="button" class="btn btn-success" onclick="editDictionaryItem({'type':'update'});"><spring:message code="tds.common.label.update"></spring:message></button>
						<button type="button" class="btn btn-warning" onclick="deleteDictionaryItem();"><spring:message code="tds.common.label.delete"></spring:message></button>
					</div>
					<strong> <spring:message code="tds.dictionary.label.item"/></strong>
				</div>
				
				<div class="panel-body">
			    	<table id="dictionaryitem"></table> 
					<div id="dictionaryitempager"></div> 
				</div>
			</div>
	    	--%>
	    	
	    </div>
	  </div>
	  <form id="ExportScriptForm" action="${ctx}/admin/dictionary/exportScript.do" target="frameForForm">
		<input type="hidden" name="ids" id="ids"/>
	  </form>
	  <iframe id="frameForForm" name="frameForForm" style="display: none;"></iframe>
	</div>
	<script>
		function getPath(){
			return '${path}';
		}
	</script>
	<jsp:include page="/tds/dictionary/js/dictionary.js.jsp"></jsp:include>
	<jsp:include page="/tds/common/dialog.js.jsp"></jsp:include>
	<jsp:include page="/tds/dictionary/js/dictionary.category.js.jsp"></jsp:include>
	<%-- <script src="${ctx }/tds/static/scrollbar/js/jquery.mCustomScrollbar.concat.min.js"></script> --%>
	<script>
		function initTreeBodyHeight(){
			var headerHeight = $('.panel-heading:eq(0)').outerHeight(true);
			$('.tree-panel-body').css('height','100%').css('padding-top',headerHeight + 'px').css('margin-top','-' + headerHeight + 'px');
			$('.tree-panel-body-content').css('height','100%').css('overflow','auto');
		}
		initDictionaryTree("dictionaryTree");
		initTreeBodyHeight();
		BootstrapDialog.configDefaultOptions({ animate: false,closeByBackdrop: false });
		
		/* $(function(){
			$(".tree-panel-body-content").mCustomScrollbar({
				theme: 'minimal-dark'
			});
		}); */
	</script>
</body>
</html>