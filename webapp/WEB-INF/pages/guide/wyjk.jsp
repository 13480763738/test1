<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xlyb2sl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xlyb1sl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Jhsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Gchysl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Gcsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Fcsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Srsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Gssl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Yyzzsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xybgsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Sfzsl2"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Sfzsl"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
	String _TITLE_ = ArticleType.WYJK.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
		CURRENT_SUB_CATEGORY = "WYJK";
	%>
	<div class="new-contant mt20 pb40" style="border-top:1px solid #ddd">
	<%@include file="/WEB-INF/include/xszy/left.jsp"%>
	<div class="new-center new-jkfl pt20 mb30 white-bg">
			<div class="new-about-xian"></div>
			<h2 style="background:#fff;">借款分类</h2>
			<div class="new-jkfl-con">
				<div class="new-jkfl-left fl">
					<h3>个人用户</h3>
					<div class="apply">
						<div class="left fl lanse bold">
							申请条件
						</div>
						<div class="right fr">
							<p>(1) 年满22-55周岁的中国公民</p>
							<p>(2) 工薪族在现单位工作满3个月,月收入3000以上</p>
							<p>(3) 私营业主经营满半年,月收入5000以上</p>
							<p>(4) 网商族经营网店满半年,近三个月的成交额满3万</p>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tiaojian pt10">
						<p>
							<span class="bold heise">主要借款用</span>
							<span>装修、结婚、买房、买车、教育、进货、其他费用</span>
						</p>
						<p>
							<span class="bold heise">借款额度</span>
							<span>50,000 - 500,000</span>
						</p>
						<p>
							<span class="bold heise">借款年利率</span>
							<span>10% - 24%</span>
						</p>
						<p>
							<span class="bold heise">借款期限</span>
							<span>1、3、6、9、12、18、24个月</span>
						</p>
						<p>
							<span class="bold heise">审核时间</span>
							<span>1 - 3个工作日</span>
						</p>
						<div class="apply">
							<div class="left fl lanse bold">
								还款方式
							</div>
							<div class="right fr">
								<p>(1) 每月还息到期还本</p>
								<p>(2) 协议还款</p>
							</div>
							<div class="clear"></div>
						</div>
					</div>
					<div class="apply pt10 noborder">
						<div class="left fl lanse bold">
							必要申请材料
						</div>
						<div class="right fr" style="padding-right: 86px;">
							<p>(1) 身份证</p>
							<p>(2) 个人征信报告(可取当地人民银行打印)</p>
							<p>(3) 带公司公章的劳动合同或工作证明(工薪族)</p>
							<p>(4) 近3个月工资卡银行流水(工薪族)</p>
							<p>(5) 营业执照与场地租赁合同(私营业主)</p>
							<p>(6) 网店认证资料(网商族)</p>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="new-jkfl-right fr">
					<h3>企业用户</h3>
					<div class="apply">
						<div class="left fl lanse bold">
							申请条件
						</div>
						<div class="right fr rightline">
							<p>(1) 企业经营时间满一年</p>
							<p>(2) 企业无涉诉情况</p>
							<p>(3) 企业无不良贷款记录</p>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tiaojian pt10">
						<p>
							<span class="bold heise">主要借款用</span>
							<span>扩大经营、购买设备或原材料、企业推广、其他费用</span>
						</p>
						<p>
							<span class="bold heise">借款额度</span>
							<span>100,000 - 5,000,000</span>
						</p>
						<p>
							<span class="bold heise">借款年利率</span>
							<span>10% - 24%</span>
						</p>
						<p>
							<span class="bold heise">借款期限</span>
							<span>1、3、6、9、12、18、24个月</span>
						</p>
						<p>
							<span class="bold heise">审核时间</span>
							<span>1 - 3个工作日</span>
						</p>
						<div class="apply">
							<div class="left fl lanse bold">
								还款方式
							</div>
							<div class="right fr">
								<p>(1) 每月还息到期还本</p>
								<p>(2) 协议还款</p>
								
							</div>
							<div class="clear"></div>
						</div>
					</div>
					<div class="apply pt10 noborder">
						<div class="left fl lanse bold">
							必要申请材料
						</div>
						<div class="right fr" style="padding-right: 86px;">
							<p>(1) 法人代表身份证</p>
							<p>(2) 企业营业执照、税务登记证、组织机构代码证</p>
							<p>(3) 企业纳税证明</p>
							<p>(4) 近1年度经审计的财务报表</p>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<!--如何借款-->
		<div class="new-rhjk new-center white-bg mt20">
			<div class="new-about-xian"></div>
			<h2>如何借款</h2>
			<div class="pt30 picimg">
				<img src="<%=controller.getStaticPath(request)%>/images/rhtz-bg.png"/>
			</div>
		</div>
		<!--完成借款-->
		   <div class="white-bg mt20 new-lcsm">

                  <div>
                      <h4>1、借款金额有限制吗？</h4>
                      <p>个人贷额度：50,000 - 500,000<br />企业贷额度：100,000 - 5,000,000</p>
                   </div>
                    <div>
                      <h4>2、麒麟通宝的借款期限和还款方式？</h4>
                      <p>目前信用借款您可以选择的借款期限1个月、3个月、6个月、9个月、12个月、18个月、24个月。还款方式有：1、协议还款;2、每月还息到期还本。</p>
                   </div>
                    <div>
                      <h4>3、借款审核需要多长时间？</h4>
                      <p>审核期限为1-5个工作日，一般在3个工作日内完成。您可以通过平台在线客服或者客服服务电话400-8098-122了解您的项目审核进度。</p>
                   </div>
 		<div>
                      <h4>4、关于还款的相关问题</h4>
                      <div>
			<h5>（1）如何还款？</h5>
                            <font>若账户中余额大于当期借款应还金额，在还款日系统会代借款者自动扣缴当期还款。若借款人需要手动还款，请点击用户名访问 "个人中心"-"我的借款"，进行还款操作。 </font>
		   </div>
		   <div>
			<h5>（2）借款人能否提前还款？</h5>
                            <font>借款人可以随时进行提前还款。具体的操作方法是点击用户名访问 "个人中心"-"我的借款"进行提前还款操作。</font>
		   </div>
 		   <div>
			<h5>（3）借款到期后能否申请延期？</h5>
                            <font>借款到期后不可以延期，您可以正常偿还完毕后再次申请。</font>
		   </div>
		   <div>
			<h5>（4）逾期还款的问题</h5>
                            <font>如果逾期还款，借款人要承担罚息与逾期后的管理费用。所以麒麟通宝强烈建议用户避免逾期还款，一旦发生逾期请尽快还清借款。</font></div>
                   </div>
             </div>
		</div>
    <div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
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