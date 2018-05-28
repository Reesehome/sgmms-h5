<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
    var zTree;
    var currentTreeNode;

    //树配置信息
    var setting = {
        async: {
            enable: true,
            url: "${ctx}/admin/ActivityDriverMapper/findChildren.do",
            dataType:'json',
            autoParam: ["id"]
        },
        callback : {
            onClick : nodeClickHandler
        }
    };

    $(function(){
        zTree = $.fn.zTree.init($("#tree"), setting, null);
        
        initDelete();
    });

    /**
     * 提交表单
     */
    function submitForm() {
        var url = $("form").attr("action");
        var params = $("form").serialize();
        $.tdsAjax({
            url:url,
            cache:false,
            dataType:'json',
            type:"POST",
            data: params,
            success: function(result){
                if(result.success) {
                    showAlert(BootstrapDialog.TYPE_SUCCESS,result.message);
                } else {
                    showAlert(BootstrapDialog.TYPE_WARNING,result.message);
                }
            }
        });
    }

    /**
     * 树节点点击回调事件
     */
    function nodeClickHandler(event, treeId, treeNode){
        currentTreeNode = treeNode;

        var params = {processKey:treeNode.params.processKey, nodeType:treeNode.params.nodeType};
        if(treeNode.params.activityId){
            params.activityId = treeNode.params.activityId;
        }

        $.tdsAjax({
            url:"${ctx}/admin/ActivityDriverMapper/showEdit.do",
            cache:false,
            data:params,
            success: function(pageHTML){
                $("#mainContainer").html(pageHTML);
            }
        });
    }

    /**
     * 同步流程引擎的定义
     */
    function synchronizeProcess(){
        $.tdsAjax({
            url:"${ctx}/admin/ActivityDriverMapper/synchronizeProcess.do",
            cache:false,
            dataType:'json',
            success: function(result){
                //成功后刷新列表
                if(result.success) {
                    showAlert(BootstrapDialog.TYPE_SUCCESS,result.message);
                    zTree.reAsyncChildNodes(null, "refresh");
                } else {
                    showAlert(BootstrapDialog.TYPE_WARNING,result.message);
                }
            }
        });
    }

    function showAlert(bootstrapDialogType,message){
        BootstrapDialog.show({
            title: '提示',
            size: BootstrapDialog.SIZE_SMALL,
            type : bootstrapDialogType,
            message: message,
            buttons: [{
                label: '<spring:message code="tds.common.label.close"/>',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
    }

    /**
     * 删除流程或者流程节点
     */
    function initDelete(){
        $('#btnDelete').confirmation({
            placement:'right',
            title:'确定要删除吗？',
            btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
            btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
            onConfirm : function(){
                var params = {processKey:currentTreeNode.params.processKey, nodeType:currentTreeNode.params.nodeType};
                if(currentTreeNode.params.activityId){
                    params.activityId = currentTreeNode.params.activityId;
                }

                
                $.tdsAjax({
                    url: "${ctx}/admin/ActivityDriverMapper/delete.do",
                    cache: false,
                    dataType:"json",
                    data:params,
                    success: function(result){
                        if(result.success){
                        	//重新加载列表数据
                        	zTree.removeNode(currentTreeNode);
                        }else{
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
        });
    }
</script>