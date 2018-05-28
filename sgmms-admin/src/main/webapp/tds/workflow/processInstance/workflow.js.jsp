<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<script type="text/javascript">
/******************流程跟踪图**********************************/
function graphTrace(pid, pdid) {
			        BootstrapDialog.show({
			    		title : '流程监控图',
			    		size: BootstrapDialog.SIZE_WIDE,
			    	 message: $('<div></div>').load(ctx+"/admin/workflow/resource/process-instance-img.do?pid="+pid+"&pdid="+pdid),
			    		//  message: $('<div></div>').load(ctx+"/admin/workflow/resource/process-instance-imgNew.do?pid="+pid+"&pdid="+pdid),
			    		 // message: $('<div></div>').load(ctx+"/tds/workflow/diagram-viewer/index2.jsp"),
			    		  buttons : [
			                       
			                       {
			                    	   label : '<spring:message code="tds.common.label.close"/>',
			                    	   action : function(dialogItself){
			                    		   dialogItself.close();
			                    	   }
			                       }
			              ]
			        });

        
}

</script>