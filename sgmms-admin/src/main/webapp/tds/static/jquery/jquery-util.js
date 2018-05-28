/**
 * jquery扩展类
 */
(function($){
	/**
	 * 把表单序列化成json对象
	 */
	$.fn.serializeJson = function(){
		var serializeObj={};
		var array=this.serializeArray();
		var str=this.serialize();
		$(array).each(function(){
			if(this.value && this.value.trim() != ''){
				if(serializeObj[this.name]){				
					if($.isArray(serializeObj[this.name])){
						serializeObj[this.name].push(this.value);
					}else{
						serializeObj[this.name]=[serializeObj[this.name],this.value];
					}
				}else{
					serializeObj[this.name]=this.value;
				}
			}
		});
		return serializeObj;
	};
	
	/**
	 * 清空表单
	 */
	$.fn.cleanForm = function(){
		this.find(':input')
		.not(':button, :submit, :reset, :hidden')
		.val('')
		.removeAttr('checked')
		.removeAttr('selected');
	};
	
	/**
	 * 自己封装的ajax，主要解决有异常生产时弹出错误提示 
	 */
	$.tdsAjax = function(config){
		config.timeout = 5000;
		var targetSuccessFun;
		if(config.success) {
			targetSuccessFun = config.success;
			config.success = function(result){
				if(result.params && result.params.uncatchException) {
					BootstrapDialog.show({
						title: result.params.title,
			            size: BootstrapDialog.SIZE_SMALL,
			            type : BootstrapDialog.TYPE_DANGER,
			            message: result.message,
			            buttons: [{
			                label: result.params.closeBtnLabel,
			                action: function(dialogItself){
			                    dialogItself.close();
			                }
			            }]
			        });
					
					return;
				}
				
				//执行用户指定的回调方法
				targetSuccessFun.apply(this,[result]);
			}			
		}
		
		$.ajax(config);
	};
})(jQuery);