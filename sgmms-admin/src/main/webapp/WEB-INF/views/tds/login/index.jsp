<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/tds/common/tag-lib.jsp" %>


<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>管理首页</title>

    <jsp:include page="/tds/common/ui-lib.jsp"/>

    <link rel="stylesheet" href="${ctx}/tds/static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="${ctx}/tds/common/ztree-ext.css" type="text/css">
    <link rel="stylesheet" href="${ctx}/tds/index/css/index.css">

    <link rel="stylesheet" href="${ctx}/tds/menu-right/css/menuRight.css" type="text/css">

    <script type="text/javascript" src="${ctx}/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>

    <script type="text/javascript" src="${ctx}/tds/static/IframeOnClick.js"></script>

    <script type="text/javascript" src="${ctx}/tds/static/iframeResizer.min.js"></script>

    <jsp:include page="/tds/index/js/index.js.jsp"/>

    <style>
        #mainContainer {
            height: 100% !important;
        }
    </style>
</head>
<body style="min-width:1200px; height: 100%">
<!--================== 头部  开始 ==================-->
<div id="top-nav" class="navbar navbar-static-top">
    <div class="container-fluid">
        <div class="row-custom">
            <div class="col-md-3">
                <div class="navbar-header" style="overflow: hidden;">
                    <a class="navbar-brand navbar-custom" href="#">
                        <span> <img border="0" src="${ctx}/${appIcon}"> ${appTitle}</span>
                    </a>
                </div>
            </div>

            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <div class="navbar-collapse collapse">
                            <ul class="nav navbar-nav navbar-right" style="margin-right: 7px;">

                                <!-- 消息开始 -->
                                <c:forEach items="${messageGroups}" var="messageGroup">
                                    <c:if test="${messageGroup.messageCount > 0}">
                                        <li class="dropdown" data-toggle="tooltip" data-placement="bottom"
                                            title="${messageGroup.tips}">
                                            <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
                                                <span><img src="${ctx}/${messageGroup.icon}"></span>
                                                <span id="${messageGroup.msgGroupId}"
                                                      class="badge">${messageGroup.messageCount}</span>
                                                <span class="caret"></span>
                                            </a>
                                            <ul id="g-account-menu" class="dropdown-menu" role="menu">
                                                <c:forEach items="${messageGroup.messages}" var="message">
                                                    <li id="${message.msgId}${loginUser.id}">
                                                        <a href="javascript:openMessage('${message.msgId}','${message.url}','${message.target}','${messageGroup.clearType}','${messageGroup.msgGroupId}','${message.msgId}${loginUser.id}');void(0);">
                                                            <span><img
                                                                    src="${ctx}/${message.icon != null ? message.icon : '/tds/index/css/img/msgLevel_info.png'}"></span>&nbsp;
                                                            <span>${message.title}</span>
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <!-- 消息结束 -->

                                <!--　用户开始 -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
                                        <span><img src="${ctx}/tds/index/css/img/user.png"></span>
                                        <span>${loginUser.userName}</span>
                                        <span class="caret"></span>
                                    </a>
                                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
                                        <li><a href="javascript:void(0);" id="personalization"><spring:message
                                                code="tds.personality.label.module"/></a></li>
                                        <li><a href="javascript:showEditPasswordWin();void(0);"
                                               id="changePassword"><spring:message
                                                code="tds.index.label.changePassword"/></a></li>
                                        <li><a href="javascript:void(0);" id="myDashboard"><spring:message
                                                code="tds.index.label.myDashboard"/></a></li>
                                    </ul>
                                </li>
                                <!--　用户结束 -->

                                <!--　语言设置开始 -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
                                        <c:forEach items="${dictionaryLangs}" var="dictionaryLang">
                                            <c:if test="${dictionaryLang.itemValue == langType}">
                                                <span><img
                                                        src="${ctx}/tds/index/css/img/${dictionaryLang.itemValue}.jpg"></span>
                                                <span>${dictionaryLang.itemName}</span>
                                                <span class="caret"></span>
                                            </c:if>
                                        </c:forEach>
                                    </a>
                                    <ul class="dropdown-menu" role="menu">
                                        <c:forEach items="${dictionaryLangs}" var="dictionaryLang">
                                            <li>
                                                <a href="javascript:changeLanguage('${dictionaryLang.itemValue}')">
                                                    <img src="${ctx}/tds/index/css/img/${dictionaryLang.itemValue}.jpg">
                                                    <span>${dictionaryLang.itemName}</span>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>
                                <!--　语言设置结束 -->


                                <!--　退出登录开始 -->
                                <li>
                                    <a class="btn" href="${ctx}/login/logout.do" id="logout">
                                        <span><img src="${ctx}/tds/index/css/img/logout.png"></span>
                                        <span><spring:message code="tds.index.label.logout"/></span>
                                    </a>
                                </li>
                                <!--　退出登录结束 -->

                                <!--　头部菜单开始 -->
                                <li id="headerMenuLI" class="dropdown" style="display: none;">
                                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
                                        <span><img src="${ctx}/tds/index/css/img/menu.png"></span>
                                        <span><spring:message code="tds.index.label.menu"/></span>
                                        <span class="caret"></span>
                                    </a>
                                    <ul id="g-account-menu" class="dropdown-menu" role="menu"
                                        style="padding: 0px;margin: 0px;">
                                        <li>
                                            <div style="width:220px;">
                                                <div class="panel panel-no-border">
                                                    <div id="demoManage" class="menu-switch-bar">
                                                        <div class="panel-body panel-body-no-border text-right">
                                                            <span style="color: green;"><spring:message
                                                                    code="tds.index.label.expandingMenus"/></span>
                                                            <button class="btn btn-sm btn-primary" style="margin: 5px;"
                                                                    onclick="showMenu()">
                                                                <span class="glyphicon glyphicon-chevron-right"></span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="headerMenuContent">
                                                    <div id="headerMenuTree" class="ztree"
                                                         style="padding: 0px;margin: 0px;"></div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <!--　头部菜单结束 -->

                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div id="shortcut" class="col-md-12">
                        <div class="navbar-collapse collapse">
                            <ul class="nav navbar-nav navbar-right" style="margin-right: -5px;">
                                <c:forEach items="${shortcuts}" var="shortcut" varStatus="status" end="4">
                                    <li>
                                        <a href="javascript:openShortcut('${shortcut.url}','');void(0);">
                                            <span><img src="${ctx}/${shortcut.icon}"></span>
                                            <span>${shortcut.rightName}</span>
                                        </a>
                                    </li>
                                </c:forEach>

                                <c:if test="${fn:length(shortcuts) > 5}">
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
                                            <span><img src="${ctx}/tds/index/css/img/more.png"></span>
                                            <span><spring:message code="tds.common.label.more"/></span>
                                            <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu" role="menu">
                                            <c:forEach items="${shortcuts}" var="shortcut" begin="5">
                                                <li>
                                                    <a href="javascript:openShortcut('${shortcut.url}','');void(0);"
                                                       style="color: #000000">
                                                        <span><img src="${ctx}/${shortcut.icon}"></span>
                                                        <span>${shortcut.rightName}</span>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--
		        <div class="navbar-header">
		            <a class="navbar-brand navbar-custom" href="#">
		            	<span> <img border="0" src="${ctx}/${appIcon}"> ${appTitle}</span>
		            </a>
		        </div>
		        
		        <div class="navbar-collapse collapse">
		            <ul class="nav navbar-nav navbar-right" style="margin-right: 1px;">
		            	<li class="dropdown">
		                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
		                    	<span><img src="${ctx}/tds/index/css/img/email.png"></span>
		                    	<span class="badge">3</span>
		                    	<span class="caret"></span>
		                    </a>
		                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
		                        <li><a href="javascript:void(0);">xx点开会</a></li>
		                        <li><a href="javascript:void(0);">合同已审批</a></li>
		                    </ul>
		                </li>
		            
		                <li class="dropdown">
		                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
		                    	<span><img src="${ctx}/tds/index/css/img/user.png"></span> <span>${loginUser.userName}</span>
		                    	<span class="caret"></span>
		                    </a>
		                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
		                        <li><a href="javascript:void(0);" id="personalization"><spring:message code="tds.personality.label.module"/></a></li>
		                        <li><a href="javascript:showEditPasswordWin();void(0);" id="changePassword"><spring:message code="tds.index.label.changePassword"/></a></li>
		                    </ul>
		                </li>
		                
		                <li class="dropdown">
		                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
		                    	<c:choose>
		                    		<c:when test="${'CN' == sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'].country}">
		                    			<span><img src="${ctx}/tds/index/css/img/chiness.jpg"></span> 
		                    			<span>简体中文</span> 
		                    			<span class="caret"></span>
		                    		</c:when>
		                    		
		                    		<c:when test="${'TW' == sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'].country}">
		                    			<span><img src="${ctx}/tds/index/css/img/hongkong.jpg"></span> 
		                    			<span>繁體中文</span> 
		                    			<span class="caret"></span>
		                    		</c:when>
		                    		
		                    		<c:otherwise>
		                    			<span><img src="${ctx}/tds/index/css/img/english.jpg"></span> 
		                    			<span>English</span> 
		                    			<span class="caret"></span>
		                    		</c:otherwise>
		                    	</c:choose>
		                    </a>
		                    <ul class="dropdown-menu" role="menu">
		                        <li><a href="javascript:changeLanguage('zh')"><img src="${ctx}/tds/index/css/img/chiness.jpg"> <span>简体中文</span></a></li>
		                        <li><a href="javascript:changeLanguage('zh-tw')"><img src="${ctx}/tds/index/css/img/hongkong.jpg"> <span>繁體中文</span></a></li>
		                        <li><a href="javascript:changeLanguage('en')"><img src="${ctx}/tds/index/css/img/english.jpg"> <span>English</span></a></li>
		                    </ul>
		                </li>
		                
		                <li>
		                	<a class="btn" href="${ctx}/login/logout.do" id="logout">
		                		<span><img src="${ctx}/tds/index/css/img/logout.png"></span> 
		                		<span><spring:message code="tds.index.label.logout"/></span>
		                	</a>
		                </li>
		                
		                <li id="headerMenuLI" class="dropdown" style="display: none;">
		                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">
		                    	<span><img src="${ctx}/tds/index/css/img/menu.png"></span> 
		                    	<span><spring:message code="tds.index.label.menu"/></span> 
		                    	<span class="caret"></span>
		                    </a>
		                    <ul id="g-account-menu" class="dropdown-menu" role="menu" style="padding: 0px;margin: 0px;">
	                       		<li>
	                       			<div style="width:220px;">
	                       				<div class="panel panel-no-border">
											<div id="demoManage" class="menu-switch-bar">
												<div class="panel-body panel-body-no-border text-right">
													<span style="color: green;"><spring:message code="tds.index.label.expandingMenus"/></span>
													<button class="btn btn-sm btn-primary"  style="margin: 5px;" onclick="showMenu()">
														<span class="glyphicon glyphicon-chevron-right"></span>
													</button>
												</div>
											</div>
										</div>
		                       			<div id="headerMenuContent">
		                       				<div id="headerMenuTree" class="ztree" style="padding: 0px;margin: 0px;"></div>
		                       			</div>
									</div>
	                       		</li>
							</ul>
						</li>
					</ul>
				</div>
				 -->
    </div>
</div>
<!--================== 头部  结束 ==================-->

<div class="container-fluid" style="height: calc(100% - 85px);">
    <div class="row" style="height: 100%">
        <!--================== 左边菜单 开始 ==================-->
        <div id="menuColumn" class="col-md-2 col-xs-2" style="padding: 0px;margin: 0px;min-width:200px;">
            <div>
                <div class="panel panel-no-border">
                    <div class="menu-switch-bar">
                        <div class="panel-body panel-body-no-border text-right">
                            <span style="color: green;"><spring:message code="tds.index.label.hiddenMenus"/></span>
                            <button class="btn btn-primary" style="margin: 5px;" onclick="hideMenu()">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </button>
                        </div>
                    </div>
                </div>

                <div id="menuContent">
                    <div id="menuTree" class="ztree"></div>
                </div>
            </div>
        </div>
        <!--================== 左边菜单  结束 ==================-->


        <!--================== 右边容器  开始 ==================-->
        <div id="mainContainerDIV" class="col-md-10 col-xs-10" style="height: 100%">
            <iframe name="mainContainer" id="mainContainer"
                    marginwidth="0"
                    marginheight="0"
                    frameborder="0"
                    scrolling="no"
                    style="width:100%;"></iframe>
        </div>
        <!--================== 右边容器 结束 ==================-->
    </div>
</div>

<!-- 树右键菜单 -->
<div id="treeRightMenu" class="list-group">
    <a href="javascript:treeRightMenuOnClick('B');void(0);" class="list-group-item list-group-item-info"><spring:message
            code="tds.menuRight.label.newWindow"/></a>
    <a href="javascript:treeRightMenuOnClick('W');void(0);" class="list-group-item list-group-item-info"><spring:message
            code="tds.menuRight.label.mainWorkspace"/></a>
    <a href="javascript:treeRightMenuOnClick('M');void(0);" class="list-group-item list-group-item-info"><spring:message
            code="tds.menuRight.label.NavigationAndMain"/></a>
</div>
</body>
</html>