<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Xgmm"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.TenderAccount"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%if(jiudianSession==null || !jiudianSession.isAuthenticated()){%>
<div class="login_boxs">
    <a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>"  rel="external" class="logins">登录</a>
    <a href="<%configureProvider.format(out,URLVariable.WAP_REGISTER);%>"  rel="external" class="registers">注册</a>
</div>
<%}else{%>
<%
	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
	TenderAccount vo = userInfoManage.getTenderAccount();
%>
<a href="<%configureProvider.format(out,URLVariable.WAP_USER_FUNDDETAIL);%>"  rel="external">
<div class="login_boxs">
    <span>可用余额<br/>
	<i><%=Formater.formatAmount(vo.kyye)%></i>元
	</span>
    
    <span>已赚总额<br/>
	<i><%=Formater.formatAmount(vo.yzzje)%></i>元
	</span>
</div>
</a>
<%}%>