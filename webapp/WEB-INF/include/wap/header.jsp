<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.common.enums.IsPass"%>
<%@page import="com.jiudian.p2p.front.service.common.UserManage"%>
<%@page import="java.util.UUID"%>
<%{String warning_id=UUID.randomUUID().toString();%>
<div style="position:fixed; background:#fff; z-index:9999;width:100%;height:768px; overflow:hidden; display:block;" name="dyym" id='<%=warning_id%>'>
<input type="hidden" id="_dyid" value="<%=warning_id%>" />
</div>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/header.js"></script>
<%}%>
<%
if (jiudianSession == null || jiudianSession.isAuthenticated()) {
	if(IsPass.S.equals(serviceSession.getService(UserManage.class).sfxgmm())){
		controller.redirectLogin(request, response, configureProvider.format(URLVariable.WAP_UPDATE_PASSWORD));
		return;
	}
}
%>
 <div data-role="header" class="qheader">
  	<h1><%=WAP_TITLE_NAME %></h1>  
    <div class="menubox">
    	<a href="#" class="header_list"></a>
    	<div class="header_menu">
            <div class="menu_list">
               	<a href="<%configureProvider.format(out,URLVariable.WAP_INDEX);%>" class="home" rel="external"><span>首页</span></a>
	            <a href="<%configureProvider.format(out,URLVariable.WAP_USER_INDEX);%>" class="account" rel="external"><span>我的</span></a>
	            <a href="<%configureProvider.format(out,URLVariable.WAP_AQXX);%>" class="save" rel="external"><span>安全</span></a>
	            <a href="<%configureProvider.format(out,URLVariable.WAP_USER_DETAIL);%>" class="saocode" rel="external"><span>扫码</span></a>
	            <a href="<%configureProvider.format(out,URLVariable.WAP_MORE);%>" class="more" rel="external"><span>更多</span></a>
            </div>
            <span class="ico_sj"></span>
        </div>
    </div>
  </div>

