<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
    $(function () {
        //初始化数据列表
        initDataGrid();

        //初始化删除
        initDelete();
    });

    /**
     *  初始化数据列表
     */
    function initDataGrid() {
        var processKey = $("#processKey").val();
        var activityId = $("#activityId").val();

        $("#list").jqGrid({
            url:'${ctx}/admin/ActivityDriverMapper/findAllActivityDriverMappersByCurrentNode.do?processKey=' + processKey + '&activityId='+activityId,//请求数据的url地址
            datatype: 'json',  //请求的数据类型
            colNames:[
                '',
                '驱动编号',
                '驱动名称',
                '参数'],     //数据列名称（数组）
            colModel:[ //数据列各参数信息设置
                {name:'mapperId',index:'mapperId', hidden:true},
                {name:'adapterId',index:'adapterId', width:25,align:'center', title:false},
                {name:'adapterName',index:'adapterName', width:25,align:'center'},
                {name:'params',index:'params',width:50, align:'center'}
            ],
            rowNum:100,//每页显示记录数
            rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
            autowidth: true, //自动匹配宽度
            height:300,   //设置高度
            gridview:true, //加速显示
            viewrecords: true,  //显示总记录数
            multiselect: true,  //可多选，出现多选框
            multiboxonly: true, //在点击表格row时只支持单选，只有当点击checkbox时才多选
            multiselectWidth: 25, //设置多选列宽度
            sortable:false,  //可以排序
            loadComplete:function(data){ //完成服务器请求后，回调函数

            }
        });

        //窗口变化时自动适应大小
        $(window).bind('resize', function() {
            $("#list").setGridWidth($("#mainContainerBody").width() - 5);
        }).trigger('resize');
    }

    /**
     * 弹出编辑窗口
     */
    function showSelectDriverWind(executType) {
        var mapperId = "";

        if("update" == executType){
            //获取选中的行
            var rowIds = $('#list').jqGrid('getGridParam','selarrrow');
            if(rowIds && rowIds.length > 0) {
                $.each(rowIds,function(index,rowId){
                    var rowData = $('#list').jqGrid('getRowData',rowId);
                    mapperId = rowData.mapperId;
                });
            }
        }
        BootstrapDialog.show({
            title : '编辑流程处理人驱动',
            message: $('<div></div>').load('${ctx}/admin/ActivityDriverMapper/showSelectDriverWind.do?mapperId='+mapperId),
            buttons : [ {
                label : '<spring:message code="tds.common.label.close"/>',
                action : function(dialogItself) {
                    //关闭窗口
                    dialogItself.close();
                }
            },{
                label : '<spring:message code="tds.common.label.submit"/>',
                action : editActivityDriverMapper
            }]
        });
    }

    /**
     * 编辑驱动映射
     */
    function editActivityDriverMapper(dialogItself){
        //验证结果正确再提交
        var validResult = $("#selectDriverForm").valid();
        if(!validResult)
            return;

        var params = $("#selectDriverForm").serialize();
        var processKey = $("#processKey").val();
        var activityId = $("#activityId").val();;
        params += ("&processKey=" + processKey + "&activityId=" + activityId);
        $.tdsAjax({
            url:"${ctx}/admin/ActivityDriverMapper/editActivityDriverMapper.do",
            type:"POST",
            dataType:"json",
            data: params,
            success: function(result){
                //成功后刷新列表
                if(result.success) {
                    $("#list").trigger("reloadGrid");
                } else {
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

        //关闭窗口
        dialogItself.close();
    }

    /**
     * 删除示例数据
     */
    function initDelete(){
        $('#btnDeleteMapper').confirmation({
            placement:'left',
            title:'确定要删除驱动吗？',
            btnOkLabel : '<spring:message code="tds.common.label.delete"/>',
            btnCancelLabel : '<spring:message code="tds.common.label.close"/>',
            onConfirm : function(){
                var rowIds = $("#list").jqGrid('getGridParam','selarrrow');

                var ids = [];
                if(rowIds && rowIds.length > 0) {
                    $.each(rowIds,function(index,rowId){
                        var rowData = $('#list').jqGrid('getRowData',rowId);
                        ids[index] = rowData.mapperId;
                    });
                }

                var params = $.param({mapperIds:ids},true);
                $.tdsAjax({
                    url: "${ctx}/admin/ActivityDriverMapper/deleteActivityDriverMapper.do",
                    cache: false,
                    dataType:"json",
                    data:params,
                    success: function(result){
                        if(result.success)
                        //重新加载列表数据
                            $("#list").trigger("reloadGrid");
                        else{
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