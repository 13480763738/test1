<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.Mterm"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "立即投标";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
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
	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
	UserInfo userInfo= userInfoManage.search();
	String isYuqi =  userInfoManage.isYuqi();
	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		
		<form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.WAP_USER_SBTB);%>">
		<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
		<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
		<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.kyMoney%>">
		<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
		<input type="hidden" name="syfs" id="syfs" value="<%=syfs%>">
		<input type="hidden" id="_hkfs" value="<%=creditInfo.repaymentType.name()%>"/>
		<input type="hidden" id="_jkzq" value="<%=creditInfo.creditCycle.name()%>"/>
		<input type="hidden" id="_nll" value="<%=creditInfo.rate%>"/>
		<input type="hidden" id="_hkqs" value="<%=creditInfo.term%>"/>
		<input type="hidden" id="_jlll" value="<%=creditInfo.jlll.doubleValue()%>"/>
		<input type="hidden" id="mfMoney" value="<%=mfjg%>">
		<input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.WAP_SBTZLB);%>?pt=<%=creditInfo.productType.name()%>">
		<input type="hidden" name="isWap" value="1">
		
		<%
		BigDecimal sjgmfs=new BigDecimal(0);
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
		
		<div data-role="content" class="qcontent">
		  	<div class="syje_box">
		    	<div class="syje_list"><em>剩余金额</em><div><span><%=Formater.formatAmount(creditInfo.remainAmount)%></span>元</div></div>
		    </div>
		    <div class="syje_box">
		    	<div class="syje_list"><em>可用金额</em><div><span><%=Formater.formatAmount(userInfo.kyMoney) %></span>元</div></div>
		    </div>
		    <div class="syje_box">
		    	<div class="syje_list"><em>可购买份数</em><div><span><%=sjgmfs%></span>份</div></div>
		    </div>
		    <div class="lqtyq_box">
		        <div class="gmfs_box">
		        	<div><span>请输入购买份数</span></div>
		            <div class="gmfs_input">
		            	<a class="left_btn" href="javascript:void(0);">-</a>
		            	<input name="amount" maxlength="10" class="text_input_hf" type="text" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)"  value="1" />
		                <a class="right_btn" href="javascript:void(0);">+</a>
		                <em>份</em>
		            </div>
		            <div><span>预计收益<span id="_yjsy">0.00</span>元+奖<span id="_yjjl">0.00</span>元</span></div>
		        </div>
		    </div>
	    </div>
	    
	    <div class="sqtyq">
	    	<%
			if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
			%>
			<span class="lcty_ljsq span">敬请期待</span>
			<%}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){ 
			%>
			<input type="button" id="tbButton" value="立即投标" fromname="form1" class="sumbitForme" >
			<%}else if(creditInfo.status==CreditStatus.YMB){ %>
			<span class="lcty_ljsq span">已满标</span>
			<%}else if(creditInfo.status==CreditStatus.YFK){ %>
			<span class="lcty_ljsq span">还款中</span>
			<%}%>
	    </div>
	    
	    
	    <div class="tc_box hq" id="confirm_join" style="display: none;">
			<div class="hqtyj">
				<h2>购买确认</h2>
				<div class="txt_box">
					<div class="text_box">
						<p>
							您此次购买份数为<span id="fs">0</span>份，<br />
							每份价格<span id="mfjg"><%=mfjg%></span>元，总需<span id="zxMoney">0.00</span>元
						</p>
						<div class="box_login" style="width:100%; float:none; "><p style="line-height:1.2rem;">
						<label>
						<input type="checkbox" checked="checked" value="1" id="isread" name="isread"><span style="color:#5a5a5a;">我同意</span></label>
						<%if(creditInfo.creditType == CreditType.XYDB){%>
						<a href="<%=controller.getPagingItemURI(request, Mterm.class, TermType.DBBXY.name()) %>" rel="external" >《借款协议》</a>
						<%}else if(creditInfo.creditType == CreditType.SDRZ){%>
						<a href="<%=controller.getPagingItemURI(request, Mterm.class, TermType.SDRZBXY.name()) %>" rel="external" >《借款协议》</a>
						<%}else{%>
						<a href="<%=controller.getPagingItemURI(request, Mterm.class, TermType.XYRZBXY.name()) %>" rel="external" >《借款协议》</a>
						<%} %></p></div>
					</div>
				</div>
				<div class="btn_box">
					<input type="button" onclick="clear_dialog('confirm_join',0,0)" value="取消" class="qx_btn"> 
					<input type="button"  id="ok" value="确认" class="qr_btn">
				</div>
			</div>
		</div>
	    
        </form>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/dialog.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/sbtz.js"></script>
	
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=message%>",$("#sbSucc").val());	
		});
	</script>
	<%
		}
	%>
	
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