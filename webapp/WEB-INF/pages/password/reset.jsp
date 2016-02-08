<%@page import="com.jiudian.p2p.front.servlets.password.Reset"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String _TITLE_ = "找回密码 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		String accountId = serviceSession.getSession().getAttribute("PASSWORD_ACCOUNT_ID");
		if(StringHelper.isEmpty(accountId)){
			controller.sendRedirect(request, response, controller.getViewURI(request, com.jiudian.p2p.front.servlets.password.Index.class));
		}
		String error = controller.getPrompt(request, response, PromptLevel.ERROR);
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		String title = "\""+configureProvider.getProperty(SystemVariable.SITE_NAME) +"验证短信\" 已发送至您的手机";
		String subtitle ="";
		String st = "手机";
		if("email".equals(type)){
			title = "\""+configureProvider.getProperty(SystemVariable.SITE_NAME) +"验证邮件\" 已发送至您的邮箱";
			subtitle = email.substring(0,1)+"******@"+email.split("@")[1];
			st = "邮箱";
		}else{
			subtitle = phone.substring(0,3)+"****"+phone.substring(7,11);
		}
	%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title">找回密码</div>
				<div class="secret clearfix">
					<div class="f24 tc"><%=title %></div>
					<div class="f24 tc"><%=subtitle %></div>
					<form action="<%=controller.getURI(request, Reset.class) %>" class="form1" method="post">
					<input type="hidden" name="email" value="<%=email %>" />
					<input type="hidden" name="phone" value="<%=phone %>" />
					<input type="hidden" name="type" value="<%=type %>" />
						<div class="secrebd mt30 ml30 f14 clearfix">
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span><%=st %>验证码：
								</div>
								<div class="sinfo">
									<input name="code" type="text" class="stext fl required isint min-length-6 max-length-6" /> 
									<p class="clear"></p>
									<p tip><%=StringHelper.isEmpty(error)?"请输入您收到的6位数验证码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(error)?"":error %></p>
									<span class="fl"></span>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>新密码：
								</div>
								<div class="sinfo">
									<input name="password" type="password" class="stext required password-a min-length-6 max-length-16" />
									<p tip>请输入6-16个字符，区分大小写</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>确认密码：
								</div>
								<div class="sinfo">
									<input name="repassword" type="password" class="stext required password-b min-length-6 max-length-16" />
									<p tip>请再次输入密码</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" type="submit" fromname="form1" value="提 交" />
							</div>
							<div class="efont clearfix">若您无法使用上述方法找回，请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL) %></div>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>