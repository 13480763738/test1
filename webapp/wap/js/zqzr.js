$(function(){
	
	$("input").keypress(function(){
		if(event.keyCode==13) {return false;}
	  });
	
	$("#amount").keyup(function(){
		var fs=$("#amount").val();
		var zrjg=$("#zrjg").val();
		//var zxMoney=zrjg*fs;
		var tz1 = fs;
		$("#tbMoney").text(c_sy_amt(_zsy,_zje,tz1));
	});
	
	/*$("#tbButton").click(function(){
		checkBid();
	});*/
	
	/*var temp;
	var time=500;
	hide = function() {
		$('.allbj').hide();
	};
	settime=function(){ temp=setTimeout(hide,time);};
	cleartime=function(){clearTimeout(temp);};
	$(".allbg").hover(function() {
		$(this).css("background-position","3px 8px");
		hide();
		$(this).closest("div").find(".allbj").show();
		cleartime();
	}, function() {
		$(this).css("background-position","3px -14px");
		settime();
	});
	$(".allbj").hover(function() {
		cleartime();
	},function() {
		settime();
	});*/
	
	$("#ok").click(function(){
		if(!checkBid()){
			return false;
		}
		var $isread = $("input[name='isread']");
		if($isread.size()>0){
			if($isread[0].checked!=true){
				errorMsg("你还没有阅读并同意签署协议!");
				return false;
			}
		}
		
		var form = document.forms[0];
		form.submit();
	});
	
	
});

function errorMsg(msg){
	$("#error_tip").html(msg);
}
function checkBid(){
	
	var fs=$("#amount").val();
	if(fs == 0 || fs.length==0){
		errorMsg("请输入购买份数");	
		return;
	}
	var syfs= $("#syfs").val();
	if(parseInt(syfs) < parseInt(fs)){
		errorMsg("你的购买的份数大余剩余债权份数");	
		return;
	}
	var kyMoney=$("#kyMoney").val();
	var zrjg=$("#zrjg").val();
	var zxMoney=zrjg*fs;
	if(kyMoney < zxMoney){
		//var url=$("#charge").val();
		errorMsg("你的账户余额不足进行本次投标 ，请先充值");	
		return;
	}
	var isYuqi= $("#isYuqi").val();
	var a = isYuqi == "Y";
	if(isYuqi == "Y"){
		errorMsg("您有逾期未还的贷款，还完才能进行投标操作");	
		return;
	}
	return true;
}

$(function(){
	$(".right_btn").click(function(){
		
		var num=parseInt($(".text_input_hf").val());
		num=num+10;
		var tz1 = num;
		$("#tbMoney").text(c_sy_amt(_zsy,_zje,tz1));
		$(".text_input_hf").val(num);
		});
	$(".left_btn").click(function(){
	var num=parseInt($(".text_input_hf").val());
	num=num-10;

	if(num<1){
		return false;
		}
	var tz1 = num;
	$("#tbMoney").text(c_sy_amt(_zsy,_zje,tz1));
	$(".text_input_hf").val(num);
	});
	});

var _zsy = $("#_zsy").val();
var _zje = $("#_zje").val();
//预计收益
function c_sy_amt(_zsy,_zje,tz){
	var jl = _zsy*tz*100/_zje;
	return jl.toFixed(2);
}
$("#tbMoney").text(c_sy_amt(_zsy,_zje,1));
function changelx(evn){
	var tz1 = $(evn).val();
	$("#tbMoney").text(c_sy_amt(_zsy,_zje,tz1));
}
 
