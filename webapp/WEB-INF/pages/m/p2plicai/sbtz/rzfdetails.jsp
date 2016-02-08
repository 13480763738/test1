<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserRZInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
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
		WAP_TITLE_NAME = "标的详情";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	String cityid="";
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestManage investManage = serviceSession.getService(InvestManage.class);
	InvestInfoManage creditManageDetail = serviceSession.getService(InvestInfoManage.class);
	UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
	
	CreditInfo creditInfo = investManage.get(id);
	CreditFiles creditFile = infoManage.getFile(creditInfo.userId);
	CreditUserInfo userInfo = creditManageDetail.getUser(id,creditInfo.creditType);
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="bdxq_box">
			<%
				if(userInfo!=null){
				UserInfo uiInfo =  infoManage.getAgeSex(userInfo.card);
				%>
				<div class="bdxq_tit">融资方信息</div>
				<div class="jkms_box">
					<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
				</div>
				<div class="lctyxq_box" style="border-bottom: none;">
					<ul>
						<li><div class="lctyxq_tit1">融资企业</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.gsmc); %></div></li>
						<li><div class="lctyxq_tit1">融资代理人</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.userName); %></div></li>
						<li><div class="lctyxq_tit1">企业地址</div>
							<div class="lctyxq_tit2" id="gzcs"><% cityid=userInfo.city; %></div></li>
						<li><div class="lctyxq_tit1">经营年限</div>
							<div class="lctyxq_tit2"><%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></div></li>
						<li><div class="lctyxq_tit1">资金用途</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, creditInfo.purpose); %></div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">本次融资金额</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditInfo.amount)%>元</div></li>
						<li><div class="lctyxq_tit1">项目合同金额</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(userInfo.htje)%>元</div></li>
						<li><div class="lctyxq_tit1">
								实地考察方<br />
								<span style="font-size: 1.2rem;">(担保方)</span>
							</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.dbgs); %></div></li>
					</ul>
				</div>
				  <%} %> 
				<div class="bdxq_tit">信用档案</div>
				<div class="lctyxq_box" style="border-bottom: none;">
					<ul>
						<li><div class="lctyxq_tit1">申请借款</div>
							<div class="lctyxq_tit2"><%=creditFile.sqjkCount%>笔</div></li>
						<li><div class="lctyxq_tit1">成功借款</div>
							<div class="lctyxq_tit2"><%=creditFile.cgCount%>笔</div></li>
						<li><div class="lctyxq_tit1">还清借款</div>
							<div class="lctyxq_tit2"><%=creditFile.hqjkCount%>笔</div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">信用额度</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.xyedMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">借款总额</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.jkzeMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">待还本息</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.dhbxMoney)%>元</div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">逾期金额</div>
							<div class="lctyxq_tit2"><%=creditFile.yqjeMoney == null? 0:Formater.formatAmount(creditFile.yqjeMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">逾期次数</div>
							<div class="lctyxq_tit2"><%=creditFile.yqcsCount%>次</div></li>
						<li><div class="lctyxq_tit1">严重逾期</div>
							<div class="lctyxq_tit2"><%=creditFile.yzyqCount%>笔</div></li>
					</ul>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>       
	<script type="text/javascript">
			$("#gzcs").html('<span style="padding-left:0px;">'+getctName('<%=cityid%>')+'</span>');
	</script>
	
</body>
</html>