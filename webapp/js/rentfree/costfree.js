$(function(){
	$("#ok").click(function(){
		var $isread = $("input[name='isread']");
		if($isread.size()>0){
			if($isread[0].checked!=true){
				alert("你还没有阅读并同意签署协议!");
				return false;
			}
		}
		if(check()){
			$("div.success").show();
			$("div.popup_bg").show();
		}
	});
	
	 
});

function check(){
	
	var mzbdzid = parseInt($("input[name='lxrid']").size());
	var kyMoney= parseInt($("#kyMoney").val());
	var sxje = parseInt($("#sxje").val());
	var ijre = parseInt($("#ijre").val());
	var zdjre = parseInt($("#zdtze").val());
	
	if(mzbdzid == 0){
		$("#info").html(newDialogInfo(600,"请选择手机号！","3"));
		$("div.popup_bg").show();
		return false;
	}
	
	if(kyMoney < sxje){
		var url=$("#charge").val();
		$("#info").html(newForwardInfo(700,'你的账户余额不足进行本次投标 ，请充值，点击<br/>"确定"，跳到充值页面，点击"取消"返回当前页面',"3",url));	
		$("div.popup_bg").show();
		return false;
	}
	
	var syje = parseInt($("#syje").val());
	if(ijre > syje){
		$("#info").html(newDialogInfo(600,"加入金额超过项目剩余金额！","3"));
		$("div.popup_bg").show();
		return false;
	}
	
	if(zdjre > ijre){
		$("#info").html(newDialogInfo(600,"加入金额小于最低投资金额！","3"));
		$("div.popup_bg").show();
		return false;
	}
	
	var isYuqi= $("#isYuqi").val();
	if(isYuqi == "Y"){
		$("#info").html(newDialogInfo(600,"您有逾期未还的贷款，还完才能进行<br/>投标操作","3"));
		$("div.popup_bg").show();
		return false;
	}
	
	return true;
}

