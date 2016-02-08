<%@page import="com.jiudian.p2p.front.servlets.SendVice"%>
<%@page import="com.jiudian.p2p.front.servlets.Send"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.Register"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%@page import="com.jiudian.p2p.front.servlets.CheckNameExists" %>
<%if(jiudianSession!=null&&jiudianSession.isAuthenticated()){controller.sendRedirect(request, response,configureProvider.format(URLVariable.USER_INDEX));return;} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "注册 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
</head>
<body>
	<%!public static String getCookieByName(HttpServletRequest request,String name){
	    Map<String,Cookie> cookieMap = ReadCookieMap(request);
	    if(cookieMap.containsKey(name)){
	        Cookie cookie = (Cookie)cookieMap.get(name);
	        return cookie.getValue();
	    }else{
	        return null;
	    }   
	}%>
	
	<%!private static Map<String,Cookie> ReadCookieMap(HttpServletRequest request){  
	    Map<String,Cookie> cookieMap = new HashMap<String,Cookie>();
	    Cookie[] cookies = request.getCookies();
	    if(null!=cookies){
	        for(Cookie cookie : cookies){
	            cookieMap.put(cookie.getName(), cookie);
	        }
	    }
	    return cookieMap;
	}%>
	
	<%
		String loginNameExists = ObjectHelper.convert(request.getAttribute("loginNameExists"), String.class);
		String mobileExists = ObjectHelper.convert(request.getAttribute("mobileExists"), String.class);
		String mobile = request.getParameter("mobile");
		String type=request.getParameter("type");
		if(StringHelper.isEmpty(type)){type=UserType.LC.name();}
	%>
	
	
	<%!public static void addCookie(HttpServletResponse response,String name,String value,int maxAge){
	    Cookie cookie = new Cookie(name,value);
	    cookie.setPath("/");
	    if(maxAge>0)  cookie.setMaxAge(maxAge);
	    response.addCookie(cookie);
	}%>
	<%
		String from = request.getParameter("from");	
		if(!StringHelper.isEmpty(from)){
			addCookie(response, "from", from, 30*24*3600);
		}else{
			from = getCookieByName(request, "from");
		}
	%>
	<%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
<form action="<%=controller.getURI(request, Register.class)%>" method="post" onsubmit="return onSubmit()">
<input type="hidden" name="userSourceStatus" value="<%=from%>">	
<div class="top min-width" style="height:110px; padding-top:10px;">
     <div class="container">
          <div class="logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=controller.getStaticPath(request)%>/images/logo.png"/></a></div>
          <div class="menu" style="float:right;">
               <span class="mfzc">注册</span>
          </div>
     </div>
</div>
<div class="center">
	<div class="register_hf">
		<div style="right:30px; top:85px;" class="register_img"><img src="<%=controller.getStaticPath(request)%>/images/register_bg_moren.jpg"></div>
		<div class="register_center_hf">
			<div class="register_content_hf">
				<dl>
					<dt><span>*</span>用户名&nbsp;</dt>
					<dd>
	                    <%if (!StringHelper.isEmpty(loginNameExists)) {%>
						<input name="accountName" type="text" maxlength="18" value="<%StringHelper.filterQuoter(out,request.getParameter("accountName"));%>" onblur="nameCheck()" />
						<p class="red">
							<%StringHelper.filterHTML(out, loginNameExists);%>
						</p>
						<%} else {%>
						<input name="accountName" type="text" class="text" maxlength="18" value="<%StringHelper.filterHTML(out,request.getParameter("accountName"));%>" onblur="nameCheck()" /> 
						<span style="color:#999; font-size:12px; line-height:30px;">6-18个字符，以字母开头</span> 
						<p id="loginNameError" class="" style="display:block;"></p>
						<%}%>
					</dd>
				</dl>
				<dl>
					<dt><span>*</span>登录密码&nbsp;</dt>
					<dd>
						<input name="password" type="password" class="text text3" onblur="passwordCheck()" maxlength="16"/>
						<span style="color:#999; font-size:12px; line-height:30px;">6~16个字符，区分大小写</span> 
						<p id="passwordSuccess" class="red" style="display:block;"></p>
					</dd>
				</dl>
				<dl>
					<dt><span>*</span>确定密码&nbsp;</dt>
					<dd>
						<input name="newPassword" type="password" maxlength="16" class="text text3" onblur="rePasswordCheck()" /> 
						<span style="color:#999; font-size:12px; line-height:30px;">请再次输入密码</span> 
						<p id="newPasswordSuccess" class="" style="display:block;"></p>
					</dd>
				</dl>
				<dl>
					<dt><span>*</span>图像码&nbsp;</dt>
					<dd>
						<input type="text" name="code" >
	                     <img  id="_verifyImg" src="<%=controller.getURI(request, RegisterVerify.class)%>" title="看不清楚?换一张" width="104" height="40" style="margin-left:8px; padding-left:0px;cursor: pointer;" onclick="this.src='<%=controller.getURI(request, RegisterVerify.class)%>?'+Math.random()" />
						
					</dd>
				</dl>
				<dl>
					<dt><span>*</span>手机号码&nbsp;</dt>
					<dd>
						<input type="text" name="phone" onblur="phoneCheck()">
	                    <span style="color:#999; font-size:12px; line-height:30px;">若非本人手机号，可能导致账户被锁定！</span> 
						<p id="phone" class="" style="display:block;"></p>
					</dd>
				</dl>
				 <dl>
                        	<dt><span>*</span>验证码&nbsp;</dt>
                            <dd>
                            <input type="text" name="verifyCode" onblur="verifyCodeCheck()"  maxlength="6">
                            <p class="red" id="verifyError" style="display:block;"></p>
                            </dd>
                        </dl>
				<dl>
                        	<dt></dt>
                            <dd>
                            	<input style=" width: 101px; height:34px; color:#fff; border:none;" class="yuyinbtn register_yzm" type="button" id="_yy" onclick="sendCode(this)" value="语音验证码"/>
                            	 <span id="_huo" class="huo">或</span> 
                            	<input style="width: 101px; height:34px; color:#fff; border:none;" id="_dx" class="register_yzm" onclick="sendCode_1(this)" type="button" value="短信验证码">
                            	 <p class="red" style="display:block;"><%StringHelper.filterHTML(out, errorMessage);%></p>
                                <div class="yuyin" style="left:-20px;display:none;">请注意接听语音电话</div>
                            </dd>
                        </dl>
				<dl style="margin-top:30px;">
					<dt>服务码&nbsp;</dt>
					<dd>
						<input name="code" type="text" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>" maxlength="6" onblur="codeCheck()"/>
                        <span style="color:#999; font-size:12px; line-height:30px;">请输入推荐人邀请码（如无可不填）</span> 
						<p class="" id="codeSuccess" style="display:block;"></p>
					</dd>
				</dl>
				<dl style="height:30px; padding:15px 0;">
					<dt></dt>
					<dd class="xieyi_hf" style="margin:0px;">
						<input type="checkbox" checked="checked" id="iAgree" name="iAgree"><label for="iAgree" style=" font-size:12px; float:left;">我已阅读并同意</label>
						<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>" class="blue">《麒麟通宝注册协议》</a>
						<div class="xieyi_bg selected"></div>           
					</dd>
				</dl>
				<dl style="padding-bottom:5px;">
					<dt></dt>
					<dd><input value="注&nbsp;&nbsp;&nbsp;册" class="submit" type="submit" style="border:none;"></dd>
				</dl>
				<h3><span></span><p>已有账号？<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">立即登录</a></p></h3>
			</div>
		</div>
	</div>
</div>
</form>
<div class="clear"></div>  
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script1.jsp"%>
	<script type="text/javascript">
	var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
	var _cUrl = '<%=controller.getURI(request, SendVice.class)%>';
	var _cUrl_1 = '<%=controller.getURI(request, Send.class)%>';
	var imgUrl = '<%=controller.getURI(request, RegisterVerify.class)%>';
	$(function(){
		$(".xieyi_bg").click(function(){
			$(this).toggleClass("selected")
			var i=$(this).attr("class");
			if(i.indexOf("selected")>=0){
				$(this).parent().find("input").attr("checked",true);
				}else{
					$(this).parent().find("input").removeAttr("checked");
					}
			});
		
			$(".yuyinbtn").hover(function(){
				$(".yuyin").stop().fadeIn(300);
			},function(){
				$(".yuyin").stop().fadeOut(300);
			});
		});
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/register.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>js/enplace.js"></script>
</body>
</html>
