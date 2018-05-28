<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- ztree 控件 -->
<script src="${ctx }/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">
<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>

<div id="rMenu" class="list-group" style="display: none;">
	<a id="m_add_toplevel" href="javascript:addTopCompany();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增顶级单位</a>
	<a id="m_add_colleague" href="javascript:addColleagueCompany();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增同级单位</a>
	<a id="m_add_subordinate" href="javascript:addLowerCompany();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;新增下级单位</a>
	<a id="m_delete" href="javascript:deleteCompany();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.deleteItem"/></a>
<%-- 	<a id="m_export" for="C D" href="javascript:exportScript();void(0);" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-export" aria-hidden="true"></span> <spring:message code="tds.dictionary.label.exportScript"/></a> --%>
</div>
<script type="text/javascript">
	var tree;

	var setting = {
		key: {
			name: "name",
			id: "id",
			parentId: "parentId"
		},
		async: {
			enable: true,
			url: "${ctx}" + "/customer/company/findByParentId",
			dataType:'json',
			autoParam: ["id"],
            dataFilter: function (treeId, parentNode, responseData) {
                if (responseData) {
                    for(var i = 0; i < responseData.length; i++) {
                        responseData[i].isParent = true;
                    }
                }
                return responseData;
            }
		},
        view: {
            fontCss: getFont
        },
		callback: {
			onClick: companyOnClick,
			onRightClick: companyOnRightClick,
			onAsyncSuccess:onTreeComplated
		}
	};

    function getFont(treeId, node) {
        if (!node.enabled) {
            return {"color": "red", "text-decoration": "line-through"};
        }
    }

	function initCompanyTree(treeHtmlId){
		findCompanyTree(treeHtmlId,"");
	}
	
	function findCompanyTree(treeId,parentId){
		tree = $.fn.zTree.init($('#'+treeId), setting, null);
	}
	
	function onTreeComplated(event, treeId, treeNode, list){
		var treeNodes = tree.getNodes();
		var rootNotExist = !treeNodes || treeNodes.length == 0;
		toggleRootCreation(treeId,rootNotExist);
		
		if(treeNode)
			return;
		
		var firstChildId = $('#'+treeId).children('li:first').attr('id');
		if( !$.isEmptyObject(firstChildId) ){
			var firstNode = tree.getNodeByTId(firstChildId);
			if(firstNode){
				tree.expandNode(firstNode,true,false,true);
				tree.selectNode(firstNode);
				  companyClickEventHandler(firstNode.id,firstNode);
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
        openCompanyForm(null);
    }

	function companyOnClick(event, treeId, treeNode) {
		var id = treeNode.id;
		//var type = treeNode.params.type;
        companyClickEventHandler(id);
	}
	
	function companyClickEventHandler(id){
		openCompanyForm(id);
	}
	
	function openCompanyForm(id){
		var url = '${ctx }/customer/company/form?id=' + (id ? id : '');

		$.tdsAjax({
			url: url,
			dateType: "json",
			type: 'get',
			success: function(returnView){
				$('#companyPanel .panel-body').html(returnView);
                var tree, selectedNode;
                if ($.trim($('#id').val()).length == 0) {
                    tree = $.fn.zTree.getZTreeObj('companyTree');
                    selectedNode = tree.getSelectedNodes()[0];
                    if (selectedNode) {
                        $('#parentName').val(selectedNode.name);
                        $('#parentId').val(selectedNode.id);
                        tree.cancelSelectedNode();
                    }
				}
			},
			error: function(){
				showError('<spring:message code="tds.dictionary.message.queryingFailed"/>');
			}
		});
	}
	
	function companyOnRightClick(event, treeId, treeNode) {
		var tree = $.fn.zTree.getZTreeObj(treeId);
		if (treeNode && !!treeNode.parentId) {
			tree.selectNode(treeNode);
            openCompanyForm(treeNode.id);
			showRMenu("node",treeNode, event.clientX, event.clientY);
		}
	}
	
	
	function showRMenu(type,treeNode, x, y) {
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
	function addTopCompany() {
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('companyTree');
		tree.selectNode(tree.getNodeByParam('parentId', null));
		openCompanyForm(null);
	}
	
	//新增同级分类
	function addColleagueCompany(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('companyTree');
		var parentNode, selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			tree.cancelSelectedNode();
            tree.selectNode(tree.getNodeByParam('id', selectedNode.parentId));
            openCompanyForm(null);
		}
		
	}
	
	//新增下级分类
	function addLowerCompany(){
		hideRMenu();
		var tree = $.fn.zTree.getZTreeObj('companyTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
            openCompanyForm(null);
		}
	}
	
	//删除对象
	function deleteCompany() {
		BootstrapDialog.confirm({
			title: '<spring:message code="tds.common.label.alertTitle"/>',
			message: '确定删除单位么？',
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
		var tree = $.fn.zTree.getZTreeObj('companyTree');
		var selectedNode = tree.getSelectedNodes()[0];
		if(selectedNode){
			var id = selectedNode.id;
			doDeleteNodeAjax(id);
		}
	}
	
	function doDeleteNodeAjax(id){
        axios.interceptors.response.use(function (res) {
            if (!res.data || !res.data.success) {
                return Promise.reject({'response': res});
            }
            return Promise.resolve(res);
        }, function (error) {
            return Promise.reject(error)
        });
        axios.delete('${ctx }/customer/company/' + id)
			// 删除节点、更新表单
            .then(function (response) {
                var tree = $.fn.zTree.getZTreeObj('companyTree');
                var deletedNode = tree.getNodeByParam('id', id);
                var selectedNode = deletedNode.getParentNode();
                tree.removeNode(deletedNode, false);
                if (!selectedNode) {
                    selectedNode = tree.getNodes()[0];
				}
				if (selectedNode != null) {
                    tree.selectNode(selectedNode);
                    openCompanyForm(selectedNode.id);
				} else {
                    openCompanyForm(null);
				}
			})
			// 异常处理
			.catch(function (error) {
				var response = error.response;
				if (response) {
					if (response.status >= 200 && response.status < 300) {
						// 业务错误
						showError(response.data.message);
						return;
					}
				}
				// 系统错误
				showError(error.message);
			});
	}
</script>