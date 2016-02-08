<%@page import="com.jiudian.p2p.front.servlets.m.Logout"%>
<%if(jiudianSession == null || !jiudianSession.isAuthenticated()){%>
<header class="index-header">
		<h1 class="fl">
			<a href="<%configureProvider.format(out,URLVariable.WAP_INDEX);%>">
			<img src="<%=controller.getStaticPath(request) %>/wap/images/logo.png" alt=""/></a>
		</h1>
		<div class="index-header-right fr">
			<div class="fr denglu">
				<a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>" class="login">登录</a>
				<a href="<%configureProvider.format(out,URLVariable.WAP_REGISTER);%>" class="zhece">注册</a>
			</div>
		</div>
		<div class="clear"></div>
</header>
<%}else{ %>
<header class="index-header">
		<h1 class="fl">
			<a href="<%configureProvider.format(out,URLVariable.WAP_INDEX);%>">
			<img src="<%=controller.getStaticPath(request) %>/wap/images/logo.png" alt=""/></a>
		</h1>
		<div class="index-header-right fr">
			<div class="menu fr">
				<span class="menu-pic"></span>
				<div class="menu-dw">
					<div style="margin-left:139px;">
						<span class="arrow-up"></span>
					</div>
					<section class="list-menu" id="list-menu">
						<a href="<%configureProvider.format(out,URLVariable.WAP_INDEX);%>">首页</a>
						<a href="<%=configureProvider.format(URLVariable.WAP_SBTZLB) %>">我要投资</a>
						<a href="<%=configureProvider.format(URLVariable.WAP_USER_INDEX) %>">我的账户</a>
						<a href="<%=controller.getURI(request, Logout.class) %>" style="border:0;">安全退出</a>
					</section>
				</div>
			</div>
		</div>
		<div class="clear"></div>
	</header>
	<%}%>