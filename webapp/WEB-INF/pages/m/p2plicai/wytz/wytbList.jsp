<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.Tbxmxq"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.WytbList"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Index"%>
<html lang="en">
<head>
<%
		String _TITLE_ = "投资列表 - P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
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
InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
int line = IntegerParser.parse(request.getParameter("line"));
int size = cnvestmentManage.searchcount();
CreditInfo[] result = cnvestmentManage.search(line);
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<section class="tbym hkz" id="wytb">
		<header class="tb-header">
			<span class="active">投资项目</span>
			<span id="zqzrtab" style="cursor:pointer">债权转让</span>
			<div class="clear"></div>
		</header>
		<section class="list-tb" style="display:block;">
			<ul class="index-wytz">
			<%
				if (result != null && result.length>0) {
					int i = 0;
					for (CreditInfo creditInfo : result) {
						if (creditInfo == null) {
							continue;
						}
						i++;
		%>
				<li class="tz first" data="<%=creditInfo.progress%>" datai="<%=i %>">
					<a href="<%=controller.getPagingItemURI(request, Tbxmxq.class,creditInfo.id)%>">
					<header><%StringHelper.filterHTML(out, creditInfo.title); %></header>
					<table>
						<tbody>
							<tr class="first">
								<td class="tit">年化利率</td>
								<td class="tit">期限</td>
								<td class="tit">借款总额</td>
								<td rowspan="2" class="yuan">
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
			<%} %>
			</ul>
		</section>
		<div class="clear"></div>
		
		<%if(line>0 && (line>=size)){%>
			<%}else{ 
				if(size >0 && line >0){
					if(size > line){
						line+=3;
					}
				}
				if(line == 0){
					line=result.length+3;
				}
				%>
			<div class="tb-more">
				<a href="<%=controller.getViewURI(request, WytbList.class)%>?line=<%=line %>">加载更多项目>></a>
			</div>
			<%}} %>
	</section>
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
</div>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/circleProgress.js"></script>
<script type="text/javascript">
process = 0;
$(function(){
	$(".tz").each(function(){
		var jd = $(this).attr("data");
		var i = $(this).attr("datai");
		if(parseInt(jd)>=100 && $('#circle-progressz-'+i).val() != $('#CreditStatus-'+i).val()){
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#83a700','#000');
		}else if($('#circle-progressz-'+i).val() == $('#CreditStatus-'+i).val()){
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#979797','#000');	
		}
		else{
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#ea5a59','#000');
		}
	});
}); 
$("#zqzrtab").click(function(){
	window.location.href="<%=controller.getViewURI(request, Index.class)%>";
});
</script>
</body>
</html>