var isNull = /^[\s]{0,}$/;
var verify = /^\d{6}$/;
var p = $("#errorMsg");
var myreg = /^(13|15|18|17|14|16|19)[0-9]{9}$/;

function phoneCheck() {
	var val = $("input[name='phone']").val();
	p.html("");
	if (isNull.test(val)) {
		p.html("手机不能为空");
		return false;
	}
	if(!myreg.test(val)){
		p.html("请输入正确手机号!");
		return false;
	}
	return true;
}
function verifyCheck() {
	var val = $("input[name='verifyCode']").val();
	p.html("");
	if (isNull.test(val)) {
		p.html("验证码不能为空");
		return false;
	} else if (!verify.test(val)) {
		p.html("您输入的验证码有误");
		return false;
	}
	return true;
}
function onSubmit() {
	
	return phoneCheck() && verifyCheck();
}