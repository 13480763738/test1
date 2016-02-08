<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.AddTyj"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.ExperiencePlan"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.yxlc.Yxlb"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.PlanRecode"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<html>
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			FinancingPlanInfo caInfo= service.getPlan(id);
			if(caInfo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
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

<div class="nav_box">
   	<div class="nav">
       	<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.yxlc.Index.class)%>" class="nav_title">理财体验 &gt;</a>
       	<span>
                <a href="javascript:void(0)" class="selected">理财体验详情</a>
        </span>
     </div>
</div>

<div style="width:100%;border-bottom:1px solid #dcdcdc;padding-bottom:20px;">
		<div class="center">
			<p class="f30 pr15" style="display:inline-block;"><%StringHelper.filterHTML(out, caInfo.planTitle); %></p>
		</div>
 </div>

<div class="plan_given_hf">
       <ul style="padding-top:30px;" class="plan_given_left">
            	<li style="line-height:50px;"><div class="list01_hf">计划金额</div><div class="list02_hf">
            	<span class="fs18c73"><%=Formater.formatAmount(caInfo.planMoney) %></span><span class="fs14c73">元</span></div>
            	<div class="list01_hf">预期收益</div><div class="list01_hf"><span class="fs18c73"><%=caInfo.yqsy == null? "0%":Formater.formatRate(caInfo.yqsy.doubleValue())%></span><span class="fs14c73">每年</span></div></li>
            	
                <li style="line-height:50px;">
                
                <div class="list01_hf">投资方式</div>
	                <div class="list02_hf"><span style="color:#f08304;" class="fs14c73"><%=PlanInvestmenWay.TYJ.getName() %></span></div>
				<div class="list01_hf">理财说明</div><div class="list01_hf">
                <a class="blue" target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>">理财体验说明书</a></div></li>
                
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
                <span class="fs14c73"><%StringHelper.filterHTML(out, (PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)?caInfo.earningsWay.getName().replace("，到期还本", ""):caInfo.earningsWay.getName()));  %></span></div><div class="list01_hf">费率说明 </div><div class="list01_hf">体验活动不收取任何费用</div></li>
            </ul>
			<div class="plan_given_right no_bg">
			<form action="<%configureProvider.format(out,URLVariable.TB_YXLC);%>" id="form2" method="post">
					<div class="tiyan_right">
						<input type="hidden" id="yxId" name="yxId" value="<%=id%>">
						<input type="hidden" id="syMoney" name="syMoney" value="<%=caInfo.syMoney == null ?0 : caInfo.syMoney%>">
						<input type="hidden" id="maxMoney" name="maxMoney" value="<%=caInfo.maxMoney == null ?0 : caInfo.maxMoney%>">
						<input type="hidden" id="minMoney" name="minMoney" value="<%=caInfo.minMoney == null ?0 : caInfo.minMoney%>">
						<input type="hidden" id="yxlcSucc" name="yxlcSucc" value="<%configureProvider.format(out, URLVariable.USER_YXLC);%>">
						<input type="hidden" id="yxlcSqz" name="yxlcSqz" value="<%configureProvider.format(out, URLVariable.USER_YXLC_SQZ);%>">
						<input type="hidden" id="tzfs" name="tzfs" value="<%=caInfo.planInvestmenWay.name()%>">
                	
                    	<p>剩余金额</p>
                        <p style="margin:8px 0;"><span style="font-size:28px;"><%=Formater.formatAmount(caInfo.syMoney)%></span><span style="font-size:14px;">元</span></p>
                        <p>每人可加入金额上限&nbsp;&nbsp;&nbsp;&nbsp;<%=Formater.formatAmount(caInfo.maxMoney)%>元</p>
                        <%if(!(jiudianSession==null || !jiudianSession.isAuthenticated())){
							UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
							UserInfo userInfo= userInfoManage.search();
							if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){
						%>
						<p style="margin:8px 0;"><span class="fl">可用金额
							<em style="font-size:18px; padding-left:10px;"><%=Formater.formatAmount(userInfo.kyMoney)%></em></span>
							<span class="fr"><a class="cz_href_hf" href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">充值</a></span></p>
                        	<p>
                        	<input type="hidden" id="kyMoney" name="kyMoney" value="<%=userInfo.kyMoney%>">
                        <%}
						if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){%>
						<p>
							<input name="gmMoney" type="text" maxlength="10" class="text_input_hf" id="gmMoney" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  value=""  />
						   <span style="position:absolute; right:12px; top:10px; color:#aaa; font-size:14px;">元</span></p>
						    
						    <p style="font-size:12px; padding:8px 0;">不低于<%=caInfo.minMoney%>元</p>
						<%}
							if(PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)){
								ExperiencePlan[] exs =  service.getTyj();
						%>
                        <p onclick="showtap()" style="padding:8px 0;">选择体验券<a style="padding-left:10px;" class="cz_href_hf" href="javascript:void(0)">(获取)</a></p>
						<p style="line-height:30px;">
							<%int idx=0; if(exs!=null)for(ExperiencePlan ex : exs){idx++;if(idx>3){break;}%>
								<label>
								<input type="checkbox" name="ex" amount="<%=ex.amount.intValue()%>" value="<%=ex.experienceNum %>">
                          		<span><%=ex.experienceNum %>&nbsp;&nbsp;(<%=Formater.formatAmount(ex.amount)%>元)</span></label>
		                    <%}%> 
                        </p>
                    		<input type="hidden" value="0" id="gmMoney" class="sy_input" maxlength="10" name="gmMoney">
                    		<p style="padding-bottom:10px;">当前已选体验金&nbsp;&nbsp;&nbsp;&nbsp;
                    		<span id="checkamont" style="font-size:18px;">0.00</span>元</p>
                    	</div>
                    		<%}
						}else{
						 if(PlanInvestmenWay.XJ.equals(caInfo.planInvestmenWay)){%>
							<p style="font-size:18px; padding:20px 0 50px 0;">可用金额
							<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="cz_href_hf" style="font-size:18px;padding-right:5px;">登录
							</a>后可见</p>
						<%}if(PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)){%>
						<p style="font-size:18px; padding:20px 0 50px 0;">
						<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="cz_href_hf" style="font-size:18px;padding-right:5px;">登录
						</a>后可见</p>
						</div>
						<%}} %>
						<%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
							<p><input type="button" value="敬请期待" class="input02" style="background-color:rgb(205,205,205);"></p>
						<%
							}else if(caInfo.planState == PlanState.YFB && !(caInfo.fromSale.after(caInfo.currentTime))){
								if(!(jiudianSession==null || !jiudianSession.isAuthenticated())){
									UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
									String isYuqi =  userInfoManage.isYuqi();			
									BigDecimal tzMoney =  service.tzMoney(id);	
						%>
					
					<input type="hidden" value="<%=isYuqi%>" name="isYuqi" id="isYuqi">
					<input type="hidden" value="<%=tzMoney%>" name="tzMoney" id="tzMoney">
					<input type="hidden" value="<%=caInfo.jrfl%>" name="jrfl" id="jrfl">
					<input type="hidden" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" name="charge" id="charge">
					<p class="pinput01"><input type="button" style="color:#fff;display:inline-block;background:rgb(251,175,1);line-height:35px" class="input01" value="申 请" id="tbButton"></p>
					<%}else{%>
						<p class="pinput02"><a style="color:#fff;display:inline-block;background:rgb(251,175,1);line-height:35px" href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="input02">申 请 </a></p>
					<%
					}
					}else if(caInfo.planState == PlanState.YJZ){
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
			</div>
			<div class="clear"></div>
	</div>
 
 <div class="center_box" style="background:#f1f3f5;">
    	<div class="center">
            <div class="plan_tab_hf">
                <ul class="plan_tab_hf_ul">
                <%if(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)){%>
				<li id="one1" onclick="setTab('one',1,1)"  class="hover">计划介绍</li>
				<%}else{%>
				<li id="one1" onclick="setTab('one',1,2)"  class="hover">计划介绍</li>
				<li id="one2" onclick="setTab('one',2,2)" >加入记录</li>
				<%}%>
                </ul>
            </div>
            <div class="plan_content_hf">
            	<div id="con_one_1" class="con_one_1_hf">
                	<%StringHelper.filterHTML(out, caInfo.introduce);%>
                </div>
                
                <%if(jiudianSession==null|| !jiudianSession.isAuthenticated()){%>
                <div id="con_one_2" class="pub_nologin_hf" style="display:none;">
	                	<p>请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>"  style=" color:#186ea7;">登录</a>
	                	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>"  style="color:#faaf00;">注册</a>后查看</p>
                </div>
                <%}else if(!(caInfo.planState == PlanState.YFB && caInfo.fromSale.after(caInfo.currentTime)) ){
                	 PlanRecode[] planRecodes = service.search(id);
                %>
	                <div id="con_one_2" class="con_one_2_hf" style="display:none;">
	                	<div class="fr"><span class="fs14c73">加入总人次<em style="font-size:24px; color:#186ea7; padding-left:10px;"><%=planRecodes==null?0:planRecodes.length %></em>(人次)</span></div>
	                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="plan_tab_con01_hf">
	                    	<tbody>
	                        	<tr class="leve_titbj_hf">
	                            	<td width="331">投资人</td>
	                                <td width="332" class="border_lr3">投资金额 </td>
	                                <td >投资时间</td>
	                            </tr>
	                             <%
				                  if (planRecodes!= null && planRecodes.length>0) {for (PlanRecode planRecode : planRecodes) {if (planRecode == null) {continue;}%>
	                            <tr class="leve_hf">
	                            	<td><%StringHelper.filterHTML(out, (planRecode.tzrName.length()>=6?planRecode.tzrName.substring(0,4):planRecode.tzrName.substring(0,1))+"***");%></td>
	                                <td><%=Formater.formatAmount(planRecode.tzMoney) %>元</td>
	                                <td><%=TimestampParser.format(planRecode.tzTime, "yyyy-MM-dd") %></td>
	                            </tr>
	                            <%}} %>
	                    </table>
	                </div>
				<%} %>
            </div>
        </div>
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
			  <div class="info">尚未开通<span class="red">第三方账户平台</span>，请<a href="<%=configureProvider.format(URLVariable.QLTB_REG_URL)%>" class="blue">马上开通</a>。</div>		    </div>
	</div>
</div>
<div class="clear"></div>

<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/yxlc.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script>
  $(function(){
	$(".checkbox_hf").click(function(){
		$(this).toggleClass("selected")
		var i=$(this).attr("class");
		if(i.indexOf("selected")>=0){
			$(this).parent().find("input").attr("checked",true);
			}else{
				$(this).parent().find("input").removeAttr("checked");
				}
		});
	});
   </script>

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
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%}else{%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSqz").val()));	
		$("div.popup_bg").show();
	</script>
	<%}}%>
	
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