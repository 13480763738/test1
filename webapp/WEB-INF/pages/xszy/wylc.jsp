<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = ArticleType.WYLC.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	CURRENT_SUB_CATEGORY = "WYLC";
%>

<div class="new-contant mt20 pb40" style="border-top:1px solid #ddd">
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
<div class="new-lcxz new-center white-bg mb30">
			<div class="new-about-xian"></div>
			<h1 class="pb40">产品介绍</h1>
			<ul class="prov pt20 pb40">
				<li><span>旗企贷</span>（企业贷）：为各类中小企业、商会协会成员，发达工业园区企业专属定制，解决中小企在发展过程中遇到的资金瓶颈问题！</li>
				<li><span>旗意贷</span>（生意贷）：为个体工商户或小企业主量身定制，手续简单，流程简化！</li>
				<li><span>旗速贷</span>（供应链贷）：为供应链上下游客户提供完善的仓单融资、贸易融资、保理融资等金融服务。</li>
				<li><span>旗车贷</span>（车辆抵押贷款）：用于帮助车辆所有者解决急需资金的贷款产品。</li>
				<li><span>旗房贷</span>（红本抵押贷）：用红本作抵押的一种贷款产品，额度高、速度快。</li>
			</ul>
			<!--如何借款-->
		<div class="new-wcjk new-center white-bg mt20">
			<div class="header">
				<h2>如何投资</h2>
			</div>
			<div class="pt30 picimg">
				<img src="<%=controller.getStaticPath(request)%>/images/rhjk-bg.png"/>
			</div>
		</div>
	    </div>
             <div class="white-bg mt20 new-lcsm">

                  <div>
                      <h4>1、投标后是否可以取消</h4>
                      <p>您在投标后不允许取消。若此标满标并放款后，您账户上的冻结金额自动将转入该标借款人账户。若此标流标，则您账户上的冻结金额自动转为用户可用金额。</p>
                   </div>
                    <div>
                      <h4>2、如何收取还款？</h4>
                      <p>借款人在规定的还款时间内将钱充值到与麒麟通宝合作的第三方支付平台上，麒麟通宝系统会发送邮件通知所有投资人借款人已成功还款。投资人可按个人需求选择提现或继续投资。<br />注：借款人也可能提前偿还全部借款或者在到期日前手动提前偿还借款，请投资人注意查收麒麟通宝发出的通知。</p>
                   </div>
                    <div>
                      <h4>3、借款人提前还款怎么办？</h4>
                      <p>借款人可以提前偿还借款，如果借款人提前偿还全部借款，需要额外支付给投资人借款剩余本金的1%作为违约金， 不用再支付后续的利息及管理费用。</p>
                   </div>
             </div>
	</div>
<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	<script>
        $(function () {
            $(".n_mc_name_hf").click(function () {
                $(this).hasClass("open") ? $(this).removeClass("open").next("div").slideUp(500) : $(this).addClass("open").next("div").slideDown(500);
            });
        });
    </script>
</body>
</html>