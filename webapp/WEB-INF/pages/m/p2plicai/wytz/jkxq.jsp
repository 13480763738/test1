<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xyhk"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
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
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<%if(jiudianSession != null && jiudianSession.isAuthenticated()){%>
<section class="jcxq">
		<h2>项目介绍</h2>
		<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
		<h2>描述</h2>
		<p><span class="tit">项目类型:</span><span><%=creditInfo.creditType.getName() %></span></p>
		<p><span class="tit">借款金额:</span><span><%=Formater.formatAmount(creditInfo.amount) %>元</span></p>
		<p><span class="tit">年化利率:</span><span><%=Formater.formatRate(creditInfo.rate,false)%>%</span></p>
		<p><span class="tit">借款期限:</span><span>
		<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
		<%=creditInfo.term%>个月
		<%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%>
		<%=creditInfo.term%>天
		<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
		秒标
		<%}%>
		</span></p>
		<p><span class="tit fl">还款方式:</span><%=creditInfo.repaymentType.getName() %></p>
		<p><span class="tit fl">借款用途:</span><font><%StringHelper.filterHTML(out, creditInfo.purpose); %></font></p>
		<!-- <h2>担保机构</h2>
		<p><span class="tit">担保机构:</span><span>某某投资管理有限公司</span></p>
		<p><span class="tit">保障方式:</span><span class="bz">100%本息保障</span></p> -->
		<!-- <a href="" class="kh">请开户</a>
		<a href="" class="tb">马上投标</a> -->
		<%if(creditInfo.hkList!=null && creditInfo.hkList.size()>0){%>	
		<h2>还款方式</h2>
		<table style="border:1px;" id="hkfs">
			<tr>
				<th style="width:100px;">还款日期</th>
				<th style="width:100px;">本金</th>
				<th style="width:100px;">利息</th>
			</tr>
			<%for(Xyhk hk : creditInfo.hkList){%>
			<tr>
				<td><%=TimestampParser.format(hk.hksj,"yyyy-MM-dd") %></td>
				<td><%=Formater.formatAmount(hk.bj) %></td>
				<td><%=Formater.formatAmount(hk.lx) %></td>
			</tr>
			<%}%>
		</table>
	<%}%>
	</section>
	<%}else{ %>
		<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="login-btn1">请先登录</a>
		<%} %>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>
<script>
	$("#hkfs").css({'width':'100%','border':'solid #ccc','border-width':'1px 0px 0px 1px'});
	$("#hkfs").find("th").css({'width':'33.33%','font-size':'1.6em','height':'50px','text-align':'center','color':'#232323','font-weight':'100','border':'solid #ccc','border-width':'0px 1px 1px 0px'});
	$("#hkfs").find("td").css({'width':'33.33%','font-size':'1.4em','height':'50px','text-align':'center','color':'#595959','border':'solid #ccc','border-width':'0px 1px 1px 0px'});
</script>