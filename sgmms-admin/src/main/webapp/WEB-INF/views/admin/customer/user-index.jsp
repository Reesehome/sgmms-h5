<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/tds/common/tag-lib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dictionary</title>
    <jsp:include page="/tds/common/ui-lib.jsp"/>
    <style>
        html, body {
            height: 100%;
        }
        .module-header {
            height: 40px;
            vertical-align: middle;
            display: table-cell;
            margin-left: -15px;
        }

        .module-body {
            padding-top: 40px;
            margin-top: -40px;
        }

        /* 冻结根节点 */
        .ztree li span.button.switch.level0 {
            visibility: hidden;
            width: 1px;
        }

        .ztree li ul.level0 {
            padding: 0;
            background: none;
        }
    </style>
</head>
<body>
<div class="container-fluid" style="min-width: 1000px;">
    <div class="module-header">
        <span class="glyphicon glyphicon-book"></span> <strong>用户维护</strong>
    </div>
    <div class="module-body">
        <!-- 左边树 -->
        <div class="layout-horizontal col-sm-3">
            <div class="panel panel-primary">
                <div class="panel-heading" style="min-height: 45px;">
                    <strong>组织列表</strong>
                </div>
                <div class="panel-body tree-panel-body">
                    <div class="tree-panel-body-content">
                        <ul id="companyTree" class="ztree"></ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /左边树 -->
        <div class="layout-horizontal col-sm-9">
            <div class="panel panel-primary" style="margin-bottom: 10px;">
                <div class="panel-heading">
                    <form id="user-form" class="form-inline" action="">
                        <div class="form-group">
                            <label for="name1" class="control-label">姓名</label>
                            <input type="text" class="form-control" name="name" id="name1" placeholder="姓名">
                        </div>
                        <div class="form-group">
                            <label for="mobile1" class="control-label">手机</label>
                            <input type="text" class="form-control" name="mobile" id="mobile1" placeholder="手机号码">
                        </div>
                        <div class="form-group">
                            <label for="companyName" class="control-label">单位</label>
                            <input type="text" class="form-control" readonly id="companyName" placeholder="单位">
                            <input type="hidden" name="companyId" id="companyId">
                        </div>
                        <!--div class="checkbox">
                            <label>
                                <input type="checkbox"> 包含下属单位
                            </label>
                        </div-->
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-warning" onclick="queryUsers()">搜索</button>
                            <button type="button" class="btn btn-danger" onclick="clearUsers()">清空</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- /搜索面板 -->
            <div class="panel panel-warning" style="margin-bottom: 10px;">
                <div class="panel-heading clearfix">
                    <div class="btn-group pull-right" role="group" aria-label>
                        <button type="button" class="btn btn-primary" onclick="addUser()">新增</button>
                        <button type="button" class="btn btn-warning" onclick="editUser()">编辑</button>
                        <button type="button" class="btn btn-danger" onclick="delUser()">删除</button>
                    </div>
                </div>
                <!-- /按钮 -->
            </div>
            <table id="users-table"></table>
            <div id="users-pager"></div>
            <!-- /用户列表 -->
        </div>
        <!-- /右边面板 -->
    </div>
</div>
<script type="text/x-template" id="edit-form">
    <form id="customerUserForm" class="form-horizontal" role="form">
        <input type="hidden" name="id" value="{{id}}" />
        <input type="hidden" name="companyId" value="{{companyId}}" />
        <div class="form-group">
            <label for="name2" class="col-sm-3 control-label">姓名</label>
            <div class="col-sm-7">
                <input type="text" name="userName" id="name2" class="form-control" placeholder="请输入姓名" value="{{userName}}" required>
            </div>
        </div>

        <div class="form-group">
            <label for="mobile2" class="col-sm-3 control-label">手机号</label>
            <div class="col-sm-7">
                <input type="text" name="mobile" id="mobile2" class="form-control" placeholder="请输入手机号码" value="{{mobile}}" required>
            </div>
        </div>

        <div class="form-group">
            <label for="gender" class="col-sm-3 control-label">性别</label>
            <div class="col-sm-7">
                <select type="text" name="gender" id="gender" class="form-control">
                    <option value="M" {{if gender == 'M'}} selected{{/if}}>男</option>
                    <option value="F" {{if gender == 'F'}} selected{{/if}}>女</option>
                </select>
            </div>
        </div>

    </form>
</script>
<script type="text/javascript" src="${ctx}/webjars/axios/0.17.1/dist/axios.js"></script>
<script type="text/javascript" src="${ctx}/admin/common/libs/template-web.js"></script>
<jsp:include page="/tds/common/dialog.js.jsp"></jsp:include>
<jsp:include page="/admin/customer/user.tree.js.jsp"></jsp:include>
<div id="load"></div>
<script>
    function initTreeBodyHeight() {
        var headerHeight = $('.panel-heading:eq(0)').outerHeight(true);
        $('.tree-panel-body').css('height', '100%').css('padding-top', headerHeight + 'px').css('margin-top', '-' + headerHeight + 'px');
        $('.tree-panel-body-content').css('height', '100%').css('overflow', 'auto');
    }

    initCompanyTree();
    initTreeBodyHeight();
    BootstrapDialog.configDefaultOptions({animate: false, closeByBackdrop: false});

    $(function () {
        var params = $('#user-form').serializeJson();
        $('#users-table').jqGrid({
            url: '${ctx}/customer/user',//请求数据的url地址
            datatype: 'json',  //请求的数据类型
            mtype: 'get',
            postData: params,
            colNames: [
                '姓名',
                '手机号',
                '性别',
                '创建时间',
                '创建人'
            ],
            colModel: [
                {name: 'userName', index: 'code', width: 200, align: 'left'},
                {name: 'mobile', index: 'title', width: 200, align: 'center'},
                {name: 'gender', index: 'beginTime', width: 100, align: 'center', formatter: function (value) { if (value == 'M') return '男'; else if (value == 'F') return '女'; else return '保密';}},
                {name: 'createOn', index: 'endTime', width: 180, align: 'center'},
                {name: 'createBy', index: 'createBy', width: 180, align: 'center'}
            ],
            rowNum: 10,//每页显示记录数
            rowList: [10, 20, 30], //分页选项，可以下拉选择每页显示记录数
            pager: '#users-pager',  //表格数据关联的分页条，html元素
            autowidth: true, //自动匹配宽度
            height: 300,   //设置高度
            gridview: true, //加速显示
            viewrecords: true,  //显示总记录数
            multiselect: true,  //可多选，出现多选框
            /*multiselectWidth: 25, //设置多选列宽度*/
            sortable: false,  //可以排序
            // sortname: 'loginTime',  //排序字段名
            sortorder: "desc" //排序方式：倒序，本例中设置默认按id倒序排序
        });
    });
    
    function queryUsers() {
        $('#users-table').jqGrid().setGridParam({postData: null}).setGridParam({postData: $('#user-form').serializeJson()}).trigger("reloadGrid");
    }

    function clearUsers() {
        $('#name1,#mobile1,#companyId').val('');
        var tree = $.fn.zTree.getZTreeObj('companyTree');
        var root = tree.getNodes()[0];
        if (!!root) {
            tree.selectNode(root);
            $('#companyName').val(root.name);
        }
        queryUsers();
    }

    function addUser() {
        var tree = $.fn.zTree.getZTreeObj('companyTree');
        var nodes = tree.getSelectedNodes();
        if (nodes == null || nodes.length == 0) {
            showError("请选择组织机构");
            return
        }
        var selectedNode = nodes[0];
        console.log(selectedNode.id)
        editUserForm('增加用户', {companyId: selectedNode.id})
    }

    function editUser () {
        var ids = $("#users-table").jqGrid('getGridParam', 'selarrrow');
        if(!ids || ids.length == 0) {
            showError('请选择一条数据');
            return
        }
        if (ids && ids.length > 1) {
            showError('不能编辑多条数据');
            return;
        }
        axios.get('${ctx}/customer/user/'+ ids[0])
            .then(function (response) {
                if (response.data && response.data.success) {
                    editUserForm('修改用户', response.data);
                } else {
                    showError('获取用户信息失败');
                }
            })
            .catch(function (error) {
                var response = error.response;
                if (response) {
                    if (response.status >= 200 && response.status < 300) {
                        // 业务错误
                        showError(response.data.message);
                        return;
                    }
                }
                // 系统错误
                showError(error.message);
            });
    }

    function editUserForm(title, user) {
        var dialog = template('edit-form', user).replace(/^\s*/, '').replace(/>\s*</g, '><');
        BootstrapDialog.show({
            title: '<span>' + title + '</span>',
            message: dialog,//$('#edit-form').html().replace(/^\s*/, '').replace(/>\s*</g, '><'),
            buttons: [
                {
                    label: '保存',
                    cssClass: 'btn-primary',
                    action: saveUser
                },
                {
                    label: '返回',
                    action: function (dialog) {
                        dialog.close();
                    }
                }
            ]
        });
    }
    
    function saveUser(dialog) {
        var $form = $('#customerUserForm');
        if (!$form.valid()) {
            return;
        }
        axios.post('${ctx}/customer/user', $form.serialize())
        .then(function (response) {
            if (response.data && response.data.success) {
                dialog.close();
                showSuccess("操作成功");
                $('#users-table').jqGrid().trigger("reloadGrid");
            } else {
                showError('操作失败');
            }
        })
        .catch(function (error) {
            var response = error.response;
            if (response) {
                if (response.status >= 200 && response.status < 300) {
                    // 业务错误
                    showError(response.data.message);
                    return;
                }
            }
            // 系统错误
            showError(error.message);
        });
    }

    function delUser() {
        var ids = $("#users-table").jqGrid('getGridParam', 'selarrrow');
        if(!ids || ids.length == 0) {
            showError('请选择一条数据');
            return
        }
        BootstrapDialog.confirm({
            title: '<spring:message code="tds.common.label.alertTitle"/>',
            message: '确定删除所选用户么？',
            type: BootstrapDialog.TYPE_WARNING,
            closable: true,
            draggable: true,
            btnCancelLabel: '<spring:message code="tds.common.label.cancel"/>',
            btnOKLabel: '<spring:message code="tds.common.label.confirm"/>',
            btnOKClass: 'btn-primary',
            callback: function(result){
                var url;
                if(result) {
                    url = '${ctx}/customer/user?userId[]=' + ids[0];
                    for (var i = 1; i < ids.length; i++) {
                        url = url + "&userId[]=" + ids[i];
                    }
                    axios.delete(url, {
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        }
                    })
                    .then(function (response) {
                        if (response.data && response.data.success) {
                            showSuccess('删除成功');
                            $('#users-table').jqGrid().trigger("reloadGrid");
                        } else {
                            showError('删除失败');
                        }
                    })
                    .catch(function (error) {
                        var response = error.response;
                        if (response) {
                            if (response.status >= 200 && response.status < 300) {
                                // 业务错误
                                showError(response.data.message);
                                return;
                            }
                        }
                        // 系统错误
                        showError(error.message);
                    });
                }
            }
        });
    }

    axios.interceptors.response.use(function (res) {
        if (!res.data || !res.data.success) {
            return Promise.reject({'response': res});
        }
        return Promise.resolve(res);
    }, function (error) {
        return Promise.reject(error)
    });
</script>
</body>
</html>