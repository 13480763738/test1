<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanCount"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
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
	FinancingPlanCount fpCount=service.getStatistics();
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<%if(fpCount != null ){ %>
			<div class="lctyhd_tit">
				<p class="left">
				<%if(fpCount.totleMoney.doubleValue()>=100000000){%>
	        	   <em><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/100000000)%></em>亿元<br />
	        	<%}else if(fpCount.totleMoney.doubleValue()>=10000 && fpCount.totleMoney.doubleValue() <100000000){%>
	        		<em><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/10000)%></em>万元<br />
	        	<%}else{%>
	        		<em><%=Formater.formatAmount(fpCount.totleMoney)%></em>元<br />
	        	<%}%>
	        	<span>累计总金额</span>
				</p>
				<p>
					<em><%=fpCount.joinCount%></em>次<br />
					<span>加入总人次</span>
				</p>
				<p class="right">
				<%if(fpCount.userEarnMoney.doubleValue()>=100000000){%>
		        	   <em class="orange"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/100000000)%></em>亿元<br />
	        	<%}else if(fpCount.userEarnMoney.doubleValue()>=10000 && fpCount.userEarnMoney.doubleValue() <100000000){%>
	        		<em class="orange"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/10000)%></em>万元<br />
	        	<%}else{%>
	        		<em class="orange"><%=Formater.formatAmount(fpCount.userEarnMoney)%></em>元<br />
	        	<%}%>
					<span>为用户累计赚取</span>
				</p>
			</div>
			<%} %>
			<div class="sbtz_sm">
				<div class="sbtz_smtit">活动介绍</div>
				<div class="sbtz_smtxt">
					<p>理财体验活动是麒麟通宝为广大理财用户免费推出的理财体验产品。用户只需领取理财体验金，在有效期内便可免费加入理财体验专区所推出的理财体验活动。平台将根据用户加入理财活动时的体验金金额与活动利息标准按期返还收益给用户。平台在用户成功加入当期理财体验活动时，将体验金收回，用户在收到利息收益后，可提现至个人指定的银行账户。活动及创意解释权归麒麟通宝官方所有。</p>
				</div>
				<div class="sbtz_smtit">体验流程</div>
				<div class="sbtz_step">
					<div>
						<p>加入活动</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>扣除体验金</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>锁定期结束</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>收益利息</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>退出活动</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>活动结束</p>
					</div>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>