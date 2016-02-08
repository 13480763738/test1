<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Zqsg"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Zqxq"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Hkjl"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Tbjl"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignment"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xyhk"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bfkgl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bxgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserRZInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentInfoManage"%>
<html>
<head>
<%
String _TITLE_ = "债权转让 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
String cityid="";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>

</head>
<body>
	<%
	CURRENT_SUB_CATEGORY = "ZQXQXQ";
	%>
	<div id="wrap-all">
	<!--头部-->
	<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<section class="tb-listpage">
		<%
			CreditAssignmentManage service = serviceSession.getService(CreditAssignmentManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			CreditAssignment caInfo= service.get(id);
			if(caInfo==null){
				response.sendError(HttpServletResponse.SC_NOT_FOUND );
				return;
			}
			
			int jkbId=caInfo.jkbId;
			BigDecimal tbMoney=new BigDecimal(0);
			int syfs=caInfo.syfs;
			int fs=0;
			BigDecimal zxMoney = new BigDecimal(0);
		%>
		
		
		<header class="listpage-header">
			<h1><%StringHelper.filterHTML(out, caInfo.title);%></h1>
			<p><span class="tit">转让价格</span><span class="red"><%=Formater.formatAmount(caInfo.zrjg)%>（元/份）</span></p>
			<p><span class="tit">债权价值</span><span><%=Formater.formatAmount(caInfo.zqjz)%>/份</span></p>
			<p><span class="tit">剩余份数</span><span><%=caInfo.syfs %>份</span></p>
			<p><span class="tit">年化收益率</span><span><%=Formater.formatRate(caInfo.rate,false)%>%</span></p>
			<p><span class="tit">还款期限</span><span><%=caInfo.jkqx%>个月</span></p>			
		</header>
			
			<%if(jiudianSession == null || !jiudianSession.isAuthenticated()){%>
					<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="pl-login">请先登录</a>
					<%}else{ 
					IsPass sf = service.sfktJzh();
					if(IsPass.S==sf){
					%>
					<a href="<%=controller.getPagingItemURI(request, Zqsg.class,id)%>" class="pl-login" style="background:#1d4d9f;color:#fff">马上投标</a>
					<%}else{ %>
					<a href="<%configureProvider.format(out,URLVariable.WAP_KTDSF);%>" class="pl-login">请开通托管账户</a>
			<%}} %>
			
			
		<footer class="listpage-footer">
			<ul>
				<li class="one">
					<a href="<%=controller.getViewURI(request, Zqxq.class)%>?id=<%=caInfo.jkbId%>">查看借款详情</a>
				</li>
				<li class="two">
					<a href="<%=controller.getPagingItemURI(request, Tbjl.class, id)%>">查看投标记录</a>
				</li>
				<li class="three">
					<a href="<%=controller.getPagingItemURI(request, Hkjl.class, id)%>">查看还款详情</a>
				</li>
			</ul>
		</footer>
	</section>
	<!--头部结束-->
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
  </div>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>