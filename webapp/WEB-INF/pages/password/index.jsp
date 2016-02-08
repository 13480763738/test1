<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.password.IndexVerify"%>
<%@page import="com.jiudian.p2p.front.servlets.password.Index"%>
<html>
<head>
<%
String _TITLE_ = "找回密码 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		String type = ObjectHelper.convert(request.getAttribute("type"), String.class);
		String emailError = ObjectHelper.convert(request.getAttribute("EMAIL_ERROR"), String.class);
		String evCodeError = ObjectHelper.convert(request.getAttribute("EMAIL_VERIFYCODE_ERROR"), String.class);
		String phoneError = ObjectHelper.convert(request.getAttribute("PHONE_ERROR"), String.class);
		String pvCodeError = ObjectHelper.convert(request.getAttribute("PHONE_VERIFYCODE_ERROR"), String.class);
	%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title2">找回密码</div>
				<div class="secret clearfix">
					<div class="secre_tab clearfix">
						<div class="email pr20">
							<span id="one1" style="cursor: pointer;" onclick="setTab('one',1,2)">使用绑定邮箱找回密码</span>
						</div>
						<div class="bound">
							<span id="one2"  style="cursor: pointer;" onclick="setTab('one',2,2)">使用绑定手机号找回密码</span>
						</div>
					</div>
					<form action="<%=controller.getURI(request, Index.class)%>" method="post" class="form1">
						<input type="hidden" name="type" value="email" />
						<div class="secrebd mt30 ml30 f14 clearfix" id="con_one_1"
								<%="email".equals(type)?"":"style=\"display: none;\"" %>>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>邮箱：
								</div>
								<div class="sinfo">
									<input name="email" type="text" class="stext required e-mail" />
									<p tip><%=StringHelper.isEmpty(emailError)?"请输入邮箱地址":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(emailError)?"":emailError %></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>验证码：
								</div>
								<div class="sinfo">
									<input name="verifyCode" type="text" class="stext required isint min-length-6 max-length-6" style=" float:left;"/> 
									<span style=" float:left; padding-left:6px;"><img
										src="<%=controller.getURI(request, IndexVerify.class)%>?t=e"
										width="54"
										onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()'
										height="31" /></span>
										<div class=" clear"></div>
									<p tip><%=StringHelper.isEmpty(evCodeError)?"请输入6位验证码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(evCodeError)?"":evCodeError %></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" fromname="form1" type="submit" value="提 交" />
							</div>
						</div>
					</form>
					<form action="<%=controller.getURI(request, Index.class)%>" method="post" class="form2">
						<input type="hidden" name="type" value="phone" />
						<div class="secrebd mt30 ml30 f14 clearfix" id="con_one_2"
							<%="phone".equals(type)?"":"style=\"display: none;\"" %>>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>手机号：
								</div>
								<div class="sinfo">
									<input name="phone" type="text" class="stext required min-length-11 max-length-11 phonenumber" />
									<p tip><%=StringHelper.isEmpty(phoneError)?"请输入手机号":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(phoneError)?"":phoneError %></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>验证码：
								</div>
								<div class="sinfo">
									<input name="verifyCode" type="text" class="stext required isint min-length-6 max-length-6" style=" float:left;" /> 
									<span style=" float:left; padding-left:6px;"><img
										src="<%=controller.getURI(request, IndexVerify.class)%>?t=p"
										onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()'
										width="54" height="31" /></span>
										<div class=" clear"></div>
									<p tip><%=StringHelper.isEmpty(pvCodeError)?"请输入6位验证码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(pvCodeError)?"":pvCodeError %></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" fromname="form2" type="submit" value="提 交" />
							</div>
						</div>
					</form>
					<div class="efont clearfix">若您无法使用上述方法找回，请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL) %></div>
				</div>
			</div>

		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>