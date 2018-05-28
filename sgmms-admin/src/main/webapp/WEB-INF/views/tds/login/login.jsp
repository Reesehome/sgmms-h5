<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>管理首页</title>
	
	<!-- bootstrap -->
	<jsp:include page="/tds/common/ui-lib.jsp" />
	
	<!-- this page specific styles -->
	<link rel="stylesheet" href="${ctx}/tds/login/css/login.css" type="text/css" media="screen" />

	<jsp:include page="/tds/login/js/login.js.jsp" />
</head>
<body>
	<div class="main">
		<c:if test="${errorMsg != null and errorMsg != ''}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<p class="text-center">
					<strong>${errorMsg}</strong>
				</p> 
			</div>
		</c:if>
		
		<form id="loginForm" action="${ctx}/login/login.do" method="post" onkeypress="loginBtnPress(event)">
			<div class="form-wrapper">
		    	<div class="form-main">
		        	<span class="fm-img">
		            	<span class="fmi-logo"><img src="${ctx}/tds/login/images/logo.png" width="240" height="150" /></span>
		                <span class="fmi-logo-text">天讯瑞达基础平台 </span>
		            </span>
		            <span class="fm-language">
		            	<div id="langSelect" class="fml-lang-select" onclick="selLanguageClick(event)">
			            	<c:forEach items="${dictionaryLangs}" var="dictionaryLang">
				            	<c:if test="${dictionaryLang.itemValue == langType}">
		                    			<span id="langLabel" value="${dictionaryLang.itemValue}">${dictionaryLang.itemName}</span>
		                    	</c:if>
	                    	</c:forEach>
			            	<input type="hidden" id="langType" name="langType" value="zh_CN"/>
		            	</div>
		            	<div id="fml-lang-container">
		            		<c:forEach items="${dictionaryLangs}" var="dictionaryLang">
		            			<div class="fml-lang-option" onclick="changeLang(this)" value="${dictionaryLang.itemValue}">${dictionaryLang.itemName}</div>
		            		</c:forEach>
		            	</div>
		            </span>
		            <span class="fm-tab">
		            	<span class="fmt-row">
		                	<span class="fmtr-title"><spring:message code="tds.login.label.loginName"/>：</span>
		                    <span class="fmtr-input-span">
		                    	<span class="fmtris-icon icon-user"></span>
		                        <input class="fmtris-input" type="text" name="loginName" value="${fn:trim(user.loginName)}"/>
		                    </span>
		                </span>
		                <span class="fmt-row">
		                	<span class="fmtr-title"><spring:message code="tds.login.label.password"/>：</span>
		                <span class="fmtr-input-span">
		               	<span class="fmtris-icon icon-paw"></span>
							<input class="fmtris-input" type="password" name="password" value="${user.password}"/>
		                </span>
		                </span>
		                
		                <c:if test="${useVerifyCode}">
			                <span class="fmt-row">
			                	<span class="fmtr-title"><spring:message code="tds.login.label.captcha"/>：</span>
			                    <span class="fmtr-tip-span">
			                   		<input class="fmtris-vcode-input" type="text" name="verifyCode" />
			                    	<span class="fmtrts-vcode-img"><img id="verifyCodeImg" onclick="generateVerifyCode()" src="${ctx}/login/generateVerifyCode.do"/></span>
			                    </span>
			                </span>
		                </c:if>
		                
		                <!-- 
		                <span class="fmt-row" style="margin-top:-5px;">
		                	<span class="fmtr-title"></span>
		                    <span class="fmtr-tip-span">
		                    	<input class="fmtrts-input-checkbox" type="checkbox" id="rememberId"/>
		                        <label class="fmtrts-vcode-text" for="rememberId">记住密码</label>
		                    </span>
		                </span>
		                 -->
		                <span class="fmt-row">
		                	<span class="fmtr-title"></span>
		                    <span class="fmtr-btn-span">
		                    	<span class="login-btn" onclick="login()"><spring:message code="tds.login.label.login"/></span>
		                    </span>
		                </span>
		            </span>
		            <span class="fm-copy">
		            	为了提高系统的使用性能，请尽量使用谷歌浏览器。
		            	外网用户可以从谷歌官网在线安装。
		            	内网用户点击<a href='${ctx}/tds/common/chrome-browser/chrome.exe' style="color: red;">这里</a>下载安装。
		            </span>
		        </div>
		    </div>
	    </form>
	</div>
</body>
</html>