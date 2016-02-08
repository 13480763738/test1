<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
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
	<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
	<section class="tzjl">
		<table>
			<tbody>
				<tr>
					<th>投资人</th>
					<th>投资金额</th>
					<th>投资时间</th>
				</tr>
					<%	
						CreditAssignmentInfoManage creditManageList = serviceSession.getService(CreditAssignmentInfoManage.class);
            			final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
            			TenderRecord[] tenderRecords = creditManageList.getRecord(IntegerParser.parse(request.getParameter("id")));
						BigDecimal b=new BigDecimal(0);
						if (tenderRecords != null) {  
							for (TenderRecord tenderRecord : tenderRecords) {
								if (tenderRecord == null) {continue;}
									b=b.add(tenderRecord.tenderMoney);
								}
						}
						if (tenderRecords != null) {int jj=1;for (TenderRecord tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}
					%>
				<tr class="bottom">
					<td class="usename"><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></td>
					<td class="money"><%=tenderRecord.tenderMoney %>元</td>
					<td><%=DateTimeParser.format(tenderRecord.tenderTime,"yyyy-MM-dd hh:mm") %></td>
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