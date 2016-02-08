<%@page import="com.jiudian.p2p.front.service.information.entity.Term"%>
<%@page import="com.jiudian.p2p.front.service.information.TermManage"%>
<%
	TermType termType = TermType.valueOf(request.getParameter("id"));
	if(termType==null){
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String _TITLE_ = " - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=termType.getName() %><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body style="min-width:0px">
<%
	TermManage termManage = serviceSession.getService(TermManage.class);
	Term term = termManage.get(termType);
%>
<div class="protocol">
  <div class="tit">
     <h2><strong><%-- <%configureProvider.format(out, SystemVariable.SITE_NAME);%><%=termType.getName() %> --%></strong></h2>
     <p><%-- 最后更新时间：<%if(term!=null){%><%=DateParser.format(term.updateTime)%><%}%>--%></p>
  </div>
  <div class="con">
    <%if(term!=null){%>
    <%
    	StringHelper.format(out, term.content, fileStore);
    	termManage.view(termType);
    %>
    <%}%>
  </div>
</div>
</body>
</html>
