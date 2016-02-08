<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Index"%>
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Tbxmxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.WytbList"%>
<%{ %>
<section class="index-wytz">
		<header class="title">
			<i class="hengxian"><i>
			<h2>可投资的项目</h2>
		</header>
		<ul class="index-wytz">
		<%InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
		CreditInfo[] result = cnvestmentManage.search(2);
		if (result != null && result.length>0) {
			int i = 0;
			for (CreditInfo creditInfo : result) {
				if (creditInfo == null) {
					continue;
				}
				i++;
		%>
			<li class="tz two" data="<%=creditInfo.progress%>" datai="<%=i %>">
				<a href="<%=controller.getPagingItemURI(request, Tbxmxq.class,creditInfo.id)%>">
				<header><%StringHelper.filterHTML(out, creditInfo.title); %></header>
				<table>
					<tbody>
						<tr class="first">
							<td class="tit">年化利率</td>
							<td class="tit">期限</td>
							<td class="tit">借款总额</td>
							<td rowspan="2" class="yuan" class="jdtab">
								<canvas id="circle-progress-<%=i %>" width="150" height="100"></canvas>
							<td>
						</tr>
						<tr>
							<td class="nianhua" ><%=Formater.formatRate(creditInfo.rate,false)%>%</td>
							<td class="timer">
							<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
							<%=creditInfo.term%>个月
				       	    <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%>
				       	    <%=creditInfo.term%>天
				       		<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
				       		秒标
				       		<%}%>
							</td>
							<td class="money">
							<%if(creditInfo.amount.doubleValue()>=10000){%>
			            	<%=creditInfo.amount.doubleValue()/10000%>万元
				            <%}else{%>
				            <%=Formater.formatAmount(creditInfo.amount)%>元
				            <%}%>
							</td>
						<tr>
					</tbody>
				</table>
				<div style="position:absolute;top:0;right:0;">
				<%
				if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
				%>
				<img src="<%=controller.getStaticPath(request) %>/wap/images/02.png"/>
				<%}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){ 
				%>
				<img src="<%=controller.getStaticPath(request) %>/wap/images/01.png"/>
				<%}else if(creditInfo.status==CreditStatus.YMB){ %>
				<img src="<%=controller.getStaticPath(request) %>/wap/images/03.png"/>
				<%}else if(creditInfo.status==CreditStatus.YFK){ %>
				<img src="<%=controller.getStaticPath(request) %>/wap/images/04.png"/>
				<%}else if(creditInfo.status==CreditStatus.YJQ){%>
				<img src="<%=controller.getStaticPath(request) %>/wap/images/05.png"/>
				<%} %>
				<input id="CreditStatus-<%=i %>" value="<%=CreditStatus.YJQ%>" style="display:none"/>
				<input id="circle-progressz-<%=i %>" value="<%=creditInfo.status%>" style="display:none"/>
					</div>
				</a>
			</li>
			<%}} %>
			<li class="bottom">
				<a href="<%=controller.getViewURI(request, WytbList.class)%>">查看投资项目>></a>
			</li>
			<li class="bottom">
				<a href="<%=controller.getViewURI(request, Index.class)%>">查看债权项目>></a>
			</li>
		</ul>
	</section>
	<%}%>