<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "奖励规则";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
int id = IntegerParser.parse(request.getParameter("id"));
InvestManage investManage = serviceSession.getService(InvestManage.class);
CreditInfo creditInfo = investManage.get(id);
UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
int ljtzcs =  infoManage.ljtzcs();
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="bdxq_box">
	    	<div class="bdxq_tit"><%=creditInfo.jllx.getName() %></div>
	        <div class="jkms_box">
	        	<p>
				<%String _jlms="";
            	if(creditInfo.jllx.equals(RewardType.XSJ)){ _jlms="筹款开始后限定时间内投资的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。";}
            	if(creditInfo.jllx.equals(RewardType.MTC)){ _jlms="筹款开始后限定时间内满标，放款后该标的所有投资用户另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
            	if(creditInfo.jllx.equals(RewardType.TCJ)){ _jlms="筹款开始后第一位投资用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";}
            	if(creditInfo.jllx.equals(RewardType.XYJ)){ _jlms="放款后，随机抽取该标的幸运投资用户，另享"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
            	if(creditInfo.jllx.equals(RewardType.THJ)){ _jlms="该标的累计投资额度最高的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。";}
            	if(creditInfo.jllx.equals(RewardType.XRJ)){ _jlms="首次在平台投资的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";}
            	if(creditInfo.jllx.equals(RewardType.PHJ)){ _jlms="放款后，该标的所有投资用户另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
            	if(creditInfo.jllx.equals(RewardType.JBJ)){ _jlms="若当次投资为您在平台投资的第"+creditInfo.xsxs+"~"+creditInfo.xsfz+"次，放款后另享年化"+Formater.formatRate(creditInfo.jlll, false)+"%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。";}
            	%>
            	<%=_jlms %>
				</p>
				<p style="font-size:1.7rem; padding-top:2rem;">
				<%if (creditInfo.status == CreditStatus.TBZ&&(creditInfo.jllx.equals(RewardType.XSJ)||creditInfo.jllx.equals(RewardType.MTC))) {%>
				限时时间：<%=creditInfo.xsxs %>时<%=creditInfo.xsfz %>分
				<%} %>
				<%if (creditInfo.status == CreditStatus.TBZ&&creditInfo.jllx.equals(RewardType.JBJ)) {%>
				当前累计投资人数：<%=ljtzcs %>次
				<%} %>
				</p>
	        </div>
	    </div>
	  </div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>