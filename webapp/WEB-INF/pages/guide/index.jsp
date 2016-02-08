<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = ArticleType.XSZY.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
		CURRENT_SUB_CATEGORY = "XSZY";
	%>
<!-- 	<div class="project-list"> -->
<%-- 	<div style="width:100%; height:230px; background:#07466b url(<%=controller.getStaticPath(request)%>/images/xinshou_pic.png) center top no-repeat;"></div> --%>
<!-- 	<div class="center_box"> -->
<!-- 	        <div class="center"> -->
<!-- 	        <div style="width:100%; float:left; margin-top:80px;"> -->
<!-- 	        	<p style="text-align:center; color:#333; line-height:30px;"><span style="font-size:30px;">1、麒麟通宝能给您带来什么</span></p> -->
<!-- 	            <ul class="xs_contant"> -->
<!-- 					<li> -->
<%-- 						<img src="<%=controller.getStaticPath(request)%>/images/xs-cont1.png" alt=""/> --%>
<!-- 						<p>年化收益高达12%</p> -->
<!-- 					</li> -->
<!-- 					<li> -->
<%-- 						<img src="<%=controller.getStaticPath(request)%>/images/xs-cont2.png" alt=""/> --%>
<!-- 						<p>有充足的抵押或担保,保障所有用户的每一笔资金本息安全</p> -->
<!-- 					</li> -->
<!-- 					<li> -->
<%-- 						<img src="<%=controller.getStaticPath(request)%>/images/xs-cont3.png" alt=""/> --%>
<!-- 						<p>邀请好友注册投资可获得推广提成</p> -->
<!-- 					</li> -->
<!-- 					<div class="clear"></div> -->
<!-- 	            </ul> -->
<!-- 			</div> -->
<!-- 			</div> -->
<!-- 	    </div> -->
<!-- 	    <div style="background:#f1f3f5; width:100%; float:left; margin-top:20px; font-size:14px; color:#5a5a5a; line-height:30px;"> -->
<!-- 	    	<div class="center"> -->
<!-- 	        	<p style="text-align:center; color:#333; line-height:30px; padding:80px 0 50px 0;"><span style="font-size:30px;">2、开启理财之旅</span></p> -->
<!-- 			<!--js部分--> 
<!-- 			<div class="investMain" >  -->
<!-- 			<a href="javascript:;" class="prev" id="idPrev"></a>  -->
<!-- 			<a href="javascript:;" class="next" id="idNext"></a> -->
<!-- 			<ul class="howInvest r3 how-step-0" id="idNum"> -->
<!-- 				<li class="step-1"><font style="border-left:1px solid #0E88D4;"><span class="shuzi">1</span>用户注册</font></li> -->
<!-- 				<li class="step-2"><font><span class="shuzi">2</span>实名认证</font></li> -->
<!-- 				<li class="step-3"><font><span class="shuzi">3</span>用户充值</font></li> -->
<!-- 				<li class="step-4"><font><span class="shuzi">4</span>用户投资</font></li> -->
<!-- 				<div class="clear"></div> -->
<!-- 			</ul> -->
<!-- 			<div class="investbox" id="idFormView"> -->
<!-- 				<ul class="invesSlider" id="idSlider" style="left: 0px;"> -->
<%-- 					<li><img src="<%=controller.getStaticPath(request)%>/images/guide_banner1.gif" width="695" height="447"> --%>
<!-- 					</li> -->
<%-- 					<li><img src="<%=controller.getStaticPath(request)%>/images/guide_banner2.gif" width="695" height="447"> --%>
<!-- 					</li> -->
<%-- 					<li><img src="<%=controller.getStaticPath(request)%>/images/guide_banner3.gif" width="695" height="447"> --%>
<!-- 					</li> -->
<%-- 					<li><img src="<%=controller.getStaticPath(request)%>/images/guide_banner4.gif" width="695" height="447"> --%>
<!-- 					</li> -->
<!-- 					<div class="clear"></div> -->
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 			<div class="clear"></div> -->
<!-- 		</div> -->
<!-- 		</div>		 -->
<!-- 		</div> -->
<!-- 	    <div class="center_box" > -->
<!-- 	    	<div class="center"> -->
<%-- 	        	<div class="ljzc"><a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="margin-top:50px;">立即注册</a></div> --%>
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	</div> -->
	 <div class="new-contant pt30 mt20 pb30">
  <!--新手指引-->
	<div class="new-xszy-contant new-center white-bg pt40 pb30">
		<div class="top-xszy">
			<ul>
				<li class="one">
					<h2><span>1.</span>麒麟通宝是什么</h2>
					<p class="p1">
						麒麟通宝是由旗丰集团重金打造的专业、安全、便捷的互联网金融投融资服务平台。麒麟通宝以"成为供应链借贷平台的标杆"为目标，专注于风险系数较低的供应链融资，辅之以保障系数较高的红本贷、车辆质押和小微企业生意贷等产品。平台依托集团在供应链服务、小额贷款方面的优势资源及专业团队，为广大投资者提供风险可控的投资标的，为融资者提供事业发展的强力支持。
					</p>
					<p class="p2">平台严格把关项目准入门槛，专业的风控团队全流程风险管控，实力雄厚的信用管理机构到期无条件债权收购，全方位保障投资人资金的高度安全、灵活流动和稳健收益；麒麟通宝平台严格依法合规经营，始终坚持以第三方托管与银行存管相结合的方式，确保平台操作规范、运营透明，发展健康。</p>
					<p class="p3">麒麟通宝始终坚持以优质的产品为导向，以严格的风控为基础，以合规经营、稳健发展为经营理念，致力于打造中国最专业的互联网供应链金融服务平台。</p>
				</li>
				<li class="two">
					<h2><span>2.</span>麒麟通宝能为你提供什么？</h2>
					<h3 class="pt40 pb30">为借款人提供</h3>
					<p>旗企贷（企业贷）：为各类中小企业、商会协会成员，发达工业园区企业专属定制，解决中小企在发展过程中<br /><span>遇到的资金瓶颈问题！</span>
					</p>
					<p>旗意贷（生意贷）：为个体工商户或小企业主量身定制，手续简单，流程简化!
					</p>
					<p>旗速贷（供应链贷）：为供应链上下游客户提供完善的仓单融资、贸易融资、保理融资等金融服务。
					</p>
					<p>旗车贷（车辆抵押贷款）：用于帮助车辆所有者解决急需资金的贷款产品。
					</p>
					<p>旗房贷（红本抵押贷）：用红本作抵押的一种贷款产品，额度高、速度快。
					</p>
					<h3 class="pt40 pb30">为投资人提供</h3>
					<p>基于供应链金融、房产、车辆及企业生意往来的债权理财产品。</p>
				</li>
				<li class="three">
					<h2><span>3.</span>麒麟通宝的优势是什么？</h2>
					<ol class="pt30 pb30">
						<li style="margin-left:0">
							<img src="<%=controller.getStaticPath(request)%>/images/xinshou-youshi3.png" alt="" />
							<p class="pt10">高收益低门槛 </p>
							<p>100元起投</p>
							<p>30倍以上银行存款收益</p>
						</li>
						<li>
							<img src="<%=controller.getStaticPath(request)%>/images/xinshou-youshi2.png" alt="" />
							<p>更安全更便利  6道审核   </p>
							<p>本息保障计划  </p>
							<p>交易资金全托管  全程网络操作</p>
						</li>
						<li style="margin-right:0">
							<img src="<%=controller.getStaticPath(request)%>/images/xinshou-youshi1.png" alt="" />
							<p class="pt10">多选择更灵活  产品多元</p>
							<p>满足各种偏好</p>
							<p> 债权可转让  资金周转更灵活</p>
						</li>
						<div class="clear"></div>
					</ol>
				</li>
			</ul>
		</div>
	</div>
	<div class="new-xszy-btm new-center white-bg mt30 pt30 pb40"> 
		<div class="top-xszy pt40 pb30">
			<h2>
				<span>麒麟通宝怎么玩</span>
			</h2>

			<div class="new-jklcpic"><img src="<%=controller.getStaticPath(request)%>/images/jklc.png" alt=""/></div>
		</div>
		<!--如何借款-->
		<div class="new-wcjk new-center white-bg mt20 mb20">
			<div class="header">
				<h2>如何投资</h2>
			</div>
			<div class="pt30 picimg">
				<img src="<%=controller.getStaticPath(request)%>/images/rhjk-bg.png"/>
			</div>
		</div>
		<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="zc-btn">立即注册</a>
	</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/lunbo_can.js"></script>
</body>
</html>