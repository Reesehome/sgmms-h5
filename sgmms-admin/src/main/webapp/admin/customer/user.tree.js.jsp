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
			url: "${ctx}/customer/company/findByParentId",
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
			onAsyncSuccess:onTreeComplated
		}
	};

    function getFont(treeId, node) {
        if (!node.enabled) {
            return {"color": "red", "text-decoration": "line-through"};
        }
    }

	function initCompanyTree(){
		tree = $.fn.zTree.init($('#companyTree'), setting, null);
	}
	
	function onTreeComplated(event, treeId, treeNode, msg){
        if (!!treeNode) return;
		var firstChildId = $('#'+treeId).children('li:first').attr('id');
		if( !$.isEmptyObject(firstChildId) ){
			var firstNode = tree.getNodeByTId(firstChildId);
			if(firstNode){
				tree.expandNode(firstNode,true,false,true);
				tree.selectNode(firstNode);
				$('#companyName').val(firstNode.name);
                //openCompanyForm(firstNode.id);
			}
		}
	}
	
	function companyOnClick(event, treeId, treeNode) {
        $('#companyName').val(treeNode.name);
        if (!treeNode.parentId) {
            $('#companyId').val('');
        } else {
            $('#companyId').val(treeNode.id);
        }
        $('#users-table').jqGrid().setGridParam({postData: null}).setGridParam({postData: $('#user-form').serializeJson()}).trigger("reloadGrid");
	}
	
	function openCompanyForm(id){
		var url = '${ctx }/customer/company/form?id=' + (id ? id : '');

        //$('#companyPanel .panel-body').html(returnView);
	}
</script>