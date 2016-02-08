<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Notice"%>
<%@page import="com.jiudian.p2p.front.service.information.NoticeManage"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = "网站公告 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
<%CURRENT_CATEGORY = "WZGG";CURRENT_SUB_CATEGORY = "WZGG";%>
<%@include file="/WEB-INF/include/gywm/left.jsp"%>

<div class="center_box">
    	<div class="center">
        	<div class="new_list_box_hf">
            	<div class="new_list_tit_hf"><img src="/images/new_images/wzgg_tit.png"></div>
                <div class="new_list_hf">
                	<ul>
                    	<%
						final int currentPage = IntegerParser.parse(request
									.getParameter("paging.current"));
							NoticeManage noticeManage = serviceSession
									.getService(NoticeManage.class);
							PagingResult<Notice> results = noticeManage.search(
									new Paging() {
										public int getCurrentPage() {
											return currentPage;
										}

										public int getSize() {
											return 10;
										}
									});
							Notice[] notices = results.getItems();
							if (notices != null && notices.length > 0) {
								for (Notice notice : notices) {
					%>
		             <li>
		             <a target="_blank" href="<%=controller.getPagingItemURI(request, Wzgg.class,notice.id)%>">
						<%StringHelper.filterHTML(out,notice.title);%>
						<em <%if(notice.type.equals(NoticeType.HD)){ %>class="em01"<%}%>></em>
		            </a><span class="ldt" style="width: 90px;"><%=DateParser.format(notice.createtime) %></span>
		             </li>
					<%}}%>
                    </ul>
                </div>
                <%Wzgg.rendPaging(out, results,controller.getPagingURI(request, Wzgg.class)); %>
            </div>
        </div>
    </div>
    <div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
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
	<script type="text/javascript" src="js/a.js"></script><!--微信微博js-->
	 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->
	
</body>
</html>