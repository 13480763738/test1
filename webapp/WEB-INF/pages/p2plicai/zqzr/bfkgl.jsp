<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bxgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bdxq"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Zrjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Zqxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Hkjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Tbjl"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditHoldInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentInfoManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<html>
<head>
<%
String _TITLE_ = "债权转让 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/blueimp-gallery.css" />
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/index.css" />
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	CURRENT_SUB_CATEGORY = "ZQXQXQ";
	%>
	<%@include file="/WEB-INF/include/zqzr/header.jsp"%>
	<div class="center_box" style="background:#f1f3f5;">
    	<div class="center">
            <div class="plan_tab_hf">
				<ul>
					<li><a href="<%=controller.getPagingItemURI(request, Bdxq.class, id)%>">标的详情</a></li>
					<li class="hover">风控信息</li>
					<li><a href="<%=controller.getPagingItemURI(request, Bxgzl.class, id)%>">相关资料</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Tbjl.class, id)%>">投标记录</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Hkjl.class, id)%>">还款记录</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Zqxx.class, id)%>">债权信息</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Zrjl.class, id)%>">转让记录</a></li>
				</ul>
            </div>
            <div class="plan_content_hf">
            	<div class="plan_tab_con01_hf">
            	<%if(jiudianSession==null||!jiudianSession.isAuthenticated()){%>
					<div class="pub_nologin_hf">
	                	<p>请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>"  style=" color:#186ea7;">登录</a>
	                	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>"  style="color:#faaf00;">注册</a>后查看</p>
	                </div>
				<%}else {
					CreditAssignmentInfoManage creditManageCreditor = serviceSession.getService(CreditAssignmentInfoManage.class);
					String content = creditManageCreditor.getFkxx(IntegerParser.parse(request.getParameter("id")));
				%>
			   			 <%StringHelper.format(out, content,fileStore);%>
				<%}%>
            	
                </div>
            </div>
        </div>
    </div>
	
	<div id="info"></div>
	<div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>

<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
	    <div class="slides"></div>
	    <h3 class="title"></h3>
	    <a class="prev">‹</a>
	    <a class="next">›</a>
	    <a class="close">×</a>
	    <ol class="indicator"></ol>
</div>

<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqzr.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/blueimp-gallery.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.blueimp-gallery.js"></script>

	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#zqSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<script>
	$(function(){
		$(".document").click(function(){
			if(navigator.userAgent.indexOf("MSIE 7.0")>0)
				{
				alert("您的浏览器版本过低，如浏览效果不好，请升级或者使用别的浏览器，谢谢！");
				}
			$(".header").css("display","none");
			});
			$(".slides").click(function(){
			$(".header").css("display","block");
			});
			$(".close").click(function(){
			$(".header").css("display","block");
			});
		})
	</script>
</body>
</html>