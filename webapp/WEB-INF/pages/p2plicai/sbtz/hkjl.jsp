<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.AlsoMoney"%>
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
	AlsoMoney[] alsoMoneys = creditManagePayment.getAlso(id);
	BigDecimal yhMoney=new BigDecimal(0);
	BigDecimal whMoney=new BigDecimal(0);
	if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {
		if (alsoMoney == null) {continue;}
		if(alsoMoney.status == RepayStatus.YH){
			yhMoney = yhMoney.add(alsoMoney.yhbx);
		}else if(alsoMoney.status == RepayStatus.WH){
			whMoney = whMoney.add(alsoMoney.yhbx);
		}
		
	}}
%>
				<div class="plan_tab_con01_hf">
                	<div class="fr" style="margin-bottom:18px;">
                    	<span class="fs14c73">已还本息<em style="font-size:20px; color:#186ea7;"><%=yhMoney %></em>元
                    	</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs14c73">待还本息<em style="font-size:20px; color:#737373;"><%=whMoney %></em>元</span>
                    </div>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    	<tbody>
                        	<tr class="leve_titbj_hf">
                            	<td width="210">合约还款日期</td>
                                <td width="144" class="border_lr3">状态</td>
                                <td width="210">应还本息</td>
                                <td width="210" class="border_lr3">应付罚息</td>
                                <td>实际还款日期</td>
                            </tr>
                            <%
								if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {if (alsoMoney == null) {continue;}
							%>
                            <tr>
                            	<td><%=DateParser.format(alsoMoney.hyhkrq) %></td>
                                <td><%=alsoMoney.status.getName() %></td>
                                <td><%=alsoMoney.yhbx%><em style="font-size:12px; color:#737373;">元</em></td>
                                <td><%=alsoMoney.yffx %><em style="font-size:12px; color:#737373;">元</em></td>
                                <td><%=alsoMoney.sjhkTime==null?"--":DateParser.format(alsoMoney.sjhkTime) %></td>
                            </tr>
                            <%}}%>
                        </tbody>
                    </table>
                    
                </div>
  
</body>
</html>