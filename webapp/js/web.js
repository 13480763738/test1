function change(option){
	var area = (typeof option.area=="undefined")?jQuery(""):option.area;				//鼠标经过停止自动播放的区域
	var box = (typeof option.box=="undefined")?jQuery(""):option.box; 					//包含项目的容器
	var btn = (typeof option.btn=="undefined")?jQuery(""):option.btn;					//包含焦点按钮的容器
	var leftBtn = (typeof option.leftBtn=="undefined")?jQuery(""):option.leftBtn;		//左按钮
	var rightBtn = (typeof option.rightBtn=="undefined")?jQuery(""):option.rightBtn;	//右按钮
	var waitTime = (typeof option.waitTime=="undefined")?8000:option.waitTime;			//切换间隔时间
	var fadeTime = (typeof option.fadeTime=="undefined")?"slow":option.fadeTime;		//淡入淡出时间
	var autoPlay = (typeof option.autoPlay=="undefined")?true:option.autoPlay;			//是否自动播放
	
	var listNum = box.find("li").length;
	box.find("li").hide();
	box.find("li:first").addClass("active").show();
	btn.find("li:first").addClass("selected");
	
	if(listNum <= 1){
		btn.hide();
		autoPlay = false;
	}
	
	//切换
	function changeItem(k){
		btn.find("li").removeClass("selected");
		btn.find("li").eq(k).addClass("selected");
		box.find("li").removeClass("active");
		box.find("li").eq(k).addClass("active");
		box.find("li").hide();
		box.find("li.active").fadeIn(fadeTime);
	}
	
	//点击左按钮
	leftBtn.click(function(){
		var e = box.find("li.active").index();
		if(e == 0){e = listNum;}
		e = e - 1;
		changeItem(e);
	});
	
	//点击右按钮
	rightBtn.click(function(){
		var e = box.find("li.active").index();
		if(e == listNum - 1){e = -1;}
		e = e + 1;
		changeItem(e);
	});
	
	//点击焦点按钮
	btn.find("li").click(function(){
		var e = jQuery(this).index();
		changeItem(e);
	});
	
	//自动播放
	function autoRun(){
		var e = box.find("li.active").index();
		if(e == listNum - 1){e = -1;}
		e = e + 1;
		changeItem(e);
	}
	
	if(autoPlay){    
        var intID = setInterval(autoRun,waitTime);                
        area.hover(function(){
            clearInterval(intID);
        },function(){
            intID = setInterval(autoRun,waitTime);
        });
    }
	
}
/*-------------------------------------------------------------------------------------------------------------------------------*/
$(function(){
	var slideDiv = $("#bannerImg");
	var imgWid = slideDiv.find("img").width();
	setWidth();
	function setWidth(){
		var screenWid = $(window).width();
		var hideWid = (screenWid - imgWid)/2;
		var hideWidSmall =  (980 - imgWid)/2;
		if(screenWid >= imgWid){
			slideDiv.css({"width":imgWid + "px","margin":"0 auto"});
		}else{
			if(screenWid > 980){
				slideDiv.css({"width":screenWid + "px","overflow":"hidden"});
				slideDiv.find("li").css({"width":screenWid + "px","overflow":"hidden"});
				slideDiv.find("img").css("margin-left",hideWid + "px");
			}else{
				slideDiv.css({"width":"980px","overflow":"hidden"});
				slideDiv.find("li").css({"width":"980px","overflow":"hidden"});
				slideDiv.find("img").css("margin-left",hideWidSmall + "px");
			}
		}
	}
	
	$(window).resize(function(){
		setWidth();
	});
	
});

//banner切换
$(function(){
	change({
		area : $("#bannerBox"),		
		box : $("#bannerImg"),		
		btn : $("#bannerBtn"),		
		leftBtn : $("#bannerBox a.leftBtn"),	
		rightBtn : $("#bannerBox a.rightBtn"),	
		waitTime : 8000,				
		fadeTime : 500,			
		autoPlay : true
	});
});



	
//首页新闻滚动
function scrollUp(area, box, leftBtn, rightBtn, showNum, waitTime, animateTime, easing, autoPlay) {
    var config = {
        area: $(area),                	//鼠标移入停止自动播放的层
        box: $(box), 				//包含ul那个div
        leftBtn: $(leftBtn),        	//左按钮
        rightBtn: $(rightBtn),      	//右按钮
        showNum: showNum, 			//容器显示的图片个数
        waitTime: waitTime,   			//间隔时间
        animateTime: animateTime,      	//滚动效果时间
        easing: easing, 			//滚动效果
        autoPlay: autoPlay, 		//是否自动播放	
        leftAllow: true,    			//为了防止连续点击左按钮
        rightAllow: true    			//为了防止连续点击右按钮		
    }
    if (config.box.find("li").length < config.showNum) {
        config.leftAllow = false; config.rightAllow = false;
    } else {
        var listLen = config.box.find("li").length;
        config.box.find("li").clone().appendTo(config.box.find("ul"));
        config.box.find("li").clone().prependTo(config.box.find("ul"));
        for (i = 0; i < listLen; i++) {
            config.box.find("li").last().remove();
        }
        config.box.find("ul").css("margin-top", -config.box.find("li").outerHeight(true) * listLen + "px");
    }

    config.rightBtn.click(function () { autoScroll(); });
    function autoScroll() {
        if (config.rightAllow) {
            var marTop = parseInt(config.box.find("ul").css("margin-top"), 10);
            var imgWid = config.box.find("li").outerHeight(true);
            config.rightAllow = false;
            config.box.find("ul").animate({ marginTop: marTop - imgWid + "px" }, config.animateTime, easing, function () {
                marTop = parseInt(config.box.find("ul").css("margin-top"), 10);
                var len = config.box.find("li").length;
                var mar = (config.showNum - listLen) * imgWid + "px";
                if (marTop == (config.showNum - len) * imgWid) { config.box.find("ul").css("margin-top", mar); }
                config.rightAllow = true;
            });
        }
    }

    config.leftBtn.click(function () {
        if (config.leftAllow) {
            var marTop = parseInt(config.box.find("ul").css("margin-top"), 10);
            var imgWid = config.box.find("li").outerHeight(true);
            config.leftAllow = false;
            if (marTop == 0) { config.box.find("ul").css("margin-top", -listLen * imgWid + "px"); }
            marTop = parseInt(config.box.find("ul").css("margin-top"), 10);
            config.box.find("ul").animate({ marginTop: marTop + imgWid + "px" }, config.animateTime, easing, function () {
                marTop = parseInt(config.box.find("ul").css("margin-top"), 10);
                var len = config.box.find("li").length;
                var mar = -listLen * imgWid + "px";
                if (marTop == 0) { config.box.find("ul").css("margin-top", mar); }
                config.leftAllow = true;
            });
        }
    });

    //自动播放
    if (config.autoPlay) {
        var intID = setInterval(autoScroll, config.waitTime);
        config.area.hover(function () {
            clearInterval(intID);
        }, function () {
            intID = setInterval(autoScroll, config.waitTime);
        });
    }

}
$(function () {
    scrollUp(
		"#topNews", 						
		"#topNews div.topnew_list", 
		"#topNews a.leftBtn", 	
		"#topNews a.rightBtn", 		
		1, 							
		5000, 						
		"normal", 	
		"", 			
		true	
	);
});

/*头部导航*/
$(function(){
		var time;
		miss=function(){
			$(".header_menu ul div").hide();
			}
		display=function(){
			time=setTimeout(miss,500);
			}
	$(".header_menu > ul > li").hover(function(){
		$(".header_menu ul div").hide();
		clearTimeout(time);
		$(this).find("a").addClass("hover");
		$(this).find("div").find("a").removeClass("hover");
		$(this).find("div").show();
		},function(){
			display();
			$(this).find("a").removeClass("hover");
			});
			
	/*登陆下拉*/	
	$(".header_loginafter").hover(function(){
		$(this).find("ul").slideDown(300);
		},function(){
			$(this).find("ul").slideUp(100);
			});
	/*底部*/
	$("#weixin").hover(function(){
		$("#erweima_rights").show();
		},function(){
			$("#erweima_rights").hide();
			});
	iframeonload = function(){
		$(".service_kf iframe").hover(function(){
		$(this).parent().css("color","#0fa5f5");
		},function(){
			$(this).parent().removeAttr("style");
			});
		}
	window.setTimeout(iframeonload,1000);
	});




/*客服在线*/
$(function(){
	function moveTips(){
		var tip=document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;
		grantt=100;
		var h=document.documentElement.clientHeight-$("#service_online").height();
		if(tip>200){
			$("#service_online").css({"position":"fixed","top":h/2+"px"});
			$("#service_online a.returntop").show();
			$("#service_onlines a.returntop").show();
			}
			if(tip<200){
			$("#service_online").removeAttr("style");
			$("#service_online a.returntop").hide();
			$("#service_onlines a.returntop").hide();
			}
			//滚到底部
			/*var a = document.documentElement.scrollTop==0? document.body.clientHeight: document.documentElement.clientHeight;
			var b = document.documentElement.scrollTop==0? document.body.scrollTop:document.documentElement.scrollTop;
			var c = document.documentElement.scrollTop==0? document.body.scrollHeight : document.documentElement.scrollHeight;
			if(a+b==c&&b!=0){
			$("#service_online a.return").addClass("top");
			}else{
				$("#service_online a.return").removeClass("top");
				}*/
	setTimeout(moveTips, grantt);
		}
	moveTips();
	//返回顶部
	$("#service_online a.returntop").click(function(){
		$("html").animate({scrollTop:0},500);
		$("body").animate({scrollTop:0},500);
		});
	$("#service_onlines a.returntop").click(function(){
		$("html").animate({scrollTop:0},500);
		$("body").animate({scrollTop:0},500);
		});
	//显示客服
	$(".service_block").hover(function(){
		$(this).find("div").show()
		},function(){
			$(this).find("div").hide();
			});
	
	})

/*二级圆形导航-add 2014-08-12*/
$(function(){
		var len=$(".top_menu_hf p a").length;
		for(i=0;i<len;i++){
			var selectedimg=$(".top_menu_hf p a").eq(i).find("img").attr("selectedimg");
			var cla=$(".top_menu_hf p a").eq(i).attr("class");
			if(cla=="selected"){
				$(".top_menu_hf p a").eq(i).find("img").attr("src",selectedimg);
				}
			$(".top_menu_hf p a").eq(i).hover(function(){
				var srcimg=$(this).find("img").attr("srcimg");
				var selectedimg=$(this).find("img").attr("selectedimg");
				$(this).find("img").attr("src",selectedimg);
				},function(){
					var hover=$(this).attr("class");
					if(hover!="selected"){
						var srcimg=$(this).find("img").attr("srcimg");
						var selectedimg=$(this).find("img").attr("selectedimg");
						$(this).find("img").attr("src",srcimg);
						}
					});
			}
	});


//综合
$(function(){
	$(".footer_link_left a").first().css("padding-left","0");
	$(".footer_link_left a").last().css("background","none");
	$(".invest tr").last().find("td").css("border","none");
	$(".hmd_content tr").last().find("td").css("border","none");
	$(".zqzrlb_list_hf tr").last().find("td").css("border","none");
});


/*热门标签，最新和推荐切换*/
$(function () {
    var box = $(".tjzx h2");
    var showCon = $(".tjzx_list");
    var e;
    box.find("a").hover(function () {
        e = $(this).index();
        box.find("a").removeClass("selected");
        $(this).addClass("selected");
		showCon.hide();
        showCon.eq(e).show();
    });
});



/*重置select值，Ps:现在平台上的没有*/
/*$(function(){
	var len=$("select").length;
	for(i=0;i<len;i++){
		var val=$("select").eq(i).find("option:selected").text();
		$(".select_div").eq(i).html(val);
		}
	})*/




