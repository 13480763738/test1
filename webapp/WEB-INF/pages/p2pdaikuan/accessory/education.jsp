<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xlyb2sl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xlyb1sl"%>
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
	<form action="<%=controller.getURI(request, Education.class)%>" class="form1" method="post">
	<div class="popup_tips">
		
		 <div class="con clearfix">
			<div class="bigtit">学历认证</div>
			<div class="info_top">借出者在选择借款申请进行投标时，借入者的学历也是一个重要的参考因素。为了让借出者更好、
				更快地相信您的学历是真实的，强烈建议您对学历进行在线验证。</div>
			<div class="mt10">
				<div class="smalltit">学历认证方法：</div>
				<p>
					一、2011年至今获得学历，需学历证书编号<br /> 1.点击<a href="http://www.chsi.com.cn/xlcx/" target="_blank" class="blue">网上学历查询</a>。<br />
					2.选择“零散查询”。<br /> 3.输入证书编号、查询码（通过手机短信获得，为12位学历查询码）、姓名、以及验证码进行查询。<br />
					4.查询成功后，您将查获得《教育部学历证书电子注册备案表》。<br /> 5.将该表<i class="d_red">右下角的12位在线验证</i><a
						href="<%=controller.getViewURI(request, Xlyb1sl.class) %>" target="_blank" class="blue">（见样本图01）</a>，输入下面的文本框。<br /> 6.点击提交审核。<br />
					二、1991年至今获得学历，无需学历证书编号<br /> 1.点击<a href="http://www.chsi.com.cn/xlcx/" target="_blank" class="blue">网上学历查询</a>。<br />
					2.选择“本人查询”。<br /> 3.注册学信网账号。<br /> 4.登录学信网，点击“学历信息”。<br />
					5.选择您的最高学历，并点击“申请验证报告”（申请过程中，您需通过手机短信获得12位学历查询码， 此查询码与<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>所需验证码不同）。<br />
					6.申请成功后，您将获得12位在线验证码<a href="<%=controller.getViewURI(request, Xlyb2sl.class) %>" target="_blank" class="blue">（见样本图02）</a><br />
					7.将12位在线验证码输入下面的文本框。<br /> 8.点击提交审核。
				</p>
				<p>
					<i class="f16 gray33">认证条件：</i><i class="d_red">大专或以上学历（普通全日制）</i>
				</p>
				<p>
					<i class="f16 gray33">认证有效期：</i><i class="d_red">永久</i>
				</p>
			</div>
			<div class="mt10">
				<div class="bd">
					<i class="d_red">*</i>12位在线验证码：<input name="count" type="text"
						class="text required is-number-12 max-length-12 min-length-12" />
						<p tip></p>
								<p errortip class="" style="display: none;padding-left:150px;"></p>
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
