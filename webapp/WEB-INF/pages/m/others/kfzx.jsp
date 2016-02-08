<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
		String _TITLE_ = "客服中心- P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
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
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
  <div class="service">
        <span>联系客服</span>
    </div>
    <div class="service_1">
          <p>关于麒麟通宝，您有任何疑问请随时拨打我们的<br>
           客服热线：<%configureProvider.format(out, SystemVariable.SITE_CUSTOMERSERVICE_TEL);%><br>
           真诚期待您的来电！</p>
    </div>
    <!--触屏、电脑版切换-->
    <!--  <div class="chuping">
        <p>触屏版 | <span>电脑版<span></p>
     </div> -->
<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</div>
</body>
</html>