<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignment"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
		String _TITLE_ = "债权转让 - P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
<style type="text/css" media="screen">
	.checkboxFive{width:25px;position:relative;margin-right:3%;}
	.checkboxFive label{cursor:pointer;position:absolute;width:20px;height:20px;top:9px;left:10px;background:#eee;border:1px solid #ddd;}
	.checkboxFive label:after{opacity:0;content:'';position:absolute;width:9px;height:5px;background:transparent;top:4px;left:4px;border:3px solid #1d4d9f;border-top:none;border-right:none;-webkit-transform:rotate(-45deg);-moz-transform:rotate(-45deg);-o-transform:rotate(-45deg);-ms-transform:rotate(-45deg);transform:rotate(-45deg);}.checkboxFive label:hover::after{opacity:0.5;}
	.checkboxFive input[type=checkbox]:checked+label:after{opacity:1;}
</style>
</head>
<%
CreditAssignmentManage service = serviceSession.getService(CreditAssignmentManage.class);
int id = IntegerParser.parse(request.getParameter("id"));
CreditAssignment caInfo= service.get(id);
int syfs=caInfo.syfs;
UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
UserInfo userInfo= userInfoManage.search();
String isYuqi =  userInfoManage.isYuqi();
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<section class="mstb">
		<header class="mstb-top">转让ID<span><%=caInfo.zcId %></span></header>
		<form method="post" action="<%configureProvider.format(out,URLVariable.WAP_USER_GMZQ);%>">
		<input type="hidden" name="zcbId" id="zcbId" value="<%=id%>">
	    <input type="hidden" name="syfs" id="syfs" value="<%=syfs%>">
	    <input type="hidden" name="zrjg" id="zrjg" value="<%=caInfo.zrjg %>">
		<input type="hidden" name="_zsy" id="_zsy" value="<%=caInfo.yjsy %>">	
		<input type="hidden" name="_zje" id="_zje" value="<%=caInfo.ystzje%>"> 
		<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
		<ul class="mstb-btm">
			<li>
				<span class="tit">购买总需</span>
				<span class="right"><%=Formater.formatAmount(caInfo.zrjg.multiply(new BigDecimal(syfs))) %>元</span>
			</li>
			<li>
				<span class="tit">可用金额:</span>
				<span class="right"><%=userInfo.kyMoney==null?0:userInfo.kyMoney %>元<a href="<%configureProvider.format(out,URLVariable.WAP_CZ_URL);%>" class="cz">充值</a></span>
			</li>
			<li>
				<span class="tit">预计收益</span>
				<span class="right"><span id="tbMoney" style="font-size:1em;">0</span>元</span>
			</li>
			<li>
				<span class="tit">申购份数</span>
				<span class="right"><input name="amount" id="amount" type="text" class="tzfs" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)" /> 份</span>
			</li>
			<p style="margin-top:5px;height:14px;color:#bb0b0b;" id="error_tip"></p>
			<div class="xuanzhe" style="width:90%">
				<div class="checkboxFive" style="float:left;">
				<input type="checkbox" value="" id="checkboxFiveInput" name="isread" style="margin:13px 0 0 13px"/>
				<label for="checkboxFiveInput"></label>
		</div>
				<!--<input type="checkbox" name="isread" />--><span style="float:left;font-size:1em;">我己阅读并同意<a href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZQZRXY.name())%>" class="">《债权转让及受让协议》</a></span>
			</div>
			<div class="tj">
				<input type="submit" id="ok"  value="确认申购" class="tb"/>
				<!-- <input type="submit" value="取消" class="qx"/> -->
			</div>
		</ul>
		</form>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/zqzr.js"></script>
</body>
</html>