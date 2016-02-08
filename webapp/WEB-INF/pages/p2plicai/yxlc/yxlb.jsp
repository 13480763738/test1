<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.Yxxq"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.Yxlb"%>
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlan"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanCount"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html>
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<%
	FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	FinancingPlanCount fpCount=service.getStatistics();
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, Yxlb.class));
	PagingResult<FinancingPlan> result = service.search(
	 new Paging() {
		public int getCurrentPage() {
	return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
		}
		public int getSize() {
	return 10;
		}
	});
	FinancingPlanInfo caInfo= service.getNewPlan();
%>

<div class="sub-nav" sup="Project">
    <div class="sub-nav-inner">
        <%@include file="/WEB-INF/include/list_header.jsp" %>
    </div>
</div>
	<div class="center_box" style="background:#f1f3f5;">
    	<div class="center">
            <div class="plan_tab_hf">
               <span class="fs18c73 fl" style="line-height:60px;">投资效果</span>
            </div>
            <div class="plan_content_hf">
            	<ul class="targeting_hf">
            		<%if(fpCount != null ){ %>
            		<li>
                    	<p>
                    	<%if(fpCount.totleMoney.doubleValue()>=100000000){%>
			        	   <span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/100000000)%>
			        	   </span><span class="fs14c73">亿元</span>
			        	<%}else if(fpCount.totleMoney.doubleValue()>=10000 && fpCount.totleMoney.doubleValue() <100000000){%>
			        	   <span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/10000)%>
			        		</span><span class="fs14c73">万元</span>
			        	<%}else{%>
			        		<span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney)%>
			        		</span><span class="fs14c73">元</span>
			        	<%}%>
                    	</p>
                        <p>累计总金额</p>
                    </li>
                    <li>
                    	<p><span style="font-size:36px; color:#176fa7;"><%=fpCount.joinCount%></span><span class="fs14c73">次</span></p>
                        <p>加入总人次</p>
                    </li>
                    <li>
                    	<p>
                    	<%if(fpCount.userEarnMoney.doubleValue()>=100000000){%>
				        	   <span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/100000000)%>
				        	   </span><span class="fs14c73">亿元</span>
			        	<%}else if(fpCount.userEarnMoney.doubleValue()>=10000 && fpCount.userEarnMoney.doubleValue() <100000000){%>
			        		<span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/10000)%>
			        		</span><span class="fs14c73">万元</span>
			        	<%}else{%>
			        		<span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney)%>
			        		</span><span class="fs14c73">元</span>
			        	<%}%>
                    	</p>
                        <p>为用户累计赚取</p>
                    </li>
				<%}else{ %>
					<li>
                    	<p><span style="font-size:36px;">0</span><span class="fs14c73">元</span></p>
                        <p>累计总金额</p>
                    </li>
                    <li>
                    	<p><span style="font-size:36px; color:#176fa7;">0</span><span class="fs14c73">次</span></p>
                        <p>加入总人次</p>
                    </li>
                    <li>
                    	<p><span style="font-size:36px; color:#f08304;">0</span><span class="fs14c73">元</span></p>
                        <p>为用户累计赚取</p>
                    </li>
				<%}%>
                </ul>
                <div class="plan_intr_hf">
                	<p class="fs18c73">往期理财体验列表</p>
                   <table width="100%" cellspacing="0" cellpadding="0" border="0" class="plan_tab_con01_hf">
                    	<tbody>
                        	<tr class="leve_titbj_hf">
                            	<td width="181">投资人</td>
                                <td width="193" class="border_lr3">计划金额 </td>
                                <td width="162">加入人数</td>
                                <td width="137" class="border_lr3">收益率</td>
                                <td width="146" style="border-right:3px solid #fff;">累计赚取</td>
                                <td>投资时间</td>
                            </tr>
                            <%
				             	FinancingPlan[] financingPlans=result.getItems();if(financingPlans!=null){for (FinancingPlan financingPlan : financingPlans) {if (financingPlan == null) {continue;}
				             %>
                            <tr class="leve_hf">
                            	<td><a href="<%=controller.getPagingItemURI(request, Yxxq.class,financingPlan.id)%>"><%=financingPlan.planTitle%></a>
                            	</td>
                                <td><%=financingPlan.planMoney%>元</td>
                                <td><%=financingPlan.joinCount%>人</td>
                                <td><span class="fs18c73"><%=Formater.formatRate(financingPlan.avgYield)%></span></td>
                                <td><span class="fs18c73"><%=Formater.formatAmount(financingPlan.totleEarn)%></span>元</td>
                                <td><%=DateParser.format(financingPlan.releaseTime)%></td>
                            </tr>
	                           <%
				              	}}
				              %>
                    	</tbody>
                    </table>
                    
                    <%
			         	AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, Yxlb.class));
			         %>
                </div>
            </div>
        </div>
    </div>
<div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript">
		var endTime =<%=caInfo.fromSale.getTime()- System.currentTimeMillis()%>;
		var clearTime = null;
		function time() {
			var leftsecond = parseInt(endTime / 1000);
			var day = Math.floor(leftsecond/ (60 * 60 * 24)) < 0 ? 0 : Math.floor(leftsecond / (60 * 60 * 24));
			var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
			var minute = Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60);
			var second = Math.floor(leftsecond - day* 24 * 60 * 60 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60* 60 - hour * 3600 - minute* 60);
			hour = hour +24*day;
			if(hour<10)
			{
				hour="0"+hour;	
			}
			if(minute<10)
			{
				minute="0"+minute;	
			}
			if(second<10)
			{
				second="0"+second;	
			}
			$(".time").html('<em>还有&nbsp;&nbsp;</em><span class="hour">'+hour+'</span><em>：</em><span class="minute">'+minute+'</span><em>：</em><span class="second">'+second+'</span><em>&nbsp;&nbsp;开始发售</em>');
			if (leftsecond <= 0) {
				clearInterval(clearTime);
			}
		}
		<%if((caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime))){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>
</script>
</body>
</html>

