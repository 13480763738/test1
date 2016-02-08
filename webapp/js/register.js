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
	if (checkName && checkmobile && iAgreeCheck()
		&& nameCheck() && passwordCheck()&&phoneCheck()
		&& rePasswordCheck()&& verifyCodeCheck()&&codeCheck()&&verifyCheck()) {
		return true;
	}
	return false;
}

function nameCheck() {
	var ipt = $("input[name='accountName']");
	var val = ipt.val();
	var p = ipt.parent().find("p");
	var loginSuccess = $("#loginSuccess");
	loginSuccess.removeClass("success_tip1");
	p.removeClass();
	p.addClass("gray9");
	if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("用户名不能为空");
		return false;
	} else if (!loginName.test(val)) {
		p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
		p.addClass("red");
		p.removeClass("gray9");
		return false;
	}
	$.post(_nURL, {
		accountName : val
	}, function(data) {
		if (data.trim() == 'true') {
			loginSuccess.removeClass("success_tip1");
			p.addClass("red");
			p.removeClass("gray9");
			p.text("该用户名已存在，请输入其他用户名");
			checkName = false;
			return false;
		}
	});
	loginSuccess.addClass("success_tip1");
	checkName = true;
	return true;
}
function passwordCheck() {
	var ipt = $("input[name='password']");
	var val = ipt.val();
	var p = ipt.parent().find("p");
	var passwordSuccess = $("#passwordSuccess");
	passwordSuccess.removeClass("success_tip1");
	p.removeClass();
	p.addClass("gray9");
	p.find("span span").removeClass("on");
	if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		$("#passwordSuccess").text("密码不能为空");
		return false;
	} else if (val.length < 6 || val.length > 16) {
		$("#passwordSuccess").text("6~16个字符，区分大小写");
		p.addClass("red");
		p.removeClass("gray9");
		return false;
	} else if (/\d+/.test(val) && /[A-Za-z]+/.test(val) && /\W+/.test(val)) {
		p.find("span span.strong").addClass("on");
	} else if (/[a-zA-Z]+/.test(val) && /[0-9]+/.test(val)) {
		p.find("span span.medium").addClass("on");
	} else if (/[a-zA-Z]+/.test(val) && /[\W_]/.test(val)) {
		p.find("span span.medium").addClass("on");
	} else if (/[0-9]+/.test(val) && /[\W_]/.test(val)) {
		p.find("span span.medium").addClass("on");
	} else {
		p.find("span span.weak").addClass("on");
	}
	passwordSuccess.addClass("success_tip1");
	return true;
}
function rePasswordCheck() {
	var ipt = $("input[name='password']");
	var _ipt = $("input[name='newPassword']");
	var val = _ipt.val();
	var p =$("#newPasswordSuccess"); 
	p.removeClass();
	p.addClass("gray9");
	if (isNull.test(ipt.val())) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("请先输入密码");
		return false;
	} else if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("确认密码不能为空");
		return false;
	} else if (val != ipt.val()) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您两次输入的密码不一致");
		return false;
	}
	newPasswordSuccess.addClass("success_tip1");
	return true;
}

function iAgreeCheck(){
	var ipt = $("input:checkbox[name='iAgree']");
	var verifyCodeSuccess = $("#verifyCodeSuccess");
	verifyCodeSuccess.removeClass("success_tip1");
	var p = ipt.parent().find("p");
	p.removeClass();
	p.addClass("gray9");
	if(ipt[0].checked!=true){
		p.addClass("red");
		p.removeClass("gray9");
		p.text("请同意我们的条款");
		return false;
	}
	verifyCodeSuccess.addClass("success_tip1");
	return true;
}

function verifyCodeCheck() {
	var ipt = $("input[name='verifyCode']");
	var val = ipt.val();
	var verifyCodeSuccess = $("#verifyCodeSuccess");
	verifyCodeSuccess.removeClass("success_tip1");
	var p = ipt.parent().find("p");
	p.removeClass();
	p.addClass("gray9");
	if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("验证码不能为空");
		return false;
	}
	verifyCodeSuccess.addClass("success_tip1");
	p.text("");
	return true;
}

function codeCheck() {
	var ipt = $("input[name='code']");
	var val = ipt.val();
	var p =  $("#codeSuccess");
	    p.removeClass();
	if (!codeVal.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的邀请码格式不正确");
		return false;
	}
}

function phoneCheck() {
	var ipt = $("input[name='phone']");
	var val = ipt.val();
	var p =$("#phone"); 
	if (!phoneVal.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的手机号码不正确");
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
	var code = $("input[name='code']");
	
	var $phone = $("input[name='phone']");
	var p = $(evn).parent().find("p");
	if (!phoneVal.test($phone.val())) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的手机号码不正确");
		return false;
	}
	var data={"phone":$phone.val(),"code":code.val()};
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
				}else{
					$("#_verifyImg").attr("src",imgUrl+'?'+Math.random());
					code.val("");
				}
				
				p.addClass("red");
				p.removeClass("gray9");
				p.text(ct[0].msg);
				return false;
			}
		}
	});
}

function sendCode_1(evn){
	var $phone = $("input[name='phone']");
	var code = $("input[name='code']");
	var p = $(evn).parent().find("p");
	if (!phoneVal.test($phone.val())) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的手机号码不正确");
		return false;
	}
	var data={"phone":$phone.val(),"code":code.val()};
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
				}else{
					$("#_verifyImg").attr("src",imgUrl+'?'+Math.random());
					code.val("");
				}
				p.addClass("red");
				p.removeClass("gray9");
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
		evn.value="语音验证码";
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
		evn.value="(" + wait + ")秒重新获取";
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
		evn.value="短信验证码";
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
		evn.value="(" + wait_1 + ")秒重新获取";
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
		p.html("您输入的验证码有误");
		p.addClass("red");
		return false;
	}
	return true;
}