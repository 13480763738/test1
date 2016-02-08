<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.*"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.*"%>
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
	LmoneyDecide lm = lmoneyManage.getLmoneyDecide( CreditType.SYD.name());
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
		controller.sendRedirect(request, response, controller.getURI(request, Syd.class));
	}
	
	FamilyManage familyManage = serviceSession.getService(FamilyManage.class);
	Family data = familyManage.getFamily();
	if(data==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, UpdateFamilymsg.class)%>"
		method="post" class="form1" >
		<input type="hidden" name="save" value="0"/>
		<div class="contain clearfix">
			<div class="w1002 top_title">
				<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">生意贷</a>
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
						<li class="on"><a
							href="<%=controller.getURI(request, Familymessage.class)%>"><i></i>家庭信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Companymessage.class)%>"><i></i>公司信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Propertymessage.class)%>"><i></i>资产信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Authormessage.class)%>"><i></i>其他信息</a></li>
					</ul>
				</div>
				<div class="container fr">
					<div class="public_tit">家庭信息填写</div>
					<div class="home_content clearfix">
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit clearfix">
									<i class="red mr5">*</i>婚姻状况：
								</div>
								<div class="list_info">
									<label><input type="radio" name="marriage"
										value="<%=MarriageStatus.YH.name()%>"
										<%if(!StringHelper.isEmpty(data.Marriagestatus) &&  data.Marriagestatus.equals(MarriageStatus.YH.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />已婚</label>
									<label><input
										type="radio" name="marriage"
										value="<%=MarriageStatus.WH.name()%>"
										<%if(StringHelper.isEmpty(data.Marriagestatus) || data.Marriagestatus.equals(MarriageStatus.WH.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1" class="mr5" />未婚</label>
								</div>
							</li>
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>有无子女：
								</div>
								<div class="list_info">
									<label><input type="radio" name="children"
										value="<%=IsHovestatus.Y.name()%>"
										<%if(!StringHelper.isEmpty(data.Ischildren) && data.Ischildren.equals(IsHovestatus.Y.name())){%>
										checked="checked" <%}%> id="RadioGroup1_0" class="mr5" />有 </label>
									<label><input
										type="radio" name="children"
										value="<%=IsHovestatus.W.name()%>"
										<%if(StringHelper.isEmpty(data.Ischildren) || data.Ischildren.equals(IsHovestatus.W.name())){%>
										checked="checked" <%}%> id="RadioGroup1_1" class="mr5" />无</label>
									<%
									AttestationState state = lmoneyManage.getAttentiontype(AttestationType.JHRZ);
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
								</div>
							</li>
						</ul>
						<div class="tit clearfix">直系亲属</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>姓 名：
								</div>
								<div class="list_info">
									<input name="zxname" type="text"
										value="<%StringHelper.filterHTML(out, data.Zxname);%>"
										class="put w280 required max-length-32" />
									<p tip>不超过32个字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>关 系：
								</div>
								<div class="list_info">
									<input name="zxrelation" type="text"
										value="<%StringHelper.filterHTML(out, data.Zxrelation);%>"
										class="put w280 required max-length-10" />
									<p tip>不超过10个字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>手 机：
								</div>
								<div class="list_info">
									<input name="zxphone" type="text"
										value="<%StringHelper.filterHTML(out, data.Zxphone);%>"
										class="put w280 required max-length-11 phonenumber" />
									<p tip>输入手机号</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
						</ul>

						<div class="tit clearfix">其他联系人</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>姓 名：
								</div>
								<div class="list_info">
									<input name="qtname" type="text"
										value="<%StringHelper.filterHTML(out, data.Qtname);%>"
										class="put w280 required max-length-32" />
									<p tip>不超过32个字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>关 系：
								</div>
								<div class="list_info">
									<input name="qtrelation" type="text"
										value="<%StringHelper.filterHTML(out, data.Qtrelation);%>"
										class="put w280 required max-length-10" />
									<p tip>不超过10个字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_tit">
									<i class="red mr5">*</i>手 机：
								</div>
								<div class="list_info">
									<input name="qtphone" type="text"
										value="<%StringHelper.filterHTML(out, data.Qtphone);%>"
										class="put w280 required max-length-11 phonenumber" />
									<p tip>输入手机号</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="list_tit">&nbsp;</div>
								<div class="list_info pt20">
									<input type="submit" class="btn btn01 fl mr10 sumbitForme"
										value="下一步" fromname="form1" savefromname /> <input type="submit"
										class="btn btn01 fl sumbitForme" fromname="form1"  value="保存" />
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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