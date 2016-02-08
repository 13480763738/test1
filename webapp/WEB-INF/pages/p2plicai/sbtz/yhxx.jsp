<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<%@include file="/WEB-INF/include/style.jsp"%>
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
				<div class="pub_title1_hf">
                	<span class="fl_hf fs18c51">用户信息</span><span class="fl_hf fs18c73 ml40_hf">ID:<%=userInfo.userId %></span>
           		</div>
				<div class="plan_tab_con_hf">
                	<table width="100%" cellspacing="0" border="0">
					<tbody><tr>
						<td width="67">用户名：</td>
						<td width="308"><span class="fl"><%StringHelper.filterHTML(out, userInfo.userName); %></span>
						<%
						 	if(uiInfo.sex == 1){
						%>
							<i class="ui_plan_bj ui_boy"></i>
						<%
						 }else{
						%>
							<i class="ui_plan_bj ui_girl"></i>
						<%} %>
						</td>
						<td width="80">公司行业</td>
						<td width="300"><%StringHelper.filterHTML(out, userInfo.companyType); %></td>
						<td width="80">收入范围</td>
						<td><%String b = userInfo.earnMoey;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></td>
					</tr>
					<tr>
						<td>年&nbsp;&nbsp;&nbsp;&nbsp;龄</td>
						<td><%=uiInfo.age%></td>
						<td>公司规模</td>
						<td><%String a = userInfo.companySize;if(a.equals("10")){a="10人以下";}else if(a.equals("500")){a="500人以上";}else{a+="人";}%><%=a%></td>
						<td>房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产</td>
						<td>
						<span class="mr15 fl"><i class="ui_plan_bj ui_<%=userInfo.isHouse.equals(IsHovestatus.Y) ? "house01": "house02"%>"></i>有</span>
						<span class="fl"><i class="ui_plan_bj ui_<%=userInfo.isHouse.equals(IsHovestatus.W) ? "house01": "house02"%>"></i>无</span></td>
					</tr>
					<tr>
						<td>学&nbsp;&nbsp;&nbsp;&nbsp;历</td>
						<td><%StringHelper.filterHTML(out, userInfo.xueli); %></td>
						<td>岗位职责</td>
						<td><%StringHelper.filterHTML(out, userInfo.gwzz); %></td>
						<td>房&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贷</td>
						<td>
						<span class="mr15 fl"><i class="ui_plan_bj ui_<%=userInfo.isHouseCredit.equals(IsHovestatus.Y) ? "house01": "house02"%>"></i>有</span>
						<span class="fl"><i class="ui_plan_bj ui_<%=userInfo.isHouseCredit.equals(IsHovestatus.W) ? "house01": "house02"%>"></i>无</span>
						</td>
					</tr>
					<tr>
						<td>学&nbsp;&nbsp;&nbsp;&nbsp;校</td>
						<td><%StringHelper.filterHTML(out, userInfo.university); %></td>
						<td>工作城市</td>
						<td id="gzcs"><% cityid=userInfo.city;%></td>
						<td>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产</td>
						<td>
						<span class="mr15 fl"><i class="ui_plan_bj ui_<%=userInfo.isCar.equals(IsHovestatus.Y) ? "house01": "house02"%>"></i>有</span>
						<span class="fl"><i class="ui_plan_bj ui_<%=userInfo.isCar.equals(IsHovestatus.W) ? "house01": "house02"%>"></i>无</span>
						</td>
					</tr>
					<tr>
						<td>婚&nbsp;&nbsp;&nbsp;&nbsp;姻</td>
						<td><%StringHelper.filterHTML(out, userInfo.hunyin.getName()); %></td>
						<td>工作时间</td>
						<td><%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></td>
						<td>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贷</td>
						<td>
						<span class="mr15 fl"><i class="ui_plan_bj ui_<%=userInfo.isCarCredit==IsHovestatus.Y ? "house01": "house02"%>"></i>有</span>
						<span class="fl"><i class="ui_plan_bj ui_<%=userInfo.isCarCredit==IsHovestatus.W ? "house01": "house02"%>"></i>无</span>
						</td>
					</tr>
					</tbody>
                	</table>
                </div>
	<%} %>
	
	<div class="pub_title1_hf">
                <span class="fl_hf fs18c51">信用档案</span> 
                <%if(creditInfo.companyStatus==null || !creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
                <span class="star star0<%=CreditLevel.getLevelId(creditFile.creditLevel)%>"><%} %></span>
            </div>
            
            <div class="plan_tab_con_hf">
            	<%
					if(creditFile!=null)
					{
				%>
					<table width="100%" cellspacing="0" border="0">
	                        <tbody><tr>
	                            <td width="119">申请借款（笔）</td>
	                            <td width="260"><%=creditFile.sqjkCount%></td>
	                            <td width="120">信用额度（元）</td>
	                            <td width="255"><%=Formater.formatAmount(creditFile.xyedMoney)%></td>
	                            <td width="122">逾期金额（元）</td>
	                            <td><%=creditFile.yqjeMoney == null? 0:Formater.formatAmount(creditFile.yqjeMoney)%></td>
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
	                        </tr>
	                    </tbody>
	                </table>
				<%} %>
             </div>
               <%if(creditInfo.companyStatus==null || !creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
                <div class="pub_title1_hf">
                	<span class="fl_hf fs18c51">审核状态</span>
                </div>
                <div class="plan_tab_con01_hf">
                	<table width="100%" cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                        <tr class="leve_titbj_hf">
                            <td width="330">审核项目</td>
                            <td width="330" class="border_lr3">状态</td>
                            <td width="362">通过日期</td>
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
								<td><%if(userRz.rzStatus.equals(AttestationState.YYZ)) {%><i class="ui_plan_bj ui_plan_right"></i><%} %></td>
								<td><%=DateParser.format(userRz.rzDate) %></td>
							</tr>
							<%} }%>
							<%
							if(creditInfo.creditType == CreditType.XYDB){ 
								String name= investManage.getJgName(id);
								if(!StringHelper.isEmpty(name)){%>
								<tr>
									<td>
										机构担保(<a target="_blank" href="<%=controller.getViewURI(request, Hzjg.class)%>" class="blue"><%StringHelper.filterHTML(out, name);%></a>)
									</td>
									<td><i class="ui_plan_bj ui_plan_right"></i></td>
									<td>--</td>
								</tr>
							<%	}}else if(creditInfo.creditType == CreditType.SDRZ){
								String name= investManage.getJgName(id);
								if(!StringHelper.isEmpty(name)){%>
								<tr>
									<td>
										实地认证(<a target="_blank" href="<%=controller.getViewURI(request, Hzjg.class)%>" class="blue"><%StringHelper.filterHTML(out, name);%></a>)
									</td>
									<td><i class="ui_plan_bj ui_plan_right"></i></td>
									<td>--</td>
								</tr>
								
							<%}} %>
                        
                        </tbody>
                    </table>
                    <p style="color:#aaa; font-size:12px; line-height:24px; padding-top:15px;"><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息 100%无误。<br/>
借入者若长期逾期，其个人信息将被公布。</p>
                </div>
                <div class="pub_title1_hf"><span class="fl_hf fs18c51">借款描述</span></div>
                <div class="plan_tab_con01_hf">
                	<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
                </div>
                
                <%} %>
                
                
  <%@include file="/WEB-INF/include/jquery.jsp" %>               
  <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>       
	<script type="text/javascript">
			$("#gzcs").html('<span style="padding-left:0px;">'+getctName('<%=cityid%>')+'</span>');
	</script>
</body>
</html>