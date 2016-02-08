<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Term"%>
<%@page import="com.jiudian.p2p.front.service.information.TermManage"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "理财体验 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	<%
		TermType termType = TermType
					.valueOf(request.getParameter("id"));
			if (termType == null) {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
			
			
			WAP_TITLE_NAME = termType.getName();
	%>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<%
			TermManage termManage = serviceSession
						.getService(TermManage.class);
				Term term = termManage.get(termType);
		%>
		<%
			if (term != null) {
		%>
		<%
			StringHelper.format(out, term.content, fileStore);
					termManage.view(termType);
		%>
		<%
			}
		%>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>