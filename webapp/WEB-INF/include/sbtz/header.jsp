<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.common.enums.CreditStatus"%>
<%@page import="com.jiudian.p2p.common.enums.RepaymentType"%>
<%@page import="com.jiudian.p2p.variables.defines.SystemVariable"%>
<%@page import="com.jiudian.p2p.common.enums.CreditCycle"%>
<%@page import="com.jiudian.p2p.common.enums.TermType"%>
<%@page import="com.jiudian.p2p.common.enums.RewardType"%>
<%@page import="com.jiudian.p2p.common.enums.CompanyStatus"%>
<%@page import="com.jiudian.p2p.common.enums.CreditType"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderRecord"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.Index"%>
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

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery/jquery-1.8.3.min.js"></script>

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


<div class="nav_box">
    	<div class="nav">
        	<%@include file="/WEB-INF/include/list_header.jsp" %>
        </div>
        <%
        	if(CURRENT_SUB_CATEGORY.equals("BDXQ")){
        %>
        <div class="top_menu_hf">
            	<p>
                	<a href="javascript:void(0)" class="selected"><em>借款详情</em></a>
                </p>
        </div>
        <%
        	}
        %>
</div>

<div class="center_box">
    	<div class="center_all_border nomargin">
        	<div class="pub_title_hf">
            	<p class="pub_tit_left_hf">
            	<%
            		if(creditInfo.creditType == CreditType.XYDB){
            	%>
				 <span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span>
				 <span class="ico ico03"></span><%
				 	}
				 		else if(creditInfo.creditType == CreditType.XJD || creditInfo.creditType == CreditType.SYD ){
				 %>
				<span class="ico"></span><span class="ico ico01"></span><%
					}
						else if(creditInfo.creditType == CreditType.SDRZ){
				%>
				<span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>">
				</span><span class="ico ico02"></span><%
					}
				%>
            	<em><%
            		StringHelper.filterHTML(out, creditInfo.title);
            	%></em>
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
            	<a href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.UserInfo.class,creditInfo.userId)%>">
					<%StringHelper.truncation(out, creditInfo.userAccountName, 4,"***");%>
				</a></p>
                <p class="pub_tit_right_hf">
		               <%if(creditInfo.creditType == CreditType.XYDB){%>
		          	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.DBBXY.name()) %>" >借款协议（范本）</a>
		           <%}else if(creditInfo.creditType == CreditType.SDRZ){%>
		           <a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.SDRZBXY.name()) %>" >借款协议（范本）</a>
		           <%}else{%>
		           <a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name()) %>" >借款协议（范本）</a>
		           <%} %>
                </p>
            </div>
        </div>
</div>


<div class="center">
    	<div class="plan_given_hf">
        	<ul class="plan_given_left">
            	<li><div class="pr100_hf"><em class="emfs18">¥</em><span class="spanfs36"><%=Formater.formatAmount(creditInfo.amount)%></span>
            	<input type="hidden" id="mfMoney" value="<%=mfjg%>">
            	<br/>标的总额（元）</div><div class="pr80_hf"><span class="spanfs36"><%=Formater.formatRate(creditInfo.rate,false)%></span>
            	<em class="emfs18">%</em><br/>年利率</div><div class="pr30_hf" style="margin-right:0px;">
            	<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><span class="spanfs36"><%=creditInfo.term%></span>
            	<em class="emfs18" style="font-family:微软雅黑;">个月</em>
       			   <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><span class="spanfs36"><%=creditInfo.term%></span>
       			   <em class="emfs18" style="font-family:微软雅黑;">天</em>
       			   <%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
				<em class="emfs18" style="font-family:微软雅黑;">满额即还</em><%}%>
				<br/>还款期限</div></li>
                <li>
                	<div class="list01_hf">保障方式</div>
                    <div class="list02_hf"><em>本息</em>
                        <div class="tips_content">
                            <div id="tips0Msg" style="padding: 8px 0px 0px 20px; " class="ui-pop-con">
                                <div class="fl ui-pop-pic"></div>
                                <div class="ui-pop-info">详情请参见
                                <a class="ml5 blue" href="<%=controller.getPagingItemURI(request, Term.class, TermType.BXBZ.name())%>" target="_blank">本息保障计划</a></div>
                            </div>
                            <span id="tips0" class="ui_plan_bj ui_i_tips"></span>
                        </div>
                    </div>
                    <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){ %>
	                    <div class="list01_hf">提前还款费率 </div>
	                    <div class="list01_hf" style="padding-left:13px;"><%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES)))%></div>
					<%} %>
                </li>
                <li>
                	<div class="list01_hf">还款方式 </div>
                    <div class="list02_hf"><em><%=creditInfo.repaymentType.getName()%></em>
                    	<div class="tips_content">
						<div id="tips1Msg" style="padding: 8px 0px 0px 20px;" class="ui-pop-con">
							<div class="fl ui-pop-pic"></div>
							<div class="ui-pop-info">
								<%if(RepaymentType.MYHKDQHB2.equals(creditInfo.repaymentType)){ %>每月还息到期还本 还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时每期还息，最后一期还当期利息和全部本金。<%} %>
<%-- 								<%if(RepaymentType.DQYCXFQ.equals(creditInfo.repaymentType)){ %>到期一次性偿还本金和利息。<%} %> --%>
							</div>
						</div>
						<span id="tips1" class="ui_plan_bj ui_i_tips"></span>
					</div>
                    </div>
                    <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
                    <div class="list01_hf">月还本息（元）</div><div class="list01_hf"><span><%=creditInfo.yhkAmount%></span></div>
       			   <%}%>
                </li>
                <li><div class="list01_hf">投标限额 </div><div class="list02_hf">
					<%if(xefs.intValue() >0){ %><%=xefs.multiply(mfjg) %><%}else{ %>不限<% }%>
					</div>
					<div class="list01_hf">投标奖励</div>
                    <div class="list01_hf" style="margin-right:0px;">
                    	<span class="fl"><em class="orange fl" style="font-size:24px;padding-left:42px; height:45px;"><%if(!creditInfo.jllx.equals(RewardType.WJL)){%><%=Formater.formatRate(creditInfo.jlll)%><%} %></em><%=creditInfo.jllx.getName() %></span>
                        <%if(!creditInfo.jllx.equals(RewardType.WJL)){%>
                        <div class="tips_content">
                            <div id="tips1Msg" style="padding: 9px 0px 0px 20px;" class="ui-pop-con">
                                <div class="fl ui-pop-pic"></div>
                                <div class="ui-pop-info"><%=_jlms %>
                                   <%if (creditInfo.status == CreditStatus.TBZ&&(creditInfo.jllx.equals(RewardType.XSJ)||creditInfo.jllx.equals(RewardType.MTC))) {%>
                                   <p style="text-align:center; line-height:23px; border-bottom:1px solid #ccc; padding-bottom:5px;"><img src="<%=controller.getStaticPath(request)%>/images/new_images/xs_ico.jpg">限时时间</p>
                                   <p style="padding-top:5px; text-align:center; font-size:18px;" class="xs_sfm">
                                   <span name="hdjshour">00</span>时<span name="hdjsminute">00</span>分<span name="hdjssecond">00</span>秒</p>
                                   <script type="text/javascript">
                                   		tempendTimetthdjs= parseInt(<%=xs_deta%>);
		                               	tempnametthdjs = "hdjs";
		                               	sclearTimetthdjs = setInterval(function() {
		                               		tempendTimetthdjs = tempendTimetthdjs - 1000;
		                               		time(tempnametthdjs,tempendTimetthdjs,sclearTimetthdjs);
		                               	}, 1000);
								    </script>
                                   <%} %>
                                   <%if (creditInfo.status == CreditStatus.TBZ&&creditInfo.jllx.equals(RewardType.JBJ)) {%>
                                   <p style="text-align:center; line-height:23px; border-bottom:1px solid #ccc; padding-bottom:5px;">当前累计投资次数</p>
                                   <p style="padding-top:5px; text-align:center; font-size:18px;" class="xs_sfm">
                                   <%if(jiudianSession!=null && jiudianSession.isAuthenticated()){
										UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
										int ljtzcs =  userInfoManage.ljtzcs();	
										out.print(ljtzcs+"次");
                                   }else{%>
                                                                              登录可见
                                   <%} %>
                                   </p>
                                   <%} %>
                                </div>
                            </div>
                            <span class="ui_plan_bj ui_i_tips" style="top:18px;"></span>
                        </div>
                        <%} %>
                    </div>
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
						剩余时间
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
						<em class="fs18c51 fv"><%=day %></em>天<em class="fs18c51 fv"><%=hour %></em>时<em class="fs18c51 fv"><%=min %></em>分
						<%} %>
					 </div>
                </li>
				<%}%>
				<%if (creditInfo.status == CreditStatus.YMB||creditInfo.status == CreditStatus.YFK) {%>
				 <li><div class="list01_hf">满标用时</div>
                	<div class="list02_hf"><%=mb_hour+24*mb_day %>时<%=mb_min %>分<%=mb_ss %>秒</div>
                </li>
				<%}%>
            </ul>
            <form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.TB_SBTZ);%>">
				<input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQTBZ);%>">
		<%if (creditInfo.status == CreditStatus.TBZ) {InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);%>
		<div class="fr submission w240 mt15">
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
				
			<div class="submission_hf">
				  <input type="hidden" id="_hkfs" value="<%=creditInfo.repaymentType.name()%>"/>
				  <input type="hidden" id="_jkzq" value="<%=creditInfo.creditCycle.name()%>"/>
                  <input type="hidden" id="_nll" value="<%=creditInfo.rate%>"/>
                  <input type="hidden" id="_hkqs" value="<%=creditInfo.term%>"/>
                  <input type="hidden" id="_jlll" value="<%=creditInfo.jlll.doubleValue()%>"/>
                  
            	<div class="text01_hf">
                	<h4><p class="fl">剩余金额</p><span style="font-size:14px;" class="fr orange">每份<em style="color:#fff">100</em>元</span></h4>
                    <p style="padding-top:8px; width:100%; float:left;">
                    <span class="fl" style="font-size:22px; margin-left:-5px;">¥<%=Formater.formatAmount(creditInfo.remainAmount)%></span>
                    <span class="fr" style="font-size:12px; margin-top:8px;">(<%=syfs.intValue()%>份)</span></p>				
                    <p style="padding-top:10px; width:100%; float:left;">
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
                    <span class="fl" style="font-size:14px;">可用金额&nbsp;&nbsp;<%=Formater.formatAmount(userInfo.kyMoney) %>(<%=sjgmfs%>份)</span>
                    <span class="fr"><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="cz_href_hf">充值</a></span></p>
                    <p style="padding-top:7px; width:100%; float:left; position:relative;">
                    <a class="left_btn" href="javascript:void(0)"></a>
                    <input name="amount" maxlength="10" type="text" class="text_input_hf" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)"  value="1" />
                    <a class="right_btn" href="javascript:void(0)"></a>
                    <span style="position:absolute; right:12px; top:15px; color:#fff; font-size:14px;">份</span></p>
                    <div style="padding-top:6px; width:100%; float:left;">
                    	<span class="fl">预计收益</span>
                        <span style="margin-left:14px;" class="fl"><span id="_yjsy">0.00</span> 元  +  奖<span id="_yjjl">0.00</span> 元</span>
                        <%if(!creditInfo.jllx.equals(RewardType.WJL)){%>
                        <div style="float:left;" class="tips_content">
                            <div id="tips1Msg" style="padding: 13px 0px 0px 20px; top:-19px;" class="ui-pop-con">
                                <div class="fl ui-pop-pic"></div>
                                <div style="color:#5a5a5a;" class="ui-pop-info"><%=_jlms %>
                                   <%if (creditInfo.status == CreditStatus.TBZ&&(creditInfo.jllx.equals(RewardType.XSJ)||creditInfo.jllx.equals(RewardType.MTC))) {%>
                                   <p style="text-align:center; line-height:23px; border-bottom:1px solid #ccc; padding-bottom:5px;"><img src="<%=controller.getStaticPath(request)%>/images/new_images/xs_ico.jpg">限时时间</p>
                                   <p style="padding-top:5px; text-align:center; font-size:18px;" class="xs_sfm"> <span name="hdjshour">00</span>时<span name="hdjsminute">00</span>分<span name="hdjssecond">00</span>秒</p>
                                   <script type="text/javascript">
                                   		tempendTimetthdjsh= parseInt(<%=xs_deta%>);
		                               	tempnametthdjsh = "hdjsh";
		                               	sclearTimetthdjsh = setInterval(function() {
		                               		tempendTimetthdjsh = tempendTimetthdjsh - 1000;
		                               		time(tempnametthdjsh,tempendTimetthdjsh,sclearTimetthdjsh);
		                               	}, 1000);
								    </script>
                                   <%} %>
                                   <%if (creditInfo.status == CreditStatus.TBZ&&creditInfo.jllx.equals(RewardType.JBJ)) {%>
                                   <p style="text-align:center; line-height:23px; border-bottom:1px solid #ccc; padding-bottom:5px;">当前累计投资次数</p>
                                   <p style="padding-top:5px; text-align:center; font-size:18px;" class="xs_sfm">
                                   <%
										int ljtzcs =  userInfoManage.ljtzcs();	
										out.print(ljtzcs+"次");
                                   %>
                                   </p>
                                   <%} %>
                                </div>
                            </div>
                            <span id="tips1" class="ui_plan_bj ui_i_tips" style="top:3px;"></span>
                        </div>
                        <%} %>
                    </div>
                    
                    <p style="padding-top:25px; width:100%; float:left; text-align:center;">
                    
                    <input type="button" id="jqqdButton" class="text_input01_hfs btn01" value="敬请期待" <%if(fb_deta==0){ %>style="display:none"<%} %>>
                    <input type="button" id="tbButton" value="投&nbsp;&nbsp;标" fromname="form1" class="text_input01_hfs sumbitForme" <%if(fb_deta>0){ %>style="display:none"<%} %>>
                    
                    </p>
                </div>
             </div>
			 <%}else{ %>
				 <div class="submission_hf">
	            	<div class="text_hf">
	                	<h4>剩余金额<span style="font-size:14px;" class="fr orange">每份<em style="color:#fff">100</em>元</span></h4>
	                    <span>¥<%=creditInfo.remainAmount%></span>
	                    <p style="font-size:12px; *padding-top:8px;">(<%=syfs.intValue()%>份)</p>
	                </div>
	                <div class="fs18c73" style="float:left; text-align:center; width:100%; margin-top:65px;">请
	                <a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" style=" color:#186ea7; padding:0 5px;">登录</a>或
	                <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="color:#faaf00;padding:0 5px;">注册</a></div>
	             </div>
			 <%}%>
		</div>
		</form>
		<%} else if (creditInfo.status.equals(CreditStatus.YFK)) {%>
		<div class="plan_given_right_hf">
                <span class="title">还款中</span>
                <ul>
                	<li><span class="fl_hf">待还本息（元）</span>&nbsp;&nbsp;&nbsp;&nbsp;<span><em class="fs14c51 fv">¥</em>
                	<em class="fs18c51 fv" style="font-size: 16px;"><%=Formater.formatAmount(creditInfo.toRepaymentAmount)%></em></span></li>
                	 <li><span class="fl_hf">剩余期数</span>&nbsp;&nbsp;&nbsp;&nbsp;<span><em class="fs14c73"><%=creditInfo.remainTerms%>&nbsp;&nbsp;期</em></span></li>
                    <li><span class="fl_hf">下一合约还款日</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>
                    <em class="fs14c51 fv"><%=Formater.formatDate(creditInfo.nextRepayDate)%></em></span></li>
                </ul>
        </div>
		<%} else if (creditInfo.status.equals(CreditStatus.YMB)) {%>
		<div class="plan_given_right_hf mb_hf">
                <span class="title">已满标</span>
                <em style="font-size:14px; text-align:center; color:#fff; width:100%; float:left;">获奖名单即将公布，敬请期待</em>
                <%
				InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
				TenderRecord[] tenderRecords = creditManagePayment.getRecord(IntegerParser.parse(request.getParameter("id")));
				%>
                <p class="mb_text_hf"><span class="fs14c73">满标用时</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span class="fs18c73"><%=mb_hour+24*mb_day %>时<%=mb_min %>分<%=mb_ss %>秒</span><br/><span class="fs14c73">加入人次
                </span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=tenderRecords == null ?0 :tenderRecords.length %>
                </span></p>
         </div>
		
		<%} else if (creditInfo.status == CreditStatus.YJQ) {%>
		<div class="plan_given_right_hf hq_hf">
                <span class="title">已还清</span>
                <p class="df_text_hf"><span class="fs14c73">还清时间</span>&nbsp;&nbsp;&nbsp;
                <span class="fs18c73"><%=creditInfo.status == CreditStatus.YDF?DateParser.format(creditInfo.dfTime):DateParser.format(creditInfo.payedDate)%></span></p>
        </div>
		<%} else if(creditInfo.status == CreditStatus.YDF){ %>
		<div class="plan_given_right_hf df_hf">
                <span class="title">已垫付</span>
                <p class="df_text_hf"><span class="fs14c73">垫付时间</span>&nbsp;&nbsp;&nbsp;
                <span class="fs18c73"><%=creditInfo.status == CreditStatus.YDF?DateParser.format(creditInfo.dfTime):DateParser.format(creditInfo.payedDate)%></span></p>
        </div>
		<%} else if (creditInfo.status.equals(CreditStatus.LB)) {%>
		<div class="plan_given_right_hf lb_hf">
                <span class="title">已流标</span>
                <p class="df_text_hf"><span class="fs18c73">亲，加油！</span></p>
        </div>
		<%}%>
        </div>
        <%if (creditInfo.status == CreditStatus.TBZ&&fb_deta>0) { %>
        <div class="daojishi">
        	<div class="dao_time">
            	<em class="start_clock">距离开始
<!--             	</em><span>0</span><em>天 -->
            	</em>
            	<span name="djshour">00</span><em>时</em>
            	<span name="djsminute">00</span><em>分</em>
            	<span name="djssecond">00</span><em>秒</em>
            </div>
        </div>
         <script type="text/javascript">
         		tempendTimettdjs= parseInt(<%=fb_deta%>);
		       	tempnamettdjs = "djs";
		       	sclearTimettdjs = setInterval(function() {
		       		tempendTimettdjs = tempendTimettdjs - 1000;
		       		time(tempnamettdjs,tempendTimettdjs,sclearTimettdjs);
		       	}, 1000);
		</script>
        <div class="clear"></div>
        <%} %>
        <%
        TenderRecord[] _jls = investManage.getJllb(id);
        if(_jls != null)
        if (creditInfo.status == CreditStatus.YFK||creditInfo.status == CreditStatus.YJQ) { 
        %>
        <div class="jl_list">
        	<div class="jl_listleft"><p><span>奖</span>励名单</p></div>
            <div class="jl_listright">
            	<table cellspacing="0" cellpadding="0" border="0" width="100%">
                	<tbody>
                    	<tr>
                        	<td>
                            	<ul>
                            	<%for(TenderRecord tenderRecord:_jls){ %>
                                	<li>
                                    	<span><%StringHelper.filterHTML(out, (tenderRecord.tenderName.length()>=6?tenderRecord.tenderName.substring(0,4):tenderRecord.tenderName.substring(0,1))+"***");%></span>
                                        <span><%=Formater.formatAmount(tenderRecord.tenderMoney)%></span>
                                        <span>获得<em class="orange"><%=Formater.formatRate(creditInfo.jlll)%></em>年化收益奖励</span>
                                    </li>
                                <%} %>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="clear"></div>
        <%} %>
</div>

<div class="popup_bg"  style="display: none;"></div>

<div class="cgcz_box2 tc_qrzf" style="width:720px; margin-top:-140px; margin-left:-315px;display: none;">
	<a href="javascript:void(0)" onclick="cleartc('tc_qrzf')" class="tc_close"></a>
	<div class="ltc_top_left"></div>
	<span class="ltc_span" style="width:670px;"></span>
	<div class="ltc_top_right"></div>
	<div class="ltc_centers">
	<div class="cgcz">
	<dl>
	<dt style="padding-left:64px; font-size:20px; width:auto; margin-bottom:20px;"><span class="cgcz03"></span>
	<p class="f20 gray33" style="font-size: 24px;color: #737373 !important;">投标购买确认</p> 
	您此次购买份数为<i class="red"><em style="font-size: 24px;" id="fs"><%=fs%></em></i>份，每份价格<i class="red">
	<em style="font-size: 24px;" id="mfjg"><%=mfjg%></em></i>元，总需<i class="red">
	<em style="font-size: 24px;" id="zxMoney"><%=zxMoney%></em></i>元
	<br/><input type="checkbox" checked="checked" value="1" class="m_cb selected" id="isread" name="isread"><label style="font-size: 12px;">我已阅读并同意</label>
	<label for="iAgree">
	 <%if(creditInfo.creditType == CreditType.XYDB){%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.DBBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%}else if(creditInfo.creditType == CreditType.SDRZ){%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.SDRZBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%}else{%>
	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name()) %>" style="font-size: 12px;" class="blue" >《借款协议》</a>
	<%} %>
	</label>
	
	</dt>
	</dl>
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




