<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<%@page import="com.jiudian.p2p.front.servlets.m.p2plicai.yxlc.AddTyjAjax"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.ExperiencePlan"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "立即申请";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%

	FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
	FinancingPlanInfo caInfo= service.getNewPlan();
	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
	String isYuqi =  userInfoManage.isYuqi();
	BigDecimal tzMoney =  service.tzMoney(caInfo.id);
	
	String safetyError = "error";

	if(jiudianSession==null || jiudianSession.isAuthenticated()){
		LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
		LmoneyDecide lm = lmoneyManage.getLmoneyDecide("");
		if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
			safetyError = "error";
		}else if(StringHelper.isEmpty(lm.password)  || StringHelper.isEmpty(lm.phoneNumber)){
			safetyError = "error";
		}else{
			safetyError = "success";
		}
	}
	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<form action="<%configureProvider.format(out,URLVariable.WAP_USER_JRLCTY);%>" id="form2" data-ajax="false" method="post">
		<input type="hidden" id="yxId" name="yxId" value="<%=caInfo.id%>">
		<input type="hidden" id="syMoney" name="syMoney" value="<%=caInfo.syMoney == null ?0 : caInfo.syMoney%>">
		<input type="hidden" id="maxMoney" name="maxMoney" value="<%=caInfo.maxMoney == null ?0 : caInfo.maxMoney%>">
		<input type="hidden" id="yxlcSucc" name="yxlcSucc" value="<%configureProvider.format(out, URLVariable.WAP_LCTY);%>">
		<input name="gmMoney" maxlength="10" type="hidden" class="sy_input" id="gmMoney" value="0" />
		<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
		<input type="hidden" id="tzMoney" name="tzMoney" value="<%=tzMoney%>">
		<input type="hidden" id="jrfl" name="jrfl" value="<%=caInfo.jrfl%>">
		<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
		<input type="hidden" id="safetyError" value="<%=safetyError%>">
		<div data-role="content" class="qcontent">
			<div class="syje_box">
				<div class="syje_list">
					<em>剩余金额</em>
					<div>
						<span><%=Formater.formatAmount(caInfo.syMoney)%></span>元
					</div>
				</div>
			</div>
			<div class="syje_box">
				<div class="syje_list">
					<em>每人可加入金额上限</em>
					<div>
						<span><%=Formater.formatAmount(caInfo.maxMoney)%></span>元
					</div>
				</div>
			</div>
			<div class="lqtyq_box">
				<div class="lqtyq">
					<div>
						<span>请选择体验券<a href="javascript:void(0)" id="get_ex" rel="external">（获取）</a></span>
					</div>
					<%
					if(PlanInvestmenWay.TYJ.equals(caInfo.planInvestmenWay)){
						ExperiencePlan[] exs =  service.getTyj();
						int idx=0; 
						if(exs!=null)for(ExperiencePlan ex : exs){idx++;if(idx>3){break;}%>
					<p>
						<label><input type="checkbox" name="ex" amount="<%=ex.amount.intValue()%>" value="<%=ex.experienceNum %>" >
						<%=ex.experienceNum %>（<%=Formater.formatAmount(ex.amount)%>元）</label>
					</p>
					<%}}%>
					<div class="xztyj">
						<p>
							当前选择体验金：<span id="checkamont">0.00</span>元
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="sqtyq">
		  	<input type="button" id="tbButton" value="申请">
		</div>
		
			<div class="tc_box" id="ensure_apply" style="display:none;">
				<div class="hqtyj">
			    	<h2>购买确认</h2>
			        <div class="txt_box">
			            <div class="text_box">
			            	<p>您此次申请理财体验需使用<br/><span id="zgxMoney">0</span>元体验金</p>
			            </div>
			        </div>
			        <div class="btn_box">
			        	<input type="button" onclick="clear_dialog('ensure_apply',0,0)" value="取消" class="qx_btn">
			            <input type="button" id="ok" value="确认" class="qr_btn">
			        </div>
			    </div>
			</div>
		
		</form>
		
		<%@include file="/WEB-INF/include/wap/getexperience.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript">
		$("input[name=ex]").change(function (){
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
	
	<script type="text/javascript">
	var _URL = "<%=controller.getURI(request, AddTyjAjax.class)%>";
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/validation.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/dialog.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/getexperiences.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/yxlc.js"></script>
	
	
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=message%>",$("#yxlcSucc").val());	
		});
		
	</script>

	<%}%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=errorMessage%>");
		});
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=warnMessage%>");
		});
	</script>
	<%
		}
	%>
	
	
</body>
</html>