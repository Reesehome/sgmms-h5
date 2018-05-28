<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- ztree 控件 -->
<script src="${ctx }/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">
<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>
</head>
<body>

<div id="rMenu" class="list-group" style="display: none;">
	<a id="m_add_top" for="C" href="javascript:addTopCategory();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.newTop"/></a>
	<a id="m_add_colleague_category" for="C" href="javascript:addColleagueCategory();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.newsiblingcategory"/></a>
	<a id="m_add_lower_category" for="C" href="javascript:addLowerCategory();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.newjuniorcategory"/></a>
	<a id="m_add_colleague_dictionary" for="D" href="javascript:addColleagueDictionary();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.newsiblingdictionary"/></a>
	<a id="m_add_lower_dicitem" for="D" href="javascript:addLowerDicitemForDic();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 新增下级字典项</a>
	<a id="m_add_lower_dictionary" for="C" href="javascript:addLowerDictionary();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.newjuniordictionary"/></a>
	<a id="m_add_colleague_dicitem" for="I" href="javascript:addColleagueDicitem();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 新增同级字典项</a>
	<a id="m_add_sub_dicitem" for="I" href="javascript:addSubDicitem();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 新增下级字典项</a>
	<a id="m_delete" for="C D I" href="javascript:deleteNode();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.deleteItem"/></a>
<%-- 	<a id="m_export" for="C D" href="javascript:exportScript();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-export" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.exportScript"/></a> --%>
</div>
<script type="text/javascript">
	var tree;

	var setting = {
		check: {
			enable: true,
			chkStyle: "checkbox",
			chkboxType: { "Y": "", "N": "" }
		},
		/*
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "parentId"
			}
		},*/
		key: {
			name: "name",
			id: "id",
			parentId: "parentId"
		},
		async: {
			enable: true,
			url: "${ctx}" + getPath() + "/dictionary/findTree.do",
			dataType:'json',
			autoParam: ["id"]
		},
		view: {
			fontCss: {'text-decoration': 'none'}
		},
		callback: {
			onClick: dictionaryOnClick,
			onRightClick: dictionaryOnRightClick,
			onAsyncSuccess:onTreeComplated,
			beforeAsync:treeBeforeAsync
		}
	};

	function initDictionaryTree(treeHtmlId){
		findDictionaryTree(treeHtmlId,"");
	}

	function treeBeforeAsync(treeId, treeNode){
		if(tree)
			tree.setting.async.otherParam = ["type",treeNode.params.type];
	}
	
	
	function findDictionaryTree(treeId,parentId){
		tree = $.fn.zTree.init($('#'+treeId), setting, null);
	}
	
	function onTreeComplated(event, treeId, treeNode, msg){
		var treeNodes = tree.getNodes();
		var rootNotExist = !treeNodes || treeNodes.length == 0;
		toggleRootCreation(treeId,rootNotExist);
		
		if(treeNode)
			return;
		
		var firstChildId = $('#'+treeId).children('li:first').attr('id');
		if( isNotEmpty(firstChildId) ){
			var firstNode = tree.getNodeByTId(firstChildId);
			if(firstNode){
				tree.expandNode(firstNode,true,false,true);
				tree.selectNode(firstNode);
				dictionaryClickEventHandler(firstNode.id,firstNode.params.type);
			}
		}
	}
	
	function toggleRootCreation(treeHtmlId,rootNotExist){
		if(rootNotExist){
			$("#"+treeHtmlId).siblings("#createRootItem").show();
			$("#"+treeHtmlId).hide();
		} else{
			$("#"+treeHtmlId).siblings("#createRootItem").hide();
			$("#"+treeHtmlId).show();
		}
	}
	
	function createRoot(){
		openDictionaryForm({id:'',operation:'add',parentId:'',parentName:'',type:'C'});
	}
	
	function dictionaryOnClick(event, treeId, treeNode) {
		var id = treeNode.id;
		var type = treeNode.params.type;
		dictionaryClickEventHandler(id,type,treeNode);
	}
	
	function dictionaryClickEventHandler(categoryId,type,treeNode){
		openDictionaryForm({id:categoryId,parentId:'',operation:'show',parentName:'',type:type,treeNode:treeNode});
		toggleDictionaryPanel(true);
	}
	
	function openDictionaryForm(params){
		var url;
		var postParams;
		if(params.type == "I"){
			url = '${ctx }'+getPath()+'/dictionary/show-itemedit.do';
			var treeNode = params.treeNode;
			postParams = {id:treeNode.id,dictionaryId:treeNode.params.dictionaryId,parentId:treeNode.parentId,operation:params.operation};
		} else {
			url = '${ctx }'+getPath()+'/dictionary/show-edit.do';
			postParams = {id:params.id,parentId:params.parentId,parentName:params.parentName,type:params.type};
		}
		
		$.tdsAjax({
			url: url,
			data: postParams,
			dateType: "json",
			type: 'post',
			success: function(returnView){
				$('#DictionaryPanel .panel-body').html(returnView);
				
				/*
				// 查询字典项
				var type = params.type;
				if("D" == type){
					initDictionaryItemTable(params.id);
				}
				toggleDictionaryItemPanel("D" == type);
				*/
			},
			error: function(){
				showError('<spring:message code="tds.dictionary.message.queryingFailed"/>');
			}
		});
	}
	
	function dictionaryOnRightClick(event, treeId, treeNode) {
		var tree = $.fn.zTree.getZTreeObj(treeId);
		if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
			tree.cancelSelectedNode();
			//showRMenu("root", event.clientX, event.clientY);
		} else if (treeNode && !treeNode.noR) {
			tree.selectNode(treeNode);
			showRMenu("node",treeNode, event.clientX, event.clientY);
		}
	}
	
	
	function showRMenu(type,treeNode, x, y) {
		var nodeType = treeNode.params.type;
		if (type=="node") {
			$('#rMenu a[for~="'+nodeType+'"]').show();
			$('#rMenu a:not([for~="'+nodeType+'"])').hide();
			$("#m_del").show();
		}else{
			$('#rMenu a[id*="top"]').show();
			$('#rMenu a:not([id*="top"])').hide();
		}
		$("#rMenu").show();
		$("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
		$("body").bind("mousedown", onBodyMouseDown);
	}
	
	function onBodyMouseDown(event){
		if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
			$("#rMenu").css({"visibility" : "hidden"});
		}
	}
	
	function hideRMenu() {
		var rMenu = $("#rMenu");
		if (rMenu) rMenu.css({"visibility": "hidden"});
		$("body").unbind("mousedown", onBodyMouseDown);
	}
	
	//新增顶级分类
	function addTopCategory() {
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		tree.cancelSelectedNode();
		openDictionaryForm({id:'',operation:'add',parentId:'',parentName:'',type:'C'});
	}
	
	//新增同级分类
	function addColleagueCategory(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			tree.cancelSelectedNode();
			var parentNode = tree.getNodeByParam('id',selectedNode.id,null);
			var parentName = '';
			if(parentNode){
				parentName = parentNode.name;
			}
			openDictionaryForm({id:'',operation:'add',parentId:selectedNode.parentId,parentName:parentName,type:'C'});
		}
		
	}
	
	//新增下级分类
	function addLowerCategory(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			//tree.cancelSelectedNode();
			openDictionaryForm({id:'',operation:'add',parentId:selectedNode.id,parentName:selectedNode.name,type:'C'});
		}
	}
	
	//新增同级字典
	function addColleagueDictionary(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			tree.cancelSelectedNode();
			var parentNode = tree.getNodeByParam('id',selectedNode.id,null);
			var parentName = '';
			if(parentNode){
				parentName = parentNode.name;
			}
			openDictionaryForm({id:'',operation:'add',parentId:selectedNode.parentId,parentName:parentName,type:'D'});
		}
	}
	
	//新增下级字典
	function addLowerDictionary(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			//tree.cancelSelectedNode();
			openDictionaryForm({id:'',operation:'add',parentId:selectedNode.id,parentName:selectedNode.name,type:'D'});
		}
	}
	
	//新增下级字典项
	function addLowerDicitemForDic() {
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			var dictionaryId = selectedNode.id;
			var dictionaryName = selectedNode.name;
			var treeNode = {params:{"dictionaryId":dictionaryId,"dictionaryName":dictionaryName}};
			openDictionaryForm({"treeNode":treeNode,type:"I",operation:'addForDic'});
		}
	}
	
	//新增同级字典项
	function addColleagueDicitem(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			var parentNode = selectedNode.getParentNode();
			if(parentNode){
				
				var treeNode = {};
				
				if(parentNode.params.type == "I"){
					treeNode.parentId = parentNode.id;
					var dicNode = getParentDicNode(parentNode);
					treeNode.params = {"dictionaryId":dicNode.id,"dictionaryName":dicNode.name};
				}else if(parentNode.params.type == "D"){
					var dictionaryId = parentNode.id;
					var dictionaryName = parentNode.name;
					treeNode.params = {"dictionaryId":dictionaryId,"dictionaryName":dictionaryName};
				}
				
				openDictionaryForm({"treeNode":treeNode,type:"I",operation:'addColleague'});
			}
		}
	}
	
	//新增下级字典项
	function addSubDicitem(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			var parentNode = getParentDicNode(selectedNode);
			
			if(parentNode){
				var dictionaryId = parentNode.id;
				var dictionaryName = parentNode.name;
				
				var treeNode = {parentId:selectedNode.id,params:{"dictionaryId":dictionaryId,"dictionaryName":dictionaryName}};
				openDictionaryForm({"treeNode":treeNode,type:"I",operation:'addSub'});
			}
		}
	}
	
	function getParentDicNode(currentTreeNode){
		if(currentTreeNode){
			var parentNode = currentTreeNode.getParentNode();
			if(parentNode){
				if(parentNode.params.type == "C" || parentNode.params.type == "D"){
					return parentNode;
				}else{
					return getParentDicNode(parentNode);
				}
			}
		}
	}
	
	//删除对象
	function deleteNode() {
		BootstrapDialog.confirm({
			title: '<spring:message code="tds.common.label.alertTitle"/>',
			message: '<spring:message code="tds.dictionary.message.confirmDelete"/>',
			type: BootstrapDialog.TYPE_WARNING,
			closable: true,
			draggable: true,
			btnCancelLabel: '<spring:message code="tds.common.label.cancel"/>',
			btnOKLabel: '<spring:message code="tds.common.label.confirm"/>',
			btnOKClass: 'btn-primary',
			callback: function(result){
			    if(result) {
			    	doDeleteNode();
			    }
			}
		});
	}
	
	function doDeleteNode(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			var parentId = selectedNode.parentId;
			var id = selectedNode.id;
			var type = selectedNode.params.type;
			doDeleteNodeAjax({id:id,parentId:parentId,type:type});
		}
	}
	
	function doDeleteNodeAjax(params){
		$.tdsAjax({
			url: '${ctx }'+getPath()+'/dictionary/deleteDictionary.do',
			data: {id:params.id,type:params.type},
			dateType: "json",
			type: 'post',
			success: function(returnValue){
				var result = returnValue;
				if(result){
					var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
					var deletedNode = tree.getNodeByParam('id',params.id,null);
					if(deletedNode)
						tree.removeNode(deletedNode,false);
					if(isNotEmpty(params.parentId)){
						var parentNode = tree.getNodeByParam('id',params.parentId,null);
						if(parentNode){
							tree.selectNode(parentNode,false);
							dictionaryClickEventHandler(parentNode.id,parentNode.params.type);
						}
					}else{
						var firstChildId = $('#dictionaryTree').children('li:first').attr('id');
						if( isNotEmpty(firstChildId) ){
							var firstNode = tree.getNodeByTId(firstChildId);
							if(firstNode){
								tree.selectNode(firstNode,false);
								dictionaryClickEventHandler(firstNode.id,firstNode.params.type);
							}
						}
					}
					
				}else{
					showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
				}
			},
			error: function(){
				showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
			}
		});
	}
	
	function exportScript(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('dictionaryTree');
		var checkedNodes = tree.getCheckedNodes(true);
		if(!checkedNodes || checkedNodes.length == 0){
			showError('<spring:message code="tds.dictionary.message.noCheckedCatetories"/>');
			return;
		}
		exportScriptAjax(checkedNodes);
	}
	
	function exportScriptAjax(nodes){
		var idArray = new Array;
		$.each(nodes,function(idx,aNode){
			idArray.push(aNode.id);
		});
		var ids = idArray.join(',');
		$('#ExportScriptForm #ids').val(ids);
		$('#ExportScriptForm').submit();
	}
</script>
</body>
</html>