$(function(){
	/*$("#gmMoney").blur(function(){
		checkBid();
	});*/
	
	$("input").keypress(function(){
		if(event.keyCode==13) {return false;}
	  });
     

	$("#tbButton").click(function(){
		
		checkBid();
	});
	
	$("#ok").click(function(){
		var form = $("#form2");
		form.submit();
	});

	 
});

	function mouseOver(id)
	{
		document.getElementById('txfy'+id).style.display = "block";
	}
	function mouseOut(id)
	{
		document.getElementById('txfy'+id).style.display = "none";
	}

	
	function checkBid(){
		var syMoney= $("#syMoney").val();
		var maxMoney=$("#maxMoney").val();
		var minMoney=$("#minMoney").val();
		var tzMoney= $("#tzMoney").val();
		var isYuqi= $("#isYuqi").val();
		var jrfl=$("#jrfl").val();
		var gmMoney=$("#gmMoney").val();
		var kyMoney=$("#kyMoney").val();
		var tzfs = $("#tzfs").val();
		var safetyError = $("#safetyError").val();
		
		
		if(tzfs == "XJ"){
			if(gmMoney == 0 || gmMoney.length==0 || !(parseInt(gmMoney)%parseInt(minMoney)===0)){
				$("#info").html(newDialogInfo(520,"你的投标金额必须为最低投标额的整数倍","3"));	
				$("div.popup_bg").show();
				return;
			}
		}
		if(tzfs == "TYJ"){
			if(safetyError=="error"){
				$("#txmm").show();
				$("#tyjtxmm").show();
				$("div.popup_bg").show();
				return;
			}
			if(gmMoney == 0 || gmMoney.length==0){
				if($("input[name='ex']").size()>0){
					$("#info").html(newDialogInfo(520,"请选择体验金再申请！","3"));	
					$("div.popup_bg").show();
					return;
				}
				$("#info").html(newDialogInfo(520,"您当前没有体验金，请关注平台线上/下活动，获取体验金再申请！","3"));	
				$("div.popup_bg").show();
				return;
			}
		}
		
		if(parseInt(maxMoney) < parseInt(gmMoney) + parseInt(tzMoney)){
			$("#info").html(newDialogInfo(520,"你的投标已经超出计划的个人投标最大限额","3"));	
			$("div.popup_bg").show();
			return;
		}
		
		if(tzfs == "XJ"){
			if(parseInt(gmMoney) < parseInt(minMoney)){
				$("#info").html(newDialogInfo(520,"你的投标金额低于计划的最低投标金额","3"));	
				$("div.popup_bg").show();
				return;
			}
		}
		
		if(parseInt(syMoney) < parseInt(gmMoney)){
			$("#info").html(newDialogInfo(520,"你的投标金额大余计划的剩余投标金额","3"));	
			$("div.popup_bg").show();
			return;
		}
		
		if(parseInt(kyMoney) < parseInt(gmMoney) + parseInt(gmMoney*jrfl)){
			var url=$("#charge").val();
			$("#info").html(newForwardInfo(520,'你的账户余额不足进行本次投标 ，请充值，点击"确定"，跳转充值页面，点击"取消"返回当前页面',"3",url));	
			$("div.popup_bg").show();
			return;
		}
		
		if(isYuqi == "Y"){
			$("#info").html(newDialogInfo(520,"您有逾期未还的贷款，还完才能进行投标操作","3"));	
			$("div.popup_bg").show();
			return;
		}
		
		$("#jrfMoney").text(parseInt(gmMoney*jrfl));
		$("#zxMoney").text(gmMoney);
		$("#zgxMoney").text(parseFloat(parseInt(gmMoney*jrfl) + parseInt(gmMoney)).toFixed(2));
		$("#gmDialog").show();	
		$("div.popup_bg").show();
	}
	

