<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>数据首页</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<script src="${ctx}/tds/demo/table/js/table.js"></script>
<style type="text/css">
	.dataImport{
		width: 550px;
	}
	.dataImport1{
		width: 150px;
		float: left;
	}
	.dataImport2{
		width: 400px;
		float: left;
	}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12" id="mainContainerBox">
				<hr>
				<div class="panel panel-info">
					<div class="panel-heading">
						<b>导入模板下载</b>
					</div>
					<div class="panel-body ">
						<div class="form-group dataImport">
							<div class="dataImport1">
								<div class="pull-right">指定模板对象：</div>
							</div>
							<div class="dataImport2">
								<input class="row" type="radio" name="dataImportForm1" value="01"
									checked="checked">&nbsp;&nbsp;组织 <input type="radio"
									name="dataImportForm1" value="02">&nbsp;&nbsp;局向 <input
									type="radio" name="dataImportForm1" value="03">&nbsp;&nbsp;业务
								<button type="button" class="btn btn-primary pull-right"
									onclick="dataDownload()">下载</button>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-info">
					<div class="panel-heading">
						<b>数据导入</b>
					</div>
					<div class="panel-body">
						<div class="form-group dataImport">
							<div class="dataImport1">
								<div class="pull-right">指定对象：</div>
							</div>
							<div class="dataImport2">
								<input type="radio" name="dataImportForm2" checked="checked">&nbsp;&nbsp;组织
								<input type="radio" name="dataImportForm2">&nbsp;&nbsp;局向
								<input type="radio" name="dataImportForm2">&nbsp;&nbsp;业务
								<button type="button" class="btn btn-primary pull-right"
									onclick="searchDemo()">选择</button>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="form-group dataImport">
							<div class="dataImport1">
								<div class="pull-right">导入对象：</div>
							</div>
							<div class="dataImport2">
								<input type="radio" name="dataImportForm3" checked="checked" value="O">&nbsp;&nbsp;组织
								<input type="radio" name="dataImportForm3" value="P">&nbsp;&nbsp;岗位
								<input type="radio" name="dataImportForm3" value="E">&nbsp;&nbsp;人员
								<input type="radio" name="dataImportForm3" value="B">&nbsp;&nbsp;局向
								<input type="radio" name="dataImportForm3" value="S">&nbsp;&nbsp;业务
							</div>
							
						</div>
					</div>
					<div class="panel-body">
						<div class="form-group dataImport">
							<div class="dataImport1">
								<div class="pull-right">数据文件：</div>
							</div>
							<div class="dataImport2" style="width: 300px; height: 50px;">
								<c:import url="/tds/common/upload-file.jsp">
									<c:param name="attachmentType" value="1" />
									<c:param name="attachmentSize" value="5048576" />
									<c:param name="attachmentTypeExts" value="*.xlsx;*.xls" />
								</c:import>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	$(document).ready(function(){
		dataImportType = $("input[name='dataImportForm3']:checked").val();
		$("input:radio").click(function(){
			dataImportType = $("input[name='dataImportForm3']:checked").val();
		});
		
		
	});

	function dataDownload(){
		var name = $("input[name=dataImportForm1]:checked").val();
		if(name){
			var url = "${ctx}/admin/attachment/downloadFile.do?fileName="+name+"&fileType=1";
			window.location.href = url;
			
		}
		
		
		 
	}
	
	</script>
</html>