<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditOutRecode"%>
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
	InvestInfoManage investInfoManage = serviceSession.getService(InvestInfoManage.class);
	CreditOutRecode[] creditOutRecodes = investInfoManage.getOutRecode(id);
	BigDecimal djyMoney = investInfoManage.getDjyMoney(id);
	BigDecimal yjyMoney = investInfoManage.getyjyMoney(id);
	
%>
<div class="plan_tab_con01_hf">
	
					<div class="fr" style="margin-bottom:18px;">
                       <span class="fs14c73">已交易总额<em style="font-size:20px; color:#186ea7;"><%=Formater.formatAmount(yjyMoney) %></em>元</span> 
                       <span class="fs14c73">待交易总额<em style="font-size:20px; color:#186ea7;"><%=Formater.formatAmount(djyMoney) %></em>元</span>
                    </div>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    	<tbody>
                        	<tr class="leve_titbj_hf">
                            	<td width="232">债权买入者</td>
                                <td width="232" class="border_lr3">债权卖出者</td>
                                <td width="292" style="border-right:3px solid #fff;">交易金额</td>
                                <td width="">交易时间</td>
                            </tr>
                            <%if (creditOutRecodes != null) {for (CreditOutRecode creditOutRecode : creditOutRecodes) {if (creditOutRecode == null) {continue;}%>
                            <tr>
                            	<td>
								<%StringHelper.filterHTML(out, (creditOutRecode.creditBuy.length()>=6?creditOutRecode.creditBuy.substring(0,4):creditOutRecode.creditBuy.substring(0,1))+"***");%>
								</td>
                                <td><%StringHelper.filterHTML(out, (creditOutRecode.creditSell.length()>=6?creditOutRecode.creditSell.substring(0,4):creditOutRecode.creditSell.substring(0,1))+"***");%></td>
                                <td><%=creditOutRecode.sellMoney %><em style="font-size:12px; color:#737373;">元</em></td>
                                <td><%=DateParser.format(creditOutRecode.sellTime) %></td>
                            </tr>
                            <%}}%>
                        </tbody>
                    </table>
	
</div>
  
</body>
</html>