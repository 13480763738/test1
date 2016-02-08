<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
		String _TITLE_ = "散标投资 - P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<link href="<%=controller.getStaticPath(request)%>/wap/css/public.css" rel="stylesheet">
<link href="<%=controller.getStaticPath(request)%>/wap/css/new-login.css" rel="stylesheet">
<style type="text/css" media="screen">
	.checkboxFive{width:25px;position:relative;margin-right:3%;}
	.checkboxFive label{cursor:pointer;position:absolute;width:20px;height:20px;top:9px;left:10px;background:#eee;border:1px solid #ddd;}
	.checkboxFive label:after{opacity:0;content:'';position:absolute;width:9px;height:5px;background:transparent;top:4px;left:4px;border:3px solid #1d4d9f;border-top:none;border-right:none;-webkit-transform:rotate(-45deg);-moz-transform:rotate(-45deg);-o-transform:rotate(-45deg);-ms-transform:rotate(-45deg);transform:rotate(-45deg);}.checkboxFive label:hover::after{opacity:0.5;}
	.checkboxFive input[type=checkbox]:checked+label:after{opacity:1;}
</style>
</head>
<%
InvestManage investManage = serviceSession.getService(InvestManage.class);
int id = IntegerParser.parse(request.getParameter("id"));
CreditInfo creditInfo = investManage.get(id);
if(creditInfo==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND );
	return;
}
int fs=0;
BigDecimal mfjg=creditInfo.perAmount;
BigDecimal zxMoney = new BigDecimal(0);
BigDecimal syfs = new BigDecimal(0);

BigDecimal ytfs = investManage.getTbcont(id);

BigDecimal tbxe = creditInfo.tbxe;
BigDecimal xefs = tbxe.divide(mfjg, 0, BigDecimal.ROUND_DOWN);


if(mfjg != null){
	syfs = creditInfo.remainAmount.divide(mfjg);
}

long _start_time = creditInfo.shTime.getTime();
if(creditInfo.fbTime!=null){
	_start_time = creditInfo.fbTime.getTime();
}
long mb_hm=1000*3600*24;
long mb_time =	(creditInfo.mbTime==null?0:creditInfo.mbTime.getTime())-_start_time;
long mb_day=mb_time/mb_hm;
long mb_hour=(mb_time-mb_day*mb_hm)/(1000*3600);
long mb_min=(mb_time-mb_day*mb_hm-mb_hour*1000*3600)/(1000*60);
long mb_ss=(mb_time-mb_day*mb_hm-mb_hour*1000*3600-mb_min*1000*60)/(1000);

long _now = Calendar.getInstance().getTimeInMillis();
long fb_deta =  _start_time-_now;if(fb_deta<0)fb_deta=0;
long xs_deta = _start_time+(60*creditInfo.xsxs+creditInfo.xsfz)*60*1000 - _now;
if(xs_deta<0)xs_deta=0;
UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
UserInfo userInfo= userInfoManage.search();
String isYuqi =  userInfoManage.isYuqi();

IsPass sf = investManage.sfktJzh();
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<section class="mstb">
		<header class="mstb-top">项目名称<span><%StringHelper.filterHTML(out, creditInfo.title); %></span></header>
		<form action="<%configureProvider.format(out,URLVariable.WAP_USER_SBTB);%>" method="post">
		<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
		<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
		<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.kyMoney%>">
		<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
		<input type="hidden" name="syfs" id="syfs" value="<%=syfs%>">
		<input type="hidden" id="_hkfs" value="<%=creditInfo.repaymentType.name()%>"/>
		<input type="hidden" id="_jkzq" value="<%=creditInfo.creditCycle.name()%>"/>
		<input type="hidden" id="_nll" value="<%=creditInfo.rate%>"/>
		<input type="hidden" id="_hkqs" value="<%=creditInfo.term%>"/>
		<input type="hidden" id="_jlll" value="<%=creditInfo.jlll.doubleValue()%>"/>
		<input type="hidden" id="mfMoney" value="<%=mfjg%>">
		<input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.WAP_SBTZLB);%>?pt=<%=creditInfo.productType.name()%>">
		<input type="hidden" name="isWap" value="1">
		
		<%
		BigDecimal sjgmfs=new BigDecimal(0);
        if(userInfo.kyMoney.compareTo(creditInfo.remainAmount)>0){
			sjgmfs = syfs;
			if(xefs.intValue() >0){
				if(ytfs.compareTo(xefs)>=0){
					sjgmfs = new BigDecimal("0");
				}else{
					if(sjgmfs.compareTo(xefs)>0){
						sjgmfs = xefs.subtract(ytfs);
					}
				}
			}
		}else{
			sjgmfs = userInfo.kyMoney.divide(mfjg, 0, BigDecimal.ROUND_DOWN);
			if(xefs.intValue() >0){
				if(ytfs.compareTo(xefs)>=0){
					sjgmfs = new BigDecimal("0");
				}else{
					if(sjgmfs.compareTo(xefs)>0){
						sjgmfs = xefs.subtract(ytfs);
					}
				}
			}
		}%>
		<ul class="mstb-btm">
			<li>
				<span class="tit">剩余金额:</span>
				<span class="right"><%=Formater.formatAmount(creditInfo.remainAmount)%>元</span>
			</li>
			<li>
				<span class="tit">可用余额:</span>
				<span class="right"><%=Formater.formatAmount(userInfo.kyMoney) %>元<a href="<%configureProvider.format(out,URLVariable.WAP_CZ_URL);%>" class="cz">充值</a></span>
			</li>
			<li>
				<span class="tit">可购买的份数</span>
				<span class="right"><%=sjgmfs%>份</span>
			</li>
			<li>
				<span class="tit">每份</span>
				<span class="right">100元</span>
			</li>
			<li>
				<p>
				<span class="tit">投资份数</span>
				<span class="right"><input id="amount" value="1" name="amount" type="text" class="tzfs" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)"/> 份</span>
				
			</li>
			</p>
				<p class="yjsy">预计收益<span id="_yjsy">0.00</span>元+奖<span id="_yjjl">0.00</span>元</span></p>
			<i class="tsk-fs"></i>
			<div class="xuanzhe" style="width:90%">
				<div class="checkboxFive" style="float:left;">
				<input type="checkbox" value="" id="checkboxFiveInput" name="isread" style="margin:13px 0 0 13px"/>
				<label for="checkboxFiveInput"></label>
				</div>
				<span style="float:left;font-size:1em;">我己阅读并同意<a href="<%=controller.getPagingItemURI(request, Term.class, TermType.JJFWXY.name()) %>" class="">《居间服务协议》</a></span>
				<%if(Jkflx.GR.name().equals(creditInfo.jkflx.name())){ %>
				<a href="<%=controller.getPagingItemURI(request, Term.class, TermType.GRJKXY.name()) %>">《借款协议》</a>
				<%}else if(Jkflx.QY.name().equals(creditInfo.jkflx.name())){%>
				<a href="<%=controller.getPagingItemURI(request, Term.class, TermType.QYJKXY.name()) %>">《借款协议》</a>
				<%} %>
			</div>
			<div class="tj">
				<%if (creditInfo.status == CreditStatus.TBZ) {
				%>
					<% if(IsPass.S==sf){%>
					<input type="submit" id="ok" value="投标" class="tb"/>
					<%}else{ %>
					<a href="<%configureProvider.format(out,URLVariable.WAP_KTDSF);%>" class="pl-login">请开通托管账户</a>
					<%} %>
				<%
				}else if (creditInfo.status.equals(CreditStatus.YFK)) {
					%>
					<a href="javascript:;" class="pl-login"><%=CreditStatus.YFK.getName() %></a>
					<%
				} 
				else if (creditInfo.status.equals(CreditStatus.YMB)) {
					%>
					<a href="javascript:;" class="pl-login"><%=CreditStatus.YMB.getName() %></a>
					<%
				} else if (creditInfo.status == CreditStatus.YJQ) {
					%>
					<a href="javascript:;" class="pl-login"><%=CreditStatus.YJQ.getName() %></a>
					<%
				} else if(creditInfo.status == CreditStatus.YDF){
					%>
					<a href="javascript:;" class="pl-login"><%=CreditStatus.YDF.getName() %></a>
					<%
				} else if (creditInfo.status.equals(CreditStatus.LB)) {
					%>
					<a href="javascript:;" class="pl-login">已<%=CreditStatus.LB.getName() %></a>
					<%
				}%>
			</div>
		</ul>
		</form>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/mstb.js"></script>
</body>
</html>