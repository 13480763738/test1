<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.Grjk"%>
<%@page import="com.jiudian.p2p.variables.defines.SystemVariable"%>
<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.common.enums.IsPass"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.Aqbz"%>
<%@page import="java.util.UUID"%>
<%@page import="com.jiudian.util.filter.HTMLFilter"%>
<%@page import="com.jiudian.p2p.front.servlets.Logout"%>
<%@page import="com.jiudian.p2p.front.service.common.UserManage"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qltb/jquery-1.8.3.min.js"></script>
<style>.i-t-wx { background-position: -29px 0px;}.wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}</style>
<%
if (jiudianSession == null || jiudianSession.isAuthenticated()) {
	if(IsPass.S.equals(serviceSession.getService(UserManage.class).sfxgmm())){
		controller.redirectLogin(request, response, configureProvider.format(URLVariable.UPDATE_PASSWORD));
		return;
	}
}
%>
<header>
		<!--头部区-->
	<div class="new-top" id="top">
		<div class="new-center">
			<div class="top-left fl">
				<span class="pr30">咨询热线&nbsp;:&nbsp;<%configureProvider.format(out, SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></span>
				<span>服务时间&nbsp;:&nbsp;<%configureProvider.format(out, SystemVariable.SITE_WORK_TIME);%></span>
				<span class="wx allbtn"></span>
				<span class="wb allbtn"></span>
				<div class="clear"></div>
				<div class="wxdw alldw">
					<span class="jiao"></span>
					<p class="heise">扫码关注"麒麟通宝微信"</p>
					<img src="<%=controller.getStaticPath(request)%>/images/wx.png" style="margin-left: 35px;"/>
				</div>

				<div class="wbdw alldw">
					<span class="jiao"></span>
					<p class="heise">点击关注"麒麟通宝"微博</p>
						<a href="<%configureProvider.format(out,SystemVariable.SITE_SINA_WEIBO); %>" class="lanses" style="margin-left: 35px;">@麒麟通宝</a>
				</div>
			</div>
			<div class="top-right fr">
				<a href="<%configureProvider.format(out,URLVariable.GUIDE);%>" class="white pr15">新手指引</a>
				
				<%if (jiudianSession == null || !jiudianSession.isAuthenticated()) {%>
				<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="white pl15 pr15 denglu">登录</a>
				<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="new-zhuce pl15">免费注册</a>
				 <%}else{ %>			
				<a href="<%configureProvider.format(out,URLVariable.USER_INDEX);%>" class="new-zhuce pl15 pr15 denglu">
					<%StringHelper.truncation(new HTMLFilter(out), serviceSession.getService(UserManage.class).getAccountName(),7);%>
				</a>
				<a href="<%configureProvider.format(out,URLVariable.USER_LETTER);%>" class="white pl15 pr15">
					消息<%int unReadLetterCount = serviceSession.getService(UserManage.class).getUnReadLetter();if(unReadLetterCount > 0){ %>
					<b class="orange" style="font-weight:normal; ">(<%=unReadLetterCount %>)</b><%} %>
				</a>
				<a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="white pl15 pr15 denglu">充值</a>
				<a href="<%configureProvider.format(out,URLVariable.USER_WITHDRAW);%>" class="white pl15 pr15">提现</a>
				<a href="<%=controller.getURI(request, Logout.class)%>" class="white pl15 pr15 denglu" style="border-right:none;">安全退出</a>
					<%} %>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<%String linkurl = request.getRequestURL().toString();%>
	<!--顶部导航区-->
		<div class="white-bg">
			<div class="new-center nav-top">
				<div class="nav-left fl">
					<h1>
						<a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=controller.getStaticPath(request)%>/images/logo.png" alt="麒麟通宝p2p" width="437" title="麒麟通宝p2p" /></a>
					</h1>
				</div>
				<ul class="fl nav-right">
					<li <%if(linkurl.indexOf("pages/index")>0){ %>class="active" <%} %>><a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="first">首页</a></li>
					<li><a href="<%configureProvider.format(out,URLVariable.QLTB_WYTZ);%>" class="first">我要投资</a>
					<div class="tz-dw three">
					
                              <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_QFD);%>">旗房贷</a>
							  <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_QQD);%>">旗企贷</a>
                              <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_QYD);%>">旗意贷</a>
                              <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_QSD);%>">旗速贷</a>
                              <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_QCD);%>">旗车贷</a>
                              <a class="" href="<%configureProvider.format(out,URLVariable.QLTB_ZQZR);%>">债权转让</a>
<!--<a class="" href="<%configureProvider.format(out,URLVariable.QLTB_LCTY);%>">理财体验</a> -->
							
						</div>
					</li>
					<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>" class="first">我要借款</a>
					<div class="jk-dw three">
							<a href="<%configureProvider.format(out,URLVariable.JKYX_GR);%>">个人借款</a>
							<a href="<%configureProvider.format(out,URLVariable.JKYX_QY);%>">企业借款</a>
						</div>
					</li>
					<li <%if(linkurl.indexOf("aqbz")>0){ %>class="active" <%} %>><a href="<%configureProvider.format(out,URLVariable.GYWM_AQBZ);%>" class="first">安全保障</a></li>
					<li <%if(linkurl.indexOf("gywm")>0 || linkurl.indexOf("zxdt")>0){ %> class="active"<%} %>><a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>" class="first">关于我们</a></li>
					<div class="clear"></div>
				</ul>
				<div class="clear"></div>
			</div>
				<div class="clear"></div>
		</div>
</header>
<script type="text/javascript">
$(".nav-right").find("li").css('float','left');
$(".nav-right").find("li").eq(1).css('position','relative');
$(".nav-right").find("li").eq(2).css('position','relative');
$(".nav-right").find("li").eq(1).find(".first").css('position','relative');
$(".nav-right").find("li").eq(2).find(".first").css('position','relative');
$(".nav-right").find("li:first").css("margin","0");
$(".nav-right").find("li").eq(1).css("margin","0");
$(".nav-right").find("li").eq(3).css("margin-left","15px");
$(".nav-right").find("li").eq(1).find(".first").css("margin","0 20px 0 8px");
$(".nav-right").find("li").eq(2).find(".first").css("margin","0 20px 0 8px");
$(".nav-right").find("li").eq(1).hover(function(){
	$(".nav-right").find(".tz-dw").show();
	$(".nav-right").find("li").eq(1).find(".first").css("color","#1d4d9f");	
},function(){
$(".nav-right").find(".tz-dw").hide();
$(".nav-right").find("li").eq(1).find(".first").css("color","#fff");
});

$(".nav-right").find("li").eq(2).hover(function(){
	$(".nav-right").find(".jk-dw").show();
	$(".nav-right").find("li").eq(2).find(".first").css("color","#1d4d9f");
},function(){
$(".nav-right").find(".jk-dw").hide();
$(".nav-right").find("li").eq(2).find(".first").css("color","#fff");
});

function navhover(e){
$(".nav-right").find("li").eq(e).find(".first").hover(
	function(){	
		$(".nav-right").find("li").eq(e).addClass("on");
	},function(){
		$(".nav-right").find("li").eq(e).removeClass("on");
	}
)
}
navhover('0');   //鼠标滑上效果
navhover('3');   //鼠标滑上效果
navhover('4');   //鼠标滑上效果

</script>
