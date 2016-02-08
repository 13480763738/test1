<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.PromptlyJoin"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.Bdxq"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.Signlist"%>
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Rewards"%>
<%@page import="com.jiudian.p2p.front.service.financing.query.InvestQuery"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<html lang="en">
<head>
<%
	String ptStr = request.getParameter("pt");
	ProductType pt = ProductType.KXT;
	if(!StringHelper.isEmpty(ptStr)){
		pt = EnumParser.parse(ProductType.class, request.getParameter("pt"));
	}
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = pt.getName();
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
		InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
		final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
		int size = cnvestmentManage.searchcount();
		int line = IntegerParser.parse(request.getParameter("line"));
		
		CreditInfo[] result = cnvestmentManage.search(line);
%>

<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>

		<div data-role="content" class="qcontent">

			<%
					if (result != null && result.length>0) {
						int i = 1;
						for (CreditInfo creditInfo : result) {
							if (creditInfo == null) {
								continue;
							}
			%>

			<div class="lcty_box">
				<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>" rel="external">
					<div class="lcty_tit">
						<%
							if (creditInfo.creditType == CreditType.XYDB) {
						%>
						<%
							if (creditInfo.companyStatus != null
													&& creditInfo.companyStatus
															.equals(CompanyStatus.SYQYZ)) {
						%>
						<span class="ico_small">企</span>
						<%
							}
						%>
						<span class="ico_small">保</span>
						<%
							} else if (creditInfo.creditType == CreditType.XJD
												|| creditInfo.creditType == CreditType.SYD) {
						%>
						<span class="ico_small">信</span>
						<%
							} else if (creditInfo.creditType == CreditType.SDRZ) {
						%>
						<%
							if (creditInfo.companyStatus != null
													&& creditInfo.companyStatus
															.equals(CompanyStatus.SYQYZ)) {
						%>
						<span class="ico_small">企</span>
						<%
							}
						%> <span class="ico_small">实</span>
						<%
							}
						%>
						<em>
						<%
							StringHelper.filterHTML(out,creditInfo.title);
						%>
						</em>
						<%
							Rewards r = cnvestmentManage.getRewards(creditInfo.id);
							int t = 0;
							if (r == null) {
						%>
						<span class="ico_jiang">无奖励</span>
						<%
							}else{
						%>
						<span class="ico_jiang"><%StringHelper.filterHTML(out, r.jllx.getName());%></span>
						<%
							}
						%>
					</div>
					<div class="lcty_txt">
						<div class="lcty_bfb">
							<div class="lcty_bfbin" style="width: <%=creditInfo.progress%>%;"></div>
						</div>
						<p class="lcty00"><%=creditInfo.progress%>%</p>
					</div>
					<div class="lcty_text">
						<p class="lcty01">
						<%if(creditInfo.amount.doubleValue()>=10000){%>
			            	<span><em><%=creditInfo.amount.doubleValue()/10000%></em>万元</span>
			            <%}else{%>
			            <span><em><%=Formater.formatAmount(creditInfo.amount)%></em>元</span>
			            <%}%>
			            <br />标的总额
						</p>
						<p class="lcty02">
							<span><em><%=Formater.formatRate(creditInfo.rate,false)%></em>%</span>
							<%if (r != null) { %>
							<span class="red"><em>+</em><%=Formater.formatRate(r.jlbl, false)%>%</span>
							<%} %>
							<br />年利率
						</p>
						<p class="lcty03">
							<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
							<span><em><%=creditInfo.term%></em>个月</span><br />
				       	    <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%>
				       	    <span><em><%=creditInfo.term%></em>天</span><br />
				       		<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
				       		<span><em></em>秒标</span><br />
				       		<%}%>还款期限
						</p>
					</div>
				</a>
				
				<%
				if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
				%>
				<span class="lcty_ljsq">敬请期待</span>
				<%}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){ 
				%>
				<a href="<%=controller.getViewURI(request, PromptlyJoin.class)%>?id=<%=creditInfo.id%>" rel="external" class="lcty_ljsq blue" style="">立即投标</a>
				<%}else if(creditInfo.status==CreditStatus.YMB){ %>
				<span class="lcty_ljsq">已满标</span>
				<%}else if(creditInfo.status==CreditStatus.YFK){ %>
				<span class="lcty_ljsq">还款中</span>
				<%}%>
			</div>
			<%
				}
					}
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
					line=result.length+3;
				}
				%>
				<a href="<%=controller.getViewURI(request, Signlist.class)%>?line=<%=line %>&pt=<%StringHelper.filterHTML(out, pt.name()); %>" rel="external">查看更多</a>
				<%}%>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>