$(function(){
	var arrowFlag = "<div class='pointer'>" + 
	                    "<div class='arrow'></div>" + 
	                    "<div class='arrow_border'></div>" + 
	                "</div>";
	
	var menuLis = $("#dashboard-menu li");
	menuLis.click(function(){
		
		if($(this).find("a").attr("class") == "dropdown-toggle"){
			$(this).find(".submenu").toggle();
		}else{
			$.each(menuLis,function(index,element){
				$(element).find(".pointer").remove();
				$(element).removeClass("active");
			});
			$(this).append(arrowFlag);
			$(this).addClass("active");
		}
	});
	
	var subMenuLis = $("#dashboard-menu li .submenu li");
	subMenuLis.click(function(e){
		e.stopPropagation();
		$.each(menuLis,function(index,element){
			$(element).find(".pointer").remove();
			$(element).removeClass("active");
			$(this).find("a").removeClass("active");
		});
		$(this).parent().append(arrowFlag);
		$(this).parent().parent().addClass("active");
		$(this).find("a").addClass("active");
	});
});