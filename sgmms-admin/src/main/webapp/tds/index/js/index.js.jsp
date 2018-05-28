<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
	var menuTree;
	var headerMenuTree;
	var readySelectNode;

	$(function(){
		$('[data-toggle="tooltip"]').tooltip();
		
		mainContainerLoaded();
		
		//加载菜单
		loadMenu();
		
		//个性化设置
		$('#personalization').click(function(){
			$("#mainContainer").attr("src",ctx + '/admin/personality/index.do');
		});
		
		//我的面板
		$("#myDashboard").on("click", function() {
			$("#mainContainer").attr("src", ctx + "/admin/dashboard/listDashboard.do");
		});
		
		//其它区域点击的时候隐藏菜单
		$("body").click(function(){
			$("#treeRightMenu").hide();
		});
		
		IframeOnClick.track(document.getElementById("mainContainer"), function() {
			$("body").click();
		});
		
		
		//右边区域打开默认页面
		var linkTarget = "M";
		if("${position}" == "left" || "${position}" == "")
			linkTarget = "W";
		
		openShortcut('${defaultLink}',linkTarget);
		
		//初始化左边菜单容器大小
		initMenuColumnSize();
		
		//绑定左边菜单容器的大小
		$("#menuContent").resize(function(){
			var menuContentHeight = $("#mainContainer").height();
			initMenuColumnSize(menuContentHeight);
		});
	});
	
	var treeSetting = {
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		view: {
			showLine: false,
			showIcon: true,
			selectedMulti: false,
			dblClickExpand: false,
			addDiyDom: addDiyDom,
			expandSpeed:""
		},
		data: {
			simpleData: {
				enable: true,
				pIdKey: "parentId"
			}
		},
		callback: {
			beforeClick: beforeClick,
			onRightClick : zTreeOnRightClick,
			onClick : function(event, treeId, treeNode){
				if(treeNode.url){
					var url = bulidURL(treeNode.url);
					$("#mainContainer").attr("src",url);
					window.scrollTo(0,0);
				} else {
					//阻止事件向上冒泡
					event.cancelBubble = true;//ＩＥ下
					event.stopPropagation();//chrome,firefox等
				}
			}
		}
	};
	
	
	/**
	 * 树节点点击回调事件
	 */
	function treeRightMenuOnClick(linkTarget) {
		//指定主区域的跳转到相应页面
		if(readySelectNode.url){
			openShortcut(readySelectNode.url,linkTarget);
		}
	}
	
	/**
	 * 树节点右键点击回调事件
	 */
	function zTreeOnRightClick(event, treeId, treeNode) {
		//顶部菜单或者菜单组不弹出右键菜单
		if(!treeNode.url || "headerMenuTree" == treeId)
			return;
		
		
		var topScro = $(document).scrollTop();
		
		//设置菜单坐标
		$("#treeRightMenu").css("left",event.clientX);
		$("#treeRightMenu").css("top",event.clientY + topScro);
		$("#treeRightMenu").show();
		
		readySelectNode = treeNode;
	}
	
	/**
	* 根据ＵＲＬ是否包含http://来构造网址，以方便准确地跳转到内网或者是外网
	*/
	function bulidURL(url){
		//在内部跳转，否则跳转到外网
		if(url.indexOf("http://") == 0 || url.indexOf("https://") == 0){
			return url;
		}else{
			return '${ctx}' + url;
		}
	}

	
	/**
	* 弹出密码修改窗口
	*/
	function showEditPasswordWin() {
		BootstrapDialog.show({
			title : '<spring:message code="tds.common.label.editData"/>',
	        message: $('<div></div>').load(ctx + "/admin/orguser/loadPasswordChangePage.do"),
	        buttons : [
				{
					label : '<spring:message code="tds.common.label.submit"/>',
					cssClass: 'btn-primary',
					action : editPassword
				},
				{
					label : '<spring:message code="tds.common.label.close"/>',
					action : function(dialogItself){
						dialogItself.close();
					}
				}
	        ]
	    });
	}
	

	/**
	* 保存密码修改信息
	*/
	function editPassword(dialogItself) {
		//验证结果正确再提交
		var validResult = $("#passwordForm").valid();
		if(validResult){
			var params = $("#passwordForm").serialize();
			$.tdsAjax({
				url:ctx + "/admin/orguser/changePassword.do",
				cache:false,
				dataType:"json",
				data:params,
				success: function(result){
					if(result.success) {
						dialogItself.close();
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_SUCCESS,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(_dialogItself){
				                	_dialogItself.close();
				                }
				            }]
				        });
						window.location.href = "${ctx}/login/logout.do";
					} else{
						BootstrapDialog.show({
							title: '<spring:message code="tds.common.label.errorMessage"/>',
				            size: BootstrapDialog.SIZE_SMALL,
				            type : BootstrapDialog.TYPE_WARNING,
				            message: result.message,
				            buttons: [{
				                label: '<spring:message code="tds.common.label.close"/>',
				                action: function(dialogItself){
				                    dialogItself.close();
				                }
				            }]
				        });
					}
				}
			});
		}
	}
	
	
	/**
	* 树节点加载前的事件
	*/
	function addDiyDom(treeId, treeNode) {
		//每个节点前添加间隔
		var spaceWidth = 18;
		var switchObj = $("#" + treeNode.tId + "_switch");
		var icoObj = $("#" + treeNode.tId + "_ico");
		
		switchObj.remove();
		
		if (treeNode.level > 0) {
			spaceWidth = spaceWidth * (treeNode.level + 1);
		}
		
		var spaceStr = "<span style='display: inline-block;width:" + spaceWidth + "px'></span>";
		icoObj.before(spaceStr);
		
		//添加徽章
		var linkObj = $("#" + treeNode.tId + "_a");
		var children = linkObj.children();
		children.wrapAll("<div style='float:left;position:absolute;z-index: 2;'></div>");
		
		if(treeNode.params){
			var alerts = treeNode.params.alerts;
			if(alerts && alerts.length > 0) {
				
				//截取太长的名字
				if(alerts && alerts.length > 1){
					var labelObj = $("#" + treeNode.tId + "_span");
					if(labelObj.text().length > 12){
						var labelText = labelObj.text().substr(0,12) + "...";
						labelObj.text(labelText);
					}
				}
				
				var badge = "<div style='right:5px;margin-right:5px;position:absolute;z-index: 3;'>";
				$.each(alerts,function(index,alert) {
					badge += "<span class='tree_badge_" + alert.type + "'>" + alert.count + "</span>";
				});
				
				badge += "</div>";
				
				linkObj.append(badge);
			}
		}
	}

	/**
	* 树节点点击前的事件
	*/
	function beforeClick(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		zTree.expandNode(treeNode);
	}
	
	/**
	* 加载菜单
	*/
	function loadMenu() {
		$.tdsAjax({
			url:"${ctx}/admin/menuRight/findMenusByUser.do",
			cache:false,
			async:false,
			success: function(result){
				var menus = result.params.menus;
				menuTree = $.fn.zTree.init($("#menuTree"), treeSetting, menus);
				headerMenuTree = $.fn.zTree.init($("#headerMenuTree"), treeSetting, menus);
			}
		});
	}
	
	/**
	* 绑定iframe内容宽高变化事件，以使其高度自动适应内容
	*/
	function mainContainerLoaded(){
		var isOldIE = (navigator.userAgent.indexOf("MSIE") !== -1); // Detect IE10 and below
		iFrameResize({
			checkOrigin: false, 
			//heightCalculationMethod:'documentElementScroll',
			heightCalculationMethod: isOldIE ? 'max' : 'lowestElement',
			resizedCallback : function(messageData){
				/*
				console.info("***********" + messageData.height)
				if(messageData.height < $(document).height())
					$("#mainContainer").height($(document).height() - $("#top-nav").height() - 6);
				else
					$("#mainContainer").height(messageData.height);
				*/
				
				//重设左边菜单容器大小
				initMenuColumnSize(messageData.height);
			}
		});
	}
	
	/**
	* 初始化左边菜单容器大小
	*/
	function initMenuColumnSize(mainContainerHeight){
		$("#menuColumn").height(0);
		var documentHeight = $(document).height();
		var menuColumnHeight = $("#menuColumn").height();
		var menuContentHeight = $("#menuContent").height();
		if(mainContainerHeight > menuContentHeight && mainContainerHeight > documentHeight) {
			$("#menuColumn").height(mainContainerHeight);
		} else {
			if(documentHeight > menuContentHeight)
				$("#menuColumn").height(documentHeight - $("#top-nav").height() - 6);
			else
				$("#menuColumn").height(menuContentHeight);
		}
		
		//$("#menuColumn").height($(document).height() - $("#top-nav").height() - 6);
	}
	
	/**
	* 指定主区域的跳转到相应页面
	*/
	function changeLanguage(langType){ 
		$.tdsAjax({
			url:ctx + "/login/changeLanguage.do?langType=" + langType,
			cache:false,
			dataType:"json",
			success: function(result){
				if(result.success) {
					//刷新页面
					window.location.reload(); 
				} else{
					BootstrapDialog.show({
						title: '<spring:message code="tds.common.label.errorMessage"/>',
			            size: BootstrapDialog.SIZE_SMALL,
			            type : BootstrapDialog.TYPE_WARNING,
			            message: result.message,
			            buttons: [{
			                label: '<spring:message code="tds.common.label.close"/>',
			                action: function(dialogItself){
			                    dialogItself.close();
			                }
			            }]
			        });
				}
			}
		});
	}
	
	/**
	* 隐藏菜单点击事件
	*/
	function hideMenu(){
		if($("#headerMenuLI").css("display") == "block")
			return
		
		//折叠全部头部菜单的节点
		headerMenuTree.expandAll(false);
		
		//找出左边树所有展开的节点，并把头部菜单树相同的节点展开
		var openedNodes = menuTree.getNodesByParam("open",true,null);
		$.each(openedNodes,function(index,openedNode){
			var curNode = headerMenuTree.getNodeByParam("id", openedNode.id, null);
			headerMenuTree.expandNode(curNode);
		});
		
		//设置当前选中的节点
		var selectedNodes = menuTree.getSelectedNodes();
		if(selectedNodes && selectedNodes.length > 0){
			var willSelect = headerMenuTree.getNodeByParam("id", selectedNodes[0].id, null);
			headerMenuTree.selectNode(willSelect);
		}
		
		//隐藏左边菜单
		$("#menuColumn").hide();
		$("#mainContainerDIV").attr("class","col-md-12");
		
		//显示顶部菜单
		$("#headerMenuLI").show();
		
		//刷新我的桌面
		var cWin = $("#mainContainer")[0].contentWindow;
		cWin.$ && cWin.$.refreshGridster && cWin.$.refreshGridster();
	}
	
	/**
	* 显示菜单点击事件
	*/
	function showMenu(){
		if($("#menuColumn").css("display") == "block")
			return
		
		//折叠全部左边菜单的节点
		menuTree.expandAll(false);
		
		//找出头部树所有展开的节点，并把左边菜单树相同的节点展开
		var openedNodes = headerMenuTree.getNodesByParam("open",true,null);
		$.each(openedNodes,function(index,openedNode){
			var curNode = menuTree.getNodeByParam("id", openedNode.id, null);
			menuTree.expandNode(curNode);
		});
		
		//设置当前选中的节点
		var selectedNodes = headerMenuTree.getSelectedNodes();
		if(selectedNodes && selectedNodes.length > 0){
			var willSelect = menuTree.getNodeByParam("id", selectedNodes[0].id, null);
			menuTree.selectNode(willSelect);
		}
		
		//显示左边菜单
		$("#menuColumn").attr("class","col-md-2");
		$("#mainContainerDIV").attr("class","col-md-10");
		$("#menuColumn").show();
		
		//隐藏顶部菜单
		$("#headerMenuLI").hide();
		
		//刷新我的桌面
		var cWin = $("#mainContainer")[0].contentWindow;
		cWin.$ && cWin.$.refreshGridster && cWin.$.refreshGridster();
	}
	
	/**
	* 打开消息页面
	*/
	function openMessage(msgId,url,target,clearType,msgGroupId,fieldId) {
		
		openShortcut(url,target);
		
		//清除消息
		$.tdsAjax({
			url:ctx + "/admin/message/deleteMessage.do?msgId=" + msgId + "&clearType="+clearType,
			cache:false,
			dataType:"json",
			success: function(result){
				if(result.success) {
					//刷新页面
					var badge = $("#"+msgGroupId).text() - 1;
					if(badge <= 0)
						$("#"+msgGroupId).remove();
					else
						$("#"+msgGroupId).text(badge);
					
					$("#"+fieldId).remove();
				}
			}
		});
	}
	
	/**
	 * 打开快捷菜单
	 */
	function openShortcut(url,linkTarget) {
		//如果显示方式为导航区+主区域就把左边菜单隐藏，否则就显示左边菜单
		if(linkTarget == "M")
			hideMenu();
		else if(linkTarget == "W")
			showMenu();
		
		if(!url)
			return;
		
		//指定主区域的跳转到相应页面
		var url = bulidURL(url);
		
		//新窗口打开
		if(linkTarget == "B"){
			window.open(url);
		}else{
			$("#mainContainer").attr("src",url);
		}
	}
</script>