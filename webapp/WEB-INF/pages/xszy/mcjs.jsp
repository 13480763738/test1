<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = ArticleType.MCJS.getName()+" - 名词解析 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	CURRENT_SUB_CATEGORY = "MCJS";
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
			<li>
				<h3>14、等额本息</h3>
				<span>
					等额本息还款法是一种被广泛采用的还款方式。在还款期内，每月偿还同等数额的借款(包括本金和利息)。借款人每月还款额中的本金比重逐月递增、利息比重逐月递减。<br>具体计算公式如下：
							<img src="<%=controller.getStaticPath(request)%>/images/u98.png" class="img " id="u98_img"  alt="<%=_ALT%>"><br>P:
							每月还款额<br>A: 借款本金<br>b: 月利率<br>n: 还款总期数<br>计算精确到小数点后两位。已经或准备在网站上进行借款活动的用户称为借款用户。凡22周岁以上的中国大陆地区公民，都可以成为借款用户。
				</span>
			</li>
			<li>
				<h3>15、每月还息到期还本（扣首月利息）</h3>
				<span>
				已每月还息到期还本（扣首月利息）还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时从借款金额中扣除首期利息至投资人账户，往后每期还息，最后一期只还本金。<br>具体利息计算公式：<br>P= A.b%<br>P: 月还利息<br>A: 借款本金<br>b%: 月利率
				</span>
			</li>
			<li>
				<h3>16、加权平均收益率</h3>
				<span>
					由于借款时间不定，麒麟通宝采用加权平均的方式计算借出者的收益率。<br>具体计算公式如下： <img src="<%=controller.getStaticPath(request)%>/images/u96.png"   alt="<%=_ALT%>" class="img" id="u96_img"><br>Ai:
							第i笔投标的本金<br>ci: 第i笔投标的年利率  
				</span>
			</li>
			<li>
				<h3>17、债权</h3>
				<span>
					指理财用户与借款用户之间的债务约定。
				</span>
			</li>
			<li>
				<h3>18、债权价值</h3>
				<span>
					用户持有债权单份价值（元/份），麒麟通宝按债权待收本金计算，具体公式：<br>债权价值=待收本金/债权持有份数，待收本金即债权的总价值。
				</span>
			</li>
			<li>
				<h3>19、债权价格</h3>
				<span>
					用户在对持有债权进行转让时所出价格。
				</span>
			</li>
			<li>
				<h3>20、债权份数</h3>
				<span>
					债权的原始投资金额每100元为一份。
				</span>
			</li>
			<li>
				<h3>21、投资金额</h3>
				<span>
					指投标时理财用户的投标金额。
				</span>
			</li>
			<li>
				<h3>22、投标奖励</h3>
				<span>
					当用户成功投资某种奖励标的时，若满足标的奖励要求将另享年化x%的投标奖励，奖励金额将在放款后由平台按期发放。<br>
注：<br>1）x%以投资列表单个标的“年化收益率”奖励比例显示为准；<br>
    2）由于借款人还款时间不确定，而奖励发放时间为平台按借款人正常还款截止时间定时发放，所以可能出现每月奖励金额到账与本息到账不同步的情况；<br>
    3）若原债权人享有投标奖励，发生债权转让后，投标奖励仍归原债权人所有，新债权人不享有该奖励。<br>
<br>
（1）限时奖<br>
筹款开始后限定时间内投资的用户，放款后另享年化x%投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。<br>
（2）满堂彩<br>
筹款开始后限定时间内满标，放款后该标的所有投资用户另享年化x%投标奖励，奖励由平台分期发放。<br>
（3）头彩奖<br>
筹款开始后第一位投资用户，放款后另享年化x%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。<br>
（4）幸运奖<br>
放款后，随机抽取该标的m位投资用户，另享x%投标奖励，奖励由平台分期发放。<br>
（5）土豪奖<br>
该标的累计投资额度最高的用户，放款后另享年化x%投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。<br>
（6）新手奖<br>
首次在平台投资的用户，放款后另享年化x%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。<br>
（7）普惠奖<br>
放款后，该标的所有投资用户另享年化x%投标奖励，奖励由平台分期发放。<br>
（8）进步奖<br>
若当次投资为您在平台投资的第m~n次（m，n由平台根据运营情况而定），放款后另享年化x%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。
				</span>
			</li>
		</ul>
	</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
 <style>
 .i-t-wx { background-position: -29px 0px;}
 .wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
 </style>
<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
</body>
</html>