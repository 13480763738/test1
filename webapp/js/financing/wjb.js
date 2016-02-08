function isok(ddindx) {
	var $isread = $("input[name='ischeck']");
	if ($isread.size() > 0) {
		if ($isread[ddindx].checked != true) {
			alert("你还没有阅读并同意签署协议!");
			return false;
		}
	}
	var form = document.forms[0];
	form.submit();
}

function changelx($env){
	var status_dq = $("#status_dq").val();
	var fs = $($env).val();
	if(status_dq == "YDZ"){
		var djbl_js = $("#djbl_js").val();
		var dj = parseFloat(djbl_js*fs).toFixed(2);
		var djsx_js = $("#djsx_js").val();
		if(parseInt(djsx_js) != 0 &&  parseInt(djsx_js) < parseInt(dj)){
			$("#show_dj").text(djsx_js);
		}else{
			$("#show_dj").text(dj);
		}
		
	}
}

function checkBid() {
	var fs = $("#amount").val();
	var msg_name = $("#msg_name").val();
	if (fs == 0 || fs.length == 0) {
		$("#info").html(newDialogInfo(520, "请输入"+msg_name+"金额", "3"));
		$("div.popup_bg").show();
		return;
	}
	var status_dq = $("#status_dq").val();
	
	if(status_dq == "YDZ" || status_dq == "KFJR"){
		var tsize = $("#zdtzr_js").val();
		if(parseInt(fs) % parseInt(tsize) != 0 || parseInt(fs) < parseInt(tsize)){
			$("#info").html(newDialogInfo(520, "加入金额必须从"+tsize+"元起，且为"+tsize+"元的倍数递增", "3"));
			$("div.popup_bg").show();
			return;
		}
		
		var djsx_js = $("#djsx_js").val();
		if(status_dq == "YDZ"){
			var ydsyje_js = $("#ydsyje_js").val();
			if(parseInt(ydsyje_js) < parseInt(fs)){
				$("#info").html(newDialogInfo(520, "剩余金额不足", "3"));
				$("div.popup_bg").show();
				return;
			}
		}
		if(status_dq == "KFJR"){
			var syje_js = $("#syje_js").val();
			if(parseInt(fs) > parseInt(syje_js)){
				$("#info").html(newDialogInfo(520, "剩余金额不足", "3"));
				$("div.popup_bg").show();
				return;
			}
		}
		
		var kyMoney = $("#kyMoney").val();
		
		if(status_dq == "YDZ"){
			var _djbl_js = $("#djbl_js").val();
			var _dj = parseFloat(_djbl_js*fs).toFixed(2);
			if(parseInt(djsx_js) != 0 &&  parseInt(djsx_js) < parseInt(_dj)){
				_dj = djsx_js;
			}
			
			if(parseInt(_dj) > parseInt(kyMoney)){
				var url = $("#charge").val();
				$("#info").html( newForwardInfo(730,'你的账户余额不足进行本次投标 ，请充值，点击"确定"，跳到充值页面，点击"取消"返回当前页面', "3",url));
				$("div.popup_bg").show();
				return;
			}
		}
		
		if(status_dq == "KFJR"){
			if(parseInt(fs) > parseInt(kyMoney)){
				var url = $("#charge").val();
				$("#info").html( newForwardInfo(730,'你的账户余额不足进行本次投标 ，请充值，点击"确定"，跳到充值页面，点击"取消"返回当前页面', "3",url));
				$("div.popup_bg").show();
				return;
			}
		}
		
		var isYuqi = $("#isYuqi").val();
		if (isYuqi == "Y") {
			$("#info").html(newDialogInfo(520, "您有逾期未还的贷款，还完才能进行投标操作", "3"));
			$("div.popup_bg").show();
			return;
		}
		
		if(status_dq == "YDZ"){
			$("#ydxin_dialog").show();
			$("div.popup_bg").show();
			var djbl_js = $("#djbl_js").val();
			var dj = parseFloat(djbl_js*fs).toFixed(2);
			$("#jrje_dialog").text(fs);
			if(parseInt(djsx_js) != 0 &&  parseInt(djsx_js) < parseInt(dj)){
				$("#dj_dialog").text(djsx_js);
				dj = djsx_js;
			}else{
				$("#dj_dialog").text(dj);
			}
			$("#ydzfsyje_dialog").text(fs-dj);
			$("input[name='dj']").val(dj);
			$("input[name='jrje']").val(fs);
		}
		if(status_dq == "KFJR"){
			$("#wjbqr").show();
			$("div.popup_bg").show();
			$("#jrje_qr_dialog").text(fs);
			$("#yfdj_qr_dialog").text("0");
			$("#yfje_qr_dialog").text(fs);
			$("input[name='jrje']").val(fs);
		}
	}else{
		$("#info").html(newDialogInfo(520, "当前阶段不能加入稳加保", "3"));
		$("div.popup_bg").show();
		return;
	}
}

function show_zf(){
	$jrje = $("#callback_jrje").val();
	$dj = $("#callback_dj").val();
	$ye = $("#callback_ye").val();
	$jrid = $("#callback_jrid").val();
	$("#jrje_qr_dialog").text($jrje);
	$("#yfdj_qr_dialog").text($dj);
	$("#yfje_qr_dialog").text($ye);
	$("input[name='dj']").val($dj);
	$("input[name='jrje']").val($ye);
	$("input[name='jrid']").val($jrid);
	$("#yd_callback").hide();
	$("#wjbqr").show();
	$("div.popup_bg").show();
}

$(function() {
	$(".tables").click(function() {
		$(".tables").removeClass("hover");
		$(this).addClass("hover");
		showdate();
	});

	function showdate() {
		var $selectli = $(".hover");
		var name = $selectli.attr("id");
		$(".iframes").hide();
		var $selectdiv = $("div[name='" + name + "']");
		$selectdiv.show();
		var url = $selectli.attr("src");
		var myiframe = document.getElementById("f" + name);
		if (myiframe != null)
			myiframe.src = url;
	}
	$("#xmjs").addClass("hover");
	showdate();
});
