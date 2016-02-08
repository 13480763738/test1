<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<head>
<LINK REL="SHORTCUT ICON" HREF="http://<%configureProvider.format(out,SystemVariable.WAP_DOMAIN);%>/favicon.ico"> 
<%
String _TITLE_ = "麒麟通宝P2P网贷平台";
String _KEYWORDS_ = "p2p网贷,网贷,网贷平台,p2p网贷平台,投资理财,互联网金融,100%本息担保, 麒麟通宝";
String _DESCRIPTION_ = "麒麟通宝 - 立足前海金融合作示范区的P2P网贷平台，提供安全高效的网贷、投资理财等互联网金融服务。通过第三方资金托管、机构100%本息担保为您的资金安全及收益提供保障。";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%> 
<meta http-equiv="Cache-Control" content="no-transform " />
<meta name="baidu-site-verification" content="NKKzOEFKOD" />
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" itemprop="description" content="<%=_DESCRIPTION_ %>">
<meta itemprop="name" content="<%=_TITLE_ %>">
<meta itemprop="image" content="http://<%configureProvider.format(out,SystemVariable.WAP_DOMAIN);%>/images/new_images/logo.png">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
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
<div id="wrap-all">
	<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<%@include file="/WEB-INF/include/wap/index/banner.jsp"%>		
	<!--首页导航-->
	<nav class="index-nav">
		<ul>
			<li>
				<a href="<%=controller.getViewURI(request, WytbList.class)%>">
					<img src="<%=controller.getStaticPath(request) %>/wap/images/nav-pic4.png"/>
					<p>我要投资<p>
				</a>
			</li>
			<li>
				<a href="<%=configureProvider.format(URLVariable.WAP_USER_INDEX) %>">
					<img src="<%=controller.getStaticPath(request) %>/wap/images/nav-pic3.png"/>
					<p>我的账户<p>
				</a>
			</li>
			<li>
				<a href="<%=configureProvider.format(URLVariable.WAP_GYWM) %>">
					<img src="<%=controller.getStaticPath(request) %>/wap/images/nav-pic2.png"/>
					<p>关于我们<p>
				</a>
			</li>
			<li>
				<a href="<%=configureProvider.format(URLVariable.WAP_AQBZ) %>">
					<img src="<%=controller.getStaticPath(request) %>/wap/images/nav-pic1.png"/>
					<p>安全保障<p>
				</a>
			</li>
			<div class="clear"></div>
		</ul>
	</nav>
	<%@include file="/WEB-INF/include/index/tblist.jsp" %>
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>

<%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/circleProgress.js"></script>
<script src="<%=controller.getStaticPath(request)%>/wap/js/yxMobileSlider.js"></script>
<script type="text/javascript">
process = 0;
 $(function(){
	$(".tz").each(function(){
		var jd = $(this).attr("data");
		var i = $(this).attr("datai");
		if(parseInt(jd)>=100 && $('#circle-progressz-'+i).val() != $('#CreditStatus-'+i).val()){
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#83a700','#000');
		}else if($('#circle-progressz-'+i).val() == $('#CreditStatus-'+i).val()){
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#979797','#000');	
		}
		else{
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#ea5a59','#000');
		}
	});
}); 
 $(".slider").yxMobileSlider({width:640,height:320,during:3000})

</script>
</body>
</html>