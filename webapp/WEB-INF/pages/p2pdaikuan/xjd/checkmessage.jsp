<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.*"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.*"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<%
String _TITLE_ = "P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int id = 0;
	LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
	LmoneyDecide lm = lmoneyManage.getLmoneyDecide( CreditType.XJD.name());
	if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=2");
	return ;
		//跳转到实名认证页面
	}
	if(StringHelper.isEmpty(lm.password)){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=3");
		//跳转到设置体现密码页面
		return;
	}
	id = lm.id;
	if(id==0){
		controller.sendRedirect(request, response, controller.getURI(request, Xjd.class));
	}
	LmoneyshManage lmoneyshManage = serviceSession.getService(LmoneyshManage.class);
	Lmoneysh data =  lmoneyshManage.getLmoneysh(CreditType.XJD.name());
	if(data==null || data.money.intValue() == 0){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class));
		return;
	}
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>

	<div class="contain clearfix">
		<div class="w1002 top_title">
			<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">薪金贷</a> &gt;
				审核</span>
		</div>

		<!--step-->
		<div class="contain_main clearfix">
			<div class="ui_step ui_three"></div>
		</div>

		<div class="contain_main clearfix">
			<div class="pub_title">
				借钱<span class="f14 ml50"><a href="<%=controller.getURI(request, Showcredit.class)%>" class="blue">借款申请信息预览</a></span>
			</div>
			<div class="borrow_money clearfix">
				<ul>
					<li>借款金额：<i class="f20"><%=data.money%></i>元
					</li>
					<li>年利率：<i class="f20"><%=Formater.formatRate(data.rating.doubleValue())%></i>
					</li>
					<li>借款期限：
					<%if(CreditCycle.AYHK.equals(data.creditCycle)){%><i class="f20"><%=data.Ctime%></i>个月
       			   <%}if(CreditCycle.TB.equals(data.creditCycle)){%><i class="f20"><%=data.Ctime%></i>天
       			   <%}if(CreditCycle.MB.equals(data.creditCycle)){%><i class="f20">满额即还</i><%}%>
					</li>
					<li><i class="fl">信用等级：</i>
					<%if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.HR) {%><i class="level lev_icon07 fl mt10"></i>
            		<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.E) {%><i class="level lev_icon06 fl mt10"></i>
            		<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.D) {%><i class="level lev_icon05 fl mt10"></i>
            		<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.C) {%><i class="level lev_icon03 fl mt10"></i>
					<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.B) {%><i class="level lev_icon02 fl mt10"></i>
					<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.A) {%><i class="level lev_icon01 fl mt10"></i>
					<%} else if (CreditLevel.Level(data.integral,configureProvider) == CreditLevel.AA) {%><i class="level lev_icon04 fl mt10"></i><%}%>
					<li>借款进度：
					<%if(CreditStatus.SQZ.name().equals(data.type)){%>
					<%=CreditStatus.SQZ.getName()%> 
					<%}if(CreditStatus.DSH.name().equals(data.type)){%>
 					<%=CreditStatus.DSH.getName()%> 
 					<%}if(CreditStatus.TBZ.name().equals(data.type)){%>
 					<%=CreditStatus.TBZ.getName()%> 
 					<%}if(CreditStatus.YMB.name().equals(data.type)){%>
 					<%=CreditStatus.YMB.getName()%> 
 					<%}if(CreditStatus.YDF.name().equals(data.type)){%>
 					<%=CreditStatus.YDF.getName()%> 
 					<%}%>
					</li>
				</ul>
			</div>

			<div class="pub_title pt20">认证状态</div>
			<div class="borrow_money clearfix">
				<div class="pt10 ml10">必要信息认证</div>
				<div class="must_info">
					<%
						AttestationState state = lmoneyManage.getAttentiontype(AttestationType.SFRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico1"></dt>
						<dd>
							<p class="f18">身份认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isidcard) && data.Isidcard.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico1"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">身份认证（必要认证）</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico1"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">身份认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico1"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">身份认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.GZRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico6"></dt>
						<dd>
							<p class="f18">工作认证（必要认证）</p>
							<p>
									<a href="javascript:void(-1);" onclick="tcc(this,'Job','<%=controller.getViewURI(request, Job.class)%>','工作认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iswork) && data.Iswork.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico6"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">工作认证（必要认证）</p>
							<p>
								<i class="btn btn06" >通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico6"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">工作认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Job','<%=controller.getViewURI(request, Job.class)%>','工作认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico6"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">工作认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Job','<%=controller.getViewURI(request, Job.class)%>','工作认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.XYBG);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico9"></dt>
						<dd>
							<p class="f18">信用报告（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Credit','<%=controller.getViewURI(request, Credit.class)%>','信用报告')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.IsCredit) && data.IsCredit.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico9"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">信用报告（必要认证）</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
		
					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico9"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">信用报告（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Credit','<%=controller.getViewURI(request, Credit.class)%>','信用报告')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico9"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">信用报告（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Credit','<%=controller.getViewURI(request, Credit.class)%>','信用报告')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					

					<%
						state = lmoneyManage.getAttentiontype(AttestationType.SRZM);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico8"></dt>
						<dd>
							<p class="f18">收入认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Ismmoney) && data.Ismmoney.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico8"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">收入认证（必要认证）</p>
							<p>
								<i class="btn btn06" >通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico8"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">收入认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico8"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">收入认证（必要认证）</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
				</div>
				<div class="clear must_line"></div>
				<div class="pt10 ml10">可选信息认证</div>
				<div class="must_info">
				
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.FCRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico10"></dt>
						<dd>
							<p class="f18">房产认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'House','<%=controller.getViewURI(request, House.class)%>','房产认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Ishousean) && data.Ishousean.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico10"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">房产认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico10"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">房产认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'House','<%=controller.getViewURI(request, House.class)%>','房产认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico10"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">房产认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'House','<%=controller.getViewURI(request, House.class)%>','房产认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.GCRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico12"></dt>
						<dd>
							<p class="f18">购车认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Car','<%=controller.getViewURI(request, Car.class)%>','购车认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iscaran) && data.Iscaran.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico12"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">购车认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico12"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">购车认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Car','<%=controller.getViewURI(request, Car.class)%>','购车认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico12"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">购车认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Car','<%=controller.getViewURI(request, Car.class)%>','购车认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.JHRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico5"></dt>
						<dd>
							<p class="f18">结婚认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Married','<%=controller.getViewURI(request, Married.class)%>','结婚认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Ismarrige) && data.Ismarrige.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico5"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">结婚认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico5"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">结婚认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Married','<%=controller.getViewURI(request, Married.class)%>','结婚认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico5"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">结婚认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Married','<%=controller.getViewURI(request, Married.class)%>','结婚认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.XLRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico2"></dt>
						<dd>
							<p class="f18">学历认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iseducation) && data.Iseducation.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico2"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">学历认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico2"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">学历认证</p>
							<p>
							<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico2"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">学历认证</p>
							<p>
							<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.JSZCRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico7"></dt>
						<dd>
							<p class="f18">技术职称认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Ispst) && data.Ispst.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico7"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">技术职称认证</p>
							<p>
								<i class="btn btn06" >通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico7"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">技术职称认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico7"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">技术职称认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.SJSMRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico3"></dt>
						<dd>
							<p class="f18">手机实名认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isphone) && data.Isphone.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico3"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">手机实名认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico3"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">手机实名认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico3"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">手机实名认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.WBRZ);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico11"></dt>
						<dd>
							<p class="f18">微博认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iswoboan) && data.Iswoboan.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico11"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">微博认证</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico11"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">微博认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico11"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">微博认证</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
									 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					
					<%
						state = lmoneyManage.getAttentiontype(AttestationType.JZDZM);
						if(state.equals(AttestationState.WYZ)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico4"></dt>
						<dd>
							<p class="f18">居住证明</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isjuzhu) && data.Isjuzhu.equals(AttestationStatus.YYZ.name())){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico4"></dt>
						<dt class="ico13"></dt>
						<dd>
							<p class="f18">居住证明</p>
							<p>
								<i class="btn btn06">通过</i>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

					<%
						if(state.equals(AttestationState.WTG)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico4"></dt>
						<dt class="ico15"></dt>
						<dd>
							<p class="f18">居住证明</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>
					<%
						if(state.equals(AttestationState.DSH)){
					%>
					<dl class="yw_jcxx clearfix">
						<dt class="ico4"></dt>
						<dt class="ico14"></dt>
						<dd>
							<p class="f18">居住证明</p>
							<p>
								<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
								 class="btn btn01" >立即认证</a>
							</p>
						</dd>
					</dl>
					<%
						}
					%>

				</div>
			</div>
		</div>

	</div>


	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript">
	function tcc(evn,tid,url,titl) {
		global_art = art.dialog.open(url,{
			id : tid,
			title : titl,
			opacity : 0.1,
			width : 783,
			height : 500,
			lock : true,
			close : function() {
				var iframe = this.iframe.contentWindow;
				var isupload = iframe.document.getElementById('isupload');
				if(isupload == null || "" == isupload || "undefind" == isupload){
					
				}
				if(isupload.value == "1"){
					
					$(evn).parent().parent().before('<dt class="ico14"></dt>');
				}
			}
		}, false);
		
	}
	</script>
</body>
</html>
