<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "网站地图 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/index.css" />
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
	   <div class="sitemap_box">
	   		<h1>网站地图</h1>
	        <div class="sitemap">
	            <dl>
	            	<dt><a href="http://www.jiudian.com/p2plicai/">我要理财</a></dt>
	                <dd><a href="http://www.jiudian.com/p2plicai/yxlc/">理财体验专区</a></dd>
	                <dd><a href="http://www.jiudian.com/p2plicai/sbtz/">散标投资列表</a></dd>
	                <dd><a href="http://www.jiudian.com/p2plicai/zqzr/">债权转让列表</a></dd>
	            </dl>
	            <dl>
	            	<dt><a href="http://www.jiudian.com/p2pdaikuan/">我要借款</a></dt>
	            </dl>
	            <dl>
	            	<dt><a href="http://www.jiudian.com/xszy/">投资攻略</a></dt>
	                <dd><a href="http://www.jiudian.com/xszy/">新手指引</a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/mcjs.html ">名词解释 </a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/ptjs.html">平台介绍</a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/lxhfy.html">利息和费用</a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/wyjk.html">我要借款 </a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/wylc.html">我要理财</a></dd>
	                <dd><a href="http://www.jiudian.com/xszy/ptzh.html">平台账户</a></dd>
	            </dl>
	            <dl>
	            	<dt><a href="http://www.jiudian.com/gywm/gsjj.html">关于我们</a></dt>
	                <dd><a href="http://www.jiudian.com/gywm/gsjj.html">公司简介</a></dd>
	                <dd><a href="http://www.jiudian.com/gywm/gltd.html">管理团队 </a></dd>
	                <dd><a href="http://www.jiudian.com/gywm/hzjg.html">合作机构</a></dd>
	                <dd><a href="http://www.jiudian.com/gywm/zxns.html">招贤纳士</a></dd>
	                <dd><a href="http://www.jiudian.com/gywm/lxwm.html">联系我们 </a></dd>
	                <dd><a href="http://www.jiudian.com/aqbz/index.html">安全保障</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/shzr.html">社会责任</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/mtbd.html">最新动态</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/hlwjryj.html">互联网金融研究</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/wdhyzx.html">网贷行业资讯</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/yjbg.html">业绩报告</a></dd>
	                <dd><a href="http://www.jiudian.com/zxdt/wzgg.html">网站公告</a></dd>
	            </dl>
	            <dl>
	            	<dt><a href="javascript:void(0)">快捷操作</a></dt>
	                <dd><a href="http://www.jiudian.com/register.html">注册</a></dd>
	                <dd><a href="http://www.jiudian.com/user/login.html">登录</a></dd>
	                <dd><a href="http://www.jiudian.com/password/">找回密码</a></dd>
	            </dl>
	        </div>
	   </div>
	</div>
	<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	
	<script>
	$(function(){
		var len=$(".sitemap dl").length;
	    for (var i = 1; i < len; i++) {
	        $(".sitemap dl").eq(i * 4 - 1).after("<div class='sitemap_bg'></div>");
	    }
		});
	</script>
	
</body>
</html>
