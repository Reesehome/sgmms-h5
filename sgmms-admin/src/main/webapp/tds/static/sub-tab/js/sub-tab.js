jQuery(function(){
	initToggleSubTab();
});

function initToggleSubTab(){
	var allTabLinks = $(".sub-tab").find("a");
	
	allTabLinks.on("click",function(){
		var thisLink = $(this);
		thisLink.css("color","#ff8000");
		
		var theSameLevelLinks = thisLink.parent().parent().find("a");
		
		$.each(theSameLevelLinks,function(i,obj){
			if(thisLink.prop("href") != $(obj).prop("href")){
				$(obj).css("color","");
			}
		})
	});
	
	
}