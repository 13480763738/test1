<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String _TITLE_ = "密码修改 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
   <div id="wrap-all">
	<!--头部-->
	 <%@include file="/WEB-INF/include/wap/index/header.jsp"%>
	<!--头部结束-->
    
    <!--恭喜您，密码修改成功-->
    <div class="khcg_ts">
        <div class="img_tishi"><img alt="开户成功" src="<%=controller.getStaticPath(request) %>/wap/images/icon_right.png"/></div>
        <div class="czcg_wenzitishi">恭喜您，密码修改成功</div> 
    </div>
    <div class="btn_MMXGCG" style="position:relative;">
        <img alt="密码修改成功" src="<%=controller.getStaticPath(request) %>/wap/images/btn_MMXGCG.png" />
		<a href="" style="position:absolute;display:block;width:80%;height:65px;top:0;left:10%;"></a>
    </div>
     <!--页脚共用部门-->
	<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
    <div class="tianchong"></div>