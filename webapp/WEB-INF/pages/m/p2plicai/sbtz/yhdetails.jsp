<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditUserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserRZInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "标的详情";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%
	String cityid="";
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestManage investManage = serviceSession.getService(InvestManage.class);
	InvestInfoManage creditManageDetail = serviceSession.getService(InvestInfoManage.class);
	
	CreditInfo creditInfo = investManage.get(id);
	UserInfoManage infoManage =serviceSession.getService(UserInfoManage.class);
	CreditFiles creditFile = infoManage.getFile(creditInfo.userId);
	UserRZInfo[] userRZInfos = creditManageDetail.getRZInfo(id);
	CreditUserInfo userInfo = creditManageDetail.getUser(id,creditInfo.creditType);
	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<div data-role="content" class="qcontent">
			<div class="bdxq_box">
				<%
					if(userInfo!=null){
						UserInfo uiInfo =  infoManage.getAgeSex(userInfo.card);
				%>
				<div class="bdxq_tit">用户信息</div>
				<div class="lctyxq_box" style="border-bottom: none;">
					<ul>
						<li><div class="lctyxq_tit1">
								用<span style="padding: 0px 0.7rem;">户</span>名
							</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.userName); %></div></li>
						<li><div class="lctyxq_tit1">
								年<span style="padding-left: 3rem;">龄</span>
							</div>
							<div class="lctyxq_tit2"><%=uiInfo.age%></div></li>
						<li><div class="lctyxq_tit1">
								学<span style="padding-left: 3rem;">历</span>
							</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.xueli); %></div></li>
						<li><div class="lctyxq_tit1">
								学<span style="padding-left: 3rem;">校</span>
							</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.university); %></div></li>
						<li><div class="lctyxq_tit1">
								婚<span style="padding-left: 3rem;">姻</span>
							</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.hunyin.getName()); %></div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">公司行业</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.companyType); %></div></li>
						<li><div class="lctyxq_tit1">公司规模</div>
							<div class="lctyxq_tit2"><%String a = userInfo.companySize;if(a.equals("10")){a="10人以下";}else if(a.equals("500")){a="500人以上";}else{a+="人";}%><%=a%></div></li>
						<li><div class="lctyxq_tit1">岗位职责</div>
							<div class="lctyxq_tit2"><%StringHelper.filterHTML(out, userInfo.gwzz); %></div></li>
						<li><div class="lctyxq_tit1">工作城市</div>
							<div class="lctyxq_tit2" id="gzcs"><% cityid=userInfo.city;%></div></li>
						<li><div class="lctyxq_tit1">工作时间</div>
							<div class="lctyxq_tit2"><%String c = userInfo.workAge;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">收入范围</div>
							<div class="lctyxq_tit2"><%String b = userInfo.earnMoey;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></div></li>
						<li><div class="lctyxq_tit1">
								房<span style="padding-left: 3rem;">产</span>
							</div>
							<div class="lctyxq_tit2">
								<span class="have <%=userInfo.isHouse.equals(IsHovestatus.Y) ? "": "none"%>">有</span>
								<span class="have <%=userInfo.isHouse.equals(IsHovestatus.W) ? "": "none"%>">无</span>
							</div></li>
						<li><div class="lctyxq_tit1">
								房<span style="padding-left: 3rem;">贷</span>
							</div>
							<div class="lctyxq_tit2">
								<span class="have <%=userInfo.isHouseCredit.equals(IsHovestatus.Y) ? "": "none"%>">有
								</span><span class="have <%=userInfo.isHouseCredit.equals(IsHovestatus.W) ? "": "none"%>">无</span>
							</div></li>
						<li><div class="lctyxq_tit1">
								车<span style="padding-left: 3rem;">产</span>
							</div>
							<div class="lctyxq_tit2">
								<span class="have <%=userInfo.isCar.equals(IsHovestatus.Y) ? "": "none"%>">有</span>
								<span class="have <%=userInfo.isCar.equals(IsHovestatus.W) ? "": "none"%>">无</span>
							</div></li>
						<li><div class="lctyxq_tit1">
								车<span style="padding-left: 3rem;">贷</span>
							</div>
							<div class="lctyxq_tit2">
								<span class="have <%=userInfo.isCarCredit==IsHovestatus.Y ? "": "none"%>">有</span>
								<span class="have <%=userInfo.isCarCredit==IsHovestatus.W ? "": "none"%>">无</span>
							</div></li>
					</ul>
				</div>
				<%} %>
				<div class="bdxq_tit">信用档案</div>
				<%
					if(creditFile!=null)
					{
				%>
				<div class="lctyxq_box" style="border-bottom: none;">
					<ul>
						<li><div class="lctyxq_tit1">申请借款</div>
							<div class="lctyxq_tit2"><%=creditFile.sqjkCount%>笔</div></li>
						<li><div class="lctyxq_tit1">成功借款</div>
							<div class="lctyxq_tit2"><%=creditFile.cgCount%>笔</div></li>
						<li><div class="lctyxq_tit1">还清借款</div>
							<div class="lctyxq_tit2"><%=creditFile.hqjkCount%>笔</div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">信用额度</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.xyedMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">借款总额</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.jkzeMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">待还本息</div>
							<div class="lctyxq_tit2"><%=Formater.formatAmount(creditFile.dhbxMoney)%>元</div></li>
						<li><div class="lctyxq_tit1"></div>
							<div class="lctyxq_tit2">
								<em></em>
							</div></li>
						<li><div class="lctyxq_tit1">逾期金额</div>
							<div class="lctyxq_tit2"><%=creditFile.yqjeMoney == null? 0:Formater.formatAmount(creditFile.yqjeMoney)%>元</div></li>
						<li><div class="lctyxq_tit1">逾期次数</div>
							<div class="lctyxq_tit2"><%=creditFile.yqcsCount%>次</div></li>
						<li><div class="lctyxq_tit1">严重逾期</div>
							<div class="lctyxq_tit2"><%=creditFile.yzyqCount%>笔</div></li>
					</ul>
				</div>
				<%} %>
				<div class="bdxq_tit">审核状态</div>
				<div class="shzt_box">
					<ul>
						<li class="tit">
							<div class="shzt_div">审核项目</div>
							<div class="shzt_div">状态</div>
							<div class="shzt_div">通过日期</div>
						</li>
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
						<li>
							<div class="shzt_div"><%StringHelper.filterHTML(out, userRz.attestationType.getName()); %></div>
							<div class="shzt_div">
							<%if(userRz.rzStatus.equals(AttestationState.YYZ)) {%><span></span><%} %>
							</div>
							<div class="shzt_div"><%=DateParser.format(userRz.rzDate) %></div>
						</li>
						<%} }%>
							<%
							if(creditInfo.creditType == CreditType.XYDB){ 
								String name= investManage.getJgName(id);
								if(!StringHelper.isEmpty(name)){%>
								<li>
									<div class="shzt_div">机构担保(<%StringHelper.filterHTML(out, name);%>)</div>
									<div class="shzt_div">
									<span></span>
									</div>
									<div class="shzt_div">--</div>
								</li>
						<%	}}else if(creditInfo.creditType == CreditType.SDRZ){
						String name= investManage.getJgName(id);
						if(!StringHelper.isEmpty(name)){%>
						<li>
							<div class="shzt_div">实地认证(<%StringHelper.filterHTML(out, name);%>)</div>
							<div class="shzt_div">
							<span></span>
							</div>
							<div class="shzt_div">--</div>
						</li>
						<%}} %>
						
					</ul>
				</div>
				<div class="bdxq_tit">借款描述</div>
				<div class="jkms_box">
					<p><%StringHelper.filterHTML(out, creditInfo.goalDesc); %></p>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>       
	<script type="text/javascript">
			$("#gzcs").html('<span style="padding-left:0px;">'+getctName('<%=cityid%>')+'</span>');
	</script>
</body>
</html>