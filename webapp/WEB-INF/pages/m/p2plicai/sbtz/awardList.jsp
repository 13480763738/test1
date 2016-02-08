<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
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
		WAP_TITLE_NAME = "奖励名单";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	InvestManage investManage = serviceSession.getService(InvestManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	TenderRecord[] _jls = investManage.getJllb(id);
	CreditInfo creditInfo = investManage.get(id);
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		 <div data-role="content" class="qcontent">
		<div class="jlmd_box">
			<div class="tbjl_box">
			 <%
	        if(_jls != null && (creditInfo.status == CreditStatus.YFK||creditInfo.status == CreditStatus.YJQ)){
	        %>
				<ul>
					<li class="tit">
						<div class="tit01">用户名</div>
						<div class="tit02">投标金额（元）</div>
						<div class="tit03">获得年化奖励</div>
					</li>
					<%for(TenderRecord tenderRecord:_jls){ %>
					<li>
						<div class="tit01"><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></div>
						<div class="tit02">
							<span><%=Formater.formatAmount(tenderRecord.tenderMoney)%></span>
						</div>
						<div class="tit03"><%=Formater.formatRate(creditInfo.jlll)%></div>
					</li>
					<%} %>
				</ul>
			 <%}else{ %>
			 暂无奖励信息
			 <%} %>
			</div>
		</div>
		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>