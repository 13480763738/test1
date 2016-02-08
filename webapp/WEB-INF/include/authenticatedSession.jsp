<%@page import="java.net.URLEncoder"%>
<%@page import="com.jiudian.framework.http.session.Session"%>
<%
	if (jiudianSession == null || !jiudianSession.isAuthenticated()) {
		controller.redirectLogin(request, response, configureProvider.format(URLVariable.LOGIN));
		return;
	}
%>