<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = ArticleType.MCJS.getName()+" - 理财百科 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	CURRENT_SUB_CATEGORY = "TZLC";
%>
<%@include file="/WEB-INF/include/xszy/left.jsp"%>

	<div class="help">
		<h1>名词解释</h1>
		<ul id="question">
			<li>
				<h3 class="active">1、借款用户（借款人）</h3>
				<span style="display:block;">
					已经或准备在网站上进行借款活动的用户称为借款用户。凡22周岁以上的中国大陆地区公民，都可以成为借款用户。
				</span>
			</li>
			<li>
				<h3>2、理财用户（理财人）</h3>
				<span>
				已经或准备在网站上进行资金出借活动并完成了实名认证、手机号码绑定和提现密码设置的用户称为理财用户。
				</span>
			</li>
			<li>
				<h3>3、服务码</h3>
				<span>
					用户注册后将获得属于个人的唯一标识码，好友填入服务码注册成功后，推广人将会根据好友充值或投资具体情况获得一定奖励。  
				</span>
			</li>
			<li>
				<h3>4、标的 [biāo dì]</h3>
				<span>
					指用户发布的包含其借款相关说明信息的借款申请。一个合格的标的内至少包含：标题、描述、借款用途、借款总额、还款方式、年利率、借款期限、招标期限等基本信息。
				</span>
			</li>
			<li>
				<h3>5、发标</h3>
				<span>
					指用户发布借款标的的行为。
				</span>
			</li>
			<li>
				<h3>6、招标</h3>
				<span>
					指标的通过审核进入到投资列表内，此时标的状态为招标。
				</span>
			</li>
			<li>
				<h3>7、投标</h3>
				<span>
					指用户将麒麟通宝账户内指定的金额出借给招标用户的行为。
				</span>
			</li>
			<li>
				<h3>8、满标</h3>
				<span>
					指一个标的在招标期限内足额筹集到所需资金，等待放款的状态。
				</span>
			</li>
			<li>
				<h3>9、放款</h3>
				<span>
					指一个标的满标后且已符合放款标准，该标的所筹资金从出借人账户转入借款人账户的过程，即借款人成功获得了借款。
				</span>
			</li>
			<li>
				<h3>10、流标</h3>
				<span>
					指因资料上传不全或综合情况不符合借款要求，导致借款申请未通过，或超过招标期限但未满标的状态叫做流标。
				</span>
			</li>
			<li>
				<h3>11、逾期</h3>
				<span>
					指用户未按借款协议约定时间进行足额还款，此时标的状态为逾期。
				</span>
			</li>
			<li>
				<h3>12、严重逾期</h3>
				<span>
					逾期时间超过30天时，从第31天开始该标的状态为严重逾期（针对借款者）。
				</span>
			</li>
			<li>
				<h3>13、垫付</h3>
				<span>
					指严重逾期的债权根据麒麟通宝本息保障计划，由麒麟通宝风险准备金代为偿还的动作，垫付完成后债权转移至机构或麒麟通宝名下。
				</span>
			</li>
		</ul>
	</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
 .i-t-wx { background-position: -29px 0px;}
 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
 </style>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/help.list1.js"></script><!--帮助页js-->
<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>	 
	 
</body>
</html>