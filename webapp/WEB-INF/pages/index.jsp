<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="http://<%configureProvider.format(out,SystemVariable.SITE_DOMAIN);%>/favicon.ico"> 
<%
String _TITLE_ = "麒麟通宝---中国领先的供应链投融资服务专家。";
String _KEYWORDS_ = "麒麟通宝，旗丰集团，P2P网络借贷，互联网金融，供应链金融，供应链投融资平台，p2p网贷,网贷,网贷平台,p2p网贷平台,投资理财,P2P平台,麒麟通宝P2P网络借贷平台，kylintb.com";
String _DESCRIPTION_ = "麒麟通宝是旗丰集团倾力打造的P2P网贷平台，提供优质项目融资及P2P无忧理财服务，低风险、高收益、100元起投，是国内领先的供应链投融资服务专家。咨询热线：4008098122";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%> 
<meta http-equiv="Cache-Control" content="no-transform " />
<meta name="baidu-site-verification" content="NKKzOEFKOD" />
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" itemprop="description" content="<%=_DESCRIPTION_ %>">
<meta itemprop="name" content="<%=_TITLE_ %>">
<meta itemprop="image" content="<%configureProvider.format(out, SystemVariable.WEB_LOGO);%>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
</head>
<body>
<%!public static void addCookie(HttpServletResponse response,String name,String value,int maxAge){
	    Cookie cookie = new Cookie(name,value);
	    cookie.setPath("/");
	    if(maxAge>0)  cookie.setMaxAge(maxAge);
	    response.addCookie(cookie);
	}%>
	
	<%!public static String getCookieByName(HttpServletRequest request,String name){
	    Map<String,Cookie> cookieMap = ReadCookieMap(request);
	    if(cookieMap.containsKey(name)){
	        Cookie cookie = (Cookie)cookieMap.get(name);
	        return cookie.getValue();
	    }else{
	        return null;
	    }   
	}%>
	
	<%!private static Map<String,Cookie> ReadCookieMap(HttpServletRequest request){  
	    Map<String,Cookie> cookieMap = new HashMap<String,Cookie>();
	    Cookie[] cookies = request.getCookies();
	    if(null!=cookies){
	        for(Cookie cookie : cookies){
	            cookieMap.put(cookie.getName(), cookie);
	        }
	    }
	    return cookieMap;
	}%>
	
	<%
		String from = request.getParameter("from");	
		if(!StringHelper.isEmpty(from)){
			addCookie(response, "from", from, 30*24*3600);
		}
	%>
	<div style="display:none">
<script type="text/javascript">
var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cspan id='cnzz_stat_icon_1256881268'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D1256881268' type='text/javascript'%3E%3C/script%3E"));
</script>
</div>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%@include file="/WEB-INF/include/index/banners.jsp"%>
	<%@include file="/WEB-INF/include/index/toolbar.jsp"%>
	<%@include file="/WEB-INF/include/index/tztj.jsp"%>
	<%@include file="/WEB-INF/include/index/tzlb.jsp"%>
	<%@include file="/WEB-INF/include/index/xszy.jsp"%>
	<%@include file="/WEB-INF/include/index/news.jsp"%>
	<%@include file="/WEB-INF/include/index/hzjg.jsp"%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/qltbScipt.jsp"%>

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
    
	$("#tabTzlc").click(function(){
		window.location.href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.wytz.Index.class)%>";
	});
	$("#tabZqzr").click(function(){
		window.location.href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class)%>";
	});
	
</script>
</body>
</html>