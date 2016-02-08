<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.wytz.WytbList"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Bdxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignment"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.zqzr.Index"%>
<html>
<head>
<%
	String _TITLE_ = "债权转让 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	CreditAssignmentManage service = serviceSession.getService(CreditAssignmentManage.class);
	int line = IntegerParser.parse(request.getParameter("line"));
	int size = service.searchCount();
	CreditAssignment[] creditAssignments=service.zqList(line);
%>

<body>
	<div id="wrap-all">
	<!--头部-->
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<!--头部结束-->
	<!--投资列表-->
	<section class="tbym hkz" id="wytb">
		<header class="tb-header">
			<span id="tzxmtab" style="cursor:pointer">投资项目</span>
			<span class="active">债权转让</span>
			<div class="clear"></div>
		</header>
		<section class="list-tb" style="display:block;">
			<ul class="index-wytz">
			<%
				
				if(creditAssignments!=null && creditAssignments.length > 0){
					int i = 0;
						for (CreditAssignment creditAssignment : creditAssignments) {
							if (creditAssignment == null) {continue;}
					i++;
			%>
				<li class="tz first" data="<%=Formater.formatRate(creditAssignment.rate,false)%>" datai="<%=i %>">
						<header>
							<a href="<%=controller.getPagingItemURI(request,Bdxq.class,creditAssignment.zcId)%>">
								<%StringHelper.filterHTML(out, StringHelper.truncation(creditAssignment.title, 7));%>
							</a>
						</header>
						<table>
							<tbody>
								<tr class="first zq-first">
									<td class="tit">年化利率</td>
									<td class="tit">剩余期限</td>
									<td class="tit" style="width:25%">借款总额</td>
									<td class="tit">剩余份数</td>
								</tr>
								<tr>
									<td class="nianhua"><%=Formater.formatRate(creditAssignment.rate,false)%>%</td>
									<td class="timer"><%=creditAssignment.syqx%>/<%=creditAssignment.jkqx%>个月</td>
									<td class="money"><%=creditAssignment.jkje%> <%-- <%=creditAssignment.zrjg%>*<%=creditAssignment.syfs%> --%>元</td>
									<td class="timer"><%=creditAssignment.syfs%>份</td>
								<tr>
							</tbody>
						</table>
				</li>
			<%}%>
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
					line=creditAssignments.length+3;
				}
				%>
		<div class="tb-more">
			<a href="<%=controller.getViewURI(request, Index.class)%>?line=<%=line %>">加载更多项目>></a>
		</div>
		<%}} %>
	</section>
	
	<!--底部-->
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
  </div>
  <%@include file="/WEB-INF/include/wap/script.jsp"%>
<script src="<%=controller.getStaticPath(request)%>/wap/js/circleProgress.js"></script>
</body>
<!--圆形进度条js-->
<script>
/* process = 0;
$(function(){
	$(".tz").each(function(){
		var jd = $(this).attr("data");
		var i = $(this).attr("datai");
		if(parseInt(jd)>=100){
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#83a700','#000');
		}else{
			DrowProcess('circle-progress-'+i,50,50,40,jd,'#ccc','#ea5a59','#000');
		}
	});
});  */
$("#tzxmtab").click(function(){
	window.location.href="<%=controller.getViewURI(request, WytbList.class)%>";
});
</script>
</html>