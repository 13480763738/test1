<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Xgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Mstb"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Hkxq"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.TzjlList"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Jkxq"%>
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
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
	InvestManage investManage = serviceSession.getService(InvestManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	CreditInfo creditInfo = investManage.get(id);
	
	long _start_time = creditInfo.shTime.getTime();
    if(creditInfo.fbTime!=null){
    	_start_time = creditInfo.fbTime.getTime();
    }
	long _now = Calendar.getInstance().getTimeInMillis();
	long fb_deta =  _start_time-_now;if(fb_deta<0)fb_deta=0;
	long xs_deta = _start_time+(60*creditInfo.xsxs+creditInfo.xsfz)*60*1000 - _now;
	if(xs_deta<0)xs_deta=0;
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<section class="tb-listpage">
		<header class="listpage-header">
			<h1><%StringHelper.filterHTML(out, creditInfo.title); %></h1>
			<p><span class="tit">借款总额</span><span><%=Formater.formatAmount(creditInfo.amount)%>元</span></p>
			<p><span class="tit">年收益率</span><span class="red"><%=Formater.formatRate(creditInfo.rate,false)%>%</span></p>
			<p><span class="tit">提前还款率</span><span><%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES)))%></span></p>
			<p><span class="tit">投资奖励</span><span>
			<%if(!creditInfo.jllx.equals(RewardType.WJL)){%>
						<%=Formater.formatRate(creditInfo.jlll)%>
						<%}%><%StringHelper.filterHTML(out, creditInfo.jllx.getName());%>
                    	<%-- <%if(!creditInfo.jllx.equals(RewardType.WJL)){%><span class="bg1 allbg"></span><%}%> --%></span></p>
			<p><span class="tit">借款期限</span><span>
				<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><%=creditInfo.term%>个月
					<%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><%=creditInfo.term%>天
					<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
					满额即还<%}%>
			</span></p>
			<p><span class="tit">还款方式</span><span><%=creditInfo.repaymentType.getName()%></span></p>
			<p><span class="tit">安全保障</span><span class="bz">信用管理机构到期债权收购</span></p>
			<%if (creditInfo.status == CreditStatus.TBZ) {%>
			<p><span class="tit">借款进度</span>
				<span class="jindutiao">
					<span style="width:<%=creditInfo.progress%>%;"></span>
				</span>
			</p>
			<p><span class="tit">可投金额</span><span><%=Formater.formatAmount(creditInfo.remainAmount)%>元</span></p>
            <%
						if(creditInfo.jsTime != null){
							creditInfo.jsTime.setHours(24);
							creditInfo.jsTime.setMinutes(59);
							creditInfo.jsTime.setSeconds(59);
							long hm=1000*3600*24;
							long time =	creditInfo.jsTime.getTime()-System.currentTimeMillis();
							
							long day=(time/hm);
							long hour=((time-day*hm)/(1000*3600));
							long min=((time-day*hm-hour*1000*3600)/(1000*60));
						%>
						<p><span class="tit">剩余时间</span><span><%=day%>天<%=hour%>时<%=min%>分</span></p>
					<%}%>	
            <%}%>
			
			
			<%if (creditInfo.status == CreditStatus.TBZ) {
				if(fb_deta==0){
				%>
				<%if(jiudianSession == null || !jiudianSession.isAuthenticated()){%>
					<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="pl-login">请先登录</a>
					<%}else{ 
					IsPass sf = investManage.sfktJzh();
					if(IsPass.S==sf){
					%>
					<a href="<%=controller.getPagingItemURI(request, Mstb.class,creditInfo.id)%>" class="pl-login" style="background:#1d4d9f;color:#fff">马上投标</a>
					<%}else{ %>
					<a href="<%configureProvider.format(out,URLVariable.WAP_KTDSF);%>" class="pl-login">请开通托管账户</a>
				<%}} %>
				<%}else if(fb_deta>0){ %>
				<%if(jiudianSession == null || !jiudianSession.isAuthenticated()){%>
					<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="pl-login time_join" style="display:none">请先登录</a>
					<%}else{ 
					IsPass sf = investManage.sfktJzh();
					if(IsPass.S==sf){
					%>
					<a href="<%=controller.getPagingItemURI(request, Mstb.class,creditInfo.id)%>" class="pl-login time_join" style="display:none;background:#1d4d9f;color:#fff">马上投标</a>
					<%}else{ %>
					<a href="<%configureProvider.format(out,URLVariable.WAP_KTDSF);%>" class="pl-login time_join" style="display:none">请开通托管账户</a>
				<%}} %>
				<a href="javascript:;" class="pl-login" style="background:#f5af55;color:#fff" id="divdown1" date="<%=fb_deta%>"></a>
				<%}%>
				<%
			} else if (creditInfo.status.equals(CreditStatus.YFK)) {
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
		</header>
		<footer class="listpage-footer">
			<ul>
				<li class="one">
					<a href="<%=controller.getViewURI(request, Jkxq.class)%>?id=<%=id%>">查看借款详情</a>
				</li>
				<li class="two">
					<a href="<%=controller.getViewURI(request, TzjlList.class)%>?id=<%=id%>">查看投标记录</a>
				</li>
				<li class="three">
					<a href="<%=controller.getViewURI(request, Hkxq.class)%>?id=<%=id%>">查看还款详情</a>
				</li>
				<li class="four">
					<a href="<%=controller.getViewURI(request, Xgzl.class)%>?id=<%=id%>">查看相关资料</a>
				</li>
			</ul>
		</footer>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/Countdown.js"></script>
<script>
	$("#divdown1").manhuaCountDown(true); 
</script>
</body>
</html>