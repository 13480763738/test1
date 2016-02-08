<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
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
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	TenderRecord[] tenderRecords = creditManagePayment.getRecord(IntegerParser.parse(request.getParameter("id")));
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<section class="tzjl">
<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
		<table>
			<tbody>
				<tr>
					<th>投资人</th>
					<th>投资金额</th>
					<th>投资时间</th>
				</tr>
				<%if (tenderRecords != null) {int i=1;for (TenderRecord tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}%>
				<tr class="bottom">
					<td class="usename"><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></td>
					<td class="money"><%=tenderRecord.tenderMoney %></td>
					<td><%=DateTimeParser.format(tenderRecord.tenderTime,"yyyy-MM-dd HH:mm") %></td>
				</tr>
				<%}}else{%>
				<tr class="bottom">
					<td colspan="3">暂无记录</td>
				</tr>
					<%} %>
			</tbody>
		</table>
		<%}else{ %>
		<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="tj">请先登录</a>
		<%} %>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>