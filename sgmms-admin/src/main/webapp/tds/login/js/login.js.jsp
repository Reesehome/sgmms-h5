<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
	if (self != top) {
		window.top.location.href = "${ctx}/";
	}

	isLogin();
	
	$(function() {
		var ch = $(document).height();
		var imgh = 1200;
		var formh = 440;
		if (ch < imgh) {
			$(".main").css("height", ch);
			$(".form-main").css({
				"margin-top" : (ch * 0.31) + "px"
			});
		} else {
			$(".main").css({
				"height" : imgh,
				"margin-top" : ((ch - imgh) / 2) + "px"
			});
			$(".form-main").css({
				"margin-top" : "430px"
			});

		}

		$("body").click(function() {
			$("#fml-lang-container").hide();
		});

		$("#langType").val($("#langLabel").attr("value"));
	});
	
	function isLogin() {
		$.tdsAjax({
			url : ctx + "/login/isLogin.do",
			cache : false,
			dataType : "json",
			success : function(isLogin) {
				if (isLogin) {
					//刷新页面
					window.location.href = "${ctx}/login/login.do";
				}
			}
		});
	}
	

	function generateVerifyCode() {
		$("#verifyCodeImg").attr("src","${ctx}/login/generateVerifyCode.do?" + Math.random());
	}
	
	
	function loadLanguage() {
		$.tdsAjax({
			url : ctx + "/login/loadLanguage.do",
			cache : false,
			dataType : "json",
			success : function(result) {
				if (result.success) {
					//刷新页面
					window.location.reload();
				} else {
					BootstrapDialog.show({
						title : '<spring:message code="tds.common.label.errorMessage"/>',
						size : BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_WARNING,
						message : result.message,
						buttons : [ {
							label : '<spring:message code="tds.common.label.close"/>',
							action : function(dialogItself) {
								dialogItself.close();
							}
						} ]
					});
				}
			}
		});
	}
	

	function login() {
		$("#loginForm").submit();
	}
	

	function loginBtnPress(event) {
		if (event.keyCode == 13)
			login();
	}
	

	function selLanguageClick(event) {
		if ($("#fml-lang-container").is(":hidden")) {
			var position = $("#langSelect").position();
			var top = position.top + 34;

			$("#fml-lang-container").css("left", position.left);
			$("#fml-lang-container").css("top", top);
			$("#fml-lang-container").show();
		} else {
			$("#fml-lang-container").hide();
		}

		//阻止事件向上冒泡
		event.cancelBubble = true;//IE下
		event.stopPropagation();//chrome,firefox等
	}
	

	function changeLang(langOption) {
		var langLabel = $(langOption).text();
		var langValue = $(langOption).attr("value");
		//$("#langLabel").text(langLabel);
		//$("#langType").val(langValue);

		$.tdsAjax({
			url : ctx + "/login/changeLanguage.do?langType="+ langValue,
			cache : false,
			dataType : "json",
			success : function(result) {
				if (result.success) {
					//刷新页面
					window.location.reload();
				} else {
					BootstrapDialog.show({
						title : '<spring:message code="tds.common.label.errorMessage"/>',
						size : BootstrapDialog.SIZE_SMALL,
						type : BootstrapDialog.TYPE_WARNING,
						message : result.message,
						buttons : [ {
							label : '<spring:message code="tds.common.label.close"/>',
							action : function(dialogItself) {
								dialogItself.close();
							}
						} ]
					});
				}
			}
		});
	}
</script>