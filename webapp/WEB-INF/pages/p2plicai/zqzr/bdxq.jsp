<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xyhk"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bfkgl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bxgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserRZInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentInfoManage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Zrjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Zqxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Hkjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Tbjl"%>
<html>
<head>
<%
String _TITLE_ = "债权转让 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
String cityid="";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
<style type="text/css">
	.pt-list1{
	padding-top:30px;
}
.pt-list1 h3{
	font-size:18px;
	padding-bottom:20px;

}
.pt-list1 p{
	line-height:28px;
	font-size:14px;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	CURRENT_SUB_CATEGORY = "ZQXQXQ";
	%>
	<div class="clear"></div>
	<div class="project-list">
	<%@include file="/WEB-INF/include/zqzr/header.jsp"%>
	<div class="center_box" style="background:#f1f3f5;">
    	<div class="center">
            <div class="plan_tab_hf">
				<ul>
					<li class="hover">标的详情</li>
<%-- 					<li><a href="<%=controller.getPagingItemURI(request, Bfkgl.class, id)%>">风控信息</a></li> --%>
					<li><a href="<%=controller.getPagingItemURI(request, Bxgzl.class, id)%>">相关资料</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Tbjl.class, id)%>">投标记录</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Hkjl.class, id)%>">还款记录</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Zqxx.class, id)%>">债权信息</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Zrjl.class, id)%>">转让记录</a></li>
				</ul>
            </div>
            
            <%
	            CreditAssignmentInfoManage creditManageDetail = serviceSession.getService(CreditAssignmentInfoManage.class);
				UserRZInfo[] userRZInfos = creditManageDetail.getRZInfo(IntegerParser.parse(request.getParameter("id")));
				UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
				CreditFiles creditFile = infoManage.getFile(caInfo.jkzId);
				
				InvestManage investManage = serviceSession.getService(InvestManage.class);
				CreditInfo creditInfo = investManage.get(caInfo.jkbId);
				
			%>
			<div class="clear"></div>
			<ul class="pt-list1">
                	<h3>项目概述</h3>
                	<p>1.项目类型：<%=creditInfo.creditType.getName() %></p>
                	<p>2.借款金额：<%=Formater.formatAmount(creditInfo.amount) %>元（RMB）</p>
                	<p>3.年化利率：<%=Formater.formatRate(creditInfo.rate,false)%>%</p>
                	<p>4.借款期限：<%=creditInfo.term%>
                	<%if(RepaymentPeriod.AYHK.name().equals(creditInfo.repaymentPeriod.name())){ %>个月
                	<%}else if(RepaymentPeriod.TB.name().equals(creditInfo.repaymentPeriod.name())){ %>天
                	<%}else{ %>秒<%} %>
                	</p>
                	<p>5.还款方式：<%=creditInfo.repaymentType.getName() %></p>
                	<p>6.借款用途：<%StringHelper.filterHTML(out, creditInfo.purpose); %></p>
                	<p>7.项目介绍：</p>
                	<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
            </ul>
            <div class="plan_content_hf">
           	<%if(jiudianSession==null||!jiudianSession.isAuthenticated()){%>
            	<div class="pub_nologin_hf">
                	<p>请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>"  style=" color:#186ea7;">登录</a>
                	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>"  style="color:#faaf00;">注册</a>后查看</p>
                </div>
                
			<%} else {
				CreditUserInfo userInfo = creditManageDetail.getUser(id,caInfo.creditType);
				if(userInfo!=null){			
					 UserInfo uiInfo =  infoManage.getAgeSex(userInfo.card);
					
			%>
			<%if((jiudianSession!=null && jiudianSession.isAuthenticated()) && (caInfo.companyStatus!=null && caInfo.companyStatus.equals(CompanyStatus.SYQYZ))){%>
				<div class="pub_title1_hf">
                	<span class="fl_hf fs18c51">融资方信息</span>
                </div>
			
				<div class="plan_tab_con01_hf">
                	<p><%StringHelper.filterHTML(out, caInfo.jkDesc); %></p>
                </div>
                
                <div class="plan_tab_con_hf">
                	<table width="100%" cellspacing="0" border="0">
						<tbody>
                        	<tr>
                            	<td width="75" style="text-align:right;"> 融资企业</td>
                                <td width="452"><span style="padding-left:20px;"><%StringHelper.filterHTML(out, userInfo.gsmc); %></span></td>
                                <td width="126" style="text-align:right;">本次融资金额</td>
                                <td><span style="padding-left:20px;"><%=Formater.formatAmount(caInfo.jkje)%>元</span></td>
                            </tr>
                            <tr>
                            	<td style="text-align:right;"> 融资代理人</td>
                                <td><span style="padding-left:20px;"><%StringHelper.filterHTML(out, userInfo.userName); %></span></td>
                                <td style="text-align:right;">项目合同金额</td>
                                <td><span style="padding-left:20px;"><%=Formater.formatAmount(userInfo.htje)%>元</span></td>
                            </tr>
                            <tr>
                            	<td style="text-align:right;"> 企业地址 </td>
                            	<td><span style="padding-left:20px;" id="gzcs"><% cityid=userInfo.city; %></span></td>
                                <td style="text-align:right;">债权收购方</td>
                                <td><span style="padding-left:20px;">
                                <a href="<%=controller.getViewURI(request, Hzjg.class)%>" target="_blank" style="color: #176fa7 !important;">
                                <%StringHelper.filterHTML(out, userInfo.dbgs); %></a>
                                </span></td>
                            </tr>
                            <tr>
                            	<td style="text-align:right;"> 经营年限 </td>
                                <td><span style="padding-left:20px;"><%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></span></td>
                                <td style="text-align:right;"></td>
                                <td><span style="padding-left:20px;"></span></td>
                            </tr>
                            <tr>
                            	<td style="text-align:right;">  资金用途 </td>
                                <td><span style="padding-left:20px;"><%StringHelper.filterHTML(out, caInfo.purpose); %></span></td>
                                <td style="text-align:right;"></td>
                                <td><span style="padding-left:20px;"></span></td>
                            </tr>
                        </tbody>
               		 </table>
                </div>
                
			<%}else{%>
				<div class="pub_title1_hf">
                	<span class="fl_hf fs18c51">用户信息</span><span class="fl_hf fs18c73 ml40_hf"></span>
           		</div>
				<div class="plan_tab_con_hf" style=" float:left;">
                	<table width="100%" cellspacing="0" border="0">
					<tbody><tr>
						<td width="67">用&nbsp;户&nbsp;名&nbsp;：</td>
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
						<td width="80">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别&nbsp;：</td>
						<td width="300"><%if(uiInfo.sex == 1){%>	男<%}else{%>女<%}%></td>
						<td width="80">年&nbsp;&nbsp;&nbsp;&nbsp;龄&nbsp;:</td>
						<td><%=uiInfo.age%></td>
					</tr>
					<tr>
						<td width="75">婚姻状况：</td>
						<td><%StringHelper.filterHTML(out, userInfo.hunyin.getName()); %></td>
						<td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业&nbsp;：</td>
						<td><%StringHelper.filterHTML(out, userInfo.gwzz); %></td>
						<td>月&nbsp;收&nbsp;入&nbsp;:</td>
						<td><%String b = userInfo.earnMoey;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></td>
					</tr>
					<tr>
						<td width="75">文化程度：</td>
						<td><%StringHelper.filterHTML(out, userInfo.xueli); %></td>
						<td>所在城市：</td>
						<td><span id="gzcs"><%cityid=userInfo.city;%></span></td>
					</tr>
					</tbody>
                	</table>
                </div>
                <%} %>
			<%}%>
		<%
		if(creditInfo.repaymentType.equals(RepaymentType.XYHK)){
			if(creditInfo.hkList!=null && creditInfo.hkList.size()>0){%>	
		<div class="pub_title1_hf">
             	<span class="fl_hf fs18c51">还款方式</span><span class="fl_hf fs18c73 ml40_hf"></span>
        </div>
		<div class="plan_tab_con_hf" style=" float:left;">
            <table width="100%" cellspacing="0" border="0">
			<tbody>
			<tr>
			<td style="width:100px;">还款时间</td>
			<td style="width:100px;">本金</td>
			<td style="width:100px;">利息</td>
			</tr>
			<%for(Xyhk hk : creditInfo.hkList){%>
			<tr>
				<td><%=TimestampParser.format(hk.hksj,"yyyy-MM-dd") %></td>
				<td><%=Formater.formatAmount(hk.bj) %></td>
				<td><%=Formater.formatAmount(hk.lx) %></td>
			</tr>
			<%} %>
			</tbody>
			</table>
        </div>
		<%}} %>	
			<div class="pub_title1_hf">
                <span class="fl_hf fs18c51">信用档案</span> 
                <%if(caInfo.companyStatus==null || !caInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
                <span class="star star0<%=CreditLevel.getLevelId(creditFile.creditLevel)%>"><%} %></span>
            </div>
            
            <div class="plan_tab_con_hf" style=" float:left;">
            	<%
					if(creditFile!=null)
					{
				%>
					<table width="100%" cellspacing="0" border="0">
	                        <tbody><tr>
	                            <td width="119">申请借款（笔）:</td>
	                            <td width="260"><%=creditFile.sqjkCount%></td>
	                            <td width="120">成功借款（笔）:</td>
	                            <td width="255"><%=creditFile.cgCount%></td>
	                            <td width="122">待还借款（笔）:</td>
	                            <td><%=creditFile.dhkCount%></td>
	                        </tr>
	                        <tr>
	                            <td>提前还款（笔）:</td>
	                            <td><%=creditFile.tqhkCount%></td>
	                            <td>准时还款（笔）:</td>
	                            <td><%=creditFile.zshkCount%></td>
	                            <td>逾期还款（笔）:</td>
	                            <td><%=creditFile.yzyqCount%></td>
	                        </tr>
	                       <%--  <tr>
	                            <td>还清借款（笔）</td>
	                            <td><%=creditFile.hqjkCount%></td>
	                            <td>待还本息（元）</td>
	                            <td><%=Formater.formatAmount(creditFile.dhbxMoney)%></td>
	                            <td>严重逾期（笔）</td>
	                            <td><%=creditFile.yzyqCount%></td>
	                        </tr> --%>
	                    </tbody>
	                </table>
				<%} %>
                	
             </div>
			<%} %>
                <div class="plan_tab_con01_hf">
                <p style="color:#aaa; font-size:12px; line-height:24px; padding-top:15px;">
                    <%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息 100%无误。<br/>
借入者若长期逾期，其个人信息将被公布。</p>
</div>
            </div>
        
    </div>
    </div>
<div id="info"></div>
<div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqzr.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
		<script type="text/javascript">
		var cs = getctName('<%StringHelper.filterHTML(out,cityid);%>').split(":");
			$("#gzcs").html(cs);
		</script>
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#zqSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>