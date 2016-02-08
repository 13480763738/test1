$(function() {
	$("input").keypress(function() {
		if (event.keyCode == 13) {
			return false;
		}
	});

	var temp;
	var time = 500;
	hide = function() {
		$('.ui-pop-con').hide();
	};
	settime = function() {
		temp = setTimeout(hide, time);
	};
	cleartime = function() {
		clearTimeout(temp);
	};
	$(".ui_i_tips").hover(function() {
		hide();
		$(this).siblings("div").show();
		cleartime();
	}, function() {
		settime();
	});
	$('.ui-pop-con').hover(function() {
		cleartime();
	}, function() {
		settime();
	});

	$("#tbButton").click(function() {
		checkBid();
	});

	$("#ok").click(function() {
		var $isread = $("input[name='isread']");
		if ($isread.size() > 0) {
			if ($isread[0].checked != true) {
				alert("你还没有阅读并同意签署协议!");
				return false;
			}
		}
		var form = document.forms[0];
		form.submit();
	});

});

function checkBid() {
	var fs = $("#amount").val();
	if (fs == 0 || fs.length == 0) {
		sussess_dialog("请输入购买份数！");
		return;
	}
	var syfs = $("#syfs").val();
	if (parseInt(syfs) < parseInt(fs)) {
		sussess_dialog("你的投标份数大于剩余投标份数！");
		return;
	}
	var kyMoney = $("#kyMoney").val();
	var mfje = $("#mfMoney").val();
	var zxMoney = mfje * fs;
	if (kyMoney < zxMoney) {
		var url = $("#charge").val();
		sussess_dialog('你的账户余额不足进行本次投标，请在PC端进行充值后投标');
		return;
	}

	var isYuqi = $("#isYuqi").val();

	if (isYuqi == "Y") {
		sussess_dialog("您有逾期未还的贷款，还完才能进行投标操作！");
		return;
	}
	$("#fs").text(fs);
	$("#zxMoney").text(zxMoney);
	$("#confirm_join").show();
	var h = $(document).height();
	$(".popup_bg").css("height", h).show();
}

$(function() {
	$(".tables").click(function() {
		$(".tables").removeClass("hover");
		$(this).addClass("hover");
		showdate();
	});

	function showdate() {
		var $selectli = $(".hover");
		// 获取选中ID名称
		var name = $selectli.attr("id");
		$(".iframes").hide();
		// 通过选中ID显示Id对于的div
		var $selectdiv = $("div[name='" + name + "']");
		$selectdiv.show();
		// 获取地址
		var url = $selectli.attr("src");
		// 刷新对应div数据
		var myiframe = document.getElementById("f" + name);
		if (myiframe != null)
			myiframe.src = url;
	}
	// 初始化选中
	$("#bdxq").addClass("hover");
	showdate();
});

$(function() {
	var nll = $("#_nll").val();
	var qs = $("#_hkqs").val();
	var jlll = $("#_jlll").val();
	var hkzq = $("#_jkzq").val();
	var hkfs = $("#_hkfs").val();
	$(".right_btn").click(function() {
		var num = parseInt($(".text_input_hf").val());
		num = num + 10;

		var tz1 = num;
		var sy = c_sy_amt(hkfs, hkzq, nll, qs, tz1);
		var jl = c_jl_amt(lx, nll, jlll);
		
		$("#_yjsy").text(sy);
		$("#_yjjl").text(jl);

		$(".text_input_hf").val(num);
	});
	$(".left_btn").click(function() {
		var num = parseInt($(".text_input_hf").val());
		num = num - 10;

		if (num < 1) {
			return false;
		}
		var tz1 = num;
		$("#_yjsy").text(c_sy_amt(hkfs, hkzq, nll, qs, tz1));
		$("#_yjjl").text(c_jl_amt(lx, nll, jlll));
		$(".text_input_hf").val(num);
	});
});

var num = $(".jl_listright li").length;
gun = function() {
	var box = $(".jl_listright");
	var rollHeight = 0;
	box.find("ul").find("li").each(function() {
		var listWid = $(this).outerHeight(true);
		rollHeight = rollHeight + listWid;
	});
	box.find("ul").find("li").clone(true).appendTo(box.find("ul"));
	box.find("ul").css("height", "999999px");
	box.css("overflow", "hidden");
	function movePic() {
		box.scrollTop(box.scrollTop() + 1);
		if (box.scrollTop() == rollHeight) {
			box.scrollTop(0);
		}
	}
	// 自动播放
	var intID = setInterval(movePic, 40);
	box.hover(function() {
		clearInterval(intID);
	}, function() {
		intID = setInterval(movePic, 40);
	});
};
if (num > 4) {
	gun();
}

Number.prototype.toFixed = function(d) {
	var s = this + "";
	if (!d)
		d = 0;
	if (s.indexOf(".") == -1)
		s += ".";
	s += new Array(d + 1).join("0");
	if (new RegExp("^(-|\\+)?(\\d+(\\.\\d{0," + (d + 1) + "})?)\\d*$").test(s)) {
		var s = "0" + RegExp.$2, pm = RegExp.$1, a = RegExp.$3.length, b = true;
		if (a == d + 2) {
			a = s.match(/\d/g);
			if (parseInt(a[a.length - 1]) > 4) {
				for (var i = a.length - 2; i >= 0; i--) {
					a[i] = parseInt(a[i]) + 1;
					if (a[i] == 10) {
						a[i] = 0;
						b = i != 1;
					} else
						break;
				}
			}
			s = a.join("").replace(new RegExp("(\\d+)(\\d{" + d + "})\\d$"),
					"$1.$2");
		}
		if (b)
			s = s.substr(1);
		return (pm + s).replace(/\.$/, "");
	}
	return this + "";
};

// 收益
function c_sy_amt(hkfs, hkzq, nll, qs, tz) {
	lx = 0;
	var P = 100;
	var R = nll / 12;
	var N = qs;
	if (hkzq == 'AYHK') {
		if (hkfs == "DEBX") {
			var bx = ((P * R * Math.pow(1 + R, N)) / (Math.pow(1 + R, N) - 1))
					.toFixed(2) * 1;
			var bj = 100;
			for (var i = 0; i < (N - 1); i++) {
				var l = (bj * R).toFixed(2) * 1;
				bj = bj - (bx - l);
				lx = lx + l;
			}
			var l = (bj * R).toFixed(2) * 1;
			lx = lx + l;
			lx = lx * tz;
		} else {
			lx = tz * qs * (P * R);
		}
	}
	if (hkzq == 'TB') {
		lx = (tz * P * nll * qs / 360);
	}
	if (hkzq == 'MB') {
		lx = tz * P * nll;
	}
	return lx.toFixed(2);
}

// 奖励
function c_jl_amt(lx, nll, jlll) {
	var jl = lx * jlll / nll;
	return jl.toFixed(2);
}

var hkzq = $("#_jkzq").val();
var hkfs = $("#_hkfs").val();
var nll = $("#_nll").val();
var qs = $("#_hkqs").val();
var jlll = $("#_jlll").val();
var tz = 1;

var lx = c_sy_amt(hkfs, hkzq, nll, qs, tz);

$("#_yjsy").text(c_sy_amt(hkfs, hkzq, nll, qs, tz));
$("#_yjjl").text(c_jl_amt(lx, nll, jlll));

function changelx(evn) {
	var tz1 = $(evn).val();
	$("#_yjsy").text(c_sy_amt(hkfs, hkzq, nll, qs, tz1));
	$("#_yjjl").text(c_jl_amt(lx, nll, jlll));
}
