<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.ExperiencePlan"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.AddTyj"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.Jhjs"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.Yxlb"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanCount"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html>
<head>
<%
String _TITLE_ = "理财体验 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>     
 <%
		FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
		FinancingPlanInfo caInfo= service.getNewPlan();
		if(caInfo==null){
			controller.sendRedirect(request, response,controller.getViewURI(request, Jhjs.class));
			return;
		}
		BigDecimal gmMoney= new BigDecimal(0);
		BigDecimal jrfMoney= new BigDecimal(0);
		
		String safetyError = "error";

		if(jiudianSession==null || jiudianSession.isAuthenticated()){
			LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
			LmoneyDecide lm = lmoneyManage.getLmoneyDecide("");
			if(StringHelper.isEmpty(lm.isRegJin) || lm.isRegJin.equals(IsPass.F.name())){
				safetyError = "error";
			}else{
				safetyError = "success";
			}
		}
	%>
	 <div class="clear"></div>
 <!--第一屏-->
<div class="project-list">

<div class="sub-nav" sup="Project">
    <div class="sub-nav-inner">
        <%@include file="/WEB-INF/include/list_header.jsp" %>
	</div><!--start: container -->
	<div class="clear"></div>
</div>
 <!--第二屏-->
 <div style="width:100%;border-bottom:1px solid #dcdcdc;padding-bottom:20px;">
		<div class="center">
			<p style="display:inline-block;" class="f30 pr15"><%StringHelper.filterHTML(out, caInfo.planTitle);%></p>
			<a href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.yxlc.Yxxq.class,caInfo.id)%>" class="blue f14">查看详情</a>
		</div>
 </div>
	<div class="plan_given_hf">
       <ul class="plan_given_left" style="padding-top:30px;">
            	<li style="line-height:50px;"><div class="list01_hf">计划金额</div><div class="list02_hf">
            	<span class="fs18c73"><%=Formater.formatAmount(caInfo.planMoney)%></span><span class="fs14c73">元</span></div>
            	<div class="list01_hf">预期收益</div><div class="list01_hf"><span class="fs18c73"><%=caInfo.yqsy == null? "0%":Formater.formatRate(caInfo.yqsy.doubleValue())%></span><span class="fs14c73">每年</span></div></li>
            	
                <li style="line-height:50px;">
                
                <div class="list01_hf">投资方式</div>
	                <div class="list02_hf"><span class="fs14c73" style="color:#f08304;"><%=PlanInvestmenWay.TYJ.getName() %></span></div>
				<div class="list01_hf">理财说明</div><div class="list01_hf">
                <a href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>" target="_blank" class="blue">理财体验说明书</a></div></li>
                
                <li style="line-height:50px;">
                
                <div class="list01_hf">计划状态</div><div class="list02_hf">
                <%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
								预售中
				<%}else if(caInfo.planState == PlanState.YFB && !caInfo.fromSale.after(caInfo.currentTime)){%>
					申请中
				<%}else if(caInfo.planState == PlanState.YSX){%>
					已满额
				<%}else if(caInfo.planState == PlanState.YJZ){%>
					已截止
				<%}%>
				</div>
				<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){
										long hm=1000*3600*24;
										long time =	 caInfo.fromSale.getTime() - caInfo.currentTime.getTime();
										long day=time/hm;
										long hour=(time-day*hm)/(1000*3600);
										long min=(time-day*hm-hour*1000*3600)/(1000*60);
				%>
                <div class="list01_hf">距离发售</div>
				<div class="list01_hf"><span class="fs14c73"><%=day%>天<%=hour%>小时<%=min%>分</span></div>
				<%
				}else if(caInfo.planState == PlanState.YSX || caInfo.planState == PlanState.YJZ){	
										long hm=3600*24;
										long time =	caInfo.fullTime;
										long day=time/hm;
										long hour=(time-day*hm)/3600;
										long min=(time-day*hm-hour*3600)/60;
										long ss=time-day*hm-hour*3600-min*60;
				%>
				<div class="list01_hf">满额用时</div>
				<div class="list01_hf"><span class="fs14c73"><%=day%>天<%=hour%>时<%=min%>分<%=ss%>秒</span></div>
				<%
				}else if(caInfo.planState == PlanState.YFB && !(caInfo.fromSale.after(caInfo.currentTime))){
										long hm=1000*3600*24;
										long time =	caInfo.cutoff.getTime()-caInfo.currentTime.getTime();
										long day=time/hm;
										long hour=(time-day*hm)/(1000*3600);
										long min=(time-day*hm-hour*1000*3600)/(1000*60);
				%>
				<div class="list01_hf">距离截止</div>
				<div class="list01_hf"><span class="fs14c73"><%=day%>天<%=hour%>小时<%=min%>分</span></div>
				<%}%>
				</li>
                
                <li style="line-height:50px;"><div class="list01_hf">锁定期限</div><div class="list02_hf">
                <span class="fs18c73"><%=caInfo.lockqx%></span><span class="fs14c73">个月</span></div>
                <%
								Calendar calendar = Calendar.getInstance();
								calendar.setTimeInMillis(caInfo.lockEnd.getTime());
								int year=calendar.get(Calendar.YEAR); 
								int month=calendar.get(Calendar.MONTH)+1; 
								int date=calendar.get(Calendar.DATE);
				%>
                <div class="list01_hf">锁定结束</div><div class="list01_hf"><%=year%>年<%=month%>月<%=date%>日</div>
                </li>
                <li style="line-height:50px;"><div class="list01_hf">收益处理</div><div class="list02_hf">
                <span class="fs14c73"><%StringHelper.filterHTML(out, (PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)?caInfo.earningsWay.getName().replace("，到期还本", ""):caInfo.earningsWay.getName()));  %>
                </span></div><div class="list01_hf">费率说明 </div><div class="list01_hf">体验活动不收取任何费用</div></li>
            </ul>
			<div class="plan_given_right no_bg">
			<form method="post" id="form2" action="<%configureProvider.format(out,URLVariable.TB_YXLC);%>">
					<div class="tiyan_right">
						<input type="hidden" id="yxId" name="yxId" value="<%=caInfo.id%>">
						<input type="hidden" id="syMoney" name="syMoney" value="<%=caInfo.syMoney == null ?0 : caInfo.syMoney%>">
						<input type="hidden" id="maxMoney" name="maxMoney" value="<%=caInfo.maxMoney == null ?0 : caInfo.maxMoney%>">
						<input type="hidden" id="minMoney" name="minMoney" value="<%=caInfo.minMoney == null ?0 : caInfo.minMoney%>">
						<input type="hidden" id="yxlcSucc" name="yxlcSucc" value="<%configureProvider.format(out, URLVariable.USER_YXLC);%>">
						<input type="hidden" id="yxlcSqz" name="yxlcSqz" value="<%configureProvider.format(out, URLVariable.USER_YXLC_SQZ);%>">
                	
                    	<p>剩余金额</p>
                        <p style="margin:8px 0;"><span style="font-size:28px;"><%=Formater.formatAmount(caInfo.syMoney)%></span><span style="font-size:14px;">元</span></p>
                        <p>每人可加入金额上限&nbsp;&nbsp;&nbsp;&nbsp;<%=Formater.formatAmount(caInfo.maxMoney)%>元</p>
                        
                        <%
							if(!(jiudianSession==null || !jiudianSession.isAuthenticated())){
								UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
								UserInfo userInfo= userInfoManage.search();
								if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){
						%>
						<p style="margin:8px 0;"><span class="fl">可用金额<em style="font-size:18px; padding-left:10px;"><%=Formater.formatAmount(userInfo.kyMoney)%></em>
						</span><span class="fr">
							<input type="hidden" id="kyMoney" name="kyMoney" value="<%=userInfo.kyMoney%>">
						<a class="cz_href_hf" href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">充值</a></span></p>
						<%} 
						if(PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)){
							ExperiencePlan[] exs =  service.getTyj();
						%>
						<p style="padding:8px 0;" onclick="showtap()">选择体验券<a href="javascript:void(0)" class="cz_href_hf" style="padding-left:10px;">(获取)</a></p>
						<p style="line-height:30px;">
						<%int idx=0; if(exs!=null)for(ExperiencePlan ex : exs){idx++;if(idx>3){break;}%>
							<label>
							<input type="checkbox" name="ex" amount="<%=ex.amount.intValue()%>" value="<%=ex.experienceNum %>" >
                          <span><%=ex.experienceNum %>&nbsp;&nbsp;(<%=Formater.formatAmount(ex.amount)%>元)</span></label>
                    	<%}%> 
                    	</p>
                    		<input name="gmMoney" maxlength="10" type="hidden" class="sy_input" id="gmMoney" value="0" />
                    		<p style="padding-bottom:10px;">当前已选体验金&nbsp;&nbsp;&nbsp;&nbsp;
                    		<span style="font-size:18px;" id="checkamont">0.00</span>元</p>
						<%}
						if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){ %>
                        <p>
                        <input name="gmMoney" maxlength="10" type="text" class="text_input_hf" id="gmMoney" value="" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" style="height:37px; width:260px; margin-top:5px;"/>
                        <span style="position:absolute; right:12px; top:10px; color:#aaa; font-size:14px;">
                     	元</span></p>
                        <p style="font-size:12px; padding:8px 0;">不低于<%=Formater.formatAmount(caInfo.minMoney)%>元</p>
						<%}
						}else{
							if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){%>
							<p style="font-size:18px; padding:20px 0 50px 0;">可用金额
							<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="cz_href_hf" style="font-size:18px;padding-right:5px;">登录
							</a>后可见</p>
							<%}else if(PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)){%>
							<p style="font-size:18px; padding:20px 0 50px 0;">
							<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="cz_href_hf" style="font-size:18px;padding-right:5px;">登录
							</a>后可见</p>	
						<% }
						}%>	
					</div>
					
					<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
						<p><input type="button" value="敬请期待" class="input02" style="background-color:rgb(205,205,205);"></p>
						<%}else if(caInfo.planState == PlanState.YFB && !(caInfo.fromSale.after(caInfo.currentTime))){
								if(!(jiudianSession==null || !jiudianSession.isAuthenticated())){
									UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
										String isYuqi =  userInfoManage.isYuqi();		
										BigDecimal tzMoney =  service.tzMoney(caInfo.id);	
							%>
								<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
								<input type="hidden" id="tzMoney" name="tzMoney" value="<%=tzMoney%>">
								<input type="hidden" id="jrfl" name="jrfl" value="<%=caInfo.jrfl%>">
								<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
								<input type="hidden" id="tzfs" name="tzfs" value="<%=caInfo.planInvestmenWay.name()%>">
								<p class="pinput01"><input type="button" style="background:#ccc;color:#fff;display:inline-block;background:rgb(251,175,1);line-height:35px;" class="input01" value="申 请" id="tbButton"></p>
							<%
								}else {
							%>
								<p class="pinput02"><a style="color:#fff;display:inline-block;background:rgb(251,175,1);line-height:35px" href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="input02">申 请 </a></p>
							<%
								}
							}else if(caInfo.planState == PlanState.YJZ ){
						%>
								<p class="pinput01"><input type="button" value="已截止" class="input02" style="background-color:rgb(205,205,205);"></p>
						<%
							}else if(caInfo.planState == PlanState.YSX){
						%>
								<p class="pinput01"><input type="button" value="已满额" class="input02" style="background-color:rgb(205,205,205);"></p>
						<%
							}
						%>
						</form>
                    
				<!--满标状态
				<div class="manbiao">
					<p class="title">己满标</p>
					<p class="sm">获奖名单即将公布敬请期待...</p>
					<p class="m_time f16">满标用时<em class="f16">0时48分56秒</em></p>
					<p class="m_num f16">加入人次<em class="f16">3</em></p>
				</div>-->

				<!--投标状态<div class="pg-right-top">
					<ul>
						<li>
							<p>剩余金额</p>
							<span class="">每份<em>100</em>元</span>
							<div class="clear"></div>
						</li>
						<li>
							<p class="f30">¥93,100.00</p>
							<span style="padding-top:10px;">(<em>931</em>)份</span>
							<div class="clear"></div>
						</li>
						<li>
							<p>可用金额&nbsp<em>56.34</em><em>0份</em></p>
							<span><a href="" style="color:#fadc00">充值</a></span>
							<div class="clear"></div>
						</li>
						<li>
							<a href="" class="btn1 btna">-</a>
							<input value="1"/>
							<a href="" class="btn2 btna">+</a>
						</li>
						<li>
							<p style="padding-right:15px">预计收益</em></p>
							<p><em>8.00元</em>+奖<em>0.01元</em></p>
							<div class="clear"></div>
						</li>
					<ul>
				</div>
				<div class="pg-right-bottom">
					<input type="submit" value="投标"/>
				</div> -->
			</div>
			<div class="clear"></div>
		
	</div>
	<!--第二屏-->
	<div class="center_box" style="background:#f1f3f5;">
		<div class="center">
            <div class="plan_tab_hf" style="border-bottom:1px solid #dadada; height:60px;">
               <span class="fs18c73 fl" style="line-height:60px;">投资效果</span>
               <span class="fr" style="line-height:60px;">
               <a href="<%=controller.getViewURI(request, Yxlb.class) %>" class="blue">查看往期理财体验&gt;&gt;</a></span>
            </div>
            <%FinancingPlanCount fpCount=service.getStatistics();%>
            <div class="plan_content_hf">
            	<ul class="targeting_hf">
            		<%if(fpCount != null ){ %>
                	<li>
                    	<p>
                    	<%if(fpCount.totleMoney.doubleValue()>=100000000){%>
			        	   <span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/100000000)%>
							</span><span class="fs14c73">亿元</span>
			        	<%}else if(fpCount.totleMoney.doubleValue()>=10000 && fpCount.totleMoney.doubleValue() <100000000){%>
			        		<span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/10000)%>
			        		</span><span class="fs14c73">万元</span>
			        	<%}else{%>
			        		<span style="font-size:36px;"><%=Formater.formatAmount(fpCount.totleMoney)%>
			        		</span><span class="fs14c73">元</span>
			        	<%}%>
                    	</p>
                        <p>累计总金额</p>
                    </li>
                    <li>
                    	<p><span style="font-size:36px; color:#176fa7;"><%=fpCount.joinCount%></span><span class="fs14c73">次</span></p>
                        <p>加入总人次</p>
                    </li>
                    <li>
                    	<p>
                    	<%if(fpCount.userEarnMoney.doubleValue()>=100000000){%>
				        	   <span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/100000000)%>
				        	  </span><span class="fs14c73">亿元</span>
			        	<%}else if(fpCount.userEarnMoney.doubleValue()>=10000 && fpCount.userEarnMoney.doubleValue() <100000000){%>
			        		<span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/10000)%>
			        		</span><span class="fs14c73">万元</span>
			        	<%}else{%>
			        		<span style="font-size:36px; color:#f08304;"><%=Formater.formatAmount(fpCount.userEarnMoney)%>
			        		</span><span class="fs14c73">元</span>
			        	<%}%>
                    	</p>
                        <p>为用户累计赚取</p>
                    </li>
                    <%}else{ %>
                    	<li>
                    	<p><span style="font-size:36px;">0</span><span class="fs14c73">元</span></p>
                        <p>累计总金额</p>
	                    </li>
	                    <li>
	                    	<p><span style="font-size:36px; color:#176fa7;">0</span><span class="fs14c73">次</span></p>
	                        <p>加入总人次</p>
	                    </li>
	                    <li>
	                    	<p><span style="font-size:36px; color:#f08304;">0</span><span class="fs14c73">元</span></p>
	                        <p>为用户累计赚取</p>
	                    </li>
                    <%}%>
					<div class="clear"></div>
                    </ul>
                <div class="plan_intr_hf">
                    <p class="fs18c73">活动介绍</p>
                    <p><%StringHelper.filterHTML(out, caInfo.introduce); %></p>
                    <p class="fs18c73" style="padding-top:20px;">体验流程</p>
                    <p style="text-align:center;"><img style="padding:50px 0 30px 200px;" alt="<%=_ALT%>" src="<%=controller.getStaticPath(request)%>/images/tylc_txt.png"></p>
                </div>
            </div>
        </div>
		<div class="clear"></div>
    </div>

<div class="popup_bg"  style="display: none;"></div>
<div class="cgcz_box2 tc_qrzf" id="gmDialog" style="width:720px; margin-top:-140px; margin-left:-315px;display: none;">
	<a href="javascript:void(0)" onclick="cleartc('tc_qrzf')" class="tc_close"></a>
	<div class="ltc_top_left"></div>
	<span class="ltc_span" style="width:670px;"></span>
	<div class="ltc_top_right"></div>
	<div class="ltc_centers">
	<div class="cgcz">
	<dl style="padding-bottom: 25px;">
	<dt style="padding-left:64px; font-size:20px; width:auto; margin-bottom:20px;"><span class="cgcz03"></span>
	<p class="f20 gray33" style="font-size: 24px;color: #737373 !important;">购买确认</p> 
	您此次购买金额为<i class="red"><em style="font-size: 24px;" id="zxMoney"><%=gmMoney%></em></i>元，加入费为<i class="red">
	<em style="font-size: 24px;" id="jrfMoney"><%=jrfMoney%></em></i>元，总需为<i class="red">
	<em style="font-size: 24px;" id="zgxMoney"><%=Formater.formatAmount(gmMoney.add(jrfMoney)) %></em></i>元。确认购买？
	<br/>
	</dt>
	</dl>
	<p style="text-align:center;">
	<a href="javascript:void(0)" id="ok"  class="zr_submit">确&nbsp;认</a>
	<a class="cancel" href="javascript:void(0)"  id="cancel" style="font-size:13px;" onclick="cleartc('tc_qrzf')">取消</a>
	</p>
	</div>
	</div>
	<div class="ltc_bottom_left"></div>
	<span class="ltc_span" style="width:670px;"></span>
	<div class="ltc_bottom_right"></div>
</div>
<div class="cgcz_box2 tyj_atyj" id="atyj"  style="width:520px; margin-top:-140px; margin-left:-315px;display: none;">
	<a href="javascript:void(0)" onclick="cleartc('tyj_atyj')" class="tc_close"></a>
	<div class="ltc_top_left"></div>
	<span class="ltc_span" style="width:470px;"></span>
	<div class="ltc_top_right"></div>
	<div class="ltc_centers">
	<div class="cgcz">
	<form class="form1" method="post" action="<%=controller.getURI(request, AddTyj.class)%>">
	<dl style="margin:20px 0 30px 0px;">
	<dt style="padding-left:64px; font-size:20px; width:auto; margin-bottom:20px;">
	  <em style="font-size:24px; margin-left:-60px;">领取体验金</em>
		<div style="margin:20px 0 30px 0px;" class="clearfix">
	         体验金券号 
	         <input type="text" value="" class="required max-length-8" style="width:250px;height:27px;line-height: 27px; border:1px solid #ccc;" name="tyjnum">
	         <p class="error_tip" tip=""></p>
			 <p style="display: none;font-size: 14px;" class="" errortip=""></p>
	      </div> 
	      <div class="clear"></div>
	</dt>
	</dl>
	<p style="text-align:center;">
	<button type="submit"  class="zr_submit">确&nbsp;认</button>
	<a class="cancel" href="javascript:void(0)"  onclick="cleartc('tyj_atyj')" style="font-size:13px;">取消</a>
	</p>
	</form>
	</div>
	</div>
	<div class="ltc_bottom_left"></div>
	<span class="ltc_span" style="width:470px;"></span>
	<div class="ltc_bottom_right"></div>
</div>
<div>
	<div class="popup_bg "  style="display: none;" id="tyjtxmm"></div>
		<div class="dialog w510 cgcz_box2 tc_qrzf" style="width:720px;margin-top:15px;margin-left: -411px;z-index:101;display:none;" id="txmm" >
			<div class="dialog_close fr" style="width:44px;height:42px;background: url('../../../../images/popup.png') no-repeat 0 -87px;"><a></a></div>
		    <div class="con clearfix">
		      <div class="d_error fl"></div>
		      <div class="info">尚未开通<span class="red">第三方账户平台</span>，请<a href="<%=configureProvider.format(URLVariable.QLTB_REG_URL)%>" class="blue">马上开通</a>。</div>
		    </div>
	</div>
</div>
<div id="info"></div>

 <!--右侧客服区-->
 <%@include file="/WEB-INF/include/index/toolbar.jsp"%>
<!--右侧客服区结束-->            
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>  
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/yxlc.js"></script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>       
 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->
<script type="text/javascript">
		function showtap(){
			$("#atyj").show();
			$("div.popup_bg").show();
		}
		
		$("input[name=ex]").change(function (){
			if($(this).attr("checked")==undefined){
				$(this).attr("checked",true);
			}else{
				$(this).attr("checked",false);
			}
			var str = 0;
            $("input[name=ex]").each(function() {
            	 if($(this).attr("checked") == "checked"){
                    str+=parseInt($(this).attr("amount"));
                }
            });
            $("#gmMoney").val(str.toFixed(2));
            $("#checkamont").html(str.toFixed(2));
		});
	
</script>
<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
				if(caInfo.planState == PlanState.YSX){
	%>
	<script type="text/javascript">
		$("#info").html(newSuccInfo(520,"<%=message%>","1",$("#yxlcSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%}else{%>
	<script type="text/javascript">
		alert($("#yxlcSqz").val());
		$("#info").html(showSuccInfo(520,"<%=message%>","1",$("#yxlcSqz").val()));	
		$("div.popup_bg").show();
	</script>
	<%}}%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(newDialogInfo(520,"<%=errorMessage%>","2"));	
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
		$("#info").html(newDialogInfo(502,"<%=warnMessage%>","3"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>