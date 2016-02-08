<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
	String _TITLE_ = ArticleType.LXHFY.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
		CURRENT_SUB_CATEGORY = "LXHFY";
	%>
	<%@include file="/WEB-INF/include/xszy/left.jsp"%>
	<div class="center_box">
		<div class="center">
			<div class="n_nav_mc_hf">
				<div class="n_nav_mt_hf">
					<h1 style=" font-size:30px;">利息和费用</h1>
				</div>
				<div style="font-size: 24px; color: #737373; margin-top: 30px;">理财人费用</div>
				<div>
					<span class="n_mc_name_hf">1、充值费用</span>
					<div class="n_me_content_hf" style="display: none;">平台暂不收取用户充值费用。为防止用户信用卡套现，平台对充值后20天内未进行投资的资金，提现时除正常提现费用外额外收取0.5%的提现手续费，20天以后提现的按正常提现规则收取费用。
					</div>
				</div>

				<div>
					<span class="n_mc_name_hf">2、提现费用</span>
					<div class="n_me_content_hf" style="display: none;">
						当理财人进行提现操作时，会发生提现费用。第三方支付平台将按以下标准收取相关费用。
						5000元以下,5元/笔;5000元(含5000元)以上,3元/笔。单笔提现金额不低于100元，不超过200000元，每日累计提现不超过5000000元。</br>为防止用户信用卡套现，平台对充值后20天内未进行投资的资金，提现时除正常提现费用外额外收取0.5%的提现手续费，20天以后提现的按正常提现规则收取费用。</div>
				</div>

				<div>
					<span class="n_mc_name_hf">3、理财体验费用</span>
					<div class="n_me_content_hf" style="display: none;">
						（1）加入费用：a%。加入计划金额的a%，期初额外收取，即加入计划金额为10万元，则另行收取10万元*a% 作为加

						入计划费用归麒麟通宝所有。<br> （2）服务费用：b%。即计划中投标所得利息收入的b%作为服务费用归麒麟通宝所有。<br>

						（3）退出费用：c%。退出计划时按退出计划金额的c%收取退出费用归麒麟通宝所有。<br>

						注：目前加入费用、服务费用、退出费用均为0。
					</div>
				</div>
				<div>
					<span class="n_mc_name_hf">4、债权转让费用</span>
					<div class="n_me_content_hf">债权转让的费用为转让管理费。平台向转出人收取，不向购买人收取任何费用。
					转让管理费金额为成交金额*转让管理费率，转让管理费率目前按<%=configureProvider.getProperty(SystemVariable.ZQZRGLF_RATE) %>收取，
					具体金额以债权转让页面显示为准。债权转让管理费在成交后直接从成交金额中扣除，
					不成交平台不向用户收取转让管理费。</div>
				</div>

				<div>
					<span class="n_mc_name_hf">5、理财服务费</span>
					<div class="n_me_content_hf">麒麟通宝将收取理财人利息收益作为理财服务费，目前平台的理财服务费为0。</div>
				</div>
				<div style="font-size: 24px; color: #737373; margin-top: 40px;">借款人费用</div>
				<div>
					<span class="n_mc_name_hf">1、借款服务费</span>
					<div class="n_me_content_hf">
						麒麟通宝收取的借款服务费将全部存于风险准备金账户用于麒麟通宝的本息保障计划。服务费将按照借款人的信用等级来收取：<br> <img
							width="714" height="80"
							src="<%=controller.getStaticPath(request)%>/images/n_lixi_03.png">
					</div>
				</div>

				<div>
					<span class="n_mc_name_hf">2、借款管理费</span>
					<div class="n_me_content_hf" style="display: none;">麒麟通宝将按照借款人的借款期限，每月向借款人收取其借款本金的0.5%作为借款管理费。
					</div>
				</div>

				<div>
					<span class="n_mc_name_hf">3、提现费用</span>
					<div class="n_me_content_hf">

						当理财人进行提现操作时，会发生提现费用。第三方支付平台将按以下标准收取相关费用。
						5000元以下,5元/笔;5000元(含5000元)以上,3元/笔。单笔提现金额不低于100元，不超过200000元，每日累计提现不超过5000000元。</br>
						为防止用户信用卡套现，平台对充值后20天内未进行投资的资金，提现时除正常提现费用外额外收取0.5%的提现手续费，20天以后提现的按正常提现规则收取费用。</div>
				</div>
				<div>
					<span class="n_mc_name_hf">4、充值费用</span>
					<div class="n_me_content_hf">平台暂不收取用户充值费用。为防止用户信用卡套现，平台对充值后20天内未进行投资的资金，提现时除正常提现费用外额外收取0.5%的提现手续费，20天以后提现的按正常提现规则收取费用。</div>
				</div>
				<div>
					<span class="n_mc_name_hf">5、逾期罚息</span>
					<div class="n_me_content_hf">
						当用户的借款发生逾期时，正常利息停止计算。按照下面公式计算罚息：<br> <img width="211"
							height="125"
							src="<%=controller.getStaticPath(request)%>/images/n_lixi_06.png"><br>
						<table width="600" border="0" style="text-align: center">
							<tbody>
								<tr style="background: #f4fcfe">
									<td>逾期天数</td>
									<td>1-30天</td>
									<td>30天以上</td>
								</tr>
								<tr style="background: #f7f7f7">
									<td>罚款利率</td>
									<td>0.05%</td>
									<td>0.1%</td>
								</tr>
							</tbody>
						</table>

					</div>
					<div>
						<span class="n_mc_name_hf">6、逾期管理费</span>
						<div class="n_me_content_hf">
							用户的借款发生逾期时，正常借款管理费用停止计算。按照下面公式计算：<br> <img width="223"
								height="121"
								src="<%=controller.getStaticPath(request)%>/images/n_lixi_09.png"><br>
							<table width="600" border="0" style="text-align: center">
								<tbody>
									<tr style="background: #f4fcfe">
										<td>逾期天数</td>
										<td>1-30天</td>
										<td>30天以上</td>
									</tr>
									<tr style="background: #f7f7f7">
										<td>罚款利率</td>
										<td>0.1%</td>
										<td>0.5%</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">7、提前还款违约金</span>
						<div class="n_me_content_hf">借款者提前还清借款，需向投资人支付提前还清时除当期还款外其他待还本金的1%作为提前还款违约金。（天标除外）
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">8、麒麟通宝年利率范围</span>
						<div class="n_me_content_hf">
							麒麟通宝目前的利率范围为10%-24%。在麒麟通宝平台上借贷的最高年利率设定为同期银行借款年利率的4倍。且随着银行

							借款利率的调整，麒麟通宝的利率上限也将随之调整。<br> 注：<br>

							（1）麒麟通宝的利率的调整会在商业银行借款年利率调整后1个月内进行调整。<br>

							（2）在利率调整之前成功的借款不受调整的影响。

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	<script>
        $(function () {
            $(".n_mc_name_hf").click(function () {
                $(this).hasClass("open") ? $(this).removeClass("open").next("div").slideUp(500) : $(this).addClass("open").next("div").slideDown(500);
            });
        });
    </script>
</body>
</html>