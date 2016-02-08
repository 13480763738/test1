<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bfkgl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bxgzl"%>
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
<%-- 					<li><a href="<%=controller.getPagingItemURI(request, Bfkgl.class, id)%>">风控信息</a></li> --%>
					<li><a href="<%=controller.getPagingItemURI(request, Bxgzl.class, id)%>">相关资料</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Tbjl.class, id)%>">投标记录</a></li>
					<li><a href="<%=controller.getPagingItemURI(request, Hkjl.class, id)%>">还款记录</a></li>
					<li class="hover">债权信息</li>
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
			        			final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
			        			CreditHoldInfo[] creditHoldInfos = creditManageCreditor.getHoldInfo(IntegerParser.parse(request.getParameter("id")));
					%>
					<%int j=0;if (creditHoldInfos != null) {for (CreditHoldInfo creditHoldInfo : creditHoldInfos) {if (creditHoldInfo == null) {continue;} j++;}} %>
                	<div class="fr" style="margin-bottom:18px;">
                    	<span class="fs14c73">持有债权人数<em style="font-size:20px; color:#186ea7;"><%=j %></em>人</span> 
                    </div>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    	<tbody>
                        	<tr class="leve_titbj_hf">
                            	<td width="205">序号</td>
                                <td width="261" class="border_lr3">债权人</td>
                                <td width="262" style="border-right:3px solid #fff;">待收本金</td>
                                <td width="">持有份数</td>
                            </tr>
                            <%if (creditHoldInfos != null) {int i=1;for (CreditHoldInfo creditHoldInfo : creditHoldInfos) {if (creditHoldInfo == null) {continue;}%>
                            <tr>
                            	<td><%=i++ %></td>
                                <td>
                                <%StringHelper.filterHTML(out, (creditHoldInfo.userName.length()>=6?creditHoldInfo.userName.substring(0,4):creditHoldInfo.userName.substring(0,1))+"***");%>
                                </td>
                                <td><%=Formater.formatAmount(creditHoldInfo.touzje) %><em style="font-size:12px; color:#737373;">元</em></td>
                                <td><%=creditHoldInfo.cyfs%><em style="font-size:12px; color:#737373;">份</em></td>
                            </tr>
                            <%}}%>
                        </tbody>
                    </table>
                    
                    <%}%>
                </div>
            </div>
        </div>
    </div>
	
	<div id="info"></div>
	<div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zqzr.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

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
</body>
</html>