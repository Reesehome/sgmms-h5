<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Personality</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<link rel="stylesheet" href="${ctx }/tds/static/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${ctx }/tds/common/ztree-ext.css">
<style type="text/css">
	.module-header{height: 40px;vertical-align: middle;display: table-cell; }
	ul.dropdown-menu{width: auto;max-height: 300px;overflow: auto;padding-right: 20px;}
	ul.dropdown-menu li{padding-left:20px;margin-left:-20px;}
	.form-horizontal .form-group{margin-left: 0px;margin-right: 0px;}
	.options-box{display: inline-block;background-color: white;border: 1px solid #dddddd;margin: 5px 5px;height:300px;border-radius: 5px;}
	.options-box .ztree{height: 100%;width: 100%;overflow: auto;}
	.options-box .options-wrapper{text-align:center;width: 100%;height: 100%;padding: 5px inherit;}
	.options-box .options-wrapper .item-list{ width:100%;height: 100%;overflow: auto;border: none;}
	.options-box .options-wrapper button{margin-top: 30%;width: 80%;text-align: center;}
	.item-list li{text-align: left;cursor: pointer;border: none;}
	.item-list li:hover{background-color: #337ab7;color: white;filter:alpha(opacity=65);opacity:.65;}
	.item-list .item-selected{background-color: #337ab7;color: white;}
	.rotate{
	    -ms-transform:rotate(90deg); /* IE 9 */
	    -moz-transform:rotate(90deg); /* Firefox */
	    -webkit-transform:rotate(90deg); /* Safari and Chrome */
	    -o-transform:rotate(90deg); /* Opera */
	}
	.input-group-btn:not(:last-child)>.btn{border-radius: 0;margin-left: -1px;}
</style>
</head>
<body style="overflow: hidden;">
	<div class="container-fluid">
		<div class="module-header">
			<strong><i class="glyphicon glyphicon-user"></i> <spring:message code="tds.personality.label.module"/></strong>
		</div><!-- module-header -->
			
		<div class="row">
			<div>
				<form id="PersonalityForm" class="form-horizontal">
					<div class="form-group" style="background-color: #eeeeee;padding: 10px 5px;">
						<label class="col-sm-2 control-label" for="menuName"><spring:message code="tds.personality.label.homepage"/></label>
						<div class="col-sm-7 input-group" style="padding-left: 5px;padding-right: 5px;float:left;">
							<input id="menuName" name="menuName" type="text" class="form-control" readonly="readonly" value="${property.homepage.propName }">
							<input type="hidden" name="menuId" id="menuId" value="${property.homepage.propValue }"/>
							<input type="hidden" name="menuType" id="menuType" value="${property.homepageType.propValue }"/>
							<div class="input-group-btn">
						        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><spring:message code="tds.index.label.menu"/> <span class="caret"> </span></button>
						        <ul id="personality-homepage-tree" class="dropdown-menu dropdown-menu-right ztree">
						        </ul>
						    </div>
						    <div class="input-group-btn">
						        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><spring:message code="tds.personality.label.dashboard"/>  <span class="caret"> </span></button>
						        <ul id="personality-dashboard-tree" class="dropdown-menu dropdown-menu-right ztree">
						        </ul>
						    </div><!-- /btn-group -->
						</div>
						<div class="col-sm-1">
							<div class="btn-group">
								<button type="button" class="btn btn-primary" onclick="savePersonality();"><spring:message code="tds.common.label.save"/></button>
							</div>
						</div>
						<div class="col-sm-12" style="height: 5px;"></div>
						<label class="col-sm-2 control-label" for="position"><spring:message code="tds.personality.label.menuposition"/></label>
						<div class="col-sm-7">
							<select id="position" name="position" class="form-control">
								<c:forEach items="${position }" var="aPosition">
									<option value="${aPosition.value }">${aPosition.name }</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="col-sm-12" style="height: 5px;"></div>
						<label class="col-sm-2 control-label" for="timeZone">所属时区</label>
						<div class="col-sm-7">
							<select id="timeZone" name="timeZone" class="form-control"></select>
						</div>
					</div>
					
					<div class="form-group">
						<div class="module-header">
							<strong><spring:message code="tds.personality.label.myshortcut"/></strong>
						</div>
					</div>
					
					<div class="form-group" style="border: 1px solid #EEEEEE;padding: 5px;boder-radius: 5px;background-color: #eeeeee;">
						<div class="col-sm-4 options-box">
							<!-- 所有菜单 -->
							<ul id="all-menu-tree" class="ztree"></ul>
						</div>
						<div class="col-sm-1 options-box" style="width: 100px;">
							<div class="options-wrapper">
								<button type="button" class="btn btn-default" onclick="addMenu();">
									<i class="glyphicon glyphicon-menu-right"></i><i class="glyphicon glyphicon-menu-right"></i>
								</button>
								<button type="button" class="btn btn-default" onclick="removeMenu();">
									<i class="glyphicon glyphicon-menu-left"></i><i class="glyphicon glyphicon-menu-left"></i>
								</button>
								<button type="button" class="btn btn-default" onclick="removeAllMenu();">
									<i class="glyphicon glyphicon-triangle-left"></i><i class="glyphicon glyphicon-triangle-left"></i>
								</button>
							</div>
						</div>
						<div class="col-sm-4 options-box">
							<div class="options-wrapper">
								<ul id="existedMenu" class="list-unstyled item-list"></ul>
							</div>
						</div>
						<div class="col-sm-1 options-box" style="width: 100px;">
							<div class="options-wrapper">
								<button type="button" class="btn btn-default" onclick="moveElement('top');">
									<i class="glyphicon glyphicon-step-backward rotate"></i>
								</button>
								<button type="button" class="btn btn-default" onclick="moveElement('upward');">
									<i class="glyphicon glyphicon-menu-up"></i>
								</button>
								<button type="button" class="btn btn-default" onclick="moveElement('downward');">
									<i class="glyphicon glyphicon-menu-down"></i>
								</button>
								<button type="button" class="btn btn-default" onclick="moveElement('bottom');">
									<i class="glyphicon glyphicon-step-forward rotate"></i>
								</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function getContext(){
			return '${ctx }';
		}
		
		//检查是否已选择 true:存在;false:不存在
		function checkMenuIsExisted(value,array){
			return array!=null && $.inArray(value, array)>-1;
		}
		
		/**
		* 获取已选择的快捷菜单
		* 返回id数组
		*/
		function getExistedId(){
			var existedMenu = $('#existedMenu').children();
			if(!existedMenu || existedMenu.length==0) return null;
			var idArray = new Array(existedMenu.length);
			$.each(existedMenu,function(idx,aMenu){
				idArray[idx] = $(aMenu).children('input[name="rightId"]').val();
			});
			return idArray;
		}
		
		/*
		* 将选择的菜单插入快捷菜单类表（最后）
		*/
		function appendSelectedMenu(id,name){
			var li = $('<li>');
			li.text(name);
			var idInput = $('<input type="hidden" name="rightId"/>');
			idInput.val(id);
			li.append(idInput);
			bindClick(li);
			$('#existedMenu').append(li);
		}
		
		/*
		* 初始化页面，将快捷菜单记录放入列表中
		*/
		function addMenu(){
			var nodeArray = getSelectedMenu();
			if(!nodeArray) return;
			var existedMenuId = getExistedId();
			$.each(nodeArray,function(idx,aNode){
				var existed = checkMenuIsExisted(aNode.id,existedMenuId);
				if(!existed){
					appendSelectedMenu(aNode.id,aNode.name);
				}else{
					showAlert( '<spring:message code="tds.personality.message.menuexisted"/>' );
				}
			});
		}
		
		/*
		* 从快捷菜单列表中移除已选择的菜单
		*/
		function removeMenu(){
			$('#existedMenu').children('.item-selected').remove();
		}
		
		/*
		* 从快捷菜单列表中移除所有菜单
		*/
		function removeAllMenu(){
			$('#existedMenu').children().remove();
		}
		
		/*
		* 绑定快捷菜单的点击事件
		*/
		function bindClick(object){
			object.click(function(){
				var hasItemClass = $(this).hasClass('item-selected');
				if(hasItemClass) $(this).removeClass('item-selected');
				else $(this).addClass('item-selected');
			});
		}
		
		/*
		* 初始化页面内容
		*/
		function initPageData(){
			
			var homepage = '${property.homepage.propValue }';
			var homepageName = '${property.homepage.propName }';
			var homepageType = '${property.homepageType.propValue}';
			$('#menuId').val(homepage);
			$('#menuName').val(homepageName);
			$('#menuType').val(homepageType);
			
			var position = '${property.position.propValue }';
			$('#position').val(position);
			
			var foundShortcut = '${shortcut}';
			var shorcut = eval('(' + foundShortcut + ')');
			if(shorcut){
				$.each(shorcut,function(idx,aShorcut){
					appendSelectedMenu(aShorcut.rightId,aShorcut.rightName);
				});
				
			}
		}
		
		/*
		* 判断文本是否不为空
		* true：不为空
		* false：为空
		*/
		function isNotEmptyText(text){
			return text != null && text != '' && typeof text != 'undefined';
		}
		
		/*
		* 保存个性化信息
		*/
		function savePersonality(){
			var timeZone = $('#timeZone').val();
			var homepage = $('#menuId').val();
			var position = $('#position').val();
			var homepageType = $('#menuType').val();
			var existedMenu = $('#existedMenu').children();
			homepage = isNotEmptyText(homepage)?homepage:'';
			position = isNotEmptyText(position)?position:'';
			var menus = '';
			if(existedMenu && existedMenu.length > 0){
				$.each(existedMenu,function(idx,aMenu){
					var menuId = $(aMenu).children('input[name="rightId"]').val();
					if(idx == 0)
						menus+= menuId;
					else
						menus+= ',' + menuId;
				});
			}
			var param = {timeZone:timeZone,homepage:homepage,position:position,menu:menus,homepageType:homepageType};
			$.tdsAjax({
				url: getContext() + '/admin/personality/savePersonality.do',
				data: param,
				type: 'post',
				success: function(data){
					if(!data)
						showError( '<spring:message code="tds.personality.message.savingpersonalityfailure"/>' );
					else
						showAlert( '<spring:message code="tds.menuRight.label.executeSuccess"/>' );
				},
				error: function(){
					showError( '<spring:message code="tds.personality.message.savingpersonalityfailure"/>' );
				}
			});
		}
		
		/*
		* 通过移动菜单位置进行排序
		*/
		function moveElement(xward){
			var selectedExitedMenu = $('#existedMenu').children('.item-selected');
			if(!selectedExitedMenu || selectedExitedMenu.length ==0) return;
			if(selectedExitedMenu.length > 1) {showAlert('<spring:message code="tds.personality.message.oneeachforsorting"/>');return;}
			var allExistedMenu = $('#existedMenu').children();
			var length = allExistedMenu.length;
			var selectedOne = selectedExitedMenu[0];
			var index = allExistedMenu.index(selectedOne);
			var selectedOneJ = $(selectedOne);
			
			if('top' == xward){
				if(0 == index) return;
				$('#existedMenu').prepend(selectedOneJ);
			}else if('bottom' == xward){
				if(index == length-1) return;
				$('#existedMenu').append(selectedOneJ);
			}else if('upward' == xward){
				if(0 == index) return;
				var preOne = selectedOneJ.prev();
				preOne.before(selectedOneJ);
			}else if('downward' == xward){
				if(index == length-1) return;
				var nextOne = selectedOneJ.next();
				nextOne.after(selectedOneJ);
			}
		}
	</script>
	<jsp:include page="/tds/common/dialog.js.jsp"></jsp:include>
	<script src="${ctx }/tds/static/ztree/js/jquery.ztree.all-3.5.js"></script>
	<script src="${ctx }/tds/common/ztree-ext.js"></script>
	<script type="text/javascript" src="${ctx }/tds/personality/homepage.tree.js"></script>
	<script type="text/javascript" src="${ctx }/tds/personality/dashboard.tree.js"></script>
	<script type="text/javascript" src="${ctx }/tds/personality/menu.tree.js"></script>
	<script type="text/javascript" src="${ctx }/tds/static/easy-timezone/timezones.full.js"></script>
	<script type="text/javascript">
		$(function(){
			initPageData();
			initHomepageTree();
			initDashboardTree();
			initMenuTree();
			$("ul.dropdown-menu").on("click",  function(e) {
			    e.stopPropagation();
			});
			
			
			if("${property.timeZone.propValue}" != "")
				moment.tz.setDefault("${property.timeZone.propValue}");
			$("#timeZone").timezones();
			
			//window.parent.document.getElementById("mainContainerDIV").style.height = 100;
			//alert(window.parent.document.height + "fffff")
		});
	</script>
</body>
</html>