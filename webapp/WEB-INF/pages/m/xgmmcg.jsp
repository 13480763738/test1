<%@page import="com.jiudian.p2p.front.servlets.m.Xgmm"%>
<%@page import="com.jiudian.p2p.front.servlets.m.CheckNameExists"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Send"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Mterm"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Register"%>
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
String _TITLE_ = "修改密码成功 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
WAP_TITLE_NAME="修改密码成功";
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
		<div data-role="content" class="qcontent">
  	<div class="xgmm_box mmxgcg"><p>密码修改成功</p></div>
    <div class="center_padding">
    	<div class="login_btn">
        	<div><a href="<%configureProvider.format(out, URLVariable.WAP_INDEX);%>" rel="external" class="returnhome">返回首页</a></div>
        </div>
    </div>
  </div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/register.js"></script>
</body>
</html>
