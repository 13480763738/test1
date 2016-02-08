<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Microblog"%>
<%@page
	import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Education"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Address"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Phone"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.IdCard"%>
<%@page
	import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.AddAccessory"%>
<html xmlns="http://www.w3.org/1999/xhtml">
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
<body>
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<form action="<%=controller.getURI(request, Microblog.class)%>" class="form1" method="post">
	<div class="popup_tips">
		
		 <div class="con clearfix">
			<div class="bigtit">微博认证</div>
			<div class="info_top">随着网络时代的发展，网络信息已成为了解借入者真实性的最新渠道之一。<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>与时俱进，将借入者网络关系评估，作为评估借入者的信用的方式之一。</div>
			<div class="mt10">
				<div class="smalltit">认证方法：</div>
				<p>
					<i class="d_red">第一步、成为<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>粉丝</i><br/>
					    请点击以下链接, <a href="<%=configureProvider.getProperty(SystemVariable.SITE_SINA_WEIBO) %>" class="blue ml15" target="_blank"><%=configureProvider.getProperty(SystemVariable.SITE_SINA_WEIBO) %> </a>, 把<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>加为关注。<br/>
					<i class="d_red">第二步、发送验证信息</i><br/>
					1、	在微博上，转发一条最新的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>的微博。<br/>
					2、	并用“私信”功能，发送您的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>昵称给<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %><br/>
					<i class="d_red">第三步、在以下输入框输入您的新浪微博昵称，并点击提交</i><br/>

				</p>
				<p><i class="f16 gray33">认证条件：</i><i class="d_red">50粉丝+50微博（目前仅支持新浪微博）</i></p>
			    <p><i class="f16 gray33">认证有效期：</i><i class="d_red">永久</i></p>
			</div>
			<div class="mt10">
				<div class="bd">
					<i class="d_red">*</i>请输入新浪微博昵称：
					<span>
						<input name="count" type="text" class="text required max-length-20" />
							<p tip></p>
							<p errortip class="" style="display: none;padding-left:150px;"></p>
					</span>
				</div>
				<div class="pt10 ml300">
					<input type="submit" class="btn btn01 sumbitForme" fromname="form1" value="提交审核" />
				</div>
			</div>
			<div class="mt10 warn">
				<i class="ui_w"> </i><i class="d_red">警告：</i><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>是一个注重诚信的网络平台。如果我们发现您上传的资料系伪造或有人工修改痕迹，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>会将你加入系统黑名单，永久取消您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>的借款资格。
			</div>
		</div>
		<input id="isupload" value="0" type="hidden"/>
	</div>
	</form>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%
	if(request.getAttribute("close") != null){
	%>
	<script type="text/javascript">
		$("#isupload").val(1);
		var list=parent.art.dialog.list;
		for(var i in list){
			list[i].close();
		}
	</script>
	<%
		return;
	}
	%>
</body>
</html>
