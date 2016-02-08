<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Microblog"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Author"%>
<%@page import="com.jiudian.p2p.front.service.credit.AuthorManage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Syd"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<%
String _TITLE_ = "P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int id = 0;
	LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
	LmoneyDecide lm = lmoneyManage.getLmoneyDecide(CreditType.SYD.name());
	if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=2");
	return ;
		//跳转到实名认证页面
	}
	if(StringHelper.isEmpty(lm.password)){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=3");
		//跳转到设置体现密码页面
		return;
	}
	id = lm.id;
	if(id==0){
		controller.sendRedirect(request, response, controller.getURI(request, Syd.class));
	}

	AuthorManage authorManage = serviceSession.getService(AuthorManage.class);
	Author data = authorManage.getAuthor();
	if(data==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
<form action="<%=controller.getURI(request, Checkmessage.class)%>"
				method="post" class="form1">
	<div class="contain clearfix">
		<div class="w1002 top_title">
			<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">生意贷</a> &gt;
				填写借款申请</span>
		</div>

		<!--step-->
		<div class="contain_main clearfix">
			<div class="ui_step ui_two"></div>
		</div>

		<%@include file="messagehead.jsp"%>

		<div class="about clearfix">
			<div class="sidebar fl">
				<ul class="barlist">
					<li class="first"></li>
					<li><a
						href="<%=controller.getURI(request, Basemessage.class)%>"><i></i>基本信息</a></li>
					<li><a
						href="<%=controller.getURI(request, Familymessage.class)%>"><i></i>家庭信息</a></li>
					<li><a
						href="<%=controller.getURI(request, Companymessage.class)%>"><i></i>公司信息</a></li>
					<li><a
						href="<%=controller.getURI(request, Propertymessage.class)%>"><i></i>资产信息</a></li>
					<li class="on"><a
						href="<%=controller.getURI(request, Authormessage.class)%>"><i></i>其他信息</a></li>
				</ul>
			</div>

			<div class="container fr">
				<div class="public_tit">其他信息</div>
					<div class="home_content clearfix">
						<div class="tit clearfix mt20">微博认证</div>
						<ul class="home_con clearfix">
							<li>
								<div class="list_info">
									<%
										AttestationState state = lmoneyManage.getAttentiontype(AttestationType.WBRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico11"></dt>
										<dd>
											<p class="f18">微博认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
									if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iswoboan) && data.Iswoboan.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico11"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">微博认证</p>
											<p>
												<i class="btn btn06">通过</i>
											</p>
										</dd>
									</dl>
									<%
										}
									%>

									<%
										if(state.equals(AttestationState.WTG)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico11"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">微博认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.DSH)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico11"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">微博认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Microblog','<%=controller.getViewURI(request, Microblog.class)%>','微博认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
								</div>
							</li>
							<li>
								<div class="list_info pt20">
								<%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);%>
									<p class="clearfix">
										<input type="submit" <%if (!StringHelper.isEmpty(ermsg)) {%> disabled="disabled" <%}%> 
										class="btn <%if (!StringHelper.isEmpty(ermsg)) {%>btn02<%}else{%>btn01<%}%> fl ml150 sumbitForme " 
										fromname="form1" value="提交申请" />
									</p>
									<p class="orange"><%StringHelper.filterHTML(out, ermsg);%></p>
								</div>
							</li>
						</ul>
					</div>
			</div>
		</div>

	</div>
</form>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript">
	function tcc(evn,tid,url,titl) {
		global_art = art.dialog.open(url,{
			id : tid,
			title : titl,
			opacity : 0.1,
			width : 783,
			height : 500,
			lock : true,
			close : function() {
				var iframe = this.iframe.contentWindow;
				var isupload = iframe.document.getElementById('isupload');
				if(isupload == null || "" == isupload || "undefind" == isupload){
					
				}
				if(isupload.value == "1"){
					
					$(evn).parent().parent().before('<dt class="ico14"></dt>');
				}
			}
		}, false);
		
	}
		
	</script>
</body>
</html>