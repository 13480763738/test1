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
	PropertyMange propertyMange = serviceSession.getService(PropertyMange.class);
	Property data = propertyMange.getProperty();
	if(data==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, UpdatePropertymsg.class)%>"
		method="post" class="form1" >
		<input type="hidden" name="save" value="0"/>
		<div class="contain clearfix">
			<div class="w1002 top_title">
				<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">薪金贷</a>
					&gt; 填写借款申请</span>
			</div>

			<!--step-->
			<div class="contain_main clearfix">
				<div class="ui_step ui_two"></div>
			</div>

			<%@include file="messagehead.jsp"%>

			<div class="about clearfix">
				<div class="sidebar fl">
					<ul class="barlist">
						<li class="first"></li>
						<li><a
							href="<%=controller.getURI(request, Basemessage.class)%>"><i></i>基本信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Familymessage.class)%>"><i></i>家庭信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Workmessage.class)%>"><i></i>工作信息</a></li>
						<li class="on"><a
							href="<%=controller.getURI(request, Propertymessage.class)%>"><i></i>资产信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Authormessage.class)%>"><i></i>其他信息</a></li>
					</ul>
				</div>
				<div class="container fr">
					<div class="public_tit">资产信息填写</div>
					<div class="home_content clearfix">
						<div class="tit clearfix mt20">信用信息</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit">&nbsp;</div>
								<div class="list_info">

									<%
										AttestationState state = lmoneyManage.getAttentiontype(AttestationType.XYBG);
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

								</div>
							</li>
						</ul>
						<div class="tit clearfix">房产信息</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit clearfix">
									<i class="red mr5">*</i>是否有房：
								</div>
								<div class="list_info">
									<label><input type="radio" name="ishouse"
										value="<%=IsHovestatus.Y.name()%>"
										<%if(!StringHelper.isEmpty(data.Ishouse) && data.Ishouse.equals(IsHovestatus.Y.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />有 </label><label><input
										type="radio" name="ishouse" value="<%=IsHovestatus.W.name()%>"
										<%if(StringHelper.isEmpty(data.Ishouse) || data.Ishouse.equals(IsHovestatus.W.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1" class="mr5" />无</label>
								</div>
							</li>
							<li>
								<div class="list_tit clearfix">
									<i class="red mr5">*</i>有无房贷：
								</div>
								<div class="list_info">
									<label><input type="radio" name="ishouseloan"
										value="<%=IsHovestatus.Y.name()%>"
										<%if(!StringHelper.isEmpty(data.Ishouseloan) && data.Ishouseloan.equals(IsHovestatus.Y.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />有 </label><label><input
										type="radio" name="ishouseloan"
										value="<%=IsHovestatus.W.name()%>"
										<%if(StringHelper.isEmpty(data.Ishouseloan) || data.Ishouseloan.equals(IsHovestatus.W.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1" class="mr5" />无</label>

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
									
								</div>
							</li>
						</ul>

						<div class="tit clearfix">车产信息</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit clearfix">
									<i class="red mr5">*</i>是否有车：
								</div>
								<div class="list_info">
								<label onclick="changeis(this,1);">
									<input type="radio" name="iscar"
										value="<%=IsHovestatus.Y.name()%>"
										<%if(!StringHelper.isEmpty(data.Iscar) && data.Iscar.equals(IsHovestatus.Y.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />有 </label>
								<label onclick="changeis(this,0)"><input
										type="radio" name="iscar" value="<%=IsHovestatus.W.name()%>"
										<%if(StringHelper.isEmpty(data.Iscar) || data.Iscar.equals(IsHovestatus.W.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1"  class="mr5" />无</label>
								</div>
							</li>
							<li class="isshow">
								<div class="list_tit clearfix">
									<i class="red mr5">*</i>是否车贷：
								</div>
								<div class="list_info">
									<label><input type="radio" name="iscarloan"
										value="<%=IsHovestatus.Y.name()%>"
										<%if(!StringHelper.isEmpty(data.Iscarloan) && data.Iscarloan.equals(IsHovestatus.Y.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />有 </label>
									<label><input
										type="radio" name="iscarloan"
										value="<%=IsHovestatus.W.name()%>"
										<%if(StringHelper.isEmpty(data.Iscarloan) || data.Iscarloan.equals(IsHovestatus.W.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1" class="mr5" />无</label>
								</div>
							</li>
							<li>
						   		<div class="list_tit">&nbsp;</div>
							   <div class="list_info">
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
								</div>
							</li>
							<li class="isshow">
					                 <div class="list_tit clearfix"><i class="red mr5">*</i>购车年份：</div>
					                 <div class="list_info">
					                   <select name="gcnf" class="sel">
					                    <%
											for(int i=2014;i>=1900;i--){
										%>
										<option <%if(data.gcnf==i){%> selected="selected" <%}%> value="<%=i%>"><%=i%></option>
										<%
											}
										%>
					                   </select>    
					                 </div>
					            </li>
								<li class="isshow">
				                  <div class="list_tit clearfix"><i class="red mr5">*</i>汽车品牌：</div>
				                  <div class="list_info">
				                    <input name="qcpp" value="<%StringHelper.filterHTML(out, data.qcpp);%>" type="text" class="put required max-length-30" />
				                    <p tip></p>
									<p errortip class="" style="display: none"></p>
				                  </div>
				               </li>
				               <li class="isshow">
				                  <div class="list_tit clearfix"><i class="red mr5">*</i>车牌号码：</div>
				                  <div class="list_info">
				                    <input name="cphm" value="<%StringHelper.filterHTML(out, data.cphm);%>" type="text" class="put required max-length-30" />
				                    <p tip></p>
									<p errortip class="" style="display: none"></p>
				                  </div>
				               </li>
							
							
							<li>
								<div class="list_tit">&nbsp;</div>
								<div class="list_info pt20">
									<input type="submit" class="btn btn01 fl mr10 sumbitForme"
										value="下一步" fromname="form1" savefromname /> <input type="submit"
										class="btn btn01 fl sumbitForme" fromname="form1" value="保存" />
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</div>
	</form>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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
	
	function changeis(evn,msg){
		if(msg == "1"){
			$(".isshow").show();
		}
		if(msg == "0"){
			$(".isshow").hide();
		}
	}
	
	$(function(){
		$iscar = $("input[name='iscar'][checked]").val();
		if($iscar == "Y"){
			$(".isshow").show();
		}else{
			$(".isshow").hide();
		}
		
	});
	
	</script>
</body>
</html>