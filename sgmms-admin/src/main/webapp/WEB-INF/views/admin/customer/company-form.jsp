<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty(errorMessage)}">
<div class="alert alert-danger">${errorMessage}</div>
</c:if>
<form:form id="companyForm" class="form-horizontal" modelAttribute="company" role="form">

    <div class="form-group">
        <label for="parentName" class="col-sm-3 control-label">上层单位</label>
        <div class="col-sm-8">
            <form:input path="parentName" class="form-control" readonly="true" id="parentName" />
        </div>
    </div>

    <div class="form-group">
        <label for="name" class="col-sm-3 control-label"><span style="color: #f00;">*</span>&nbsp;单位名称</label>
        <div class="col-sm-8">
            <form:input path="name" class="required form-control" id="name" />
        </div>
    </div>

    <div class="form-group">
        <label for="code" class="col-sm-3 control-label">单位编码</label>
        <div class="col-sm-8">
            <form:input path="code" class="form-control" id="code" />
        </div>
    </div>

    <div class="form-group">
        <label for="code" class="col-sm-3 control-label">是否有效</label>
        <div class="col-sm-8">
            <form:select path="enabled" cssClass="form-control">
                <form:option value="Y">是</form:option>
                <form:option value="N">否</form:option>
            </form:select>
        </div>
    </div>

    <div class="form-group">
        <label for="comment" class="col-sm-3 control-label">备注</label>
        <div class="col-sm-8">
            <form:textarea rows="2" path="comment" class="form-control" id="comment"/>
        </div>
    </div>

    <form:hidden path="id" id="id"/>
    <form:hidden path="parentId" id="parentId"/>

</form:form>

<script type="text/javascript">
    $(function () {
        $("#btnSave").off("click");
        $("#btnSave").on("click", saveDictionary);
        initValidate();
    });


    function saveDictionary() {
        if (!$('#parentId').val()) {
            showError("根节点不允许编辑");
            return;
        }
        if ($("#companyForm").valid())
            doSave();
    }

    function doSave() {
        var params = $("#companyForm").serialize();
        axios.interceptors.response.use(function (res) {
            if (!res.data || !res.data.success) {
                return Promise.reject({'response': res});
            }
            return Promise.resolve(res);
        }, function (error) {
            return Promise.reject(error)
        });
        axios.post(ctx + "/customer/company/save", params)
            // 保存数据
            .then(function (response) {
                var location = response.headers.location;
                if (!location) {
                    showAlert('请手工刷新数据');
                    return;
                }
                return axios.get(location);
            })
            //添加或更新节点
            .then(function (response) {
                var company = response.data;
                var tree = $.fn.zTree.getZTreeObj("companyTree");
                var node = tree.getNodeByParam('id', company.id);
                company.isParent = true;
                if (!$('#id').val()) {// 新增节点
                    $('#id').val(company.id);
                } else if (node) {// 更新节点：先删除了节点，再增加节点。
                    tree.removeNode(node);
                }
                node = tree.addNodes(tree.getNodeByParam('id', company.parentId), company);
                tree.selectNode(node[0], false);
                showAlert("保存成功");
            })
            // 异常处理
            .catch(function (error) {
                console.log(error);
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


    /**
     * 初始化表单验证
     */
    function initValidate() {
        //为inputForm注册validate函数
        $('#SaveDictionaryForm').validate({
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                name: {
                    required: true,
                    maxlength: 64
                }
            },
            messages: {
                name: {
                    required: '<spring:message code="tds.dictionary.message.nameNotNull"/>',
                    maxlength: '<spring:message code="tds.dictionary.message.nameMaxLength"/>'
                }
            },

            highlight: function (element) {
                $(element).parent('div').addClass('has-error');
            },

            success: function (label) {
                label.parent('div').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function (error, element) {
                element.parent('div').append(error);
            }
        });
    }
</script>