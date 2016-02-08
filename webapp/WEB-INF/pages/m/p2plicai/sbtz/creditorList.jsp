<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditHoldInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "债权信息";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
	CreditHoldInfo[] creditHoldInfos = creditManagePayment.getHoldInfo(id);
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		 <div data-role="content" class="qcontent">
			<div class="jlmd_box">
				<div class="tbjl_box">
					<%int j=0;if (creditHoldInfos != null && creditHoldInfos.length>0) {%>
					<ul>
						<li class="tit">
							<div class="tit01">债权人</div>
							<div class="tit02">待收本金（元）</div>
							<div class="tit03">持有份数(份)</div>
						</li>
						<%for (CreditHoldInfo creditHoldInfo : creditHoldInfos) {if (creditHoldInfo == null) {continue;}%>
						<li>
							<div class="tit01"><%StringHelper.filterHTML(out, (creditHoldInfo.userName.length()>=6?creditHoldInfo.userName.substring(0,4):creditHoldInfo.userName.substring(0,1))+"***");%></div>
							<div class="tit02">
								<span><%=Formater.formatAmount(creditHoldInfo.touzje) %></span>
							</div>
							<div class="tit03"><%=creditHoldInfo.cyfs%></div>
						</li>
						<%} %>
					</ul>
					<%}else{%>
					暂无债权信息
					<%} %>
				</div>
			</div>
		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>