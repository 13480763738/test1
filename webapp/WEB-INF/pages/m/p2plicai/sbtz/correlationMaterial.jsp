<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "相关资料";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/wap/css/swipebox.css" />
</head>

<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	Xgzl[] xgzl = creditManagePayment.getXgzl(id);	
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
			<div data-role="content" class="qcontent">
				<%if(xgzl.length==0){out.print("无相关资料");} %>
			  	<ul class="gallery square-thumb" id="gallery">
					<%if(xgzl != null){ for(Xgzl x:xgzl){ %>
			        <li>
			        	<p><%StringHelper.filterHTML(out, x.name);%></p>
			            <a title="<%StringHelper.filterHTML(out, x.name);%>" href="<%=fileStore.getURL(x.imge)%>" class="swipebox">
			            <img alt="img" src="<%=fileStore.getURL(x.imge)%>"></a>
			        </li>
			   	 	<%}} %>   
			    </ul>
		    </div>
		
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/scripts/owl.carousel.min.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/scripts/jquery.swipebox.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/scripts/snap.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/scripts/framework.launcher.js"></script>
</body>
</html>