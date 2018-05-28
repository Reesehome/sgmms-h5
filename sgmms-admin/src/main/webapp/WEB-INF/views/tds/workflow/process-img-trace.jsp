<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

		<script type="text/javascript">
	$(function() {
		 $('#workflowTraceDialog').css('padding', '0.2em');
		// 跟踪
		var options={};
	        var _defaults = {
		        srcEle: this,
		        pid: '${pid}',
			    pdid: '${pdid}'
		    };
		    var opts = $.extend(true, _defaults, options);
		    
		    // 获取图片资源
		    $.getJSON(ctx + '/admin/workflow/process/trace?pid=' + opts.pid, function(infos) {
		    	
			    	var positionHtml = "";
			        // 生成图片
			        var varsArray = new Array();
			        $.each(infos, function(i, v) {
			            var $positionDiv = $('<div/>', {
			                'class': 'activity-attr'
			            }).css({
			            	position: 'absolute',
			            	left: (v.x +20),
				             top: (v.y +20),
			                width: (v.width - 2),
			                height: (v.height - 3),
			                backgroundColor: 'black',
			                opacity: 0,
			                zIndex: $.fn.qtip.zindex - 1
			            });
	
			            // 节点边框
			            var $border = $('<div/>', {
			                'class': 'activity-attr-border'
			            }).css({
			            	position: 'absolute',
			            	 left: (v.x +20),
				             top: (v.y +20),
			                width: (v.width - 2),
			                height: (v.height - 3),
			                zIndex: $.fn.qtip.zindex - 2
			            });
	
			            if (v.currentActiviti) {
// 			                $border.addClass('ui-corner-all-12').css({
// 			                    border: '3px solid red'
// 			                });
			            }
			            positionHtml += $positionDiv.outerHTML() + $border.outerHTML();
			            varsArray[varsArray.length] = v.vars;
			        });
			        
			        $('#workflowTraceDialog #processImageBorder').html(positionHtml);
	
			        // 设置每个节点的data
			        $('#workflowTraceDialog .activity-attr').each(function(i, v) {
			            $(this).data('vars', varsArray[i]);
			        });

			        $('.activity-attr').qtip({
			        	style: {
	                        classes: 'qtip-rounded qtip-shadow' //圆角 阴影
	                    },
	                    content: function() {
	                    	
	                        var vars = $(this).data('vars');
	                        var tipContent = "<table class='table table-bordered' style='word-break:break-all; '>";
	                        $.each(vars, function(varKey, varValue) {
	                           // if (varValue) {
	                        	    varValue = varValue==null?"":varValue;  ///style='white-space:nowrap;' 强制不换行
	                                tipContent += "<tr><td class='active' style='white-space:nowrap;'>" + varKey + ":  </td><td  style='background-color:#FFF'>" + varValue + "</td></tr>";
	                            //}
	                        });
	                        tipContent += "</table>";
	                       return tipContent;
	                    },
	                   
	                    position: {
	                    	my: 'top left',
	                        at: 'bottom right',
	                        	adjust: {  
	                                // 提示信息位置偏移  
	                                x: -10, y: -10
	                                }
	                     }
	                });
			 });////// getJSON
	});
	
	
	/**
	 * 获取元素的outerHTML
	 */
	$.fn.outerHTML = function() {

	    // IE, Chrome & Safari will comply with the non-standard outerHTML, all others (FF) will have a fall-back for cloning
	    return (!this.length) ? this : (this[0].outerHTML ||
	    (function(el) {
	        var div = document.createElement('div');
	        div.appendChild(el.cloneNode(true));
	        var contents = div.innerHTML;
	        div = null;
	        return contents;
	    })(this[0]));
	    
	};
</script>

		<div id="workflowTraceDialog">
<%-- 			<img id="img" src="${ctx }/admin/workflow/resource/process-instance?type=image&pid=${pid}"/> --%>
			<img id="img"  src="${ctx }/admin/workflow/process/trace/auto/${pid}">
			
			<div   id='processImageBorderTrace'></div>
			
		</div>
	
