<%@page import="com.jiudian.p2p.front.servlets.introduce.Reg"%>
<%@page import="com.jiudian.p2p.front.servlets.Send"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
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
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body style="background:#f1f3f5;">
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
	
	<div id="container">
	
    
    <%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
    
	<form action="<%=controller.getURI(request, Reg.class)%>" method="post" onsubmit="return onSubmit()">
	<input type="hidden" name="userSourceStatus" value="<%=from%>">
    <div class="register_box_hf">
    	<div class="header_zc">
        	<div class="header">
                <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="logo_zc"><img src="<%=controller.getStaticPath(request)%>/images/new_images/logo_db.png"></a>
                <span class="logo_txt"></span>
                <span class="mfzc">注册</span>
            </div>
        </div>
    	<div class="center" style="position:relative;">
        	<div class="register_hf">
        		<div class="register_img" style="right:0px;top:55px;"><img src="<%=controller.getStaticPath(request)%>/images/new_images/register_bg_yqs.png"></div>
            	<div class="register_top_hf"></div>
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
								<span id="loginSuccess"></span>
								<p class="gray9" id="loginNameError">6-18个字符，可使用字母、数字、下划线，需以字母开头</p>
								<%}%>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>登录密码&nbsp;</dt>
                            <dd>
                            	<input name="password" type="password" class="text text3" onblur="passwordCheck()" maxlength="16"/> <span id="passwordSuccess">
                                <p class="">6~16个字符，区分大小写 </p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>确定密码&nbsp;</dt>
                            <dd>
                            	<input name="newPassword" type="password" maxlength="16" class="text text3" onblur="rePasswordCheck()" /> <span id="newPasswordSuccess"></span>
                                <p class="gray9">请再次输入密码</p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>手机号码&nbsp;</dt>
                            <dd>
                            	<input type="text" name="phone" onblur="phoneCheck()">
                                <p class="gray9">若非本人手机号，可能导致账户被锁定！</p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>验证码&nbsp;</dt>
                            <dd>
                            	<input type="text" name="verifyCode" onblur="verifyCodeCheck()" class="shortinput">
                            	<input class="get_code_hf" type="button" onclick="sendCode(this)" value="免费获取验证码">
                                <p class="red"><%StringHelper.filterHTML(out, errorMessage);%></p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt>服务码&nbsp;</dt>
                            <dd>
                            <input name="code" type="text" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>" maxlength="6" onblur="codeCheck()"/>
                                <p class="gray9">请输入推荐人服务码<span>(如无可不填)</span></p>
                            </dd>
                        </dl>
                        <dl style="height:30px; padding:20px 0;">
                        	<dt></dt>
                            <dd class="xieyi_hf">
                            	<input type="checkbox" checked="checked" class="m_cb selected" id="iAgree" name="iAgree"><label for="iAgree">我已阅读并同意</label>
                            	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>" >《麒麟通宝注册协议》</a>
                                <div class="xieyi_bg selected"></div>           
                            </dd>
                        </dl>
                        <dl style="padding-bottom:5px;">
                        	<dt></dt>
                            <dd><input type="submit" value="注&nbsp;&nbsp;&nbsp;册" class="submit"></dd>
                        </dl>
                        <h3><span></span><p>已有账号？<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">立即登录</a></p></h3>
                        <h3 class="h3_txt"></h3>
                    </div>
                </div>
                <div class="register_bottom_hf"></div>
            </div>
        </div>
    </div>
    </form>
	<div class="register_footerbox_hf"><!--2015.01.14-->
    	<div class="register_footer_hf">
        	<div class="footer_infoleft">
                <p>&copy; 2014 麒麟通宝 All rights reserved<br>深圳前海齐融金融服务有限公司 | 备案号：粤ICP备14060638号</p>
                <div>
                <div class="footer_inforight">
                    <a class="ui_term ui_term03" target="_blank" rel=""nofollow"" href="http://psc.sgsgroup.com.hk/QRCodeInternet/cn/Supplier/Result.aspx?id=2014091000001"></a>
                    <a href="http://www.itrust.org.cn/yz/pjwx.asp?wm=2311696076" class="ui_term ui_term02" target="_blank" rel="nofollow"></a>
                    <a href="https://cert.ebs.gov.cn/240034c5-9153-469f-bad7-ac2748363220" target="_blank" rel=""nofollow"" class="ui_term ui_term04"></a>
                    <a class="ui_term" style="background:none;" rel=""nofollow"" href="http://webscan.360.cn/index/checkwebsite/url/jiudian.com" target="_blank"><img width="88px" height="33px" border="0" src="http://img.webscan.360.cn/status/pai/hash/08eeb11a559c16846d8229503d2c76cf"></a>
                </div>
                </div>
            </div>
           <div class="footer_inforight">
           		<p>客服电话<br><span>400-880-5306</span><br>服务时间9:00-21:00</p>
           </div>
            
        </div>
    </div>
 </div>
	<%@include file="/WEB-INF/include/script1.jsp"%>
	<script type="text/javascript">
	<!--//
		var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
	//-->
	var _cUrl = '<%=controller.getURI(request, Send.class)%>';
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
		});
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/register.js"></script>
</body>
</html>
