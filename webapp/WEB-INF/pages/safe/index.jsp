<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.xszy.Ptjs"%>
<html>
<head>
<LINK REL="SHORTCUT ICON"
	HREF="http://<%configureProvider.format(out, SystemVariable.SITE_DOMAIN);%>/favicon.ico">
<%
String _TITLE_ = "安全保障 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<style>
.stepbox{ width:312px; height:165px; border:1px solid #ccc; float:left; position:relative; color:#5a5a5a; font-size:14px; margin-right:29px; margin-bottom:40px;}
.stepbox p{ text-align:justify;text-justify:inter-ideograph; }
.stepbox span{ font-size:18px;  font-style:italic; background:#fff; position:absolute; left:-1px; top:-7px; padding:0 5px 0 0; float:left; }
.aqbz_rightico{ width:20px; height:16px; background:url(<%=controller.getStaticPath(request)%>/images/new_images/aqbz_ico.jpg) left -2px no-repeat; position:absolute;}
.aqbz_downico{ width:16px; height:20px; background:url(<%=controller.getStaticPath(request)%>/images/new_images/aqbz_ico.jpg) -32px top no-repeat; position:absolute;}
.aqbz_leftico{width:20px; height:16px; background:url(<%=controller.getStaticPath(request)%>/images/new_images/aqbz_ico.jpg) right -2px no-repeat; position:absolute;}
.aqbz_bg{ width:200px; height:320px; position:absolute; left:10px; top:185px;}
.wzjs{width:1050px; margin-top:45px; padding-bottom:60px; float:left;}
.wzjs dl{ float:left; width:315px; margin-right:29px;}
.wzjs dt{ border-bottom:4px solid #ccc; text-align:center; width:100%; float:left; font-size:18px; color:#5a5a5a; position:relative; padding-bottom:7px;}
.wzjs dt span{ width:60px; height:60px; position:absolute; background:url(<%=controller.getStaticPath(request)%>/images/new_images/aqbz_bg03.png) left top no-repeat; left:37px; top:-17px;}
.wzjs dt span.span01{ background-position:7px top;}
.wzjs dt span.span02{background-position:0px -87px;}
.wzjs dt span.span03{background-position:left bottom;}
.wzjs dd{ width:100%; float:left; font-size:14px; line-height:24px; margin-top:20px;}
.ljzc{ text-align:center; padding:100px 0;}
.ljzc a:hover{color:#fff;}
.ljzc a{ width:311px; height:70px; line-height:70px; color:#fff; text-align:center; font-size:30px; display:inline-block; background:url(<%=controller.getStaticPath(request)%>/images/new_images/aqbz_bg04.png) left top no-repeat;}
</style>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	
	<div class="project-list" style="margin-top:20px;">
	<div style="width:100%; height:230px; background:#07466b url(<%=controller.getStaticPath(request)%>/images/sefety_pic.png) center top no-repeat;"></div>
	<!--风控体系-->
<div class="new-contant pb40 pt40">
	<div class="new-safe-fktx">
		<div class="new-center white-bg pt20 pb40">
			<h2 class="pt20 pb40">
				风控体系
			</h2>
			<ul>
				<li>
					<img src="/images/fktx1.png" /> 
					<h3 class="first xm">
						<img src="/images/dian.png" />优先项目
					</h3>
					<p>
						麒麟通宝依托旗丰集团丰富的业务资源优势，结合其在供应链及小额贷款领域深耕多年，形成了全面细致的风控体系，始终选择风险可控、收益可观的融资项目推荐给平台用户。
					</p>
				</li>
				<li>
					<img src="/images/fktx2.png" /> 
					<h3 class="xm">
						<img src="/images/dian.png" />多重措施
					</h3>
					<p>
						有通过麒麟通宝平台发布的融资需求项目均需通过项目的材料初审、前期背景调查、实地财务核查、实地项目考察、工商司法调查、平台线上审核这六道严格的风控审核，确保平台所有项目均在全面规范的风控下开展。
					</p>
				</li>
				<li>
					<img src="/images/fktx3.jpg" /> 
					<h3 class="xm">
						<img src="/images/dian.png" />严格管控
					</h3>
					<p>
						风险控制中心针对平台融资项目制定了专业且严格的贷后管理制度，确保融资资金使用得当，按时回流。
					</p>
				</li>
				<div class="clear">
				</div>
			</ul>
		</div>
	</div>
<!--资金安全-->
	<div class="new-safe-zjaq new-center mt20 mb20">
		<ul>
			<li>
				<h3>
					资金管理隔离
				</h3>
				<p>
					麒麟通宝平台采用第三方资金托管模式，平台仅作为桥梁作用，绝不经手用户交易资金。
				</p>
			</li>
			<li>
				<h3>
					资金流向透明
				</h3>
				<p>
					平台所有资金流转均经第三方资金托管机构实现，平台并无用户交易资金支配权限，所有资金交易均由第三方资金托管机构进行监控，确保交易规范、流向透明。
				</p>
			</li>
			<li class="last">
				<h3>
					多重还款保障
				</h3>
				<p>
					<span>融资方正常还款;</span> <span>融资方担保人（机构）全额代偿;</span> <span>项目推荐机构到期无条件全额收购债权;</span> <span>平台启动风险准备金.</span> 
				</p>
			</li>
			<div class="clear">
			</div>
		</ul>
	</div>
<!--技术安全-->
	<div class="new-safe-fktx">
		<div class="new-center white-bg pt20 pb40">
			<h2 class="pt20 pb40">
				技术安全
			</h2>
			<ul>
				<li>
					<img src="/images/jsaq1.png" /> 
					<h3>
						基础架构完善
					</h3>
					<p>
						平台自建机房，为平台网站设置多重防火墙，在硬件的维护日常维护中建立了严格的管理及监控制度。
					</p>
				</li>
				<li>
					<img src="/images/jsaq2.png" /> 
					<h3>
						数据安全无忧
					</h3>
					<p>
						麒麟通宝对平台所有交易数据、资金数据及其它信息数据建有严格的访问权限制度，定时自动备份，确保平台数据安全无忧。
					</p>
				</li>
				<li>
					<img src="/images/jsaq3.png" /> 
					<h3>
						网站运行稳定
					</h3>
					<p>
						麒麟通宝自建专业技术团队，各项技术及网络设备均通过完善的灾备系统进行监控管理，保障平台网站运行稳定。
					</p>
				</li>
				<div class="clear">
				</div>
			</ul>
		</div>
	</div>
<!--政策保障-->
	<div class="white-bg new-safe-zc mt20">
		<h2 class="pb30">
			政策保障
		</h2>
		<div class="new-safe-zc-l fl">
			<h3>
				国家政策支持
			</h3>
			<p>
				2015年7月18日，经党中央、国务院同意，中国人民银行、国家互联网信息办公室等机构部门联合印发了《关于促进互联网金融健康发展的指导意见》（银发〔2015〕221号，以下简称指导意见》）
			</p>
<br />
			<p>
				《指导意见》按照“鼓励创新、防范风险、趋利避害、健康发展”的总体要求，提出了一系列鼓励创新、支持互联网金融稳步发展的政策措施，积极鼓励互联网金融平台、产品和服务创新，鼓励从业机构相互合作，拓宽从业机构融资渠道，坚持简政放权和落实、完善财税政策，推动信用基础设施建设和配套服务体系建设。“依法监管、适度监管、分类监管、协同监管、创新监管”的原则，确立了互联网支付、网络借贷、股权众筹融资、互联网基金销售、互联网保险、互联网信托和互联网消费金融等互联网金融主要业态的监管职责分工，落实了监管责任，明确了业务边界。
			</p>
		</div>
		<div class="new-safe-zc-r fl">
			<div class="top">
				<h3>
					关于投资人通过麒麟通宝平台获得投资收益的合法性
				</h3>
				<p>
					根据自2015年9月1日最新《最高人民法院关于审理民间借贷案件适用法律若干问题的规定》二十六条规定，借贷双方约定的利率未超过年利率24%，出借人请求借款人按照约定的利率支付利息的，人民法院应予支持。借贷双方约定的利率超过年利率36%，超过部分的利息约定无效。借款人请求出借人返还已支付的超过年利率36%部分的利息的，人民法院应予支持。
				</p>
			</div>
			<div class="bottom">
				<h3>
					国家政策的保障
				</h3>
				<p>
					2015年9月16日李克强总理主持召开国务院常务会议中强调：要落实小微企业税收优惠和清费政策，加大财政对企业贷款、担保等的支持，发展中小金融机构，降低融资成本，缓解小微企业融资难题。26日，国务院印发《关于加快构建大众创业万众创新支撑平台的指导意见》（以下简称《指导意见》）中强调：规范发展网络借贷。鼓励互联网企业依法合规设立网络借贷平台，为投融资双方提供借贷信息交互、撮合、资信评估等服务。积极运用互联网技术优势构建风险控制体系，缓解信息不对称，防范风险。
				</p>
			</div>
		</div>
		<div class="clear">
		</div>
	</div>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>