<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditHoldInfo"%>
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
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
	CreditHoldInfo[] creditHoldInfos = creditManagePayment.getHoldInfo(id);
	int j = 0;
	if(creditHoldInfos!=null){
		j = creditHoldInfos.length;
	}
	
%>
  <ul class="pt-list3">
		<p>持有债权人数<em><%=j %></em>人</p>
		<table>
			<tbody>
				<tr class="title">
					<th>序号</th>
					<th>债权人</th>
					<th>待收本金</th>
					<th>持有份数</th>
				</tr>
				<%if (creditHoldInfos != null) {int i=1;for (CreditHoldInfo creditHoldInfo : creditHoldInfos) {if (creditHoldInfo == null) {continue;}%>
				<tr>
					<td><%=i++ %></td>
                    <td>
                    <%StringHelper.filterHTML(out, (creditHoldInfo.userName.length()>=6?creditHoldInfo.userName.substring(0,4):creditHoldInfo.userName.substring(0,1))+"***");%>
                    </td>
                    <td><%=Formater.formatAmount(creditHoldInfo.touzje) %><em style="font-size:12px; color:#737373;">元</em></td>
                    <td><%=creditHoldInfo.cyfs%><em style="font-size:12px; color:#737373;">份</em></td>
				</tr>
				<%}} %>
			</tbody>
		</table>
	</ul>
	<div class="clear"></div>
</body>
</html>