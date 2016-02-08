/*图片切换*/
 $(function(){
	$("div[data-scro='controler'] b,div[data-scro='controler2'] a").click(function(){
		var T = $(this);
		if(T.attr("class")=="down") return false;
		J2ROLLING_ANIMATION.st({
			findObject : T,	//当前点击对象 默认写
			main : T.parent().parent().find("div[data-scro='list']"),	//滚动目标容器窗口对象
			pagSource : T.parent().parent().find("div[data-scro='controler'] b"),	//切换按钮对象
			className : "down",		//选中的样式
			duration : "slow",		//滚动速度 和jquery速度一致
			on : $(this)[0].tagName=="A" ? true : false		//用于判断是否开启无限滚动 or 来回切换
		});
		return false;
	});
	var J2SETTIME="", J2Time=true,J2ROLLING_ANIMATION = {
		init : function(){
			this.start();
			this.time();	
		},
		st : function(o){
			if(J2Time){
				this.animate(o.findObject,o.main,o.className,o.duration,o.pagSource,o.on);
				J2Time = false;
			}
		},
		animate : function(T,M,C,S,P,O){
				var _prevDown = O ? P.parent().find("*[class='"+C+"']") : T.parent().find(T[0].tagName+"[class='"+C+"']"),
					_prevIndex = _prevDown.index(),
					_thisIndex = O ? (T.attr("class")=="next" ? _prevIndex+1 : _prevIndex-1) : T.index(),
					_list = M.find(".item"),
					p2n = 1;
				_prevDown.removeClass(C);
				if(O){
					if(_thisIndex==-1) _thisIndex=_list.size()-1;
					if(_thisIndex==_list.size()) _thisIndex=0;
					P.eq(_thisIndex).addClass(C);
				}else{
					T.addClass(C);
				}
				if(T.attr("class")=="prev" || _thisIndex<_prevIndex) p2n = false;
				if((T.attr("class")=="next" || _thisIndex>_prevIndex)&&T.attr("class")!="prev") p2n = true;
				
				!p2n ? _list.eq(_thisIndex).css("left",-M.width()) : '';
				_list.eq(_prevIndex).animate({left:p2n ? -M.width() : M.width()},S,function(){
					$(this).removeAttr("style");	
					J2Time = true;
				});
				_list.eq(_thisIndex).animate({left:"0px"},S);
		},
		start : function(){
			/*$("#section-focus-pic div[data-scro='controler'] b,#section-focus-pic div[data-scro='controler2'] a").mouseover(function(){*/
			$("#section-focus-pic").mouseover(function(){
				window.clearInterval(J2SETTIME);																	   
			}).mouseout(function(){
				J2ROLLING_ANIMATION.time();
			});
		},
		time : function(){
			J2SETTIME = window.setInterval(function(){
				var num = $("#section-focus-pic div[data-scro='controler'] b[class='down']").index(),
					_list = $("#section-focus-pic div[data-scro='list'] li");
				_list.eq(num).animate({"left":-$("#section-focus-pic div[data-scro='list']").width()},"slow",function(){
					$(this).removeAttr("style");	
					$("#section-focus-pic div[data-scro='controler'] b").removeClass("down").eq(num).addClass("down");
				});	
				num++;
				if(num==_list.size()){
					num=0;
				}
				_list.eq(num).animate({"left":"0px"},"slow");		
			},5000);
		}
	};
	$("a").click(function(){
		$(this).blur();				  
	});
	
	J2ROLLING_ANIMATION.init();	//是否开启自动轮播
(this.jQuery || this.baidu);
$(".pages ul li").first().css("left","0");
	$(".controler b").first().addClass("down");
});

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
	/*奖品明细*/
	$(".img dl").hover(function(){
		$(this).stop().animate({bottom:15},300);
		},function(){
			$(this).stop().animate({bottom:0},300);
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
	var accountid = $("#accountid").val();
	var jb = $("#jb").val();


//砸蛋
	function eggClick(obj){
		var _this = obj;
		var type=_this.index();
		
		if(type==1 && jb>=5000){
			jb=jb-5000;
		}else if(type==1 && jb<5000){
			$(".popup_bg").show();
			$(".tips_box").show();
			return;
		}else if(type==2 && jb>=50000){
			jb=jb-50000;
		}else if(type==2 && jb<50000){
			$(".popup_bg").show();
			$(".tips_box").show();
			return;
		}else if(type==3 && jb>=200000){
			jb=jb-200000;
		}else if(type==3 && jb<200000){
			$(".popup_bg").show();
			$(".tips_box").show();
			return;
		}
		$.ajax({
			type:"post",
			async : false,
			dataType:"html",
			url:"http://www.jiudian.com/act/ydcj.htm?type="+type,
			success:function(data){
				if(data){
					var ct = eval('('+data+')');
					if(ct.length>0 && ct[0].num == 1){
						var je = ct[0].msg;
						if(je==0){
							$(".popup_bg").show();
							$(".tips_box").show();
						}else{
							$(".egg").each(function(){
								$(this).unbind('click');
							});
							hammer();
							$(".money").text(je);
							$(".tick span").text(je);
							$(".gongxi span").text(je);	
							$(".tit01.ddl p span").text(jb);
						}
					}
					if(ct.length>0 && ct[0].num == 0){
						$(".popup_bg").show();
						$(".login_tips").show();
					}
					
				}
			}
		});
			
			function hammer(){
				$(".hammer").css({"top":_this.position().top,"left":_this.position().left+86});
				$(".hammer").animate({"top":_this.position().top-80,"left":_this.position().left+86},200).animate({"top":_this.position().top-65,"left":_this.position().left+86},200,function(){
						_this.addClass("curr"); 
						_this.find("div.egg_top").show(); 
						$(".hammer").hide();
						$(".egg_top").animate({top:-36},1000,function(){
							imgshow();
							});
					});
			}
			
		
		}
	
	
	


	

//关闭层
	$(".tips_center .queding").click(function(){
		$(".popup_bg").hide();
		$(".login_tips").hide();
		$(".tips_box").hide();
	});

//锤子移动
$(".egg").hover(function() {
	var posL = $(this).position().left + $(this).width()-81;
	$(".hammer").show().css('left', posL);
});
//砸了重置
function resetegg(){
	$(".egg").each(function(){
		$(this).removeClass("curr").html("<div class='egg_top'><p class='cash'>现金</p><p><span class='money'></span>元</p></div><div class='egg_center'>点击砸蛋</div>");
		$(this).bind('click',function(){
			eggClick($(this));
			});
		});
	$(".money").text("");
	$(".tick span").text("");
	$(".gongxi span").text("");
	fucntioninit();
	}


	var t;
	imgfly=function(){
			var H=$(window).height();
			var h=$(".cash_box").height();
			var hei=(H-h)/2+90;
			$(".tick").after($(".tick:first").clone(true));
			$(".tick").first().animate({width:125+"px",left:580+"px",top:-hei+"px",opacity:0.3},800,'easeInQuad',function(){
				$(this).animate({opacity:0},300,function(){
					$(this).remove();
					});
				});
			setTimeout(imghide,1100);
			};
	imghide=function(){
		$(".popup_bg").hide();
		$(".cash_box").hide();
		resetegg();
	};
	clear=function(){
		imgfly();
	};
	imgshow=function(){
		$(".popup_bg").show();
		$(".cash_box").show();
		$(".lingqu").attr("num",1);
	};
	miss=function(){
		clearTimeout(t);
	};
	$(".lingqu").click(function(){
			var i=$(".lingqu").attr("num");
			if(i==1){
				miss();
				clear();
			}
			$(".lingqu").attr("num",i+1);
			
	});
	
	fucntioninit();
	
	function fucntioninit(){
		if(accountid>0){
			$(".egg").click(function() {
				eggClick($(this));
			});
			
		}else{
			$(".egg").click(function(){
				$(".popup_bg").show();
				$(".login_tips").show();
				return;
			});
		}
	}
});


