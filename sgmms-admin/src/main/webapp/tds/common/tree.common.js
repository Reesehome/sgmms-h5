function isNotNullAndEmpty(str){
	return str!=null && str!='' && typeof str != 'undefined'; 
}
 function initRMenu(){
	$("#rMenu ul").show();
	$("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
	$("body").bind("mousedown", onBodyMouseDown);
 }
 
 function onBodyMouseDown(event){
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		$("#rMenu").css({"visibility" : "hidden"});
	}
}