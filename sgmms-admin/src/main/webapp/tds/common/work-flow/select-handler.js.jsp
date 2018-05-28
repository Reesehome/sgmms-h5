<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<script type="text/javascript">
    $(function () {

        //初始化树
        initHandlerTree();


        //初始人员列表
        initHandlerTable();
    });

    /**
     * 初始人员列表
     */
    function initHandlerTable() {
    	var tableSetting = {
                url : ctx + '/admin/organization/findOrganizationUsers.do',//请求数据的url地址
                mtype : "POST",
                datatype: 'local',
                colNames:[
                    "",
                    "userId",
                    "<spring:message code='tds.user.label.username' />",
                    "<spring:message code='tds.user.label.loginname' />"], //数据列名称（数组）
                colModel:[ //数据列各参数信息设置
						{hidden : true},
						{name:'userId', index:'userId', width : 100, hidden : true},
						{name:'userName', index:'userName', width : 100, algin:"center"},
						{name:'loginName', index:'loginName', width : 100, algin:"center"}
                ],
                width:340,
                height:280,
                rowNum:10,//每页显示记录数
                rowList:[10,20,30], //分页选项，可以下拉选择每页显示记录数
                pager : '#userTablePager',  //表格数据关联的分页条，html元素
                gridview:true, //加速显示
                viewrecords: true,  //显示总记录数
                //multiselect: true,  //可多选，出现多选框
                multiselectWidth: 25, //设置多选列宽度
                sortable:true,  //可以排序
                sortname: 'startDate',  //排序字段名
                sortorder: "desc", //排序方式：倒序，本例中设置默认按id倒序排序
                viewrecords:false,
                loadComplete:function(data) { //完成服务器请求后，回调函数
                    //alert("成功了");
                }
		};
    	
    	tableSetting.multiselect = ('${multiSelect}' == 'Y' ? true : false);
    	if('${multiSelect}' == 'N'){
    		tableSetting.colModel[0] = {formatter:initRadio,width:20, sortable:false,align:'center'};
    		tableSetting.onSelectRow = function(rowId,status,e){
    			$("input[name=radUser]").prop("checked",false);
    			$("#rad_"+rowId).prop("checked",true);
    		}
    	}
    	
        $("#userTable").jqGrid(tableSetting);
    }
    
    /**
     * 初始化树
     */
	function initRadio(cellvalue, options, rowObject) {
		var radio = "<input type='radio' id='rad_" + options.rowId + "' name='radUser' onclick='selectRow(\"" + options.rowId + "\")'>";
		return radio;
	}
    
	/**
     * 当单选点击时选择行
     */
	function selectRow(rowId) {
		$("#userTable").jqGrid("resetSelection");
		$("#userTable").jqGrid("setSelection",rowId,false);
	}
    

    /**
    * 初始化树
    */
    function initHandlerTree() {
        //组织树
        var zTree;
        //临时准备选中的节点
        var readySelectNode;

        //树配置信息
        var treeSetting = {
            data : {
                simpleData : {
                    enable : true,
                    idKey : "id",
                    pIdKey : "parentId",
                    rootPid : null
                }
            },
            callback : {
                onClick : nodeClickHandler
            }
        };

        //初始化组织机构树事件
        $.tdsAjax({
            url : "${ctx}/admin/organization/findOrganizationTree.do",
            type : "POST",
            dataType : "json",
            success : function(data) {
                zTree = $.fn.zTree.init($("#tree"), treeSetting, data);
                //首次加载完后展开第一层节点信息
                var nodes = zTree.getNodes();
                if (nodes.length > 0) {
                    zTree.expandNode(nodes[0], true, false, true);
                    zTree.selectNode(nodes[0], true);
                    //调用点击事件
                    zTree.setting.callback.onClick(null, zTree.setting.treeId, nodes[0]);
                }
            }
        });
    }

    /**
     * 树节点点击回调事件
     */
    function nodeClickHandler(event, treeId, treeNode, type){
        loadUsers(treeNode.id);
    }

    function loadUsers(orgId) {
        $("#userTable").setGridParam({datatype:'json',postData:{orgId:orgId}}).trigger("reloadGrid");
    }
</script>