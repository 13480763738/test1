<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.jiudian.framework.http.session.Session"%>
<%
	if (jiudianSession == null || !jiudianSession.isAuthenticated()) {
		controller.redirectLogin(request, response, configureProvider.format(URLVariable.WAP_LOGIN));
		return;
	}
%>