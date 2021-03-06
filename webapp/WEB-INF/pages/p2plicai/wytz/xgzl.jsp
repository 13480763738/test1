<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<html>
<head>
<%
	if (jiudianSession == null || !jiudianSession.isAuthenticated()) {
%>
	<script type="text/javascript">
		parent.location.reload();
	</script>		
<%
	}
String cityid="";

String _TITLE_ = "散标详情 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/blueimp-gallery.css" />
</head>
<body>
<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	Xgzl[] xgzl = creditManagePayment.getXgzl(id);
	
%>
<div class="img_box">
<%if(xgzl.length==0){%><div class="f16" style="line-height:32px;"><%out.print("无相关资料");%></div><%}%>
<%if(xgzl != null){ for(Xgzl x:xgzl){ %>
		<a data-gallery="gallery-contract" title="<%StringHelper.filterHTML(out, x.name);%>" href="<%=fileStore.getURL(x.imge)%>" class="document">
			<div class="img-polaroid">
				<div class="thumb">
					<img src="<%=fileStore.getURL(x.imge)%>" alt="<%=_ALT%>">
				</div>
			</div>
			<div class="clear"></div>
			<p class="document-name"><%StringHelper.filterHTML(out, x.name);%></p>
		 </a>
		 <%}} %> 
		 <div class="clear"></div>
</div>

<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <ol class="indicator"></ol>
</div> 
<div class="clear"></div>  
</body>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/blueimp-gallery.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.blueimp-gallery.js"></script>

</html>