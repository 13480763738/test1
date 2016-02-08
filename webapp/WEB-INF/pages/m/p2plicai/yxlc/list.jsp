<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.Yxxq"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.Iapply"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.List"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlan"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "理财体验";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
	int size = service.getcount();
	int line = IntegerParser.parse(request.getParameter("line"));
	FinancingPlan[] lists= service.searchWap(line);
	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			 <%
	            if(lists!=null && lists.length>0){
	            	for (FinancingPlan financingPlan : lists) {
	            		if (financingPlan == null) {continue;}
             %>
			<div class="lcty_box">
				<a href="<%=controller.getPagingItemURI(request, Yxxq.class,financingPlan.id)%>" rel="external">
					<div class="lcty_tit"><%StringHelper.filterHTML(out, financingPlan.planTitle);%></div>
					<div class="lcty_txt">
						<div class="lcty_bfb">
							<div class="lcty_bfbin" style="width: <%=new BigDecimal(financingPlan.proess).intValue()%>%;"></div>
						</div>
						<p class="lcty00"><%=new BigDecimal(financingPlan.proess).intValue()%>%</p>
					</div>
					<div class="lcty_text">
						<p class="lcty01">
						<%if(financingPlan.planMoney_wap.doubleValue()>=100000000){%>
			        	   <span><em><%=Formater.formatAmount(financingPlan.planMoney_wap.doubleValue()/100000000)%></em>亿</span>
			        	<%}else if(financingPlan.planMoney_wap.doubleValue()>=10000 && financingPlan.planMoney_wap.doubleValue() <100000000){%>
			        		<span><em><%=Formater.formatAmount(financingPlan.planMoney_wap.doubleValue()/10000)%></em>万</span>
			        	<%}else{%>
			        		<span><em><%=Formater.formatAmount(financingPlan.planMoney_wap)%></em>元</span>
			        	<%}%>
			        	<br />计划金额
						</p>
						<p class="lcty02">
							<span><em><%=Formater.formatRate(financingPlan.yqsy, false) %></em>%</span>
							<br />预期年利率
						</p>
						<p class="lcty03">
							<span><em><%=financingPlan.lockqx %></em>个月</span>
							<br />锁定期限
						</p>
					</div>
				</a> 
				<%if(financingPlan.planState == PlanState.YFB && financingPlan.fromSale.after(financingPlan.currentTime)){%>
					<span class="lcty_ljsq">敬请期待</span>
				<%}else if(financingPlan.planState == PlanState.YSX){%>
					<span class="lcty_ljsq">已满额</span>
				<%}else if(financingPlan.planState == PlanState.YFB && !financingPlan.fromSale.after(financingPlan.currentTime)){ %>
					<a href="<%=controller.getViewURI(request, Iapply.class)%>" rel="external" class="lcty_ljsq">立即申请</a>
				<%}else if(financingPlan.planState == PlanState.YJZ){%>
					<span class="lcty_ljsq">已截止</span>
				<%} %>
			</div>
 			<%
            	}}
            %>

			<div class="lcty_ckgd">
			<%if(line>0 && (line>=size)){%>
			<%}else{ 
				if(size >0 && line >0){
					if(size > line){
						line+=3;
					}
				}
				if(line == 0){
					line=lists.length+3;
				}
				%>
				<a href="<%=controller.getViewURI(request, List.class)%>?line=<%=line %>" rel="external">查看更多</a>
				<%}%>
			</div>

		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>