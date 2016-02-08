<%@page import="com.jiudian.p2p.front.servlets.m.Xgmm"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%if(jiudianSession!=null&&!jiudianSession.isAuthenticated()){controller.sendRedirect(request, response,configureProvider.format(URLVariable.WAP_INDEX));return;} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "修改密码 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
WAP_TITLE_NAME="修改密码";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	 <%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
		<div data-role="page">
			<div data-role="header" class="qheader">
			<h1><%=WAP_TITLE_NAME%></h1>
			<a href="javascript:history.back(-1);" class="return_up" rel="external">返回</a>
			<div class="menubox">
				<a href="#" class="header_list"></a>
				<div class="header_menu">
					<div class="menu_list">
						<a href="<%configureProvider.format(out, URLVariable.WAP_INDEX);%>"
							class="home" rel="external"><span>首页</span></a> <a
							href="<%configureProvider.format(out, URLVariable.WAP_USER_INDEX);%>"
							class="account" rel="external"><span>我的账户</span></a> 
							<a href="<%configureProvider.format(out,URLVariable.WAP_MORE);%>" class="more"  rel="external"><span>更多</span></a>
					</div>
					<span class="ico_sj"></span>
				</div>
			</div>
		</div>
		<form action="<%=controller.getURI(request, Xgmm.class)%>" data-ajax="false" method="post" onsubmit="return onSubmit()">
		<div data-role="content" class="qcontent">
			<div class="xgmm_box"><p>您的账户当前使用的是系统默认密码，为确保您的账号资金安全，请更改您的登录密码！</p></div>
		  	<div class="login_box" style="margin-top:2.2rem;">
			  <div class="box_login xgmm">
			        	<div class="login_user"><span>新密码</span><input  name="password" type="password" onblur="passwordCheck()" maxlength="16" placeholder="6~16个字符，区分大小写" ></div>
			            <div class="login_user"><span>确认密码</span><input name="newPassword"  type="password" placeholder="确认密码" maxlength="16" onblur="rePasswordCheck()" ></div>
		        </div>
		    </div>
		    <div class="box_login">
		    	<p class="error_tip" id="error_mesg" style=""><%StringHelper.filterHTML(out, errorMessage);%></p>
		    </div>
		    <div class="center_padding">
		    	<div class="login_btn">
		       	  <input type="submit" value="确认修改">
		        </div>
		    </div>
	    </div>
		</form>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/register.js"></script>
</body>
</html>
