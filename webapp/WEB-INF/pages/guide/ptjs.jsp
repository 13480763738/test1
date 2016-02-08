<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
	String _TITLE_ = ArticleType.PTJS.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="clear"></div>
	<%
				CURRENT_SUB_CATEGORY = "PTJS";
			%>
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
	<div class="center_box">
		<div class="center">
			<div class="n_nav_mc_hf_hf">
				<div class="n_nav_mt_hf_hf">
					<h1 style=" font-size:30px;">平台介绍</h1>
				</div>
				<div style="font-size: 24px; color: #737373; margin-top: 30px;">关于麒麟通宝</div>
				<div>
					<span class="n_mc_name_hf">1、关于麒麟通宝</span>
					<div class="n_me_content_hf" style="display: none;">麒麟通宝依托实力雄厚的股东背景，行业领先的精英团队，管理健全的风控体系，以互联网技术和创新的金融服务模式旨在打造安全、透明、公正的互联网金融信息服务平台。让投资人切实感受到轻松赚钱的乐趣，让借款人获得雪中送炭的快感，真正实现平台的核心价值&mdash;&mdash;君子取财，趣之有道。</div>
				</div>

				<div>
					<span class="n_mc_name_hf">2、麒麟通宝的来源</span>
					<div class="n_me_content_hf">麒麟通宝（www.jiudian.com）是深圳世纪家园集团子公司深圳前海齐融金融服务有限公司旗下P2P网贷品牌，注册资金5000万元人民币。深圳世纪家园集团前身为"深圳市世纪中心家居广场有限公司"，最早成立于2003年，所创的商业品牌"世纪中心家居广场"连续多年保持"深圳最具影响力商场""深圳最受消费者欢迎商场""等多项荣誉称号。十年磨剑，集团业务迅猛发展，已由单一的商业业态扩张至商业金融、房地产、文化产业、进出口贸易等多元领域，形成多元化、立体化的集团组织模式。</div>
				</div>
				<div class="n_nav_mc_hf" id="name3" style="padding-bottom: 0px;">
					<div style="font-size: 24px; color: #737373; margin-top: 30px;">政策法规</div>
					<div>
						<span class="n_mc_name_hf">1、麒麟通宝平台提供居间撮合服务的合法性</span>
						<div class="n_me_content_hf">
							根据《合同法》第23章关于"居间合同"的规定，特别是第424条规定的"居间合同是居间人向委托人报告订立合同

							的机会或者提供订立合同的媒介服务，委托人支付报酬的合同"，麒麟通宝平台作为合法设立的中介服务机构，为民间

							借贷提供撮合，使借贷双方形成借贷关系并收取相关报酬的居间服务有着明确的法律基础。</div>
					</div>

					<div>
						<span class="n_mc_name_hf">2、理财人及借款人双方民间借贷关系的合法性</span>
						<div class="n_me_content_hf">
							根据《合同法》第196条规定"借款合同是借款人向贷款人借款，到期返还借款并支付利息的合同"，《合同法》允

							许自然人等普通民事主体之间发生借贷关系，并允许出借方到期可以收回本金和符合法律规定的利息。</div>
					</div>

					<div>
						<span class="n_mc_name_hf">3、理财人通过麒麟通宝平台获得的出借理财收益的合法性</span>
						<div class="n_me_content_hf" style="display: none;">
							根据最高人民法院《关于人民法院审理借贷案件的若干意见》第6条："民间借贷的利率可以适当高于银行的利率，

							各地人民法院可以根据本地区的实际情况具体掌握，但最高不得超过银行同类贷款利率的四倍（包含利率本数）。超

							出此限度的，超出部分的利息不予保护。"麒麟通宝的出借理财收益未超过银行同类贷款利率的四倍，为合法利息收益， 受到法律保护。</div>
					</div>
					<div>
						<span class="n_mc_name_hf">4、电子合同的合法性</span>
						<div class="n_me_content_hf">
							根据《合同法》和《电子签名法》的规定，当事人可以采用合同书、信件和数据电文（包括电报、电传、传真、电子数

							据交换和电子邮件）等形式订立合同，并通过以电子形式所含、所附用于识别签名人身份并表明签名人认可其中内容的

							数据电文等电子签名方式进行签署，当事人不能仅因合同采用电子签名、数据电文的形式就否定其法律效力。</div>
					</div>
				</div>
				<div class="n_nav_mc_hf" style="padding-bottom: 0px;">
					<div style="font-size: 24px; color: #737373; margin-top: 30px;">安全保障</div>
					<div id="name1">
						<span class="n_mc_name_hf">1、本息保障计划</span>
						<div class="n_me_content_hf">
							<span style="font-weight:bold; color:#717171;">1.1 计划介绍</span><br>

							“本息保障计划”是麒麟通宝为保护平台全体投资人的共同权益而建立的信用风险共担机制。平台的所有投资人经过平台身份认证后，在平台的投资行为均适用于“本息保障计划”，投资人不需支付任何费用。<br>

							“本息保障计划”是指平台对每笔成交的借款通过机构赔付、平台风险备用金垫付、法律维权三重保障机制对投资人本金和利息提供全额保障。其中，机构赔付预用资金来源为机构向平台交纳的保证金及机构服务费，平台风险备用金来源为平台专项风险备用资金和借款项目借款服务费，法律维权由北京市京都（深圳）律师事务所提供专业维权服务。 “本息保障计划”为投资人提供了有效的风险共担机制，分散了投资人投资行为所带来的信用风险，营造了一个安全健康的投资环境，保障了投资人的权益。<br><br>
  <span style="font-weight:bold; color:#717171;">1.2机构赔付</span><br>

							“机构赔付”是针对机构提供第三方实地考察和担保服务的借款项目，在借款人出现严重逾期（逾期30天）情况时，由服务机构对借款项目投资人的本金和利息进行赔付，以保证投资人合法收益。<br><br>
  <span style="color:#717171;">1.2.1机构赔付资金来源</span><br>

							合作第三方机构在麒麟通宝开设风险保证金账户，预用资金来源为机构预先交纳的保证金及机构向借款方收取的服务费，平台会依据预用资金来源为机构设定合理的信用额度，当机构可用信用额度降低至无法发布新的借款项目时，平台将敦促机构及时补充保证金，否则平台为降低风险将停止发布机构服务项目。<br><br>
  <span style="color:#717171;">1.2.2机构赔付资金用途</span><br>

							机构预用风险保证资金只针对各机构提供服务的借款项目，即实地认证与机构担保项目。对平台信用标借款项目，机构无赔付责任。<br>
  <br> <span style="font-weight:bold; color:#717171;">1.3平台风险备用金账户规则</span><br> “平台风险备用金账户”是指麒麟通宝为所服务的所有投资人的共同利益考虑，以麒麟通宝名义开设并由平安银行进行管理的专款专用账户，服务于麒麟通宝平台的本息保障计划。<br><br>

  <span style=" color:#717171;">1.3.1“风险备用金账户”资金来源</span><br>

							“风险备用金账户”资金当前部分来源于平台根据其与借款人签署的协议向其所服务的借款人所收取的服务费（以下简称“服务费”），平台在依协议向借款人收取服务费的同时，将在收取的服务费中按照贷款产品类型及借款人的信用等级等信息计提风险备用金（详见《麒麟通宝风险备用金账户--产品垫付规则明细表》）。另外，平台将根据借款项目待收金额与服务费收取实际情况，计提风险备用金维持在待收本金的5%-8%，不足5%时平台将通过充值方式向风险备用金账户中补充金额，每月末平台经根据待收项目详情对风险备用金进行调整。计提和补充充值的风险备用金将存放入“风险备用金账户”进行专户管理，并定期对风险备用账户信息进行披露。各产品类型及信用等级等所对应的风险备用金的计提标准和方式由麒麟通宝制定并解释，麒麟通宝有权根据实际业务需要对相关内容进行调整，如作修改，麒麟通宝将及时进行披露。<br><br>

  <span style=" color:#717171;">1.3.2“平台风险备用金账户”资金用途</span>
							<br>“平台风险备用金账户”资金将专门用于在一定限额内补偿平台所服务的投资人（债权人）由于借款人（债务人）的违约和机构无法及时赔付所遭受的本息损失（具体赔付金额以所投资的产品类型的垫付规则为准），即当信用标借款人（债务人）逾期还款超过30日时，平台将按照“风险备用金账户资金使用规则”从该账户中提取相应资金用于偿付投资人（债权人）应收取的本息金额；实地考察标、机构担保标借款人（债务人）逾期还款超过30日当机构无法及时赔付时，平台将按照“风险备用金账户资金使用规则”从该账户中提取相应资金用于偿付投资人（债权人）应收取的本息金额（不同产品的垫付范围请参考《麒麟通宝风险备用金账户&mdash;产品垫付规则明细表》）（以下统一简称“逾期应收赔付金额”）。<br><br>
  <span style=" color:#717171;">1.3.3“平台风险备用金账户”资金使用规则</span><br>
							“平台风险备用金账户”资金使用遵循以下规则：
							<br>
							（1）违约偿付规则，即当信用标借款人（债务人）逾期还款超过30日，或实地考察标、机构担保标借款人（债务人）逾期还款超过30日当机构无法及时赔付时，方才从“平台风险备用金账户”资金中抽取相应资金偿付投资人（债权人）逾期应收赔付金额。
							<br> （2）时间顺序规则，即“平台风险备用金账户”资金对投资人（债权人）逾期应收赔付金额的偿付按照该债权发生的时间顺序进行偿付分配。先偿付时间发生在前的债权，后偿付时间发生在后的债权。<br>

							（3）债权比例规则，即“风险备用金账户”资金对同一借款协议下的不同理财人（债权人）逾期应收赔付金额的偿付按照各债权金额占同协议内发生的债权总额的比例进行偿付分配；或当“风险备用金账户”资金当期余额不足以支付当期（每月为一期）所有应享受该账户的理财人所对应的逾期赔付金额时，则当期应享受该账户的理财人按照各自对应的逾期应收赔付金额占当期所有理财人对应的逾期应收赔付总额的比例进行偿付分配。<br>

							（4）收益转移规则，即当投资人享有了“平台风险备用金帐户”对某笔逾期债权赔付金额的足额偿付后，该债权对应的借款人其后为该笔债权所偿还的本金、利息及罚息归属“风险备用金账户”；如债权有抵押、质押及其他担保的，则平台代借款人处置抵押质押物的所得等也归属“风险备用金账户”。<br>
  （5）金额上限规则，即当“平台风险备用金帐户”内金额超过当时平台上所有非合作机构项目债权未还本金金额的10%时，平台有权将超出部分转出该账户，转出部分归麒麟通宝所有。<br><br>
  <span style=" color:#717171;"> 1.3.4“平台风险备用金账户”资金管理规则</span><br>
  附表：《麒麟通宝风险备用金账户-产品垫付规则明细表》<br><br>
							<!--<img src="/images/u139.jpg" alt="麒麟通宝P2P网贷平台"/><br/>-->
							<table style="margin: 0px auto; border-collapse: collapse; width: 70%; font-size: 12px; border: 1px solid #aaa;">
								<tbody>
									<tr>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											产品类型</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											成交借款风险计提比例</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											逾期/严重逾期借款风险垫付范围</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											垫付资金来源</th>
									</tr>
									<tr>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											信用认证标</th>
										<th width="20%" style="border: 1px solid #aaa; text-align: left;">
											<table style="margin: 0px auto; border-collapse: collapse; width: 100%; font-size: 12px;">
												<tbody>
													<tr>
														<th width="20%" style="padding: 4px 10px; text-align: center;">★★★★<br>★★★
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-top: none; border-right: none; text-align: left;">0%
														</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; text-align: center;">
															★★★★<br>★★☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; text-align: left;">1.0%
														</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; text-align: center;">
															★★★★<br>★☆☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; text-align: left;">1.5%
														</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; text-align: center;">
															★★★★<br>☆☆☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; text-align: left;">2.0%
														</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; text-align: center;">
															★★★☆<br>☆☆☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; text-align: left;">
															2.5%</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; text-align: center;">
															★★☆☆<br>☆☆☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; text-align: left;">3.0%
														</th>
													</tr>
													<tr>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-left: none; border-bottom: none; text-align: center;">
															★☆☆☆<br>☆☆☆
														</th>
														<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; border-right: none; border-bottom: none; text-align: left;">
															5.0%</th>
													</tr>
												</tbody>
											</table>
										</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											未还本金；逾期当期利息。</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											麒麟通宝风险备用金</th>
									</tr>
									<tr>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											实地认证标</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">归平台风险备用金所应提计比例与信用认证标相同</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											未还本金；逾期当期利息。</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;"> 实地认证机构保证金；麒麟通宝风险备用金</th>
									</tr>
									<tr>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											机构担保标</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">归平台风险备用金所应提计比例与信用认证标相同</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;">
											未还本金；逾期当期利息。</th>
										<th width="20%" style="padding: 4px 10px; border: 1px solid #aaa; text-align: left;"> 合作担保机构风险备用金；麒麟通宝风险备用金</th>
									</tr>
								</tbody>
							</table>
<br>
  <span style="font-weight:bold; color:#717171;">1.4法律维权</span><br>
  麒麟通宝与北京市京都（深圳）律师事务所合作，针对违约的借款项目，投资人在合作机构无法及时赔付，且平台风险备用金不足及时垫付时，可通过法律手段向借款人追缴剩余借款本息。<br><br>
  <span style=" color:#717171;"> 1.4.1维权费用</span><br>
  麒麟通宝针对投资人的法律维权行为，除了与专业律师事务所合作外，还提供专款资金作为维权服务费，即违约借款项目的投资人通过北京市京都（深圳）律师事务所进行法律维权的，其中所需所有服务费用由麒麟通宝承担。
							

						</div>
					</div>

					<div id="name2">
						<span class="n_mc_name_hf">2、账户及信息安全保障</span>
						<div class="n_me_content_hf">
							麒麟通宝作为国内先进的P2P金融服务平台，不仅要为用户提供周到的金融服务，同时也有责任保障每位网站用户的账

							户以及信息安全。我们使用先进的技术方案、完善的权限管理，最大程度的对用户账户安全进行保护。<br> 2.1.
							网站技术保障<br> 麒麟通宝网站运用各种先进的安全技术保护用户在麒麟通宝账户中存储的个人信息、账户信息以及交易记录，以免用户账

							户遭受未经授权的访问、使用以及信息泄露。<br>

							麒麟通宝网站有着完善的安全监测系统，可以及时发现网站的非正常访问并做相应的安全响应。对于用户的账户信息，

							麒麟通宝网站会对其进行高强度的加密，以防止用户信息的外泄。<br>

							同时，我们还会持续更新和改进网站的安全策略，以保证网站安全策略的有效性和健壮性。<br> 2.2. 权限管理保障<br>

							我们严格遵守国家相关的法律法规，对用户的隐私信息进行保护。未经您的同意，麒麟通宝不会向任何第三方公司、组织

							和个人披露您的个人信息、账户信息以及交易信息（法律法规另有规定的除外）。<br>

							同时，麒麟通宝公司内部也设有严格、完善的权限管理体系，以保证每一位内部员工都只能查看自己职责和权限之内的数 据和信息。

						</div>
					</div>

					<div>
						<span class="n_mc_name_hf">3、借款审核与保障</span>
						<div class="n_me_content_hf">
							3.1. 严格的贷前审核<br>

							在客户提出借款申请后，麒麟通宝会对客户的基本资料进行分析。通过网络、电话及其他可以掌握的有效渠道进行详实、

							仔细的调查。避免不良客户的欺诈风险。在资料信息核实完成后，根据个人信用风险分析系统进行评估，由经验丰富

							的借款审核人员进行双重审核确认后最终决定批核结果。<br> 3.2. 完善的贷后管理<br>

							如果用户逾期未归还借款，贷后管理部门将第一时间通过短信、电话等方式提醒用户进行还款。如果用户在5天内还未

							归还当期借款，麒麟通宝将会联系该用户的紧急联系人、直系亲属、单位等督促用户尽快还款。如果用户仍未还款，交由

							专业的高级催收团队与第三方专业机构合作进行包括上门等一系列的催收工作，直至采取法律手段。

						</div>
					</div>
					<div id="name4">
						<span class="n_mc_name_hf">4、用户自我保护</span>
						<div class="n_me_content_hf">
							账户安全需要网站和用户共同努力。在此，我们提倡各位用户在网站使用过程中，注意以下几点：<br> 4.1.
							牢记麒麟通宝官方网址：www.jiudian.com<br>

							不要点击来历不明的链接访问麒麟通宝，谨防网站钓鱼和欺诈。我们建议您将麒麟通宝官方网址加入浏览器收藏夹，以方便 您的下次登录。<br>

							4.2. 为您的麒麟通宝账户设置高强度的登录密码<br>

							（1）您在密码设置时，最好使用数字和字母混合，不要使用纯数字或纯字母，且密码长度要在6位以上。<br>

							（2）不要使用您的生日、姓名拼音、身份证号码、手机号或是邮箱名作为登录密码。<br>

							（3）不要使用连续的，或重复的字母、数字组合作为密码，例如：aaaaaa，111111，abcdef，123456。<br>

							（4）不要使用以下常用密码，例如：qazwsx，qwerty，mima123，password等。<br> 4.3.
							注重电脑运行环境的安全<br> （1）及时为您的电脑进行系统更新，及时系统安全补丁，以防系统漏洞被黑客利用。<br>

							（2）为您的电脑安装杀毒软件或防火墙，并定期为电脑进行查毒、杀毒。<br>

							（3）避免在网吧等公共场所使用网上银行，不要打开来历不明的电子邮件。<br>

							（4）不要访问危险的网站，不要使用来历不明的软件。<br> 4.4. 时刻注意保护个人隐私<br>

							用户在平台上交流的过程中，不要向其他用户透露自己真实姓名与住址等，以防个人信息被盗取造成损失。<br> 4.5.
							避免私下交易<br>

							麒麟通宝建议用户避免私下交易。私下交易的约束力极低，造成逾期的风险非常高，同时您的个人信息将有可能被泄漏，

							存在遭遇诈骗甚至受到严重犯罪侵害的隐患。

						</div>
					</div>
				</div>
				<div class="n_nav_mc_hf">
					<div style="font-size: 24px; color: #737373; margin-top: 30px;">网站协议及产品说明</div>
					<div>
						<span class="n_mc_name_hf">1、电子合同的有效性</span>
						<div class="n_me_content_hf">
							通过麒麟通宝审核的借款方向投资方借贷，双方通过平台的电子借贷协议，明确双方的债务与债权关系。依据中华人民

							共和国合同法第十一条规定："书面形式是指合同书、信件和数据电文（包括电报、电传、传真、电子数据交换和电

							子邮件）等可以有形地表现所载内容的形式"，麒麟通宝上电子合同与传统合同具有同等的法律效力，麒麟通宝服务仅向

							符合中华人民共和国有关法律法规及本公司相关规定的合格投资人和借款人提供。</div>
					</div>

					<div>
						<span class="n_mc_name_hf">2、如何查询我的借款协议？</span>
						<div class="n_me_content_hf">
							2.1. 如果您已在网上成功的获得借款，您可以在网站上访问"我的麒麟通宝"-"我的借款"-"合同"<br>

							2.2. 如果您已在网上成功的投标理财，您可以在网站上访问"我的麒麟通宝"-"我的投标"-"合同"<br>

							2.3. 您也可以在帮助中查看"网站借款协议范本"

						</div>
					</div>

					<div>
						<span class="n_mc_name_hf">3、网站借款协议范本</span>
						<div class="n_me_content_hf">
							<span> <a
								href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name())%>"
								target="_blank" style="color: #6699ff;">点击查看网站借款协议范本</a></span>
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">4、理财体验说明书</span>
						<div class="n_me_content_hf">
							<span><a
								href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>"
								target="_blank" style="color: #6699ff;">点击查看理财体验说明书</a></span>
						</div>
					</div>
					<div></div>
					<div>
						<span class="n_mc_name_hf">5、债权转让说明书</span>
						<div class="n_me_content_hf">
							<span> <a
								href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZQZRSMS.name())%>"
								target="_blank" style="color: #6699ff;">点击查看债权转让说明书</a></span>
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">6、债权转让协议</span>
						<div class="n_me_content_hf">
							<span> <a
								href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZQZRXY.name())%>"
								target="_blank" style="color: #6699ff;">债权转让及受让协议范本</a></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>	
	
</body>
</html>