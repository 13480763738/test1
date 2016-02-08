function ShowCountDown(year,month,day,divname) 
		{ 
		var now = new Date(); 
		var endDate = new Date(year, month-1, day); 
		var leftTime=endDate.getTime()-now.getTime(); 
		var leftsecond = parseInt(leftTime/1000); 
		//var day1=parseInt(leftsecond/(24*60*60*6)); 
		var day1=Math.floor(leftsecond/(60*60*24)); 
		var hour=Math.floor((leftsecond-day1*24*60*60)/3600); 
		var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60); 
		var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60); 
		var cc = document.getElementById(divname); 
		if (day1 <= 9) day1 = '0' + day1;
		if (hour <= 9) hour = '0' + hour;
		if (second <= 9) second = '0' + second;
		if (minute <= 9) minute = '0' + minute;
			cc.innerHTML ="距投标还有:"+day1+"天"+hour+"小时"+minute+"分"+second+"秒"; 
}

$.fn.extend({  
	manhuaCountDown : function(isDay) {  
		var $this = $(this);	
		var dstr = $this.attr("date");
		var sys_second = dstr/1000;			
		var day,hour,minute,second;		
		var timer = setInterval(function(){
			sys_second -= 1;	
			if (sys_second >= 0) {	
				day = Math.floor((sys_second / 3600) / 24);	
				hour = Math.floor((sys_second / 3600) % 24);
				minute = Math.floor((sys_second / 60) % 60);
				second = Math.floor(sys_second % 60);
				if(isDay){
					day = day;//计算天
				}else{
					day = "";
				}
				hour = hour<10?"0"+hour:hour;//计算小时
				minute = minute<10?"0"+minute:minute;//计算分
				second = second<10?"0"+second:second;// 计算秒
				$this.html("距投标还有:"+day+"天"+hour+"小时"+minute+"分"+second+"秒");
			} else { 
				$this.css("display","none");
				$(".time_join").css("display","block");
				clearInterval(timer);
			}
		}, 1000);
	}  
});