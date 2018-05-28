(function($){
	var _param = {
		id: '',
		url: ''
	};
	
	var methods = {
		initGroup: function(setting){
			var param = setting.group;
			var id =  param.id;
			$.tdsAjax({
				url: param.url,
				data: {id:id},
				success: function(returnPage){
					$('#'+param.containerid).html(returnPage);
				},
				error: function(){
					
				}
			});
		},
		initRight: function(setting){
			var param = setting.right;
			var id =  param.id;
			$.tdsAjax({
				url: param.url,
				data: {id:id},
				success: function(returnPage){
					$('#'+param.containerid).html(returnPage);
				},
				error: function(){
					
				}
			});
		},
		initOrganizationTree: function(setting){
			var param = setting.oTree;
			var id =  param.id;
			$.tdsAjax({
				url: param.url,
				data: {id:id},
				success: function(organizationTreePage){
					$('#'+param.containerid).html(organizationTreePage);
				},
				error: function(){
					
				}
			});
		},
		initOrganizationTable: function(setting){
			var param = setting.oTable;
			var id =  param.id;
			$.tdsAjax({
				url: param.url,
				data: {id:id},
				success: function(organizationTablePage){
					$('#'+param.containerid).html(organizationTablePage);
				},
				error: function(){
					
				}
			});
		},
		initUserTable: function(setting){
			var param = setting.uTable;
			var id =  param.id;
			$.tdsAjax({
				url: param.url,
				data: {id:id},
				success: function(userTablePage){
					$('#'+param.containerid).html(userTablePage);
				},
				error: function(){
					
				}
			});
		}
	};
	$.fn.authority = {
			
			init: function(params){
				var setting = $.extend(true,_param,params);
				methods.initGroup(setting);
				methods.initRight(setting);
				methods.initOrganizationTree(setting);
				methods.initOrganizationTable(setting);
				methods.initUserTable(setting);
			},
			save: function(url,param,callback){
				$.tdsAjax({
					url: url,
					data:param,
					type: 'post',
					success: function(returnValues){
						var group = returnValues.GROUP;
						if(callback)
							callback(group);
					},
					error: function(){
						var text = getJspParam('savingFaild');
						showError(text);
					}
				});
			},
			deleteGroup: function(url,param,callback){
				$.tdsAjax({
					url: url,
					data:param,
					type: 'post',
					success: function(returnValues){
						var group = returnValues.GROUP;
						if(group){
							if(callback)
								callback(param.id);
						}else{
							var text = getJspParam('deletingFaild');
							showError(text);
						}
					},
					error: function(){
						var text = getJspParam('deletingFaild');
						showError(text);
					}
				});
			}
	};
})(jQuery);
