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
var wait = 60;

function onSubmit()
{
	if (phoneCheck()&& passwordCheck()&&verifyCodeCheck()&&iAgreeCheck()) {
		return true;
	}
	return false;
}

function nameCheck() {
	var ipt = $("input[name='accountName']");
	var val = ipt.val();
	var p = ipt.parent().parent().find("p");
	var loginSuccess = $("#loginSuccess");
	loginSuccess.removeClass("success_tip1");
	p.removeClass();
	p.addClass("gray9");
	p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
	if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("用户名不能为空");
		return false;
	} else if (!loginName.test(val)) {
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
	var p = ipt.parent().parent().find("p");
	p.removeClass();
	if (isNull.test(val)) {
		p.addClass("red");
		p.text("密码不能为空");
		return false;
	} else if (val.length < 6 || val.length > 16) {
		p.text("密码不正确");
		p.addClass("red");
		return false;
	} else if (/\d+/.test(val) && /[A-Za-z]+/.test(val) && /\W+/.test(val)) {
	} else if (/[a-zA-Z]+/.test(val) && /[0-9]+/.test(val)) {
	} else if (/[a-zA-Z]+/.test(val) && /[\W_]/.test(val)) {
	} else if (/[0-9]+/.test(val) && /[\W_]/.test(val)) {
	} else {
	}
	p.text("");
	return true;
}
function rePasswordCheck() {
	var ipt = $("input[name='password']");
	var _ipt = $("input[name='newPassword']");
	var val = _ipt.val();
	var newPasswordSuccess = $("#newPasswordSuccess");
	newPasswordSuccess.removeClass("success_tip1");
	var p = _ipt.parent().parent().find("p");
	p.removeClass();
	p.addClass("gray9");
	p.text("请再次输入密码");
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
	if(ipt[0].checked!=true){
		p.addClass("red");
		p.text("请同意我们的条款");
		return false;
	}
	p.text("");
	return true;
}

function verifyCodeCheck() {
	var ipt = $("input[name='verifyCode']");
	var val = ipt.val();
	var p = ipt.parent().parent().find("p");
	p.removeClass();
	if (isNull.test(val)) {
		p.addClass("red");
		p.text("验证码不能为空");
		return false;
	}
	p.text("");
	return true;
}

function codeCheck() {
	var ipt = $("input[name='code']");
	var val = ipt.val();
	var codeSuccess = $("#codeSuccess");
	codeSuccess.removeClass("success_tip1");
	var p = ipt.parent().parent().find("p");
	p.removeClass();
	if (!codeVal.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的邀请码格式不正确");
		return false;
	}
	if(val!='')
	{
		codeSuccess.addClass("success_tip1");
	}
	return true;
}

function phoneCheck() {
	var ipt = $("input[name='phone']");
	var val = ipt.val();
	var p = ipt.parent().parent().find("p");
	p.removeClass();
	if (!phoneVal.test(val)) {
		p.addClass("red");
		p.text("您输入的手机号码不正确");
		return false;
	}
	p.text("");
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
	var p = $(evn).parent().parent().find("p");
	p.addClass("red");
	if (!phoneVal.test($phone.val())) {
		p.addClass("red");
		p.text("您输入的手机号码不正确");
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
				p.addClass("red");
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
		evn.value="获取验证码";
		wait = 60;
	} else {
		if(!$(evn).hasClass("selected")){
			$(evn).addClass("selected");
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