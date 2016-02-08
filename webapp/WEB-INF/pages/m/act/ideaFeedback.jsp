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
		WAP_TITLE_NAME = "意见反馈";
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
		<form action="<%=controller.getURI(request, IdeaFeedback.class)%>" class="form1"  data-ajax="false" method="post">
		<div data-role="content" class="qcontent">
			<div class="yjfk_box">
				<div class="yjfk_out">
					<textarea cols="" rows="" name="idea"  class="yjfk_txt min-length-10 max-length-199"></textarea>
					<div class="lxfs"><input type="text" name="lxfs"  class="input" placeholder="请留下您的联系方式    QQ/手机/邮箱"></div>
					<p tip></p>
					<p errortip class="" style="color: red;"></p>
					<p class="error_tip"><%String msg = controller.getPrompt(request, response , PromptLevel.ERROR);if(!StringHelper.isEmpty(msg)){%><%=msg%><%}%></p>
				</div>
				<div class="login_btn">
					<input type="submit" fromname="form1" class="sumbitForme" value="告诉我们">
				</div>
			</div>
		</div>
		</form>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/validation.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/dialog.js"></script>
</body>

<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=message%>","<%configureProvider.format(out,URLVariable.WAP_INDEX);%>");	
		});
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$$(function() {
			sussess_dialog("<%=errorMessage%>");
		});
	</script>
	<%
		}
	%>
</html>