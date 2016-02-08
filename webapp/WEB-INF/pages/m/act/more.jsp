<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.m.act.IdeaFeedback"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
		+ configureProvider
				.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "更多";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		 <div data-role="content" class="qcontent">
  	<div class="more_box">
        <div class="ydy_logo"><span></span></div>
        <div class="more_txt">
        	<div class="zjzz_links">
            	<a href="<%configureProvider.format(out,URLVariable.WAP_YJFK);%>" rel="external">意见反馈<span></span></a>
                <p>客服热线<a href="tel:4008805306"><%configureProvider.format(out, SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></a><span></span></p>
            </div>
        </div>
        <p class="worktime">客服工作时间 <%configureProvider.format(out, SystemVariable.SITE_WORK_TIME);%></p>
    </div>
  </div>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
</body>
</html>