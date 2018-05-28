function arrayToJson(oneArray){
	var temp = oneArray.join(',');
	/*$.each(oneArray,function(idx,text){
		if(temp == '')
			temp = '"' + text +'"';
		else
			temp += ',"' + text +'"';
	});*/
	var oneJson = [temp ];
	return oneJson;
};
