<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.CustomerService"%>
<%@page import="com.jiudian.p2p.front.service.information.CustomerServiceManage"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = "在线客服 - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
<script>var online= new Array();</script> 

</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="clear"></div>
	<%{ %>
	<div class="n_new">
		<div class="n_nav">
			<%
				CURRENT_SUB_CATEGORY = "ZXKF";
			%>
			<%@include file="/WEB-INF/include/xszy/left.jsp"%>
			<div class="n_nav_right fl">
				<%
					CustomerServiceManage customerServiceManage = serviceSession
								.getService(CustomerServiceManage.class);
						CustomerService[] customerServices = customerServiceManage
								.getAll(CustomerServiceType.QQ);
						if (customerServices != null && customerServices.length > 0) {
							for (CustomerService customerService : customerServices) {
								String image = fileStore
										.getURL(customerService.imageCode);
				%>
				<div class="ask_people">
					<a href="http://wpa.qq.com/msgrd?v=3&uin=<%StringHelper.filterHTML(out, customerService.number);%>&site=qq&menu=yes"
						target="_blank"><img
						src="<%if (StringHelper.isEmpty(image)) {%><%=controller.getStaticPath(request)%>/images/lead_pic17.jpg<%} else {%><%=image%><%}%>"
						width="115" height="114" />
					</a> <span>
					
					<a id="qkef<%StringHelper.filterHTML(out, customerService.number);%>" href="http://wpa.qq.com/msgrd?v=3&uin=<%StringHelper.filterHTML(out, customerService.number);%>&site=qq&menu=yes"
						target="_blank"> <%StringHelper.filterHTML(out, customerService.name);%>
					</a></span>
						<script src="http://webpresence.qq.com/getonline?Type=1&<%StringHelper.filterHTML(out, customerService.number);%>:" ></script>
						<script>if(online[0]==0){
							document.getElementById("qkef<%StringHelper.filterHTML(out, customerService.number);%>").style.color="#727272";
							}
						</script>
				</div>
				<%
					}
						}
				%>
			</div>
		</div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	
</body>
</html>