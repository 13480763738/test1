var isNull = /^[\s]{0,}$/;
var verify = /^\d{6}$/;
var p = $("#errorMsg");

function codeCheck() {
	var val = $("input[name='code']").val();
	if (isNull.test(val)) {
		p.text("验证码不能为空");
		return false;
	}
	p.text("");
	return true;
}
function passwordCheck() {
	var val = $("input[name='password']").val();
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
	var val = $("input[name='password']").val();
	var val2 = $("input[name='repassword']").val();
	if (isNull.test(val)) {
		p.text("请先输入密码");
		return false;
	} else if (isNull.test(val2)) {
		p.text("确认密码不能为空");
		return false;
	} else if (val != val2) {
		p.text("两次输入的密码不一致");
		return false;
	}
	p.text("");
	return true;
}
function onSubmit() {
	
	return codeCheck() && passwordCheck() && rePasswordCheck();
}