<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.kxt.Zrjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.kxt.Zqxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.kxt.Hkjl"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Tbjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Xgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Yhxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Rzfxx"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditFiles"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="http://<%configureProvider.format(out,SystemVariable.SITE_DOMAIN);%>/favicon.ico"> 
<%
String _TITLE_ = "麒麟通宝---中国领先的供应链投融资服务专家。";
String _KEYWORDS_ = "麒麟通宝，旗丰集团，P2P网络借贷，互联网金融，供应链金融，供应链投融资平台，p2p网贷,网贷,网贷平台,p2p网贷平台,投资理财,P2P平台,麒麟通宝P2P网络借贷平台，kylintb.com";
String _DESCRIPTION_ = "麒麟通宝是旗丰集团倾力打造的P2P网贷平台，提供优质项目融资及P2P无忧理财服务，低风险、高收益、100元起投，是国内领先的供应链投融资服务专家。咨询热线：4008098122";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%> 
<meta http-equiv="Cache-Control" content="no-transform " />
<meta name="baidu-site-verification" content="NKKzOEFKOD" />
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" itemprop="description" content="<%=_DESCRIPTION_ %>">
<meta itemprop="name" content="<%=_TITLE_ %>">
<meta itemprop="image" content="http://www.jiudian.com/images/new_images/logo.png">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
 <style>
 .i-t-wx { background-position: -29px 0px;}
 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
 </style>
</head>
<%
InvestManage investManage = serviceSession.getService(InvestManage.class);
int id = IntegerParser.parse(request.getParameter("id"));
CreditInfo creditInfo = investManage.get(id);
if(creditInfo==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND );
	return;
}
int fs=0;
BigDecimal mfjg=creditInfo.perAmount;
BigDecimal zxMoney = new BigDecimal(0);
BigDecimal syfs = new BigDecimal(0);

BigDecimal ytfs = investManage.getTbcont(id);

BigDecimal tbxe = creditInfo.tbxe;
BigDecimal xefs = tbxe.divide(mfjg, 0, BigDecimal.ROUND_DOWN);


if(mfjg != null){
	syfs = creditInfo.remainAmount.divide(mfjg);
}

long _start_time = creditInfo.shTime.getTime();
if(creditInfo.fbTime!=null){
	_start_time = creditInfo.fbTime.getTime();
}
long mb_hm=1000*3600*24;
long mb_time =	(creditInfo.mbTime==null?0:creditInfo.mbTime.getTime())-_start_time;
long mb_day=mb_time/mb_hm;
long mb_hour=(mb_time-mb_day*mb_hm)/(1000*3600);
long mb_min=(mb_time-mb_day*mb_hm-mb_hour*1000*3600)/(1000*60);
long mb_ss=(mb_time-mb_day*mb_hm-mb_hour*1000*3600-mb_min*1000*60)/(1000);

long _now = Calendar.getInstance().getTimeInMillis();
long fb_deta =  _start_time-_now;if(fb_deta<0)fb_deta=0;
long xs_deta = _start_time+(60*creditInfo.xsxs+creditInfo.xsfz)*60*1000 - _now;
if(xs_deta<0)xs_deta=0;
%>
<body> 
<script type="text/javascript">

	function time(timeid,sendTime,sclearTime) {
		var endTime = parseInt(sendTime);
		var leftsecond = parseInt(endTime / 1000);
		var day = Math.floor(leftsecond / (60 * 60 * 24)) < 0 ? 0 : Math
				.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0
				: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math
				.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0
				: Math
						.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600
				- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60
				* 60 - hour * 3600 - minute * 60);
		hour = hour + day*24;
		
		if (hour < 10) {
			hour = "0" + hour;
		}
		
		if (minute < 10) {
			minute = "0" + minute;
		}
		
		if (second < 10) {
			second = "0" + second;
		}
		
		$("span[name='"+timeid+"hour']").html(hour);
		$("span[name='"+timeid+"minute']").html(minute);
		$("span[name='"+timeid+"second']").html(second);
		if (leftsecond <= 0) {
			if(timeid == 'djs'){
				$("#jqqdButton").hide();
				$("#tbButton").show();
			}
			clearInterval(sclearTime);
		}
	}
</script>    
<%@include file="/WEB-INF/include/header.jsp"%> 
 <!--第一屏-->
 <div class="clear"></div>
   <div class="project-list pt20">
<div class="sub-nav" sup="Project">
    <div class="sub-nav-inner">
        <%@include file="/WEB-INF/include/list_header.jsp" %>
    </div>
</div>
 <!--第二屏-->
	<div class="plan_given_hf">
        <ul class="plan_given_left" style="position:relative;">
            <li>
            	<div class="pr80_hf">
					<span class="spanfs36" style=" height:56px; display:block; width:800px;"><%StringHelper.filterHTML(out, creditInfo.title);%></span>     		
				</div>
				<div class="pr100_hf">
					<em class="emfs18">¥</em>
					<span class="spanfs36"><%=Formater.formatAmount(creditInfo.amount)%></span>
            		<input type="hidden" id="mfMoney" value="100.00">
            		<br/>标的总额（元）
				</div>
				<div class="pr80_hf">
					<span class="spanfs36"><%=Formater.formatRate(creditInfo.rate,false)%></span>
            		<em class="emfs18">%</em><br/>年利率
				</div>
				<div class="pr30_hf" style="margin-right:0px;">
					<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
					<span class="spanfs36"><%=creditInfo.term%></span>
					<em class="emfs18" style="font-family:微软雅黑;">个月</em>
					<%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%>
					<span class="spanfs36"><%=creditInfo.term%></span>
					<em class="emfs18" style="font-family:微软雅黑;">天</em>
					<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
					<span class="spanfs36">满额即还</span>
					<em class="emfs18" style="font-family:微软雅黑;"></em>
					<%}%>
					   <br/>还款期限
				</div>
				<div class="clear"></div>
			</li>
            <li>
                <div class="list01_hf">保障方式</div>
                <div class="list02_hf">
					<em>本息</em>
					<span id="span1" class="bg1 allbg"></span>
					<div id="bj1" class="allbj" style="display:none;padding-left:10px;">
                          <span class="bj_span1" style="margin-left: -9px;"></span>
                          <span class="bj_span2">详情请参见<a target="_blank" style="color:#176fa7;padding:0 5px" href="<%=controller.getPagingItemURI(request, Term.class, TermType.BXBZ.name())%>">本息保障计划</a></span>
                     </div>
                 </div>
                 <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
                 <div class="list01_hf">提前还款费率 </div>
	             <div class="list01_hf" style="padding-left:13px;"><%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES)))%></div>
				 <%}%>
				 <div class="clear"></div>
		    </li>
            <li>
                	<div class="list01_hf">还款方式 </div>
                    <div class="list02_hf"><em><%=creditInfo.repaymentType.getName()%></em>
                    <span id="span2" class="bg1 allbg"></span>
						<div id="bj2" style="display: none;" class="allbj">
							<span class="bj_span1"></span>
							<span class="bj_span2">
								<%if(RepaymentType.MYHKDQHB2.equals(creditInfo.repaymentType)){ %>每月还息到期还本 还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时每期还息，最后一期还当期利息和全部本金。<%} %>
<%-- 								<%if(RepaymentType.DQYCXFQ.equals(creditInfo.repaymentType)){ %>到期一次性偿还本金和利息。<%} %> --%>
								<%if(RepaymentType.XYHK.equals(creditInfo.repaymentType)){ %>协议还款是平台为保障投资人收益采用的一种还款方式。协议还款是指依据投融资双方按照约定的还款计划进行还款，还款计划详情请查看标的详情。<%} %>
							</span>
						</div>
                    </div>
                   <%-- <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
                    <div class="list01_hf">月还本息（元）</div><div class="list01_hf"><span><%=creditInfo.yhkAmount%></span></div>
                    <%}%> --%>
					<div class="clear"></div>
            </li>
            <li>
            <%
            		String _jllx = "",_jlms="";
  	            	if(creditInfo.jllx.equals(RewardType.XSJ)){ _jllx="tgjiang01";_jlms="筹款开始后限定时间内投资的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。";}
  	            	if(creditInfo.jllx.equals(RewardType.MTC)){ _jllx="tgjiang02";_jlms="筹款开始后限定时间内满标，放款后该标的所有投资用户另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
  	            	if(creditInfo.jllx.equals(RewardType.TCJ)){ _jllx="tgjiang03";_jlms="筹款开始后第一位投资用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";}
  	            	if(creditInfo.jllx.equals(RewardType.XYJ)){ _jllx="tgjiang04";_jlms="放款后，随机抽取该标的幸运投资用户，另享"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
  	            	if(creditInfo.jllx.equals(RewardType.THJ)){ _jllx="tgjiang05";_jlms="该标的累计投资额度最高的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。";}
  	            	if(creditInfo.jllx.equals(RewardType.XRJ)){ _jllx="tgjiang06";_jlms="首次在平台投资的用户，放款后另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";}
  	            	if(creditInfo.jllx.equals(RewardType.PHJ)){ _jllx="tgjiang07";_jlms="放款后，该标的所有投资用户另享年化"+Formater.formatRate(creditInfo.jlll)+"投标奖励，奖励由平台分期发放。";}
  	            	if(creditInfo.jllx.equals(RewardType.JBJ)){ _jllx="tgjiang08";_jlms="若当次投资为您在平台投资的第"+creditInfo.xsxs+"~"+creditInfo.xsfz+"次，放款后另享年化"+Formater.formatRate(creditInfo.jlll, false)+"%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。";}
  	            	if(!_jllx.isEmpty())out.print("<span class=\"tgjiang "+_jllx+"\"></span>");
            	%>
            	<div class="list01_hf">投标限额</div>
            	<div class="list02_hf"><%if(xefs.intValue() >0){%><%=xefs.multiply(mfjg) %><%}else{%>不限<%}%></div>
					<div class="list01_hf">投标奖励</div>
                    <div class="list01_hf" style="margin-right:0px; position:relative;">
                    	<span class="fl">
                    	<em class="orange fl" style="font-size:24px;padding-left:42px; height:45px;"><%if(!creditInfo.jllx.equals(RewardType.WJL)){%>
						<%=Formater.formatRate(creditInfo.jlll)%>
						<%}%></em><%StringHelper.filterHTML(out, creditInfo.jllx.getName());%></span>
                    	<%if(!creditInfo.jllx.equals(RewardType.WJL)){%><span class="bg1 allbg"></span><%}%>
					<div class="allbj" style="top:-2px;left:170px; display:none;">
                          <span class="bj_span1" style="margin-left: -14px;"></span>
                          <span class="bj_span2" style="margin-top: -23px;"><%=_jlms%></a></span>
                     </div>
                      </div>
					  <div class="clear"></div>
		     </li>
				<%if (creditInfo.status == CreditStatus.TBZ) {%>
				<li><div class="list01_hf">投标进度</div>
                	<div class="list02_hf">
                        <div class="progress_bar_bg_hf">
                            <div style="width: <%=creditInfo.progress%>%;" class="progress_bar_con_hf"></div>
                        </div>
                        <div class="percentage_hf"><%=creditInfo.progress%>%</div>
                     </div>
                     <div style="color:#aaa; font-size:12px;">
                     <%
						if(creditInfo.jsTime != null){
							creditInfo.jsTime.setHours(24);
							creditInfo.jsTime.setMinutes(59);
							creditInfo.jsTime.setSeconds(59);
							long hm=1000*3600*24;
							long time =	creditInfo.jsTime.getTime()-System.currentTimeMillis();
							
							long day=(time/hm);
							long hour=((time-day*hm)/(1000*3600));
							long min=((time-day*hm-hour*1000*3600)/(1000*60));
						%>
						剩余时间
						<em class="fs18c51 fv"><%=day%></em>天<em class="fs18c51 fv"><%=hour%></em>时<em class="fs18c51 fv"><%=min%></em>分
					<%}%>
					 </div>
						<div class="clear"></div>
                </li>
                <%}%>
				<div class="clear"></div>
			</ul>
			<div class="plan_given_right" style="margin-top:30px;">
			 <form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.TB_SBTZ);%>">
				<input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQTBZ);%>"/>
		<%if (creditInfo.status == CreditStatus.TBZ) {InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);%>
			<%if(jiudianSession!=null && jiudianSession.isAuthenticated()){
				UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
				UserInfo userInfo= userInfoManage.search();
				String isYuqi =  userInfoManage.isYuqi();		
			%>
				<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
				<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
				<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.kyMoney%>">
				<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
				<input type="hidden" name="syfs" id="syfs" value="<%=syfs%>">
				<div class="pg-right-top">
				  <input type="hidden" id="_hkfs" value="<%=creditInfo.repaymentType.name()%>"/>
				  <input type="hidden" id="_jkzq" value="<%=creditInfo.creditCycle.name()%>"/>
                  <input type="hidden" id="_nll" value="<%=creditInfo.rate%>"/>
                  <input type="hidden" id="_hkqs" value="<%=creditInfo.term%>"/>
                  <input type="hidden" id="_jlll" value="<%=creditInfo.jlll.doubleValue()%>"/>
					<ul>
						<li>
							<p>剩余金额</p>
							<span class="">每份<em>100</em>元</span>
							<div class="clear"></div>
						</li>
						<li>
							<p class="f30">¥<%=Formater.formatAmount(creditInfo.remainAmount)%></p>
							 <%BigDecimal sjgmfs=new BigDecimal(0);
		                    	if(userInfo.kyMoney.compareTo(creditInfo.remainAmount)>0){
									sjgmfs = syfs;
									if(xefs.intValue() >0){
										if(ytfs.compareTo(xefs)>=0){
											sjgmfs = new BigDecimal("0");
										}else{
											if(sjgmfs.compareTo(xefs)>0){
												sjgmfs = xefs.subtract(ytfs);
											}
										}
									}
								}else{
									sjgmfs = userInfo.kyMoney.divide(mfjg, 0, BigDecimal.ROUND_DOWN);
									if(xefs.intValue() >0){
										if(ytfs.compareTo(xefs)>=0){
											sjgmfs = new BigDecimal("0");
										}else{
											if(sjgmfs.compareTo(xefs)>0){
												sjgmfs = xefs.subtract(ytfs);
											}
										}
									}
								}%>
							<span style="padding-top:10px;">(<em><%=syfs.intValue()%></em>)份</span>
							<div class="clear"></div>
						</li>
						<li>
							<p>可用金额&nbsp<em><%=Formater.formatAmount(userInfo.kyMoney)%></em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>(<%=sjgmfs%>)份</em></p>
							<span><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" style="color:#fadc00">充值</a></span>
							<div class="clear"></div>
						</li>
						<li>
							<a class="btn1 btna" href="javascript:void(0)">-</a>
							<input name="amount" maxlength="10" type="text" class="text_input_hf" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)" value="1"/>
							<a class="btn2 btna" href="javascript:void(0)">+</a>
						</li>
						<li>
							<p style="padding-right:15px">预计收益</p>
							<p><em id="_yjsy">0.00 </em>元  +  奖<em id="_yjjl">0.00 </em>元</p>
							<div class="clear"></div>
						</li>
					<ul>
				</div>
				<div class="pg-right-bottom">
					<input type="button" id="tbButton" fromname="form1" class="sumbitForme" <%if(fb_deta>0){ %>style="display:none"<%}%> value="投标"/>
				</div>
				<%}else{ %>
					<div class="pg-right-top" style="height:80px;">
					<ul >
						<li>
							<p>剩余金额</p>
							<span class="">每份<em>100</em>元</span>
							<div class="clear"></div>
						</li>
						<li>
							<p class="f30">¥<%=creditInfo.remainAmount%></p>
							<span style="padding-top:10px;">(<em><%=syfs.intValue()%></em>)份</span>
							<div class="clear"></div>
						</li>
						<div class="clear"></div>
					</ul>
					</div>
					<div class="fs18c73" style="background: #f2f3f5 none repeat scroll 0 0;height:100px;text-align: center;line-height: 42px;padding-top:12px;">请
	                <a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" style=" color:#186ea7; padding:0 5px;">登录</a>或
	                <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="color:#faaf00;padding:0 5px;">注册</a>
	                <div class="dao_time" style=" height:30px;  ">
	            	<em class="start_clock">距离开始
	<!--             	</em><span>0</span><em>天 -->
	            	</em>
	            	<span name="djshour">00</span><em>时</em>
	            	<span name="djsminute">00</span><em>分</em>
	            	<span name="djssecond">00</span><em>秒</em>
	            </div>
	                
	                </div>
	                
				 </form>
				<%}}else if (creditInfo.status.equals(CreditStatus.YFK)) {%>
					<div class="plan_given_right">
					<!--还款中-->
					<div class="manbiao"> 
						<p class="title">还款中</p>
						<div class="m_bottom">
							<p class="bx">待还本息（元）   <span> ¥ <%=Formater.formatAmount(creditInfo.toRepaymentAmount)%></span></p>
							<p class="qs">剩余期数    <span><%=creditInfo.remainTerms%></span> 期</p>
							<p>下一合约还款日     <span><%=Formater.formatDate(creditInfo.nextRepayDate)%></span></p>
						</div>
					</div>
				</div>
				<%}else if (creditInfo.status.equals(CreditStatus.YMB)) {%>
					<div class="manbiao">
					<p class="title">己满标</p>
					<p class="sm"></p>
					<%
						InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
						TenderRecord[] tenderRecords = creditManagePayment.getRecord(IntegerParser.parse(request.getParameter("id")));
					%>
					<p class="m_time f16">满标用时<em class="f16"><%=mb_hour+24*mb_day %>时<%=mb_min %>分<%=mb_ss %>秒</em></p>
					<p class="m_num f16">加入人次<em class="f16"><%=tenderRecords == null ?0 :tenderRecords.length %></em></p>
				</div>
				<%}else if (creditInfo.status == CreditStatus.YJQ) {%>
					<div class="manbiao">
					<p class="title">已还清</p>
					<p class="sm">还清时间</p>
					<p class="m_time f16"><%=creditInfo.status == CreditStatus.YDF?DateParser.format(creditInfo.dfTime):DateParser.format(creditInfo.payedDate)%></p>
				</div>
				<%} else if(creditInfo.status == CreditStatus.YDF){%>
					<div class="manbiao">
					<p class="title">已垫付</p>
					<p class="sm">垫付时间</p>
					<p class="m_time f16"><%=creditInfo.status == CreditStatus.YDF?DateParser.format(creditInfo.dfTime):DateParser.format(creditInfo.payedDate)%></p>
				</div>
				<%}else if (creditInfo.status.equals(CreditStatus.LB)) {%>
					<div class="manbiao">
					<p class="title">已流标</p>
					<p class="sm">亲，加油！</p>
				</div>
				<%}%>
			</div>
			<%if (creditInfo.status == CreditStatus.TBZ&&fb_deta>0) { %>
        	<div class="daojishi">
	        
        	</div>
	         <script type="text/javascript">
	         		tempendTimettdjs= parseInt(<%=fb_deta%>);
			       	tempnamettdjs = "djs";
			       	sclearTimettdjs = setInterval(function() {
			       		tempendTimettdjs = tempendTimettdjs - 1000;
			       		time(tempnamettdjs,tempendTimettdjs,sclearTimettdjs);
			       	}, 1000);
			</script>
			<%}%>
			<div class="clear"></div>
		<div class="plan_tab_hf" style="height:auto; border-bottom:none;">
			<ul class="pt-hf-tit">
			<%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
				<li id="bdxq" class="tables" src="<%=controller.getViewURI(request, Rzfxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">标的详情</a></li>
			<%}else{%>
				<li id="bdxq" class="tables" src="<%=controller.getViewURI(request, Yhxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">标的详情</a></li>
			<%} %>
				<li id="xgzl" class="tables" src="<%=controller.getViewURI(request, Xgzl.class)%>?id=<%=id%>">相关资料</li>
				<li id="tbjl" class="tables" src="<%=controller.getViewURI(request, Tbjl.class)%>?id=<%=id%>">投标记录</li>
				<%
				 if(creditInfo.status==CreditStatus.YFK||creditInfo.status==CreditStatus.YDF||creditInfo.status==CreditStatus.YJQ){
			%>
				<li id="hkjl" class="tables" src="<%=controller.getViewURI(request, Hkjl.class)%>?id=<%=id%>"><a href="javascript:void(0)">还款记录</a></li>
				<li id="zqxx" class="tables" src="<%=controller.getViewURI(request, Zqxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">债权信息</a></li>
				<li id="zrjl" class="tables" src="<%=controller.getViewURI(request, Zrjl.class)%>?id=<%=id%>"><a href="javascript:void(0)">转让记录</a></li>
			<%}%>
			</ul>
			<div class="pt-list1" style="display:none;">
				123
			</div>
			<div class="pt-list2" style="display:none;">
				456
			</div>
			<%if(jiudianSession==null||!jiudianSession.isAuthenticated()){%>
			<div style="display:block;" class="pt-list3">
				<p style="padding-left:400px;" class="f30">请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" style=" color:#186ea7;">登录</a>
                	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="color:#faaf00;">注册</a>后查看</p>
                	
			</div>
			
			<%}else{ %>
			<div name="bdxq"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fbdxq" width="100%" frameborder="0" src="" name="fbdxq" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="fkxx"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="ffkxx" width="100%" frameborder="0" src="" name="ffkxx" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="xgzl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fxgzl" width="100%" frameborder="0" src="" name="fxgzl" style="border: 0px none;min-height: 580px;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="tbjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="ftbjl" width="100%" frameborder="0" src="" name="ftbjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			<%
				if(creditInfo.status==CreditStatus.YFK||creditInfo.status==CreditStatus.YDF||creditInfo.status==CreditStatus.YJQ){
			%>
			
			<div name="hkjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fhkjl" width="100%" frameborder="0" src="" name="fhkjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="zqxx"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fzqxx" width="100%" frameborder="0" src="" name="fzqxx" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="zrjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fzrjl" width="100%" frameborder="0" src="" name="fzrjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<%}%>
			<%}%>
		</div>
	</div>
   
 <!--右侧客服区-->
<%@include file="/WEB-INF/include/index/toolbar.jsp"%>
<!--右侧客服区结束-->   
<div id="info"></div>      
<div class="popup_bg"  style="display: none;"></div> 
<div class="cgcz_box2 tc_qrzf" style="width:720px; margin-top:-140px; margin-left:-315px;display: none;">
	<a href="javascript:void(0)" onclick="cleartc('tc_qrzf')" class="tc_close"></a>
	<div class="ltc_top_left"></div>
	<span class="ltc_span" style="width:670px;"></span>
	<div class="ltc_top_right"></div>
	<div class="ltc_centers">
	<div class="cgcz">
	<dl>
	<dt style="padding-left:64px; font-size:20px; width:auto; height:88px;"><span class="cgcz03"></span>
	<p class="f20 gray33" style="font-size: 24px;color: #737373 !important;">投标购买确认</p> 
	您此次购买份数为<i class="red"><em style="font-size: 24px;" id="fs"><%=fs%></em></i>份，每份价格<i class="red">
	<em style="font-size: 24px;" id="mfjg"><%=mfjg%></em></i>元，总需<i class="red">
	<em style="font-size: 24px;" id="zxMoney"><%=zxMoney%></em></i>元
	<br/><input type="checkbox" checked="checked" value="1" class="m_cb selected" id="isread" name="isread" style="display:inline-block;margin:5px 3px 0 0; float:left;"><label style="font-size: 12px;display:inline-block;float:left; margin-top:5px;">我已阅读并同意</label>
	<label for="iAgree" style="width:300px; float:left; margin-top:5px;">
	<%--  <%if(creditInfo.creditType == CreditType.XYDB){%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.DBBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%}else if(creditInfo.creditType == CreditType.SDRZ){%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.SDRZBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%}else{%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%} %> --%>
	<%if(Jkflx.GR.name().equals(creditInfo.jkflx.name())){ %>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.GRJKXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议(个人)》</a>
	<%}else if(Jkflx.QY.name().equals(creditInfo.jkflx.name())){%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.QYJKXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议(企业)》</a>
	<%} %>及
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.JJFWXY.name()) %>" style="font-size: 12px;" class="blue" >《投资会员居间服务协议》</a>
	</label>
	</dt>
	</dl>
	<div class="clear"></div>
	<p style="text-align:center;">
	<a href="javascript:void(0)" id="ok"  class="zr_submit">确&nbsp;认</a>
	<a class="cancel" href="javascript:void(0)"  onclick="cleartc('tc_qrzf')" style="font-size:13px;">取消</a>
	</p>
	</div>
	</div>
	<div class="ltc_bottom_left"></div>
	<span class="ltc_span" style="width:670px;"></span>
	<div class="ltc_bottom_right"></div>
</div> 
</div>
<div class="clear"></div> 
<%@include file="/WEB-INF/include/footer.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
 <script type="text/javascript">
	$(".pcjiang").hover(function(){
		$(this).find("div").show();
		},function(){
			$(this).find("div").hide();
			});
    var box = $(".biaodi h2 span.fl");
    var showCon = $(".biaodi_list");
    var e;
    showCon.find("li:first").find("a").addClass("newgif");
    box.find("a").hover(function () {
        e = $(this).index();
        box.find("a").removeClass("selected");
        $(this).addClass("selected");
		showCon.hide();
        showCon.eq(e).show();
		$(".biaodi h2 span.fr a").hide();
		$(".biaodi h2 span.fr a").eq(e).show();
		showCon.find("li:first").find("a").addClass("newgif");
    });
    
    $(function(){
		 var num=$(".djs_qgz").length;
		 for(i=0;i<num;i++){
			 var percent=parseInt($(".djs_qgz_out").eq(i).find("span").text());
			var Wid=$(".djs_qgz_out").eq(i).width();
			var bg=Math.round(Wid-Wid*percent/100);
			var wid=Math.round(Wid-bg-$(".djs_qgz_out").eq(i).find("span").width()/2-1);
			$(".djs_qgz_out").eq(i).css("background-position",-bg+"px bottom");
			$(".djs_qgz_out").eq(i).find("span").css("left",wid+"px");
			 }
   	});
</script>           
<script type="text/javascript" src="js/a.js"></script><!--微信微博js-->
 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->
</body>
</html>
