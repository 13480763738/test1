<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.Mterm"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.Iapply"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.List"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.entity.FinancingPlan"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "理财体验详情";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
	
	<script type="text/javascript">

		function time(timeid,sendTime,sclearTime) {
			var endTime = parseInt(sendTime);
			var leftsecond = parseInt(endTime / 1000);
			var day = Math.floor(leftsecond / (60 * 60 * 24)) < 0 ? 0 : Math
					.floor(leftsecond / (60 * 60 * 24));
			var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0
					: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
			var minute = Math
					.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0
					: Math
							.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
			var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600
					- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60
					* 60 - hour * 3600 - minute * 60);
			hour = hour + day*24;
			if (hour < 10) {
				hour = "0" + hour;
			}
			if (minute < 10) {
				minute = "0" + minute;
			}
			if (second < 10) {
				second = "0" + second;
			}
			
			$("span[name='"+timeid+"hour']").html(hour);
			$("span[name='"+timeid+"minute']").html(minute);
			$("span[name='"+timeid+"second']").html(second);
			if (leftsecond <= 0) {
				clearInterval(sclearTime);
				$("#count_time").hide();
				$("#_time_join").show();
			}
		}
	
	</script>
</head>

<%
	FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	FinancingPlanInfo caInfo= service.getPlan(id);
	if(caInfo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>

		<div data-role="content" class="qcontent">
			<div class="lctyxq_box">
				<ul>
					<li class="tit"><p><%
				StringHelper.filterHTML(out, caInfo.planTitle);
			%></p></li>
					<li><div class="lctyxq_tit1">计划金额</div>
						<div class="lctyxq_tit2">
							<span class="orange"><%=Formater.formatAmount(caInfo.planMoney) %></span><em>元</em>
						</div></li>
					<li><div class="lctyxq_tit1">预期收益</div>
						<div class="lctyxq_tit2">
							<span class="red"><%=caInfo.yqsy == null? "0%":Formater.formatRate(caInfo.yqsy.doubleValue())%></span><em>每年</em>
						</div></li>
					<li><div class="lctyxq_tit1">投资方式</div>
						<div class="lctyxq_tit2">体验金</div></li>
					<li><div class="lctyxq_tit1">理财说明</div>
						<div class="lctyxq_tit2">
							<a href="<%=controller.getPagingItemURI(request, Mterm.class, TermType.WAP_LCTYCPSMS.name())%>" rel="external">《理财体验说明书》</a>
						</div></li>
					<li><div class="lctyxq_tit1">计划状态</div>
					<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
							<div class="lctyxq_tit2">预售中</div>
					<%}else if(caInfo.planState == PlanState.YFB && !caInfo.fromSale.after(caInfo.currentTime)){%>
							<div class="lctyxq_tit2">申请中</div>
					<%}else if(caInfo.planState == PlanState.YSX){%>
							<div class="lctyxq_tit2">已满额</div>
					<%}else if(caInfo.planState == PlanState.YJZ){%>
							<div class="lctyxq_tit2">已截止</div>
					<%}%>
					</li>
					<li>
						<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){
												long hm=1000*3600*24;
												long time =	 caInfo.fromSale.getTime() - caInfo.currentTime.getTime();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="lctyxq_tit1">距离发售</div>
						<div class="lctyxq_tit2">
							<%=day%><em>天</em><%=hour%><em>小时</em><%=min%><em>分</em>
						</div>
						<%
						}else if(caInfo.planState == PlanState.YSX || caInfo.planState == PlanState.YJZ){	
												long hm=3600*24;
												long time =	caInfo.fullTime;
												long day=time/hm;
												long hour=(time-day*hm)/3600;
												long min=(time-day*hm-hour*3600)/60;
												long ss=time-day*hm-hour*3600-min*60;
						%>
						<div class="lctyxq_tit1">满额用时</div>
						<div class="lctyxq_tit2">
							<%=day%><em>天</em><%=hour%><em>小时</em><%=min%><em>分</em>
						</div>
						<%
						}else if(caInfo.planState == PlanState.YFB && !(caInfo.fromSale.after(caInfo.currentTime))){
												long hm=1000*3600*24;
												long time =	caInfo.cutoff.getTime()-caInfo.currentTime.getTime();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="lctyxq_tit1">距离截止</div>
						<div class="lctyxq_tit2">
							<%=day%><em>天</em><%=hour%><em>小时</em><%=min%><em>分</em>
						</div>
						<%
							}
						%>
					</li>
					<li><div class="lctyxq_tit1">锁定期限</div>
						<div class="lctyxq_tit2">
							<%=caInfo.lockqx%><em>个月</em>
						</div></li>
						 <%
							Calendar calendar = Calendar.getInstance();
							calendar.setTimeInMillis(caInfo.lockEnd.getTime());
							int year=calendar.get(Calendar.YEAR); 
							int month=calendar.get(Calendar.MONTH)+1; 
							int date=calendar.get(Calendar.DATE);
						 %>
					 <li><div class="lctyxq_tit1">锁定结束</div><div class="lctyxq_tit2 red"><%=year%><em>年</em><%=month%><em>月</em><%=date%><em>日</em></div></li>
					<li><div class="lctyxq_tit1">收益处理</div>
						<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, (PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)?caInfo.earningsWay.getName().replace("，到期还本", ""):caInfo.earningsWay.getName()));  %></div></li>
					<li><div class="lctyxq_tit1">费率说明</div>
						<div class="lctyxq_tit2">体验活动不收取任何费用</div></li>
					<li class="tit" style="padding-top: 0.8rem; padding-bottom: 0rem;"><p>计划介绍</p></li>
				</ul>
			</div>
			<div class="lctyxq_txt">
				<p><%StringHelper.filterHTML(out, caInfo.introduce);%></p>
			</div>
			<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
				<a href="<%=controller.getViewURI(request, Iapply.class)%>" rel="external" id="_time_join" class="lctyxq_jr" style="display: none;">立即加入</a>
				<span class="lctyxq_jr span" id="count_time">距离开始：
				<span style="padding: 0px;" name="tbnamehfbhour">00
				</span><em>时</em>
				<span style="padding: 0px;" name="tbnamehfbminute">00
				</span><em>分</em><span style="padding: 0px;" name="tbnamehfbsecond">00</span><em>秒</em></span>
				<script type="text/javascript">
				tempendTimehfb= parseInt(<%=caInfo.fromSale.getTime()-System.currentTimeMillis()%>);
				tempnamehfb = "tbnamehfb";
				sclearTimehfb = setInterval(function() {
				tempendTimehfb = tempendTimehfb - 1000;
				time(tempnamehfb,tempendTimehfb,sclearTimehfb);
				}, 1000);
				
				</script>
			<%}else if(caInfo.planState == PlanState.YFB && !caInfo.fromSale.after(caInfo.currentTime)){%>
			<a href="<%=controller.getViewURI(request, Iapply.class)%>" rel="external" class="lctyxq_jr" >立即加入</a>
			<%}else if(caInfo.planState == PlanState.YSX){%>
				<span class="lctyxq_jr span" >已满额</span>
			<%}else if(caInfo.planState == PlanState.YJZ){%>
				<span class="lctyxq_jr span" >已截止</span>
			<%}%>
			
			
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
		<div class="footer_show"></div>
	</div>

	
</body>
</html>