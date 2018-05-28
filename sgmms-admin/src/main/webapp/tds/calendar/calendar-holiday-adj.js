/**
 * 
 */
var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#holidayAdjForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 adjustName : {
                 required : true,
                 maxlength : 128
             },
             adjustType : {
                 required : true
             },
             startDate : {
                 required : true
             },
             endDate : {
                 required : true
             }
         },
         messages : {
        	 adjustName : {
                 required : "调整名称不能为空！",
                 maxlength : "调整名称不能大于128个文字！"
             },
             adjustType : {
                 required : "调整类型不能为空！"
             },
             startDate : {
                 required : "开始时间不能为空！"
             },
             endDate : {
                 required : "结束时间不能为空！"
             }
         },
         highlight : function(element) {
             $(element).closest('.form-group').addClass('has-error');
         },

         success : function(label) {
             label.closest('.form-group').removeClass('has-error');
             label.remove();
         },
         errorPlacement : function(error, element) {
             element.parent('div').append(error);
         }
     });
});

/**
* 初始化时间组件
*/
function initEditDateWidget(){
	//初始化时间控件
	var startTime;
	$("#_startDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1}).on('changeDate',function(ev){
			startTime = ev.date.valueOf();
			if(endTime && startTime > endTime){
				$("#_startDate").val('');
			}else{
				$("#_endDate").datetimepicker('setStartDate',ev.date);
			}
	});
		
	
	var endTime;
	$("#_endDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1}).on('changeDate',function(ev){
			endTime = ev.date.valueOf();
			if(startTime && startTime > endTime){
				$("#_endDate").val('');
			}else{
				$("#_startDate").datetimepicker('setEndDate',ev.date);
			}
	});
	
}