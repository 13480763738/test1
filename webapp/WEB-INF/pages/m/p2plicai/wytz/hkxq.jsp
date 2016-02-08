<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.AlsoMoney"%>
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
</head>
<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	AlsoMoney[] alsoMoneys = creditManagePayment.getAlso(id);
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
<section class="tzjl">
		<table>
			<tbody>
				<tr>
					<th style="width:22%">合约还款日期</th>
					<th style="width:12%">状态</th>
					<th style="width:22%">应还本息</th>
					<th style="width:22%">应还罚息</th>
					<th style="width:22%">实际还款日期</th>
				</tr>
			<%
			if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {
				System.out.println("----"+alsoMoney.status);
				if (alsoMoney == null || alsoMoney.status.equals(RepayStatus.WH)) {continue;}
			%>
				<tr class="bottom">
					<td><%=alsoMoney.hyhkrq==null?"--":DateParser.format(alsoMoney.hyhkrq) %></td>
					<td><%=alsoMoney.status.getName() %></td>
					<td class="money"><%=alsoMoney.yhbx %></td>
					<td class="money"><%=alsoMoney.yffx %></td>
					<td><%=alsoMoney.sjhkTime==null?"--":DateParser.format(alsoMoney.sjhkTime) %></td>
				</tr>
				<%}}else{ %>
				<tr class="bottom">
					<th colspan="3">暂无记录</th>
				</tr>
				<%} %>
			</tbody>
		</table>
	</section>
		<%}else{ %>
		<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="login-btn1" >请先登录</a>
		<%} %>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>