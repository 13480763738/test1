<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<html lang="en">
<head>
<%
		String _TITLE_ = "散标投资 - P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
<style>
	.xgzl-list li img{
		max-width:640px;
		height:auto;
	}
</style>
</head>

<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	Xgzl[] xgzl = creditManagePayment.getXgzl(id);	
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
<h1 style="font-size:1.6em;padding:40px 0;width:15%;margin:0 auto;">相关资料</h1>
<%if(xgzl.length==0){out.print("无相关资料");} %>
	<ul class="xgzl-list">
	<%if(xgzl != null){ for(Xgzl x:xgzl){ %>
		<li>
			<img src="<%=fileStore.getURL(x.imge)%>"/>
		</li>
	<%}} %>
	</ul>
<%}else{ %>
	<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="login-btn1">请先登录</a>
<%} %>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>