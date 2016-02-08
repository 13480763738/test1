<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xyhk"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserRZInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
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
<style type="text/css">
body,dl,dd,ul,p,pre,h1,h2,h3,h4,h5,h6,button,input,form,figure{margin:0; padding:0;}
body{font-size:12px;font-family:"微软雅黑";-webkit-text-size-adjust:none; color:#737373;}
/*ol{margin-top:0;margin-bottom:0;}*/
ul,input,button{padding:0;}
table{border-collapse:collapse;}
ul, ol, li,submit{list-style:none;border:none}
img{border:none;}
a{text-decoration:none; outline:none;}
input{ outline:none; font-family:微软雅黑;}
em,h1,h2,h3,h4,h5,h6{ font-weight:normal; font-size:14px; font-style:normal;}
html, div, p, h1, h2, h3, h4, h5, h6, blockquote,
ol, ul, li, dl, dt, dd, 
form, fieldset, legend, button, input, textarea, 
pre, code, th, td{margin:0;padding:0;}
a:hover{ text-decoration:none;color:#0FA5F5;}
/* HTML5 tag */
article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block;}
button,input,select, textarea{font-size:100%;}
input, img, select {vertical-align:middle; border:0;font-family:"微软雅黑";} 
img {
    display: block;
}
button, dd, div, dl, dt, form, img, input, li, ol, p, td, th, ul {
    margin: 0px;
    padding: 0px;
    border: 0px none;
}
/* clear float */
.clearfix:after{clear:both;display:block;visibility:hidden;font-size:0;content:" ";height:0;}
.clearfix{zoom:1;}
.pt-list1{
	padding-top:30px;
}
.pt-list1 h3{
	font-size:18px;
	padding-bottom:20px;

}
.pt-list1 .xinxi{
	padding:30px 0 30px;
	line-height:30px;
}
.pt-list1 .xinxi .xx_left{
	display:inline-block;
	width:50%;
}
.pt-list1 p{
	line-height:28px; font-size:14px;
}
.pt-list1 .xinxi .xx_right{
	display:inline-block;
	width:49%;
	float:right;
}
.pt-list1 .xinxi .xx_right a{
	color:#176fa7;
}
.pt-list1 table{
	width:1170px;
	line-height:30px;
	font-size:14px;
}
</style>
</head>
<body>
<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestManage investManage = serviceSession.getService(InvestManage.class);
	InvestInfoManage creditManageDetail = serviceSession.getService(InvestInfoManage.class);
	
	CreditInfo creditInfo = investManage.get(id);
	UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
	CreditFiles creditFile = infoManage.getFile(creditInfo.userId);
	UserRZInfo[] userRZInfos = creditManageDetail.getRZInfo(id);
	CreditUserInfo userInfo = creditManageDetail.getUser(id,creditInfo.creditType);
	if(userInfo!=null){
    UserInfo uiInfo =  infoManage.getAgeSex(userInfo.card);
	
%>
	<ul class="pt-list1" style="display:block;">
				<h3>融资方信息</h3>
				<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
				<div class="xinxi">
					<div class="xx_left">
						<p>融资企业:&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.gsmc); %></p>
						<p>融资代理人:&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.userName); %></p>
						<p>企业地址:&nbsp;&nbsp;<% cityid=userInfo.city; %></p>
						<p>经营年限:&nbsp;&nbsp;<%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></p>
						<p>资金用途:&nbsp;&nbsp;<%StringHelper.filterHTML(out, creditInfo.purpose); %></p>
					</div>
					<div class="xx_right">
						<p>本次融资金额:&nbsp;&nbsp;<%=Formater.formatAmount(creditInfo.amount)%>元</p>
						<p>项目合同金额:&nbsp;&nbsp;<%=Formater.formatAmount(userInfo.htje)%>元</p>
						<p>债权收购方:&nbsp;&nbsp;<a href="<%=controller.getViewURI(request, Hzjg.class)%>"><%StringHelper.filterHTML(out, userInfo.dbgs); %></a></p>
					</div>
					<div class="clear"></div>
				</div>
				<h3>信用档案</h3>
				<%if(creditFile!=null){%>
				<table>
					<tbody>
						<tr>
							<td>申请借款（笔）:&nbsp;&nbsp;<%=creditFile.sqjkCount%></td>
							<td>成功借款（笔）: &nbsp;&nbsp;<%=creditFile.cgCount%></td>
							<td>待还借款（笔）: &nbsp;&nbsp;<%=creditFile.dhkCount%></td>
						</tr><tr>
						</tr>
						<tr>
	                            <td>提前还款（笔）:&nbsp;&nbsp;<%=creditFile.tqhkCount%></td>
	                            <td>准时还款（笔）:&nbsp;&nbsp;<%=creditFile.zshkCount%></td>
	                            <td>逾期还款（笔）:&nbsp;&nbsp;<%=creditFile.yzyqCount%></td>
	                        </tr>
	                        <%-- <tr>
	                            <td>还清借款（笔）</td>
	                            <td><%=creditFile.hqjkCount%></td>
	                            <td>待还本息（元）</td>
	                            <td><%=Formater.formatAmount(creditFile.dhbxMoney)%></td>
	                            <td>严重逾期（笔）</td>
	                            <td><%=creditFile.yzyqCount%></td>
	                        </tr> --%>
						</tbody><tbody>
				</tbody></table>
				<%}%>	
				<p style="color:#aaa; font-size:12px; line-height:24px; padding-top:15px;"><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息 100%无误。<br/>
借入者若长期逾期，其个人信息将被公布。</p>
		<%if(creditInfo.hkList!=null && creditInfo.hkList.size()>0){%>	
				<h3>还款方式</h3>
				<table style="border:1px;">
					<tr>
					<td style="width:100px;">还款日期</td>
					<td style="width:100px;">本金</td>
					<td style="width:100px;">利息</td>
					</tr>
					<%for(Xyhk hk : creditInfo.hkList){%>
					<tr>
						<td><%=TimestampParser.format(hk.hksj,"yyyy-MM-dd") %></td>
						<td><%=Formater.formatAmount(hk.bj) %></td>
						<td><%=Formater.formatAmount(hk.lx) %></td>
					</tr>
					<%}%>
				</table>
				<%}%>	 
			</ul>
	<%} %>
	<div class="clear"></div> 
</body>
</html>