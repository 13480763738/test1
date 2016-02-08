$(function() {
	$("#nav")
			.click(
					function(e) {
						var src = e ? e.target : event.srcElement;
						if (src.tagName == "H3") {
							var next = src.nextElementSibling
									|| src.nextSibling;
							next.style.display = (next.style.display == "block") ? "none"
									: "block";
						}
					});
});

function setTab(name, cursel, n) {
	for (var i = 1; i <= n; i++) {
		var menu = document.getElementById(name + i);
		var con = document.getElementById("con_" + name + "_" + i);
		menu.className = i == cursel ? "hover" : "";
		con.style.display = i == cursel ? "block" : "none";
	}
}

$(function() {
	function getStr(string, str) {
		var string = document.URL;
		var str = "value=";
		var str_after = string.split(str)[1];
		if (document.URL.match(str + str_after)) {
			$("#" + str_after).find("span.n_mc_name_hf").addClass("open");
			$("#" + str_after).find("div").css("display", "block");
			$("#" + str_after).find("p").css("display", "block");
			var hight = $("#" + str_after).offset().top;
			$("html,body").animate({
				scrollTop : hight-126
			}, 1000);
		}
	}
	getStr();

});