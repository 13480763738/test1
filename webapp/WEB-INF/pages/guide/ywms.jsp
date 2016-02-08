<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = "帮助中心"+" - 业务模式 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	<div class="clear"></div>
<%
	CURRENT_SUB_CATEGORY = "YWMS";
%>
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
	
		<div class="help">
			<h1>业务模式</h1>
			<ul>
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/ywms.jpg"/>
				</li>
			
			</ul>
		</div>
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	 <style>
	 .i-t-wx { background-position: -29px 0px;}
	 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
	 </style>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/help.list1.js"></script><!--帮助页js-->
	
</body>
</html>