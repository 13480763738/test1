<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Tbjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Xgzl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Fkxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Yhxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Rzfxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Zrjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Zqxx"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Hkjl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Bdxq"%>
<html>
<head>
<%
String cityid="";

String _TITLE_ = "散标详情 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	CURRENT_SUB_CATEGORY = "BDXQ";
	%>
	<%@include file="/WEB-INF/include/sbtz/header.jsp"%>
	<div class="center_box" style="background:#f1f3f5;">
    	<div class="center">
            <div class="plan_tab_hf">
				<ul>
					<%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>
					<li id="bdxq" class="tables" src="<%=controller.getViewURI(request, Rzfxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">标的详情</a></li>
					<%}else{%>
					<li id="bdxq" class="tables" src="<%=controller.getViewURI(request, Yhxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">标的详情</a></li>
					<%} %>
<%-- 					<li id="fkxx" class="tables" src="<%=controller.getViewURI(request, Fkxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">风控信息</a></li> --%>
					<li id="xgzl" class="tables" src="<%=controller.getViewURI(request, Xgzl.class)%>?id=<%=id%>"><a href="javascript:void(0)">相关资料</a></li>
					<li id="tbjl" class="tables" src="<%=controller.getViewURI(request, Tbjl.class)%>?id=<%=id%>"><a href="javascript:void(0)">投标记录</a></li>
					
				<%
					if(creditInfo.status==CreditStatus.YFK||creditInfo.status==CreditStatus.YDF||creditInfo.status==CreditStatus.YJQ){
				%>
					<li id="hkjl" class="tables" src="<%=controller.getViewURI(request, Hkjl.class)%>?id=<%=id%>"><a href="javascript:void(0)">还款记录</a></li>
					<li id="zqxx" class="tables" src="<%=controller.getViewURI(request, Zqxx.class)%>?id=<%=id%>"><a href="javascript:void(0)">债权信息</a></li>
					<li id="zrjl" class="tables" src="<%=controller.getViewURI(request, Zrjl.class)%>?id=<%=id%>"><a href="javascript:void(0)">转让记录</a></li>
				<%}%>
				</ul>
            </div>
            
            <%if(jiudianSession==null||!jiudianSession.isAuthenticated()){%>
            	<div class="pub_nologin_hf">
                	<p>请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" style=" color:#186ea7;">登录</a>
                	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="color:#faaf00;">注册</a>后查看</p>
                </div>
			<%}else{ %>
			
			<div name="bdxq"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fbdxq" width="100%" frameborder="0" src="" name="fbdxq" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="fkxx"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="ffkxx" width="100%" frameborder="0" src="" name="ffkxx" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="xgzl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fxgzl" width="100%" frameborder="0" src="" name="fxgzl" style="border: 0px none;min-height: 580px;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="tbjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="ftbjl" width="100%" frameborder="0" src="" name="ftbjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			<%
				 if(creditInfo.status==CreditStatus.YFK||creditInfo.status==CreditStatus.YDF||creditInfo.status==CreditStatus.YJQ){
			%>
			
			<div name="hkjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fhkjl" width="100%" frameborder="0" src="" name="fhkjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="zqxx"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fzqxx" width="100%" frameborder="0" src="" name="fzqxx" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<div name="zrjl"  class="plan_content_hf iframes"  style="display:none;">
				<iframe id="fzrjl" width="100%" frameborder="0" src="" name="fzrjl" style="border: 0px none;" onload="this.height=this.contentWindow.document.documentElement.scrollHeight"  allowtransparency="true" scrolling="no"></iframe>
			</div>
			
			<%}%>
            <%} %>
        </div>
    </div>
	<div id="info"></div>
	<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp" %>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript">
			$("#gzcs").html('<span style="padding-left:0px;">'+getctName('<%StringHelper.filterHTML(out,cityid);%>')+'</span>');
	</script>
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(newSuccInfo(520,"<%=message%>","1",$("#sbSucc").val()));
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
</body>
</html>