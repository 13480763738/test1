<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.Jlgz"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.PromptlyJoin"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.CreditorTransferList"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.CreditorList"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.AwardList"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.RefundList"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.CorrelationMaterial"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.InvestList"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.util.Calendar"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.Yhdetails"%>
<%@page
	import="com.jiudian.p2p.front.servlets.m.p2plicai.sbtz.Rzfdetails"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "借款详情";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
		InvestManage investManage = serviceSession
				.getService(InvestManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		CreditInfo creditInfo = investManage.get(id);
		
		if (creditInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
		int ljtzcs =  infoManage.ljtzcs();
		CreditFiles creditFile = infoManage.getFile(creditInfo.userId);
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
		
%>
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
				if(!($("#count_time").is(":hidden"))){
					$("#count_time").hide();
					$("#_time_join").show();
				}
			}
		}
	
	</script>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="zjzz_box">
				<div class="tit">
					<%
					 	StringHelper.filterHTML(out, creditInfo.title);
					 %><span class="ico_jiang"><%StringHelper.filterHTML(out, creditInfo.jllx.getName());%></span>
				</div>
				<div class="tit_box">
						<%
							if (creditInfo.creditType == CreditType.XYDB) {
						%>
						<%
							if (creditInfo.companyStatus != null
													&& creditInfo.companyStatus
															.equals(CompanyStatus.SYQYZ)) {
						%>
						<div class="tit_box01">
							<span class="ico_small">企</span>企业融资
						</div>
						<%
							}
						%>
						<div class="tit_box01">
							<span class="ico_small">保</span>机构担保
						</div>
						<%
							} else if (creditInfo.creditType == CreditType.XJD
												|| creditInfo.creditType == CreditType.SYD) {
						%>
						<div class="tit_box01">
							<span class="ico_small">信</span>信用认证
						</div>
						<%
							} else if (creditInfo.creditType == CreditType.SDRZ) {
						%>
						<%
							if (creditInfo.companyStatus != null
													&& creditInfo.companyStatus
															.equals(CompanyStatus.SYQYZ)) {
						%>
						<div class="tit_box01">
							<span class="ico_small">企</span>企业融资
						</div>
						<%
							}
						%> 
						<div class="tit_box01">
							<span class="ico_small">实</span>实地认证
						</div>
						<%
							}
						%>
					<div class="tit_box01 tit_box01_01">信用度<span class="star">
					<%for(int i=1;i<=7;i++){if(i<=CreditLevel.getLevelId(creditFile.creditLevel)){%>★<%}else{%>☆<%}} %>
						</span>
					</div>
				</div>
				<div class="lctyxq_box" style="border-bottom: none;">
					<ul>
						<li><div class="lctyxq_tit1">标的总额</div>
							<div class="lctyxq_tit2">
								<span class="orange"><%=Formater.formatAmount(creditInfo.amount)%></span><em>元</em>
							</div></li>
						<li><div class="lctyxq_tit1">年利率</div>
							<div class="lctyxq_tit2">
								<span class="orange"><%=Formater.formatRate(creditInfo.rate,false)%>%</span>
							</div></li>
						<li><div class="lctyxq_tit1">还款期限</div>
							<div class="lctyxq_tit2">
							<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><%=creditInfo.term%>个月
							<%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><%=creditInfo.term%>天
							<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
							满额即还<%}%></div></li>
						<li><div class="lctyxq_tit1">保障方式</div>
							<div class="lctyxq_tit2">本息</div></li>
						 <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){ %>
						<li><div class="lctyxq_tit1">提前还款费率</div>
							<div class="lctyxq_tit2"><%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES)))%></div></li>
						<%} %>
						<li><div class="lctyxq_tit1">还款方式</div>
							<div class="lctyxq_tit2"><%=creditInfo.repaymentType.getName()%></div></li>
						<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
						<li><div class="lctyxq_tit1">月还本息</div>
							<div class="lctyxq_tit2"><%=creditInfo.yhkAmount%>元</div></li>
					    <%}%>
					    <%if (creditInfo.status == CreditStatus.TBZ) {%>
						<li>
							<div class="lctyxq_tit1">投标进度</div>
							<div class="lctyxq_tit2">
								<div class="lcty_txt zjzz">
									<div class="lcty_bfb">
										<div class="lcty_bfbin" style="width: <%=creditInfo.progress%>%;"></div>
									</div>
									<p class="lcty00"><%=creditInfo.progress%>%</p>
								</div>
							</div>
						</li>
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
							<li><div class="lctyxq_tit1">剩余时间</div>
							<div class="lctyxq_tit2"><%=day %>天<%=hour %>小时<%=min %>分</div></li>
							<%} %>
						<%}%>
						<%if (creditInfo.status == CreditStatus.YMB||creditInfo.status == CreditStatus.YFK) {%>
						<li><div class="lctyxq_tit1">满标用时</div><div class="lctyxq_tit2"><%=mb_hour+24*mb_day %>天<%=mb_min %>小时<%=mb_ss %>分</div></li>
						<%}%>
						<li><div class="lctyxq_tit1">投标奖励</div>
							<div class="lctyxq_tit2">
								<span class="orange">
								<%if(!creditInfo.jllx.equals(RewardType.WJL)){%>
								<%=Formater.formatRate(creditInfo.jlll)%>
								<%} %>
								</span><%StringHelper.filterHTML(out, creditInfo.jllx.getName());%>
							</div></li>
						<li><div class="lctyxq_tit1">当前累计投资次数</div>
							<div class="lctyxq_tit2">
								<span class="orange"><%=ljtzcs%>次</span>
							</div></li>
						<%if ((creditInfo.status == CreditStatus.TBZ&&(creditInfo.jllx.equals(RewardType.XSJ)||creditInfo.jllx.equals(RewardType.MTC)))&&xs_deta>0) {%>
						<li><div class="lctyxq_tit1"><%StringHelper.filterHTML(out, RewardType.XSJ.getName()+"倒计时");%></div>
							<div class="lctyxq_tit2">
							<span name="hdjshour">00</span>时<span name="hdjsminute">00</span>分<span name="hdjssecond">00</span>秒
							</div></li>
							<script type="text/javascript">
                              		tempendTimetthdjs= parseInt(<%=xs_deta%>);
	                              	tempnametthdjs = "hdjs";
	                              	sclearTimetthdjs = setInterval(function() {
	                              		tempendTimetthdjs = tempendTimetthdjs - 1000;
	                              		time(tempnametthdjs,tempendTimetthdjs,sclearTimetthdjs);
	                              	}, 1000);
						    </script>
						<%} %>
						
						<li><div class="lctyxq_tit1">投标限额</div>
							<div class="lctyxq_tit2"><%if(xefs.intValue() >0){ %><%=xefs.multiply(mfjg) %><%}else{ %>不限<% }%></div></li>
					</ul>
				</div>
			</div>
			<div class="zjzz_links">
				<%
					if (creditInfo.companyStatus != null
								&& creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)) {
				%>
				<a href="<%=controller.getViewURI(request, Rzfdetails.class)%>?id=<%=id%>" rel="external">标的详情<span>></span></a>
				<%
					} else {
				%>
				<a href="<%=controller.getViewURI(request, Yhdetails.class)%>?id=<%=id%>" rel="external">标的详情<span>></span></a>
				<%
					}
				%>
				<a href="<%=controller.getViewURI(request, CorrelationMaterial.class)%>?id=<%=id%>" rel="external">相关资料<span>></span></a> 
				<a href="<%=controller.getViewURI(request, InvestList.class)%>?id=<%=id%>" rel="external">投标记录<span>></span></a>
				<%
					 if(creditInfo.status==CreditStatus.YFK||creditInfo.status==CreditStatus.YDF||creditInfo.status==CreditStatus.YJQ){
				%>
				<a href="<%=controller.getViewURI(request, RefundList.class)%>?id=<%=id%>" rel="external">还款记录<span>></span></a>
				<a href="<%=controller.getViewURI(request, CreditorList.class)%>?id=<%=id%>" rel="external">债权信息<span>></span></a>
				<a href="<%=controller.getViewURI(request, CreditorTransferList.class)%>?id=<%=id%>" rel="external">转让记录<span>></span></a>
				<%}%>
				
				 <%
			        TenderRecord[] _jls = investManage.getJllb(id);
			        if(_jls != null)
			        if (creditInfo.status == CreditStatus.YFK||creditInfo.status == CreditStatus.YJQ) { 
		        %>
		        	<a href="<%=controller.getViewURI(request, AwardList.class)%>?id=<%=id%>" rel="external">奖励名单<span>></span></a>
		        <%} %>
		        <a href="<%=controller.getViewURI(request, Jlgz.class)%>?id=<%=id%>" rel="external">奖励规则<span>></span></a>
			</div>
			
			<%if (creditInfo.status == CreditStatus.TBZ) {
				if(fb_deta==0){
				%>
				<a href="<%=controller.getViewURI(request, PromptlyJoin.class)%>?id=<%=id%>" rel="external" id="_time_join" class="lctyxq_jr" >立即加入</a>
				<%}else if(fb_deta>0){ %>
				<a href="<%=controller.getViewURI(request, PromptlyJoin.class)%>?id=<%=id%>" rel="external" id="_time_join" class="lctyxq_jr" style="display: none;">立即加入</a>
				<span class="lctyxq_jr span" id="count_time">距离开始：
				<span style="padding: 0px;" name="djshour">00
				</span><em>时</em>
				<span style="padding: 0px;" name="djsminute">00
				</span><em>分</em><span style="padding: 0px;" name="djssecond">00</span><em>秒</em></span>
				<script type="text/javascript">
		         		tempendTimettdjs= parseInt(<%=fb_deta%>);
				       	tempnamettdjs = "djs";
				       	sclearTimettdjs = setInterval(function() {
				       		tempendTimettdjs = tempendTimettdjs - 1000;
				       		time(tempnamettdjs,tempendTimettdjs,sclearTimettdjs);
				       	}, 1000);
				</script>
				<%}%>
				<%
			} else if (creditInfo.status.equals(CreditStatus.YFK)) {
				%>
				<span class="lctyxq_jr span" ><%=CreditStatus.YFK.getName() %></span>
				<%
			} 
			else if (creditInfo.status.equals(CreditStatus.YMB)) {
				%>
				<span class="lctyxq_jr span" ><%=CreditStatus.YMB.getName() %></span>
				<%
			} else if (creditInfo.status == CreditStatus.YJQ) {
				%>
				<span class="lctyxq_jr span" ><%=CreditStatus.YJQ.getName() %></span>
				<%
			} else if(creditInfo.status == CreditStatus.YDF){
				%>
				<span class="lctyxq_jr span" ><%=CreditStatus.YDF.getName() %></span>
				<%
			} else if (creditInfo.status.equals(CreditStatus.LB)) {
				%>
				<span class="lctyxq_jr span" >已<%=CreditStatus.LB.getName() %></span>
				<%
			}%>
		</div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
		
		 <div class="footer_show"></div>
		
	</div>

</body>
</html>