<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.AlsoMoney"%>
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
		WAP_TITLE_NAME = "投标记录";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
	TenderRecord[] tenderRecords = creditManagePayment.getRecord(IntegerParser.parse(request.getParameter("id")));
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="tbjl_box">
				<ul>
					<li class="tit">
						<div class="tit01">投标人</div>
						<div class="tit02">投标金额（元）</div>
						<div class="tit03">投标时间</div>
					</li>
					<%if (tenderRecords != null) {int i=1;for (TenderRecord tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}%>
					<li>
						<div class="tit01"><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></div>
						<div class="tit02">
							<span><%=tenderRecord.tenderMoney %></span>
						</div>
						<div class="tit03"><%=DateTimeParser.format(tenderRecord.tenderTime,"yyyy-MM-dd HH:mm") %></div>
					</li>
				 	<%}}else{%>
				 	<li>
						暂无记录
					</li>
					<%} %>
				</ul>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>