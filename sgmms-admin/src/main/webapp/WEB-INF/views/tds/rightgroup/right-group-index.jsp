<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Operation Authority</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/tree.common.css">
<link rel="stylesheet" href="${ctx }/tds/static/scrollbar/css/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">
<script type="text/javascript" src="${ctx }/tds/common/tree.common.js"></script>
	<style>
		html,body{height: 100%;}
		.full-height{height: 100%;}
		.full-width{width: 100%;}
		.tree-font-color{color: rgb(110, 130, 155);}
		.horizontal{display: inline-block;vertical-align: top;}
		.horizontal + .horizontal{padding-left: 5px;margin-left: -5px;}
		.container-column{padding: 2px;}
		.nav-container{padding-top: 57px;margin-top: -52px;}
		.panel-body-addition{height: 100%;}
		.panel-body-content{height: 100%;overflow: auto;}
		.module-header{height: 40px;vertical-align: middle;display: table-cell;margin-left: -15px; }
		.module-body{padding-top: 40px;margin-top: -40px;}
	</style>
</head>
<body>
	<c:set var="path" value="/admin"></c:set>
	<div class="container-fluid full-height">
		<!-- 模块标题 -->
		<div class="module-header">
			<span class="glyphicon glyphicon-book"></span> <strong><spring:message code="tds.authority.label.authorityModule"/></strong>
		</div>
		<div class="module-body full-height">
			<!-- 树 左 -->
			<div id="authority-category" class="container-column horizontal full-height col-sm-3">
				<div id="GroupTreePanel" class="panel panel-info full-height">
		    		<div class="panel-heading" style="min-height: 45px;">
		    			<div class="btn-group pull-right">
		    				<button type="button"  class="btn btn-primary" onclick="addGroup();"><spring:message code="tds.common.label.add"></spring:message></button>
		    				<button type="button" class="btn btn-warning" onclick="deleteGroup();"><spring:message code="tds.common.label.delete"></spring:message></button>
		    			</div>
		    			<strong><spring:message code="tds.authority.label.authorityList"/> </strong>
		    		</div>
		    		<div class="panel-body tree-panel-body">
		    			<div class="panel-body-content">
			    			<ul id="auth-group-tree" class="ztree"></ul>
							<ul id="auth-group-root" style="list-style: none;">
								<li><a href="javascript:void(0);" onclick="createGroupRoot();"><spring:message code="tds.authority.label.newGroup"/></a></li>
							</ul>
						</div>
					</div>
		    	</div>
			</div>
			<!-- 内容 右下 -->
			<div id="authority-content" class="container-column horizontal full-height col-sm-9">
				<!-- 当前权限组  右上 -->
    			<div class="full-width" id="current-authority" style="height: 158px;padding-bottom: 10px;">
    				
				</div>
				<div style="height: 100%;min-height: 250px;padding-top: 158px;margin-top: -158px;">
					<nav class="navbar navbar-default" style="margin-bottom: 0px;">
						<div class="container-fluid" style="padding-left: 0px;">
					     	<div class="collapse navbar-collapse full-height" 
					     		style="padding-right: 0px;padding-left: 0px;" id="content-navbar">
							      <ul class="nav navbar-nav">
							        <li class="active" for="group-right"><a href="javascript:void(0);"><spring:message code="tds.authority.label.authorityItem"/> </a></li>
							        <li for="organization-content"><a href="javascript:void(0);"><spring:message code="tds.authority.label.organizationAuthority"/></a></li>
							        <li for="organization-table"><a href="javascript:void(0);"><spring:message code="tds.authority.label.organizationPreview"/></a></li>
							        <li for="user-table"><a href="javascript:void(0);"><spring:message code="tds.authority.label.userPreview"/></a></li>
							      </ul>
						     </div>
					    </div>
				    </nav>
				    <div class="nav-container full-height" id="group-right"></div>
				    <div class="nav-container full-height" id="organization-content"></div>
				    <div class="nav-container full-height" id="organization-table"></div>
				    <div class="nav-container full-height" id="user-table"></div>
				</div>
			</div>
		</div>
		<div id="rMenu" class="list-group" style="display: none;">
<%-- 		<a id="add_group" href="javascript:void(0);" for="add" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <spring:message code="tds.authority.label.newGroup"/></a> --%>
<%-- 		<a id="delete_group" href="javascript:void(0);" for="delete" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> <spring:message code="tds.authority.label.deleteGroup"/></a> --%>
			<a id="refresh_group" href="javascript:void(0);" for="refresh" class="list-group-item list-group-item-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> <spring:message code="tds.common.label.refresh"/></a>
		</div>
	</div>
	
	<script type="text/javascript">
		function getJspParam(tag){
			var param = '';
			if(tag == 'ctx')
				param = '${ctx }';
			else if(tag == 'path')
				param = '${path }';
			else if(tag == 'savingFaild')
				param = '<spring:message code="tds.authority.message.savingFailed"/>';
			else if(tag == 'deletingFaild')
				param = '<spring:message code="tds.authority.message.deletingFaild"/>';
			return param;
		}
		
		function isNotEmpty(str){
			return str!=null && str!='' && typeof str != 'undefined';
		}
		
		$(function(){
			initNavbar();
		});
		
		function initNavbar(){
			var firstnav = $('#content-navbar').children('ul.navbar-nav').children('li:first');
			firstnav.addClass('active');
			firstnav.siblings().removeClass('active');
			var activeId = firstnav.attr('for');
			var firstContent = $('#authority-content').children(":eq(1)").children('#'+activeId);
			firstContent.show();
			firstContent.siblings('.nav-container').hide();
		}
		
		function resizeTable(params){
			$("#gbox_"+params.tableid).css("width","100%");
			$("#gbox_"+params.tableid).css("margin-right","0px");
			$("#gview_"+params.tableid).css("width","100%");
			$("#gview_"+params.tableid+ " .ui-jqgrid-hdiv").css("width","100%");
			$("#gview_"+params.tableid + " .ui-jqgrid-hdiv .ui-jqgrid-hbox").css("width","100%");
			var htable = $("#gview_"+params.tableid + " .ui-jqgrid-hdiv .ui-jqgrid-hbox .ui-jqgrid-htable");
			htable.css("width","100%");
			var widthparams = params.widtharray;
			$.each(widthparams , function(idx,aParam){
				htable.children("thead").children("tr").children("th:eq("+idx+")").width(aParam+'%');
			});
			
			$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").width("100%");
			$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").children(":first").width(htable.width());//.css({'padding-right':'20px','position':'absolute'});//.css('left',left_offset);//.css('margin-left','-20px').css('position','relative');
			var table = $("#"+params.tableid);
			table.width('100%');
			$.each(widthparams , function(idx,aParam){
				table.children("tbody").children("tr").children("td:eq("+idx+")").width(aParam+'%');
			});
			$("#"+params.pager).width('100%');
		}
		
		$('#content-navbar').children('ul.navbar-nav').children('li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			var forid = $(this).attr("for");
			var container = $('#' + forid);
			container.show();
			container.siblings('.nav-container').hide();
			if('organization-table' == forid){
				var params = {widtharray:[4,48,48],tableid:'group-org-table',pager:'group-org-table-pager'};
				resizeTable(params);
			}else if('user-table' == forid){
				var params = {widtharray:[4,15,15,64],tableid:'group-user-table',pager:'group-user-table-pager'};
				resizeTable(params);
			}
			
		});
		
		function addGroup(){
			initGroupContent('');
		}
		
		function clickSaveGroup(){
			var tree = $.fn.zTree.getZTreeObj("auth-group-tree");
			
			
			var oldName = $("#oldName").val();
			var groupName = $("#groupName").val();
			var nodes = tree.getNodes();
			if(nodes && nodes.length > 0 && oldName != groupName){
				for(i=0;i<nodes.length;i++){
					var nodeName = nodes[i].name;
					if(nodeName == groupName){
						showError('<spring:message code="tds.authority.message.groupExisted"/>');
						return;
					}
				}
			}
			
			var dicValidator = $("#GroupForm").validate();
			var isValid = $("#GroupForm").valid();
			if( !isValid )
				return;
			
			var rightIds = getTreeCheckedIds('group-right-tree');
			var orgIds = getTreeCheckedIds('auth-group-org-tree');
			
			$('#GroupForm #rightIds').val(rightIds);
			$('#GroupForm #orgIds').val(orgIds);
			
			var context = getJspParam('ctx');
			var group = $('#GroupForm').serialize();
			var url = context + getJspParam('path') + '/right/group/saveGroup.do';
			$.fn.authority.save(url,group,function(aGroup){
				if(aGroup){
					//判断是新增还是更新
					var groupId = $('#GroupForm #groupId').val();
					if(isNotEmpty(groupId)){
						var name = $('#GroupForm #groupName').val();
						updateGroupTreeSelectedNodeName(name);
					}else{
						addGroupNode(aGroup);
					}
					representGroupTree();
					selectedNodeClick();
					
					showSuccess('<spring:message code="tds.menuRight.label.executeSuccess"/>');
				}else{
					showError('<spring:message code="tds.authority.message.savingFailed"/>');
				}
			});
		}
		
		function getTreeCheckedIds(treeId){
			var tree = $.fn.zTree.getZTreeObj(treeId);
			var ids = '';
			if(tree){
				var nodes = tree.getCheckedNodes(true);
				if(nodes && nodes.length > 0){
					var nodeIdArr = new Array();
					$.each(nodes ,function(idx,aNode){
						nodeIdArr.push(aNode.id);
					});
					ids = nodeIdArr.join(',');
				}
			}
			return ids;
		}
		
		function deleteGroup(){
			var checkedIds = getCheckedIds();
			if(!isNotEmpty(checkedIds)){
				showAlert('<spring:message code="tds.authority.message.selectGroup"/>');
				return;
			}
			BootstrapDialog.confirm({
				title: '<spring:message code="tds.common.label.alertTitle"/>',
				message: '<spring:message code="tds.authority.message.confirmDeleteGroup"/>',
				type: BootstrapDialog.TYPE_WARNING,
				closable: true,
				draggable: true,
				btnCancelLabel: '<spring:message code="tds.common.label.cancel"/>',
				btnOKLabel: '<spring:message code="tds.common.label.confirm"/>',
				btnOKClass: 'btn-primary',
				callback: function(result){
				    if(result) {
				    	var context = getJspParam('ctx');
						var url = context + getJspParam('path') + '/right/group/deleteGroup.do';
						var groupIds = getCheckedIds();
						var param = {id:groupIds};
						$.fn.authority.deleteGroup(url,param,function(ids){
							var array = ids.split(',');
							$.each(array,function(idx,aId){
								deleteGroupTreeNode(aId);
							});
							groupTreeFirstNodeClick();
						});
				    }
				}
			});
		}
		
		/* function showAlert(message){
			BootstrapDialog.alert({
				title: '<spring:message code="tds.common.label.alertTitle"/>',
				message: message,
				buttonLabel: '<spring:message code="tds.common.label.alertButtonText"/>'
			});
		} */
		
		 $('#rMenu a').click(function(){
			var whatfor = $(this).attr('for');
			switchOperation(whatfor);
		});
		
		//$('#saveGroup').click(clickSaveGroup);
		
		
	</script>
	<script src="${ctx }/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
	<script src="${ctx }/tds/common/ztree-ext.js"></script>
	<script type="text/javascript" src="${ctx }/tds/rightgroup/js/rightgroup.content.js"></script>
	<script type="text/javascript" src="${ctx }/tds/rightgroup/js/rightgroup.group.js"></script>
	<jsp:include page="/tds/common/dialog.js.jsp"></jsp:include>
	<script src="${ctx }/tds/static/scrollbar/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script type="text/javascript">
		initAuthorityOperationGroup('auth-group-tree');
		BootstrapDialog.configDefaultOptions({ animate: false,closeByBackdrop: false });
		function openFirstNode(zTree,treeId){
			var firstNodeId = $('#'+ treeId).children('li:first').attr('id');
			if( zTree && isNotNullAndEmpty(firstNodeId) ){
				var firstNode = zTree.getNodeByTId(firstNodeId);
				if(firstNode){
					zTree.expandNode(firstNode,true,false,true);
					zTree.selectNode(firstNode);
				}
			}
		}
		function initTreeBodyHeight(){
			var headerHeight = $('.panel-heading:eq(0)').outerHeight(true);
			$('.tree-panel-body').css('height','100%').css('padding-top',headerHeight + 'px').css('margin-top','-' + headerHeight + 'px');
			//$('.tree-panel-body-content').css('height','95%').css('overflow','auto');
		}
		initTreeBodyHeight();
		$(function(){
			$(".panel-body-content").mCustomScrollbar({
				theme: 'minimal-dark'
			});
		});
		
	</script>
</body>
</html>