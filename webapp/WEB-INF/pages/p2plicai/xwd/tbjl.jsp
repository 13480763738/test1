<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<html>
<head>
<%
	if (jiudianSession == null || !jiudianSession.isAuthenticated()) {
%>
	<script type="text/javascript">
		parent.location.reload();
	</script>		
<%
	}
String cityid="";

String _TITLE_ = "散标详情 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<%@include file="/WEB-INF/include/meta.jsp"%>
<title><%=_TITLE_ %></title>
</head>
<style type="text/css">
.pt-list3{
	padding-top:28px;	
}
.pt-list3 p{
	padding-left:830px;
}
.pt-list3 p em{
	font-size:24px;
	color:#f1aa00;
}
.pt-list3 table{
	text-align:center;
	margin-top:10px;
}
.pt-list3 th{
	width:280px;
	height:44px;
	line-height:44px;
	background:#f2f3f5;
	font-size:14px;
}
.pt-list3 tr{
	border-bottom:1px solid #ccc;
	padding-bottom:5px;
}
.pt-list3 td{
	height:44px;
	line-height:44px;
	font-size:14px;
}
.title{
	border:0;
}
html, div, p, h1, h2, h3, h4, h5, h6, blockquote, ol, ul, li, dl, dt, dd, form, fieldset, legend, button, input, textarea, pre, code, th, td {
    margin: 0;
    padding: 0;
    font-family:"微软雅黑";
    color:#737373;	
}
table{
	border-collapse:collapse;
	width:1170px;
}

</style>
<body>
<%
InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
final HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(request);
TenderRecord[] tenderRecords = creditManagePayment.getRecord(IntegerParser.parse(request.getParameter("id")));
BigDecimal totleMoney=new BigDecimal(0);
if (tenderRecords != null && tenderRecords.length>0) {
for (TenderRecord tenderRecord : tenderRecords) {
if (tenderRecord == null) {continue;};
totleMoney=totleMoney.add(tenderRecord.tenderMoney);
}}%>
	<ul class="pt-list3">
		<p>加入人次<em><%=tenderRecords == null?0:tenderRecords.length %></em>人,投标总额<em><%=Formater.formatAmount(totleMoney) %></em>元</p>
		<table>
			<tbody>
				<tr class="title">
					<th>序号</th>
					<th>投标人</th>
					<th>投标金额</th>
					<th>投资时间</th>
				</tr>
				<%if (tenderRecords != null) {int i=1;for (TenderRecord tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}%>
				<tr>
					<td><%=i++ %></td>
					<td><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></td>
					<td><%=tenderRecord.tenderMoney %>元</td>
					<td><%=DateTimeParser.format(tenderRecord.tenderTime,"yyyy-MM-dd HH:mm") %></td>
				</tr>
				<%}}else{%>
					<tr><td colspan="4"></td></tr>
				<%} %>
			</tbody>
		</table>
	</ul>
	<div class="clear"></div> 
</body>
</html>