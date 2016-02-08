<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "本息保障";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>

		<div data-role="content" class="qcontent">
			<div class="sbtz_sm">
				<div class="sbtz_smtit">100%本息保障计划</div>
				<div class="sbtz_smtxt">
					<p>所有理财用户的每笔出借资金均在麒麟通宝的本息保障计划覆盖之内， 一旦出现逾期坏账，麒麟通宝通过风险备用金优先垫付，保证理财人
						的资金安全。</p>
				</div>
				<div class="sbtz_smtit">风险备用金帐户</div>
				<div class="sbtz_smtxt">
					<p>"风险备用金账户"是指麒麟通宝为所服务的所有理财人的共同利益考虑，以麒麟通宝名义单独开设并由第三方支
						付平台进行资金托管的一个专款专用账户，服务于麒麟通宝平台的本息保障计划。</p>
				</div>
			</div>
		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>