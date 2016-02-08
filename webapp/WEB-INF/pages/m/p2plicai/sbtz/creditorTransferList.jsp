<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditOutRecode"%>
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
		WAP_TITLE_NAME = "转让记录";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage investInfoManage = serviceSession.getService(InvestInfoManage.class);
	CreditOutRecode[] creditOutRecodes = investInfoManage.getOutRecode(id);
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="zrjl_box">
				<div class="tbjl_box">
				<%if (creditOutRecodes != null && creditOutRecodes.length>0){  %>
					<ul>
						<li class="tit">
							<div class="tit01">买入者</div>
							<div class="tit01">卖出者</div>
							<div class="tit02">金额（元）</div>
							<div class="tit03">交易时间</div>
						</li>
						<%for (CreditOutRecode creditOutRecode : creditOutRecodes) {if (creditOutRecode == null) {continue;}%>
						<li>
							<div class="tit01"><%StringHelper.filterHTML(out, (creditOutRecode.creditBuy.length()>=6?creditOutRecode.creditBuy.substring(0,4):creditOutRecode.creditBuy.substring(0,1))+"***");%></div>
							<div class="tit01"><%StringHelper.filterHTML(out, (creditOutRecode.creditSell.length()>=6?creditOutRecode.creditSell.substring(0,4):creditOutRecode.creditSell.substring(0,1))+"***");%></div>
							<div class="tit02">
								<span><%=creditOutRecode.sellMoney %></span>
							</div>
							<div class="tit03">
								<span><%=DateParser.format(creditOutRecode.sellTime) %>
								</span>
							</div>
						</li>
						<%} %>
					</ul>
				<%}else{ %>
					暂无转让记录	
				<%} %>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>