$(function(){
	var li_w=$('.invesSlider li').width()+4;
	var ul_w=$('.invesSlider').width();
	var num = $(".invesSlider li").length;
	var left = -parseInt($(".invesSlider").css("left"));
	//var timeout;
	function next(){
	var on_num=left/li_w;
		if(on_num==(num-1)){
			on_num=0;
			left=0;
			$(".invesSlider").stop(true,true).animate({"left":"0px"},300);
			$("#idNum").removeClass("how-step-"+(num-1));
			$("#idNum").addClass("how-step-0");
			$("#nav_dot").removeClass("dot-"+(num-1));
			$("#nav_dot").addClass("dot-0");
		}else{
			var n_left = -(left+li_w);
			left = -n_left;
			$(".invesSlider").stop(true,true).animate({"left":n_left+"px"},600);
			$("#idNum").removeClass("how-step-"+on_num);
			$("#idNum").addClass("how-step-"+(on_num+1));
			$("#nav_dot").removeClass("dot-"+on_num);
			$("#nav_dot").addClass("dot-"+(on_num+1));
		}
		//timeout=setTimeout('next()',3000);
	}
	function prev(){
	var on_num=left/li_w;
		if(on_num==0){
			on_num=(num-1);
			n_left=-(li_w*on_num);
			left=-n_left;
			$(".invesSlider").stop(true,true).animate({"left":n_left+"px"},300);
			$("#idNum").removeClass("how-step-0");
			$("#idNum").addClass("how-step-"+on_num);
			$("#nav_dot").removeClass("dot-0");
			$("#nav_dot").addClass("dot-"+on_num);
		}else{
			var n_left = -(left-li_w);
			left = -n_left;
			$(".invesSlider").stop(true,true).animate({"left":n_left+"px"},600);
			$("#idNum").removeClass("how-step-"+on_num);
			$("#idNum").addClass("how-step-"+(on_num-1));
			$("#nav_dot").removeClass("dot-"+on_num);
			$("#nav_dot").addClass("dot-"+(on_num-1));
		}
	}
	//setTimeout('next()',3000);
	$(".next").click(function(){
		//clearTimeout(timeout);
		next()
	});
	$(".prev").click(function(){prev()});
	$("#idNum li").click(function(){
		var on_num1 = $(this).index();
		var n_left = -(li_w*(on_num1));
		left = -n_left;
		$(".invesSlider").stop(true,true).animate({"left":n_left+"px"},600);
		for (var i=0;i<num;i++){
			$("#idNum").removeClass("how-step-"+i);
			$("#nav_dot").removeClass("dot-"+i);
		}
		$("#idNum").addClass("how-step-"+(on_num1));
		$("#nav_dot").addClass("dot-"+(on_num1));
	});
});
