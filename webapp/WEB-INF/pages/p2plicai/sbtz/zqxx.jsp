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
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
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
<div class="plan_tab_con01_hf">
                	<div class="fr" style="margin-bottom:18px;">
                    	<span class="fs14c73">持有债权人数<em style="font-size:20px; color:#186ea7;"><%=j %></em>人</span> 
                    </div>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    	<tbody>
                        	<tr class="leve_titbj_hf">
                            	<td width="205">序号</td>
                                <td width="261" class="border_lr3">债权人</td>
                                <td width="262" style="border-right:3px solid #fff;">待收本金</td>
                                <td width="">持有份数</td>
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
                            <%}}%>
                        </tbody>
                    </table>
</div>
  
</body>
</html>