/**
 * 
 */
var validateForm;
$(function(){
	//为inputForm注册validate函数
	validateForm = $('#holidayForm').validate({
         errorClass : 'help-block',
         focusInvalid : false,
         rules : {
        	 holidayName : {
                 required : true,
                 maxlength : 128
             },
             startDate : {
                 required : true
             },
             endDate : {
                 required : true
             },
             year : {
            	 required : true,
            	 number : true,
            	 min : 0
             }
         },
         messages : {
        	 holidayName : {
                 required : "节假日名称不能为空！",
                 maxlength : "节假日名称不能大于128个文字！"
             },
             startDate : {
                 required : "开始时间不能为空！"
             },
             endDate : {
                 required : "结束时间不能为空！"
             },
             year : {
            	 required : "所属年份不能为空！",
            	 number : "所属年份必须为数字！",
            	 min : "所属年份必须大于等于0！"
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
function initDateWidget(){
	//初始化时间控件
	var startTime;
	$("#startDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1}).on('changeDate',function(ev){
			startTime = ev.date.valueOf();
			if(endTime && startTime > endTime){
				$("#startDate").val('');
			}else{
				$("#endDate").datetimepicker('setStartDate',ev.date);
			}
	});
		
	
	var endTime;
	$("#endDate").datetimepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		todayBtn: true,
		clearBtn: true,
		language: 'zh-CN',
		minView : 5,
		weekStart: 1}).on('changeDate',function(ev){
			endTime = ev.date.valueOf();
			if(startTime && startTime > endTime){
				$("#endDate").val('');
			}else{
				$("#startDate").datetimepicker('setEndDate',ev.date);
			}
	});
	
}