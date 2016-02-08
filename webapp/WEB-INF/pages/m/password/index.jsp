<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.password.IndexVerify"%>
<%@page import="com.jiudian.p2p.front.servlets.m.password.Index"%>
<html>
<head>
<%
String _TITLE_ = "找回密码 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	<%
		String type = ObjectHelper.convert(request.getAttribute("type"), String.class);
		String phoneError = ObjectHelper.convert(request.getAttribute("PHONE_ERROR"), String.class);
	%>

	<div id="wrap-all">
	<%@include file="/WEB-INF/include/wap/index/header.jsp"%>			
				<section class="photo-xg">
					<form action="<%=controller.getURI(request, Index.class)%>" method="post" class="form2" onsubmit="return onSubmit();">
						<input type="hidden" name="type" value="phone" />
						<ul>
							
							<li class="first">
								<label>手&nbsp;机&nbsp;号:</label>
								<input type="hidden" name="type" value="phone" />
								<input name="phone" placeholder="请输入手机号" type="text" class="stext required min-length-11 max-length-11 phonenumber" onblur="phoneCheck();"/>											
							</li>
							<li class="two">
								<label>验&nbsp;证&nbsp;码:</label>
								<input name="verifyCode" placeholder="请输入验证码" type="text" class="wjmm-yz required isint min-length-6 max-length-6" onblur="verifyCheck();">
								<span style="float: right;margin-top: -45px;"><img
									src="<%=controller.getURI(request, IndexVerify.class)%>?t=p"
									onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()'
									 height="60px" width="100px"  />
								</span>
								<div class=" clear"></div>		
							</li>
						</ul>
						<p id="errorMsg" style="color:#ff0000;height:20px;text-align: center;margin:-10px 0px -10px 0px;"><%=StringHelper.isEmpty(phoneError)?"":phoneError %></p>
						<div class="tj"> 
							<input type="submit" value="确认修改" fromname="form2"class="quren"/>
							</div>
					</form>
				</section>
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
<%-- 	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/validation.js"></script> --%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/forgetPwd.js"></script>
	<script>
			$(".menu-pic").click(function(){
				$(".menu-dw").show();
				return false;
			
			});
			$(document).click(function(){
				$(".menu-dw").hide();
			
			});
</script>
</body>
</html>