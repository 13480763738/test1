<%@include file="/WEB-INF/include/customerservice.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/focus.js"></script>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/help.list1.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	$(".pcjiang").hover(function(){
		$(this).find("div").show();
		},function(){
			$(this).find("div").hide();
			});
    var box = $(".biaodi h2 span.fl");
    var showCon = $(".biaodi_list");
    var e;
    showCon.find("li:first").find("a").addClass("newgif");
    box.find("a").hover(function () {
        e = $(this).index();
        box.find("a").removeClass("selected");
        $(this).addClass("selected");
		showCon.hide();
        showCon.eq(e).show();
		$(".biaodi h2 span.fr a").hide();
		$(".biaodi h2 span.fr a").eq(e).show();
		showCon.find("li:first").find("a").addClass("newgif");
    });
    
    $(function(){
		 var num=$(".djs_qgz").length;
		 for(i=0;i<num;i++){
			 var percent=parseInt($(".djs_qgz_out").eq(i).find("span").text());
			var Wid=$(".djs_qgz_out").eq(i).width();
			var bg=Math.round(Wid-Wid*percent/100);
			var wid=Math.round(Wid-bg-$(".djs_qgz_out").eq(i).find("span").width()/2-1);
			$(".djs_qgz_out").eq(i).css("background-position",-bg+"px bottom");
			$(".djs_qgz_out").eq(i).find("span").css("left",wid+"px");
			 }
   	});
</script>        
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/a.js"></script><!--微信微博js-->
 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->