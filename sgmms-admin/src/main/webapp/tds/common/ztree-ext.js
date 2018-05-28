/**
 * ztree的扩展方法
 */
(function($){
	_zTreeTools = function(setting, zTreeTools) {
		/**
		 * 勾选或取消勾选所有父亲节点
		 * @param node　需要勾选或取消勾选的当前节点
		 * @param checked　checked = true 表示勾选所有父亲节点（包括当前节点）,checked = false 表示取消勾选所有父亲节点（包括当前节点）
		 */
		zTreeTools.checkParentNodes = function(node, checked) {
			//对当前节点进行选中或者取消选中操作
			zTreeTools.checkNode(node,checked,false);
			
			var parentNode = node.getParentNode();
			if(parentNode){
				zTreeTools.checkNode(parentNode,checked,false);
				zTreeTools.checkParentNodes(parentNode, checked);
			}
		}
		
		/**
		 * 勾选或取消勾选所有子节点
		 * @param node　需要勾选或取消勾选的当前节点
		 * @param checked　checked = true 表示勾选所有子节点（包括当前节点）,checked = false 表示取消勾选所有子节点（包括当前节点）
		 */
		zTreeTools.checkSubNodes = function(node, checked) {
			//对当前节点进行勾选或取消勾选操作
			zTreeTools.checkNode(node,checked,false);
			
			//获取当前节点的所有子节点
			var subNodes = node.children;
			if(subNodes && subNodes.length > 0){
				$.each(subNodes,function(index,subNode){
					zTreeTools.checkNode(subNode,checked,false);
					zTreeTools.checkSubNodes(subNode, checked);
				});
			}
		}
	},

	 $.fn.zTree._z.data.addZTreeTools(_zTreeTools);
})(jQuery);