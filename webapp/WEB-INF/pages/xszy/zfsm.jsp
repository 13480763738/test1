<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = "帮助中心"+" - 资费说明 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="clear"></div>
<%
	CURRENT_SUB_CATEGORY = "ZFSM";
%>
<div class="new-contant mt20 pb30" style="border-top:1px solid #ddd">
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
			<div class="new-center white-bg new-zfxq pt50 pb40">
			<h2 class="pb30">资费详情表</h2>
			<table class="zf-table"  cellpadding="0" cellspacing="0">
				<tbody>		
					<tr style="background: #1d4d9f;color:#fff;">
						<th>项目</th>
						<th>说明</th>
						<th>目前费率</th>
					</tr>
					<tr>
						<td>投资收益服务费</td>
						<td>收益（利息收入）*费率</td>
						<td>10%（推广期间免收）</td>
					</tr>
					<tr>
						<td>债权转让手续费</td>
						<td>成交金额*费率</td>
						<td>0.5%</td>
					</tr>
					<tr>
						<td>提前还款违约金</td>
						<td>除当期还款外的其他待还本金（剩余本金）*费率</td>
						<td>1%</td>
					</tr>
					<tr>
						<td>罚息</td>
						<td>逾期本金*费率*逾期天数</td>
						<td>0.5%</td>
					</tr>
					<tr>
						<td>充值费用</td>
						<td>免费</td>
						<td>0</td>
					</tr>
					<tr>
						<td>提现费用</td>
						<td>单笔提现限制100≤2000000充值后20天内未投资的资金提现是加收0.5%手续费</td>
						<td>目前推广期，由平台全部垫付，所有投资人均免提现费</td>
					</tr>
				</tbody>		
			</table>
			<h2 class="pt40 pb30">资费说明</h2>
			<div class="sm pb30">
				<p>平台推广期间，所有用户的充值、提现的手续费用均由麒麟通宝平台承担，所有用户均可享受免手续费的充值和提现服务。</p>
				<p class="last">注：充值未投资的资金在网时间小于20天，按提现总额的5‰收取提现费用，在网时间超过20天则免收提现费用。</p>
			</div>
		</div>
		<div class="pt40"></div>
	</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	 <style>
	 .i-t-wx { background-position: -29px 0px;}
	 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
	 </style>
	<%-- <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/help.list1.js"></script> --%><!--帮助页js-->
	
</body>
</html>