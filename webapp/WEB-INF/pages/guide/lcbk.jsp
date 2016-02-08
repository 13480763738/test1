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
	CURRENT_SUB_CATEGORY = "LCBK";
%>
<div class="new-contant mt20 pb40" style="border-top:1px solid #ddd">
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
	
	<div class="new-help1 white-bg">
		<div class="new-about-xian"></div>
		<h1 class="pb50">理财百科</h1>
		<div>
				<span style="display:block;">
					1、借款用户（借款人）</br>
					<p>已经或准备在网站上进行借款活动的用户称为借款用户。凡22周岁以上的中国大陆地区公民，都可以成为借款用户。</p>
					</br></br>
				</span>
                <span style="display:block;">
					2、理财用户（投资人）</br>
					<p>已经或准备在网站上进行资金出借活动并完成了实名认证、手机号码绑定和提现密码设置的用户称为理财用户。</p>
					</br></br>
				</span>
               <span style="display:block;">
					3、服务码</br>
					<p>用户注册后将获得属于个人的唯一标识码，好友填入服务码注册成功后，推广人将会根据好友充值或投资具体情况获得一定奖励。</p>
					</br></br>
				</span>
				<span style="display:block;">
					4、标的</br>
					<p>又称"借款标的"、"借款项目"，经常简称为"标"。指P2P借贷平台发布的借款信息，内容一般包括：标题、借款人、借款总额、借款用途、借款期限、还款方式、利率、招标期限、逾期（违约）时的保障措施等。</p>
					</br></br>
				</span>
				<span style="display:block;">
					5、发标</br>
					<p>指麒麟通宝用户通过平台发布借款标的的行为。</p>
					</br></br>
				</span>
				<span style="display:block;">
					6、招标</br>
					<p>指标的通过审核进入到投资列表内，此时标的状态为招标。</p>
					</br></br>
				</span>
				<span style="display:block;">
					7、投标</br>
					<p>指投资人选择处于招标期限之内、未满标的借款标的，表达向该标的的借款人出借资金的意愿和数额。投资人投标后，所投资金将被暂时锁定，但并不直接转给借款人，一般在满标之后才会真正划转给借款人。</p>
					</br></br>
				</span>
				<span style="display:block;">
					8、满标</br>
					<p>指一个标的在招标期限内足额筹集到所需资金，等待放款的状态。</p>
					</br></br>
				</span>
				<span style="display:block;">
					9、放款</br>
					<p>指一个标的满标后且已符合放款标准，该标的所筹资金从出借人账户转入借款人账户的过程，即借款人成功获得了借款。</p>
					</br></br>
				</span>
				<span style="display:block;">
					10、流标</br>
					<p class="sele">指因资料上传不全或综合情况不符合借款要求，导致借款申请未通过，或超过招标期限但未满标的状态叫做流标。</p>
					</br></br>
				</span>
				<span style="display:block;">
					11、逾期</br>
					<p class="sele">指用户未按借款协议约定时间进行足额还款，此时标的状态为逾期。</p>
					</br></br>
				</span>
				<span style="display:block;">
					12、到期一次性付清</br>
					<p class="sele" > 指当借款期限到达时，一次性将本金和利息全部归还的还款方式。多见于期限低于三个月的短期标。</p>
					</br></br>
				</span>
				<span style="display:block;">
					13、每月还息到期还本</br>
					<p class="sele">每月还息到期还本 还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时每期还息，最后一期还当期利息和全部本金。</p>
					</br></br>
				</span>
				<span style="display:block;">
					14、协议还款</br>
					<p class="sele">协议还款是平台为保障投资人收益采用的一种还款方式。协议还款是指投融资双方按照约定的还款计划进行还款。</p>
					</br></br>
				</span>
				<span style="display:block;">
					15、债权</br>
					<p class="sele">指理财用户与借款用户之间的债务关系。</p>
					</br></br>
				</span>
				<span style="display:block;">
					16、债权价值</br>
					<p class="sele">用户持有债权单份价值（元/份），麒麟通宝按债权待收本金计算。</br>具体计算公式：
债权价值=待收本金/债权持有份数 ，待收本金即债权的总价值。</p>

					</br></br>
				</span>
				<span style="display:block;">
					17、债权价格</br>
					<p class="sele">用户在对持有债权进行转让时的出售价格。</p>
					</br></br>
				</span>
				<span style="display:block;">
					18、债权份数</br>
					<p class="sele">债权的原始投资金额每100元为一份。</p>
					</br></br>
				</span>
				<span style="display:block;">
					19、投资金额</br>
					<p class="sele">指投标时理财用户的投标金额。</p>
					</br></br>
				</span>
				<span style="display:block;">
					20、冻结金额<br />
					 <p class="sele"> 冻结金额指用户帐户内不能自由支配的资金部分，一般是投标冻结和提现冻结。</p>
					</br></br>
				</span>
			</div>
	</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<%-- <%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%> --%>	 
	 
</body>
</html>