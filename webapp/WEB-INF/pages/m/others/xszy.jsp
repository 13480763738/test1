<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
		String _TITLE_ = "新手指引- P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<link href="<%=controller.getStaticPath(request)%>/wap/css/public.css" rel="stylesheet">
<link href="<%=controller.getStaticPath(request)%>/wap/css/tishiye.css" rel="stylesheet">
</head>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
 <section class="xszy">
		<header class="xs-head">
			<h1>新手指引</h1>
			<h2>麒麟通宝的优势是什么？</h2>
			<ul>
				<li>
					<img src="<%=controller.getStaticPath(request) %>/wap/images/new_01.jpg">
					<p style="padding-top:10px">高收益低门槛</p>
					<p>100元起投</p>
					<p>30倍以上银行存款收益</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request) %>/wap/images/new_02.jpg">
					<p>更安全更便利 6道审核</p>
					<p>本息保障计划</p>
					<p>交易资金全托管 全程网络操作</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request) %>/wap/images/new_03.jpg">
					<p style="padding-top:10px">多选择更灵活 产品多元</p>
					<p>满足各种偏好</p>
					<p>债权可转让 资金周转更灵活</p>
				</li>
				<div class="clear"></div>
			</ul>
			<h2>麒麟通宝能为你提供什么？</h2>
			<h3>为借款人提供:</h3>
			<p>1.旗企贷（企业贷）：为各类中小企业、商会协会成员，发达工业园区企业专属定制，
   解决中小企在发展过程中遇到的资金瓶颈问题！</p>
			<p>2.旗意贷（生意贷）：为个体工商户或小企业主量身定制，手续简单，流程简化!</p>
			<p>3.旗速贷（供应链贷）：为供应链上下游客户提供完善的仓单融资、贸易融资、保理
    融资等金融服务。</p>
			<p>4.旗车贷（车辆抵押贷款）：用于帮助车辆所有者解决急需资金的贷款产品。</p>
			<p>5.旗房贷（红本抵押贷）：2015-12-2用红本作抵押的一种贷款产品，额度高、速度快。</p>
			<h3 style="margin-top:40px;">为投资人提供:</h3>
			<p>基于供应链金融、房产、车辆及企业生意往来的债权理财产品。</p>
		</header>
		<footer class="xs-foot">
			<h2>
				<span>如何投资</span>
			</h2>
			<img src="<%=controller.getStaticPath(request) %>/wap/images/rhtz-pic.png" style="display:block;margin: 0 auto;"/>
		</footer>
		<%if(jiudianSession == null || !jiudianSession.isAuthenticated()){ %>
		<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="denglu-btn">请先登陆</a>
		<%}%>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</div>
</body>
</html>