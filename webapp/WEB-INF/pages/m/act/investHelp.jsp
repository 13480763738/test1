<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "投资步骤";
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
				<div class="sbtz_smtit">产品介绍</div>
				<div class="sbtz_smtxt">
					 <p>麒麟通宝P2P理财平台提供信用认证标、机构担保标、实地认证标等多类产品，用户根据审核后的信息，自选合适的借款标的，构建符合个人意愿的投资组合。</p>
		             <p>• 标的年利率区间10%-24%</p>
		             <p>• 投资标的适用本息保障计划</p>
		             <p>• 期限灵活，1-24个月</p>
		             <p>• 债权持有90天以上，可进行转让</p>
				</div>
				<div class="sbtz_smtit">如何投资</div>
				<div class="sbtz_step">
					<div>
						<p>第一步：注册</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>第二步：充值</p>
					</div>
					<div>
						<span></span>
					</div>
					<div>
						<p>第三步：投资</p>
					</div>
				</div>
			</div>
		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>