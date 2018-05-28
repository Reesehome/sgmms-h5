<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dictionary</title>
<jsp:include page="/tds/common/ui-lib.jsp" />
<style>
  html,body{height: 100%;}
  .row{height: 100%;}
  .height100{height: 100%;}
  .tree-font-color{color: rgb(110, 130, 155);}
  .form-group{margin-bottom: 5px;}
  .module-header{height: 40px;vertical-align: middle;display: table-cell;margin-left: -15px;}
  .module-body{padding-top: 40px;margin-top: -40px;}
  .col-sm-3,.col-sm-9{padding-left: 2px;padding-right: 2px;}
  /* 冻结根节点 */
  .ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
  .ztree li ul.level0 {padding:0; background:none;}
</style>
</head>
<body>
  <div class="container-fluid height100" style="min-width: 1000px;">
    <div class="module-header">
      <span class="glyphicon glyphicon-book"></span> <strong>组织维护</strong>
    </div>
    <div class="module-body height100">
      <!-- 左边树 -->
      <div class="layout-horizontal col-sm-3 height100">
        <div id="DictionaryTreePanel" class="panel panel-info height100">
          <div class="panel-heading" style="min-height: 45px;">
            <strong>组织列表</strong>
          </div>
          <div class="panel-body tree-panel-body">
            <div class="tree-panel-body-content">
              <ul id="companyTree" class="ztree"></ul>
            <ul id="createRootItem" style="list-style: none;">
              <li><a href="javascript:void(0);" onclick="createRoot();">新增根节点</a>
            </ul>
          </div>
        </div>
        </div>
      </div>
      <!-- /左边树 -->
      <div class="layout-horizontal col-sm-9 height100">
        <!-- 类别显示与编辑 -->
        <div id="companyPanel" class="panel panel-info">
          <div class="panel-heading" style="min-height: 45px;">
            <div class="btn-group pull-right">
              <button id="btnSave" type="button" class="btn btn-primary">保存</button>
            </div>
            <strong>公司详情</strong>
          </div>
          <div class="panel-body">
        </div>
        </div>
      </div>
      <!-- /右边面板 -->
    </div>
  </div>
  <script type="text/javascript" src="${ctx}/webjars/axios/0.17.1/dist/axios.js"></script>
  <jsp:include page="/tds/common/dialog.js.jsp"></jsp:include>
  <jsp:include page="/admin/customer/company.tree.js.jsp"></jsp:include>
  <script>
    function initTreeBodyHeight(){
      var headerHeight = $('.panel-heading:eq(0)').outerHeight(true);
      $('.tree-panel-body').css('height','100%').css('padding-top',headerHeight + 'px').css('margin-top','-' + headerHeight + 'px');
      $('.tree-panel-body-content').css('height','100%').css('overflow','auto');
    }
    initCompanyTree("companyTree");
    initTreeBodyHeight();
    BootstrapDialog.configDefaultOptions({ animate: false,closeByBackdrop: false });

  </script>
</body>
</html>