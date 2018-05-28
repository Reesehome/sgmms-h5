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
</head>
<body>
<script>
	var saveDialog;
	var saveItemDialog;
	var dictionaryItemTable;
	
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
			htable.children("thead").children("tr").children("th:eq("+idx+")").css("width",aParam+"%");
		});
		
		$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").css("width","100%");
		$("#gview_"+params.tableid + " .ui-jqgrid-bdiv").children(":first").width(htable.width());
		var table = $("#"+params.tableid);
		table.css("width","100%");
		
		$.each(widthparams , function(idx,aParam){
			table.children("tbody").children("tr").children("td:eq("+idx+")").css("width",aParam+"%");
		});
		
		$("#"+params.pager).width($("#gview_"+params.tableid).width());
	}
	
	function initDictionaryItemTable(dictionaryId){
		var params = {dictionaryId:dictionaryId};
		if(dictionaryItemTable)
			$("#dictionaryitem").jqGrid('setGridParam',{postData:params}).trigger("reloadGrid");
		else{
			dictionaryItemTable = $("#dictionaryitem").jqGrid({
				url: ctx + getPath() + '/dictionary/findDictionaryItemByDictionaryId.do',//请求数据的url地址
				postData: params,
				datatype: 'json',  //请求的数据类型
			   	colNames:['<spring:message code="tds.dictionary.label.name"/>','<spring:message code="tds.dictionary.label.value"/>'], //数据列名称（数组）
			   	colModel:[ //数据列各参数信息设置
			   		{name:'name',index:'name', width:300,align:'center'},
					//{name:'code',index:'code', width:300,align:'center'},,'<spring:message code="tds.dictionary.label.code"/>'
					{name:'value',index:'value', width:300,align:'center'}
			   	],
			   	rowNum:10,//每页显示记录数
			   	rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
			   	pager : '#dictionaryitempager',  //表格数据关联的分页条，html元素
				autowidth: true, //自动匹配宽度
				height: '200',   //设置高度
				gridview:true, //加速显示
			    viewrecords: true,  //显示总记录数
				multiselect: true,  //可多选，出现多选框
				multiselectWidth: 25, //设置多选列宽度
				sortable:true,  //可以排序
				sortname: 'name',  //排序字段名
			    sortorder: 'desc', //排序方式：倒序，本例中设置默认按id倒序排序
				loadComplete:function(data){ //完成服务器请求后，回调函数
					var params = {widtharray:[4,48,48],tableid:'dictionaryitem',pager:'dictionaryitempager'};
					resizeTable(params);
				}
			});
		}
	}
	
	function reloadDictionaryItemTable(){
		$("#dictionaryitem").trigger("reloadGrid");
	}
	
	function editDictionary(params){
		var type = params.type;
		var id = null;
		if(type == 'add')
			id = [];
		else{
			id = getSeletedDictionaryId();
			if(!id){
				showAlert('<spring:message code="tds.dictionary.message.selectOne"/>');
				return;
			}else if(id.length == 0){
				showAlert('<spring:message code="tds.dictionary.message.selectOne"/>');
				return;
			}else if(id.length > 1){
				showAlert('<spring:message code="tds.dictionary.message.onlyOne"/>');
				return;
			}
		}
		openEditDialog(id);
	}
	
	function editDictionaryItem(params){
		var type = params.type;
		var id = null;
		if(type == 'add')
			id = [];
		else{
			id = getSeletedDictionaryItemId();
			if(!id){
				showAlert('<spring:message code="tds.dictionary.message.selectOne"/>');
				return;
			}else if(id.length == 0){
				showAlert('<spring:message code="tds.dictionary.message.selectOne"/>');
				return;
			}else if(id.length > 1){
				showAlert('<spring:message code="tds.dictionary.message.onlyOne"/>');
				return;
			}
		}
		openItemEditDialog(id);
	}
	
	function deleteDictionary(){
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
			    	doDelete();
			    }
			}
		});
	}
	
	function deleteDictionaryItem(){
		BootstrapDialog.confirm({
			title: '<spring:message code="tds.common.label.alertTitle"/>',
			message: '<spring:message code="tds.dictionary.message.confirmDeleteItem"/>',
			type: BootstrapDialog.TYPE_WARNING,
			closable: true,
			draggable: true,
			btnCancelLabel: '<spring:message code="tds.common.label.cancel"/>',
			btnOKLabel: '<spring:message code="tds.common.label.confirm"/>',
			btnOKClass: 'btn-primary',
			callback: function(result){
			    if(result) {
			    	doDeleteItem();
			    }
			}
		});
	}
	
	function showDictionaryItem(){
		var id = getSeletedDictionaryId();
		if(!id || id.length==0){
			showAlert('<spring:message code="tds.dictionary.message.selectOne"/>');
			return;
		}else if(id.length > 1){
			showAlert('<spring:message code="tds.dictionary.message.onlyOne"/>');
			return;
		}
		doShowItem(id[0]);
	}
	
	function doShowItem(dictionaryId){
		$('#DictionaryPanel').children('.panel-heading:first').children('#selectedDictionaryId').val(dictionaryId);
		initDictionaryItemTable(dictionaryId);
		toggerDictionaryContainer(false);
	}
	function getSeletedDictionaryId(){
		var selected = $("#dictionary").jqGrid('getGridParam', 'selarrrow');
		return selected;
	}
	
	function getSeletedDictionaryItemId(){
		var selected = $("#dictionaryitem").jqGrid('getGridParam', 'selarrrow');
		return selected;
	}
	
	function openEditDialog(ids){
		var id = '';
		if(ids && ids.length>0){
			id = ids[0];
		}
		saveDialog = BootstrapDialog.show({
			title: '<spring:message code="tds.dictionary.label.editTitle"/>',
	        message: function(dialog) {
	            var $message = $('<div></div>');
	            $message.load(ctx + getPath() + '/dictionary/show-edit.do',{id:id});
	            return $message;
	        }
	    });
	}
	
	function openItemEditDialog(ids){
		var id = '';
		if(ids && ids.length>0){
			id = ids[0];
		}
		var parentId = $('#SaveDictionaryForm').find('input[name="id"]').val();
		var parentName = $('#SaveDictionaryForm').find('input[name="name"]').val();
		if(!isNotEmpty(parentName))
			parentName = '';
		saveItemDialog = BootstrapDialog.show({
			title: '<spring:message code="tds.dictionary.label.editTitle"/>',
	        message: function(dialog) {
	            var $message = $('<div></div>');
	            $message.load(ctx + getPath() + '/dictionary/show-itemedit.do',{id:id,dictionaryId:parentId,dictionaryName:parentName});
	            return $message;
	        }
	    });
	}
	
	function closeEditDialog(){
		if(saveDialog) saveDialog.close();
	}
	
	function closeItemEditDialog(){
		if(saveItemDialog) saveItemDialog.close();
	}
	
	function doDelete(){
		var ids = getSeletedDictionaryId();
		if(!ids || ids.length == 0){
			showAlert('<spring:message code="tds.dictionary.message.selectToDelete"/>');
			return;
		}
		var params = {ids:ids.join(',')};
		$.tdsAjax({
			url: "${ctx }"+getPath()+"/dictionary/deleteDictionary.do",
			data: params,
			cache:false,
			success: function(returnValue){
				var result = returnValue;
				if(!result){
					showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
				}else{
					reloadDictionaryTable();
				}
			},
			error: function(){
				showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
			}
		});
	}
	
	function doDeleteItem(){
		var ids = getSeletedDictionaryItemId();
		if(!ids || ids.length == 0){
			showAlert('<spring:message code="tds.dictionary.message.selectItemToDelete"/>');
			return;
		}
		var params = {ids:ids.join(',')};
		$.tdsAjax({
			url: "${ctx }"+getPath()+"/dictionary/deleteDictionaryItem.do",
			data: params,
			cache:false,
			success: function(returnValue){
				var result = returnValue;
				if(!result){
					showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
				}else{
					reloadDictionaryItemTable();
				}
			},
			error: function(){
				showError('<spring:message code="tds.dictionary.message.deleteFailed"/>');
			}
		});
	}
	
	function isNotEmpty(str){
		return str != null && str != "" && typeof str != "undefined";
	}
	
	function toggerDictionaryContainer(flag){
		$("#DictionaryContainer").toggle(flag);
		$("#DictionaryItemContainer").toggle(!flag);
	}
	
	function toggleDictionaryPanel(flag){
		$("#DictionaryPanel").toggle(flag);
	}
	
	function toggleDictionaryItemPanel(flag){
		$("#DictionaryItemPanel").toggle(flag);
	}

	function getResult(key){
		if(key == 'EXISTED')
			return '<spring:message code="tds.dictionary.message.codeExisted"/>';
		else if(key == 'ERROR')
			return '<spring:message code="tds.dictionary.message.savingFailed"/>';
		else return '';
	}
</script>
</body>
</html>