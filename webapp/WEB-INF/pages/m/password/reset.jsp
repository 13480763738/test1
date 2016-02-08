<%@page import="com.jiudian.p2p.front.servlets.m.password.Reset"%>
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
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	
	<%
		String accountId = serviceSession.getSession().getAttribute("PASSWORD_ACCOUNT_ID");
		if(StringHelper.isEmpty(accountId)){
			controller.sendRedirect(request, response, controller.getViewURI(request, com.jiudian.p2p.front.servlets.password.Index.class));
		}
		String error = controller.getPrompt(request, response, PromptLevel.ERROR);
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		String code = request.getParameter("code");
		String title = "\""+configureProvider.getProperty(SystemVariable.SITE_NAME) +"验证短信\" 已发送至您的手机";
		String subtitle ="";
		String st = "手机";
		subtitle = phone.substring(0,3)+"****"+phone.substring(7,11);
	%>
	 <div id="wrap-all">
	 <%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	 <section class="photo-xg">
	<form action="<%=controller.getURI(request, Reset.class) %>" class="form1" method="post" onsubmit="return onSubmit();">
	<input type="hidden" name="type" value="<%=type %>" />
	<input type="hidden" name="phone" value="<%=phone %>" />
		<p class="sjdx">
			<%=title+subtitle %>
		</p>
		<ul>
			<li>
				<label>手机验证码:</label>
				<input name="code" placeholder="请输入验证码" type="text" onblur="codeCheck();"/>
			</li>
			<li>
				<label>新&nbsp;&nbsp;密&nbsp;&nbsp;码:</label>
				<input name="password" placeholder="请输入密码" type="password" onblur="passwordCheck();"/>
			</li>
			<li style="border-bottom:0">
				<label>确认新密码:</label>
				<input  name="repassword" placeholder="请再次输入验证码" type="password" onblur="rePasswordCheck();"/>
			</li>
		</ul>
		<p id="errorMsg" style="color:#ff0000;height:20px;text-align: center;margin:-10px 0px -10px 0px;"><%StringHelper.filterHTML(out, error);%></p>
		<div class="tj">
		<input class="quren" type="submit" fromname="form1" value="提 交" />
		</div>
	</form>
	</section>
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
		<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/wap/js/reset.js"></script>
</body>
</html>