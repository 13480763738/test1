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
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
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

<div class="plan_tab_con01_hf">
<div class="fr" style="margin-bottom:18px;">
<span class="fs14c73">加入人次<em style="font-size:20px; color:#186ea7;"><%=tenderRecords == null?0:tenderRecords.length %></em>人&nbsp;&nbsp;&nbsp;&nbsp;</span> 
<span class="fs14c73">投标总额<em style="font-size:20px; color:#186ea7;"><%=Formater.formatAmount(totleMoney) %></em>元</span>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tbody>
    	<tr class="leve_titbj_hf">
        	<td width="205">序号</td>
            <td width="261" class="border_lr3">投标人</td>
            <td width="262" style="border-right:3px solid #fff;">投标金额</td>
    		<td width="">投标时间</td>
		</tr>
	<%if (tenderRecords != null) {int i=1;for (TenderRecord tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}%>
		<tr>
			<td><%=i++ %></td>
			<td>
			<%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%>
			</td>
       	    <td><%=tenderRecord.tenderMoney %><em style="font-size:12px; color:#737373;">元</em></td>
			<td><%=DateTimeParser.format(tenderRecord.tenderTime,"yyyy-MM-dd HH:mm") %></td>
		</tr>
	<%}}else{%>
		<tr><td colspan="4"></td></tr>
	<%} %>
    </tbody>
</table>
</div>
</body>
</html>