<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.DateFormat"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xyhk"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
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
<%-- <%@include file="/WEB-INF/include/style.jsp"%> --%>
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
	line-height:28px;
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
.ui_plan_bj{background:url(../../../../images/financial05.png) no-repeat; display:block;}
.ui_plan_right{background-position:-327px -181px;;widht:30px;height:18px;}
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
                <ul class="pt-list1" style="font-size:14px;">
                	<h3>项目概述</h3>
                	<p>1.项目类型：<%=creditInfo.creditType.getName() %></p>
                	<p>2.借款金额：<%=Formater.formatAmount(creditInfo.amount) %>元（RMB）</p>
                	<p>3.年化利率：<%=Formater.formatRate(creditInfo.rate,false)%>%</p>
                	<p>4.借款期限：<%=creditInfo.term%>
                	<%if(creditInfo.repaymentPeriod.name().equals(RepaymentPeriod.AYHK.name())){ %>个月
                	<%}else if(RepaymentPeriod.TB.name().equals(creditInfo.repaymentPeriod.name())){ %>天
                	<%}else{ %>秒<%} %>
                	</p>
                	<p>5.还款方式：<%=creditInfo.repaymentType.getName() %></p>
                	<p>6.借款用途：<%StringHelper.filterHTML(out, creditInfo.purpose); %></p>
                	<p>7.项目介绍：</p>
                	<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
                </ul>
                <ul class="pt-list1" style="display:block;">
				<h3>用户信息</h3>
				<table>
					<tbody>
						<tr>
							<td>用&nbsp;户&nbsp;名&nbsp;&nbsp;:&nbsp;&nbsp;	<%StringHelper.filterHTML(out, userInfo.userName); %></td>
							<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：&nbsp;&nbsp;<%if(uiInfo.sex == 1){%>	男<%}else{%>女<%}%></td>
							<td>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;<%=uiInfo.age%></td>
							<td>婚姻状况:&nbsp;<%StringHelper.filterHTML(out, userInfo.hunyin.getName()); %></td>
						</tr><tr>
							<td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.gwzz); %></td>
						
							<td>月&nbsp;收&nbsp;入&nbsp;&nbsp;:&nbsp;&nbsp;<%String b = userInfo.earnMoey;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></td>
							
							<td>文化程度&nbsp;:&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.xueli); %></td>
							<td id="gzcs">所在城市&nbsp;:&nbsp;&nbsp;&nbsp;<% cityid=userInfo.city;%></td>
						</tr>
					
						<%-- <tr>
							<td>用户名：	<%StringHelper.filterHTML(out, userInfo.userName); %></td>
							<td><%if(uiInfo.sex == 1){%>	男<%}else{%>女<%}%></td>
							<td>公司行业&nbsp;&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.companyType); %></td>
							<td>收入范围&nbsp;&nbsp;&nbsp;&nbsp;<%String b = userInfo.earnMoey;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></td>
						</tr><tr>
						</tr><tr>
							<td>年&nbsp;&nbsp;&nbsp;&nbsp;龄&nbsp;&nbsp;&nbsp;&nbsp;<%=uiInfo.age%></td>
							<td>公司规模&nbsp;&nbsp;&nbsp;&nbsp;<%String a = userInfo.companySize;if(a.equals("10")){a="10人以下";}else if(a.equals("500")){a="500人以上";}else{a+="人";}%><%=a%></td>
							<td>房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产&nbsp;&nbsp;&nbsp;&nbsp;<%if(userInfo.isHouse.equals(IsHovestatus.Y)){%>有<%}if(userInfo.isHouse.equals(IsHovestatus.W)){%>无<%}%></td>
						</tr><tr>
						</tr><tr>
							<td>学&nbsp;&nbsp;&nbsp;&nbsp;历&nbsp;&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.xueli); %></td>
							<td>岗位职责&nbsp;&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.gwzz); %></td>
							<td>房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贷&nbsp;&nbsp;&nbsp;&nbsp;<%if(userInfo.isHouseCredit.equals(IsHovestatus.Y)){%>有<%}else if(userInfo.isHouseCredit.equals(IsHovestatus.W)){%>无<%}%></td>
						</tr><tr>
					</tr><tr>
							<td>学&nbsp;&nbsp;&nbsp;&nbsp;校&nbsp;&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.university); %></td>
							<td>工作城市&nbsp;&nbsp;&nbsp;&nbsp;<% cityid=userInfo.city;%></td>
							<td>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产&nbsp;&nbsp;&nbsp;&nbsp;<%if(userInfo.isCar.equals(IsHovestatus.Y)){%>有<%}else if(userInfo.isCar.equals(IsHovestatus.W)){%>无<%}%></td>
						</tr><tr>
					</tr><tr>
							<td>婚&nbsp;&nbsp;&nbsp;&nbsp;姻&nbsp;&nbsp;&nbsp;&nbsp;<%StringHelper.filterHTML(out, userInfo.hunyin.getName()); %></td>
							<td>工作时间&nbsp;&nbsp;&nbsp;&nbsp;<%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></td>
							<td>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贷&nbsp;&nbsp;&nbsp;&nbsp;<%if(userInfo.isCarCredit==IsHovestatus.Y){%>有<%}else if(userInfo.isCarCredit==IsHovestatus.W){%>无<%}%></td>
						</tr><tr>
					</tr> --%>
					</tbody><tbody>
				</tbody></table>
				<div class="clear"></div>
				
				<h3>信用档案</h3>
				<%if(creditFile!=null){%>
				<table>
					<tbody>
						<tr>
							 <td>申请借款（笔）:	&nbsp;&nbsp;<%=creditFile.sqjkCount%></td>
							 <td>成功借款（笔）: &nbsp;&nbsp;<%=creditFile.cgCount%></td>
							 <td>待还借款（笔）: &nbsp;&nbsp;<%=creditFile.dhkCount%></td>
						</tr><tr>
							 <td>提前还款（笔）:&nbsp;&nbsp; <%=creditFile.tqhkCount%></td>
							 <td>准时还款（笔）:&nbsp;&nbsp; <%=creditFile.zshkCount%></td>
							 <td>逾期还款（笔）:&nbsp;&nbsp; <%=creditFile.yzyqCount%></td>
						<tr>
					
						<%-- <tr>
							<td>申请借款（笔）	<%=creditFile.sqjkCount%></td>
							<td>信用额度（元）	<%=Formater.formatAmount(creditFile.xyedMoney)%></td>
							<td>逾期金额（元）	<%=creditFile.yqjeMoney == null? 0:Formater.formatAmount(creditFile.yqjeMoney)%></td>
						</tr><tr>
						</tr>
						<tr>
	                            <td>成功借款（笔）</td>
	                            <td><%=creditFile.cgCount%></td>
	                            <td>借款总额（元）</td>
	                            <td><%=Formater.formatAmount(creditFile.jkzeMoney)%></td>
	                            <td>逾期次数（次）</td>
	                            <td><%=creditFile.yqcsCount%></td>
	                        </tr>
	                        <tr>
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
				<%-- <%if(creditInfo.companyStatus==null || !creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
				<h3>审核状态</h3>
					<table>
					<tbody>
						<tr>
                            <td>审核项目</td>
                            <td>状态</td>
                            <td>通过日期</td>
                        </tr>
						<%
						if(userRZInfos!=null)
						{
							for(UserRZInfo userRz:userRZInfos)
							{
								if(userRz==null)
								{
									continue;
								}
							%>
							<tr>
								<td><%StringHelper.filterHTML(out, userRz.attestationType.getName()); %></td>
								<td><%if(userRz.rzStatus.equals(AttestationState.YYZ)) {%>
								<i class="ui_plan_bj ui_plan_right" style="width:30px;"></i><%} %>
								</td>
								<td><%=DateParser.format(userRz.rzDate) %></td>
							</tr>
						<%} }%>
						<%
							if(creditInfo.creditType == CreditType.XYDB){ 
								String name= investManage.getJgName(id);
								if(!StringHelper.isEmpty(name)){%>
						<tr>
							<td>机构担保(<a target="_blank" href="<%=controller.getViewURI(request, Hzjg.class)%>" class="blue"><%StringHelper.filterHTML(out, name);%></a>)</td>
							<td>
								<i class="ui_plan_bj ui_plan_right" style="width:30px;">
							</td>
							<td>--</td>
						</tr><tr>
						</tr>
						<%	}}else if(creditInfo.creditType == CreditType.SDRZ){
								String name= investManage.getJgName(id);
								if(!StringHelper.isEmpty(name)){%>
						<tr>
							<td>实地认证(<a target="_blank" href="<%=controller.getViewURI(request, Hzjg.class)%>" class="blue"><%StringHelper.filterHTML(out, name);%></a>)</td>
							<td><i class="ui_plan_bj ui_plan_right" style="width:30px;"></i></td>
							<td>--</td>
						</tr><tr>
						</tr>
						<%}} %>				
						</tbody><tbody>
				</tbody></table>
				<%}%> --%>
				<p style="color:#aaa; font-size:12px; line-height:24px; padding-top:15px;"><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息 100%无误。<br/>
借入者若长期逾期，其个人信息将被公布。</p>
			</ul>
			<%if(creditInfo.hkList!=null && creditInfo.hkList.size()>0){%>
			<ul class="pt-list1">
				<h3>还款方式</h3>
				<table style="border:1px;">
					<tr>
					<td style="width:100px;">还款日期</td>
					<td style="width:100px;">本金</td>
					<td style="width:100px;">利息</td>
					</tr>
					<%for(Xyhk hk : creditInfo.hkList){%>
					<tr>
						<td><%=TimestampParser.format(hk.hksj,"yyyy-MM-dd")%></td>
						<td><%=Formater.formatAmount(hk.bj) %></td>
						<td><%=Formater.formatAmount(hk.lx) %></td>
					</tr>
					<%}%>
				</table>
			</ul>
			<%}%>
	<%} %>
                                
  <%@include file="/WEB-INF/include/jquery.jsp" %>               
  <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>       
	<script type="text/javascript">
		var s = getctName('<%=cityid%>').split(":");
		$("#gzcs").html('所在城市：&nbsp;<span style="padding-left:0px;">'+s+'</span>');
	</script>
	<div class="clear"></div> 
</body>
</html>