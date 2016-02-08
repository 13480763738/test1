var checkName = true;
var checkmobile = true;
$(function() {
	showAuto();
	$("input:checkbox[name='iAgree']").click(function() {
		var iAgree = $(this).attr("checked");
		var register = $("#sub-btn");
		if (iAgree) {
			register.addClass("btn01");
			register.removeClass("btn02");
		} else {
			register.removeClass("btn01");
			register.addClass("btn btn02");
		}
	});
});
var isNull = /^[\s]{0,}$/;
var loginName = /^[a-z]([\w]{5,17})$/i;
var codeVal=/^[A-Za-z0-9]{0,20}$/;
var phoneVal = /^(13|15|18|17|14|16|19)[0-9]{9}$/;
var wait = 180;
var wait_1 = 60;

function onSubmit()
{
	if (checkName && checkmobile && iAgreeCheck()&&imgCodeCheck()
		&& nameCheck() && passwordCheck()&&phoneCheck()
		&& rePasswordCheck()&& verifyCodeCheck()&&codeCheck()&&verifyCheck()) {
		return true;
	}
	return false;
}

function nameCheck() {
	var ipt = $("input[name='accountName']");
	var val = ipt.val();
	var p = $("#loginNameError");
	if (isNull.test(val)) {
		p.text("用户名不能为空");
		return false;
	} else if (!loginName.test(val)) {
		p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
		return false;
	}
	p.text("");
	$.post(_nURL, {
		accountName : val
	}, function(data) {
		if (data.trim() == 'true') {
			p.text("用户名已存在");
			checkName = false;
			return false;
		}
	});
	checkName = true;
	
	return true;
}
function passwordCheck() {
	var ipt = $("input[name='password']");
	var val = ipt.val();
	var p =  $("#passwordError");
	if (isNull.test(val)) {
		p.text("密码不能为空");
		return false;
	} else if (val.length < 6 || val.length > 16) {
		p.text("6~16个字符，区分大小写");
		return false;
	} 
	p.text("");
	return true;
}
function rePasswordCheck() {
	var ipt = $("input[name='password']");
	var _ipt = $("input[name='rePassword']");
	var val = _ipt.val();
	var p =$("#rePasswordError"); 
	if (isNull.test(ipt.val())) {
		p.text("请先输入密码");
		return false;
	} else if (isNull.test(val)) {
		p.text("确认密码不能为空");
		return false;
	} else if (val != ipt.val()) {
		p.text("两次输入的密码不一致");
		return false;
	}
	p.text("");
	return true;
}

function iAgreeCheck(){
	var ipt = $("input:checkbox[name='iAgree']");
	var p = $("#iAgreeError");
	if(!ipt[0].checked){
		p.text("请选择同意");
		return false;
	}
	p.text("");
	return true;
}

function verifyCodeCheck() {
	var ipt = $("input[name='verifyCode']");
	var val = ipt.val();
	var p = $("#verifyCodeError");
	if (isNull.test(val)) {
		p.text("验证码不能为空");
		return false;
	}
	p.text("");
	return true;
}

function imgCodeCheck() {
	var ipt = $("input[name='imgCode']");
	var val = ipt.val();
	var p = $("#imgCodeError");
	if (isNull.test(val)) {
		p.text("验证码不能为空");
		return false;
	}
	p.text("");
	return true;
}

function codeCheck() {
	var ipt = $("input[name='code']");
	var val = ipt.val();
	var p =  $("#codeError");
	if (!codeVal.test(val)) {
		p.text("邀请码格式不正确");
		return false;
	}
	p.text("");
	return true;
}

function phoneCheck() {
	var ipt = $("input[name='phone']");
	var val = ipt.val();
	var p =$("#phoneError"); 
	if (!phoneVal.test(val)) {
		p.text("手机号码不正确");
		return false;
	}
		if(p.text()!='')
		{
			p.text("");
			return false;
		}
		
		return true;
	}
	

function anotherImg(contextPath) {
	$("#verify-img").attr("src", contextPath);
}

function showAuto() {
	var checked = $("#type2").attr("checked");
	if (checked) {
		$("#autoPayDiv").show();
	} else {
		$("#autoPayDiv").hide();
	}
}

function sendCode(evn){
	var $phone = $("input[name='phone']");
	var p = $("#verifyCodeError");
	if (!phoneVal.test($phone.val())) {
		$("#phoneError").text("手机号码不正确");
		return false;
	}
	var data={"phone":$phone.val()};
	$.ajax({
		type:"post",
		dataType:"html",
		url:_cUrl,
		data:data,
		success:function(data){
			var ct = eval('('+data+')');
			if(ct.length>0){
				if(ct[0].num == 2){
					sendclick(evn);
				}
				p.text(ct[0].msg);
				return false;
			}
		}
	});
	
	
}

function sendCode_1(evn){
	var $phone = $("input[name='phone']");
	var p = $("#verifyCodeError");
	if (!phoneVal.test($phone.val())) {
		$("#phoneError").text("手机号码不正确");
		return false;
	}
	var data={"phone":$phone.val()};
	$.ajax({
		type:"post",
		dataType:"html",
		url:_cUrl_1,
		data:data,
		success:function(data){
			var ct = eval('('+data+')');
			if(ct.length>0){
				if(ct[0].num == 2){
					sendclick_1(evn);
				}
				p.text(ct[0].msg);
				return false;
			}
		}
	});
	
	
}
function sendclick(evn){

	if (wait == 0) {
		evn.removeAttribute("disabled");
		$(evn).removeClass("selected");
		evn.value="语音验证";
		wait = 180;
		$("#_dx").removeAttr("disabled");
		$("#_dx").removeClass("readonly");
	} else {
		$("#_dx").attr("disabled", true);
		if(!$(evn).hasClass("selected")){
			$(evn).addClass("selected");
			$("#_dx").addClass("readonly");
		}
		evn.setAttribute("disabled", true);
		
		evn.value="(" + wait + ")秒后重发";
		wait--;
		setTimeout(function() {
			sendclick(evn);
		},
		1000);
	}
}

function sendclick_1(evn){
	if (wait_1 == 0) {
		evn.removeAttribute("disabled");
		$(evn).removeClass("selected");
		evn.value="短信验证";
		wait_1 = 60;
		$("#_yy").show();
		$("#_dx").removeClass("readonly");
		$("#_yy").removeClass("readonly");
		$("#_yy").removeAttr("disabled");
	} else {
		$("#_yy").attr("disabled", true);
		if(!$(evn).hasClass("selected")){
			$(evn).addClass("selected");
			$("#_yy").addClass("readonly");
		}
		evn.setAttribute("disabled", true);
		evn.value="(" + wait_1 + ")秒后重发";
		wait_1--;
		setTimeout(function() {
			sendclick_1(evn);
		},
		1000);
	}
}
var verify = /^\d{6}$/;
function verifyCheck() {
	var val = $("input[name='verifyCode']").val();
	var p = $("#verifyError");
	p.html("");
	p.removeClass("red");
	if (isNull.test(val)) {
		p.html("验证码不能为空");
		p.addClass("red");
		return false;
	} else if (!verify.test(val)) {
		p.html("验证码错误");
		p.addClass("red");
		return false;
	}
	return true;
}