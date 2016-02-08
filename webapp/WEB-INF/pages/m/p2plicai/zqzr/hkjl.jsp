<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.AlsoMoney"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentInfoManage"%>
<html>
<head>
<%
		String _TITLE_ = "债权转让 - P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	<%
	CURRENT_SUB_CATEGORY = "ZQXQXQ";
	%>
	<div id="wrap-all">
	<!--头部-->
	<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
	<!--头部结束-->
	 <%
		CreditAssignmentInfoManage creditManagePayment = serviceSession.getService(CreditAssignmentInfoManage.class);
		final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
		AlsoMoney[] alsoMoneys = creditManagePayment.getAlso(IntegerParser.parse(request.getParameter("id")));

		BigDecimal yhMoney=new BigDecimal(0);
		BigDecimal whMoney=new BigDecimal(0);
		if (alsoMoneys != null) {
			for (AlsoMoney alsoMoney : alsoMoneys) {
				if (alsoMoney == null) {continue;}
				if(alsoMoney.status == RepayStatus.YH){
				yhMoney = yhMoney.add(alsoMoney.yhbx);
				}else if(alsoMoney.status == RepayStatus.WH){
					whMoney = whMoney.add(alsoMoney.yhbx);
				}
			}
		}
	%>
	<!--投资列表-->
	<section class="tzjl">
		<table>
			<tbody>
				<tr>
					<th>还款日期</th>
					<th>待还本息</th>
					<th>状态</th>
				</tr>
					<%
						if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {if (alsoMoney == null) {continue;}
					%>
				<tr class="bottom">
					<td><%=DateTimeParser.format(alsoMoney.hyhkrq,"yyyy-MM-dd") %></td>
					<td class="money"><%=Formater.formatAmount(alsoMoney.yhbx)%>元</td>
					<td><%=alsoMoney.status == null?"":alsoMoney.status.getName()  %></td>
				</tr>
				 <%}}%>
			</tbody>
		</table>
	</section>
	<%}else{ %>
		<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="login-btn1">请先登录</a>
		<%} %>
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
  </div>
  <%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>