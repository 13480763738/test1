$(function(){
	/*头部下拉*/
	$(".user_name").hover(function(){
		$(this).siblings("div").show();
		},function(){
			$(this).siblings("div").hide();
			});
	$(".header_login_list").hover(function(){
		$(this).show();
		},function(){
			$(this).hide();
			});
			
	/*排名滚动*/
	var num=$(".pm_list li").length;
	gun=function () {
    var box = $(".pm_list");
	var rollHeight = 0;
	box.find("ul").find("li").each(function(){
		var listWid = $(this).outerHeight(true);
		rollHeight = rollHeight + listWid;
	});
    box.find("ul").find("li").clone(true).appendTo(box.find("ul"));
    box.find("ul").css("height", "999999px");
    box.css("overflow", "hidden");
    function movePic() {
        box.scrollTop(box.scrollTop() + 1);
        if (box.scrollTop() == rollHeight) { box.scrollTop(0); }
    }
    var intID = setInterval(movePic, 40);
    box.hover(function () {
        clearInterval(intID);
    }, function () {
        intID = setInterval(movePic, 40);
    });
};
if(num>10){
	gun();
	}
	
/*会飞的红包*/
	function hb(){
		$(".hbf").animate({"top":"300px"},1000).animate({"top":"317px"},1000);
		$(".cloud1").animate({"left":"-65px"},1000).animate({"left":"-55px"},1000);
		$(".cloud2").animate({"right":"-70px"},1000).animate({"right":"-50px"},1000);
		};
	$(document).ready(function(){
		hb();
		setInterval(hb,2000);
		});
	
	});