<%@include file="/WEB-INF/include/jquery1.jsp" %>
<%if(JQUERY_UI_NOT_INCLUDED){%>
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/css/smoothness/jquery-ui-1.10.4.custom.min.css" media="screen" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/jquery-ui-1.10.4.custom.min.js" charset="UTF-8"></script>
<%JQUERY_UI_NOT_INCLUDED=false;}%>
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/js/upload/js/jquery.ui.plupload/css/jquery.ui.plupload.css" media="screen" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/upload/js/plupload.full.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/upload/js/jquery.ui.plupload/jquery.ui.plupload.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/upload/js/i18n/zh_CN.js"></script>