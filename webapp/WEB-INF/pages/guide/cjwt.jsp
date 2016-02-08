<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = "帮助中心"+" - 常见问题 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	<div class="clear"></div>
<%
	CURRENT_SUB_CATEGORY = "CJWT";
%>
<div class="new-contant mt20 pb30" style="border-top:1px solid #ddd">
<%@include file="/WEB-INF/include/xszy/left.jsp"%>

	<div class="white-bg new-question new-question1">
		<div class="new-about-xian"></div>
		<h1 class="pb50">常见问题</h1>
		<h2><span></span>登录注册</h2>
		<div class="wtbox pb20">
		    <h3>1、如何找回我的密码？</h3>
 		    <p>如果您遗忘了密码，可以在网站用户登录页面，点击"忘记密码"按钮，选择绑定邮箱或注册手机号找回密码。</p>
		</div>
		<div class="wtbox pb20">
		    <h3>2、如何修改密码？</h3>
 		    <p>您注册时输入的密码可以是数字或者英文字母，对于英文字母我们同时设置了大小写的区分。注册后您可以随时通过点击用户名进入个人详情页中-"安全中心"-"安全信息"-"修改密码"中修改您所设定的密码。</p>
		</div>
		<div class="wtbox pb20">
		    <h3>3、如何修改绑定的手机号？</h3>
 		    <p>登录麒麟通宝平台后点击注册名进入“我的账户”，进入“安全中心”——“安全信息”页面的“绑定手机”点击修改，根据修改页面操作提示完成相关操作即可修改成功。</p>
		</div>
		<div class="wtbox">
		    <h3>4、为什么手机认证时会收不到验证码短信？如何处理？</h3>
 		    <p>（1）若手机安装了拦截软件有可能被拦截，您可以查看一下拦截记录/垃圾短信，是否被拦截。</p>
     		    <p>（2）由于短信运营商通道可能会出现阻塞情况，有时短信会出现延时或者失败的情况。</p>
     		    <p>（3）如有其它问题请联系客服。客服电话：400-8098-122。</p>
		</div>			
	</div>	
	<div class="white-bg new-question mt20">
		<h2 class="pt50"><span></span>充值提现</h2>
		<div class="wtbox pb20">
		    <h3>1、有哪些方式可以给账户充值？</h3>
 		    <p>目前支持通过第三方资金托管机构进行充值。</p>
		</div>
		<div class="wtbox pb20">
		    <h3>2、平台充值流程</h3>
 		    <p>登录平台账号，点击用户名，进入”个人中心”点击充值，或者在“个人中心”-“资金管理”点击充值，根据充值提示即可成功充值</p>
		</div>
		<div class="wtbox pb20">
		    <h3>3、如何提取现金？</h3>
 		    <p>您可以随时将您在"麒麟通宝"账号中的可用余额申请提现到您所绑定的银行卡上.</p>
		    <p>注意：请提供申请提现的银行卡账号，并确保该账号的开户人姓名和您在麒麟通宝上提供的身份证上的真实姓名一致， 否则无法成功提现。</p>
		</div>
		<div class="wtbox">
		    <h3>4、资金提现需要多长时间到账？</h3>
 		    <p>a 借款人还款后，投资人可在当日申请提现，资金到账时间为T+1；</p>
     		<p>b 提现申请提交成功后，预计在下一工作日到账，实际到账时间由提现银行的处理机制而定；</p>
     		 <p>注：通常情况下，提现资金会在1个工作日内到账，由于双休或者国家法定节假日第三方支付平台不处理对公业务，提现资金到账时间会自动延迟到下一工作日。</p>
		</div>
	</div>
	<div class="white-bg new-question mt20">
		<h2 class="pt50"><span></span>债权转让</h2>
		<div class="wtbox pb20">
		    <h3>1、什么是债权转让？</h3>
 		    <p>指债权持有人通过麒麟通宝债权转让平台将债权挂出且与购买人签订债权转让协议，将所持有的债权转让给购买人的操作</p>
		</div>
		<div class="wtbox pb20">
		    <h3>2、如何转出债权？</h3>
 		    <p>当理财用户持有的债权处于可转让状态时，理财用户可以通过点击用户名进入”个人中心”-“我的投标”中对带有可转让标识的债权进行转让；也可直接通过点击用户名进入”个人中心”-“债权转让“中对有可转让标识的债权进行转让。</p>
		</div>
		<div class="wtbox pb20">
		    <h3>3、如何买入债权？</h3>
 		    <p>理财用户可以在债权转让列表页面进行购买债权。用户登陆后可以按照份数购买债权，在确认购买份数及金额等信息后点击确定按钮，即完成债权的购买。</p>
		</div>
		<div class="wtbox">
		    <h3>4、什么样的债权可以转让？</h3>
 		    <p>a 持有债权后即可进行转让。</p>
     		    <p>b 转让预发起时间距离下一个回款日超过3天。</p>
     		    <p>c 债权没有处于逾期状态。如转让挂出时没有处于逾期，但在转让中时债权变为逾期状态，系统将会把债权停止转让。</p>
     		    <p>d 按天借款标和协议还款标的不可转让</p>
		</div>			
	</div>		
</div>
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	 
 <style>
 .i-t-wx { background-position: -29px 0px;}
 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
 </style>
 <%@include file="/WEB-INF/include/script.jsp"%>
 <%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%> 

</body>
</html>