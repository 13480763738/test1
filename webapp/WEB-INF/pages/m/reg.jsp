<%@page import="com.jiudian.p2p.front.servlets.m.Reg"%>
<%@page import="com.jiudian.p2p.front.servlets.m.CheckNameExists"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Send"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Mterm"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Register"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%if(jiudianSession!=null&&jiudianSession.isAuthenticated()){controller.sendRedirect(request, response,configureProvider.format(URLVariable.WAP_INDEX));return;} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "注册 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
WAP_TITLE_NAME="注册";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
<style>
	.zc_logo{margin-top:6rem;}
	.zclogo{ text-align:center;  vertical-align:middle; }
	.zclogo span{ background:url(<%=controller.getStaticPath(request)%>/wap/images/morelogo.jpg) left center no-repeat; background-size:contain; padding:2.5rem 5rem; display:inline-block;}
	.zc_logo p{ font-size:1.2rem; color:#5a5a5a; text-align:center;}
	.login_box{ margin-top:2rem;}
	.footer_txt{ font-size:1.5rem; color:#5a5a5a; text-align:center; width:100%; float:left; margin:1rem 0;}
</style>
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
	 <%if (!StringHelper.isEmpty(loginNameExists)) {%>
	 <%errorMessage =  loginNameExists;}%>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>
		<form action="<%=controller.getURI(request, Reg.class)%>" data-ajax="false" method="post" onsubmit="return onSubmit()">
		<input type="hidden" name="userSourceStatus" value="<%=from%>">
		<div data-role="content" class="qcontent">
			<div class="zc_logo">
		    	<div class="zclogo"><span></span></div>
		        <p>一家专业从事中小企业融资担保服务的专业担保机构</p>
		    </div>
		  	<div class="login_box">
			  <div class="box_login zc_box">
			        	<div class="login_user"><span>手机号</span>
			        	<input type="text" name="accountName" placeholder="请输入本人手机号" value="" maxlength="18" value="<%StringHelper.filterHTML(out,request.getParameter("accountName"));%>" onblur="nameCheck()" >
			        	</div>
			        	<div class="login_user"><span>登录密码</span><input  name="password" type="password" onblur="passwordCheck()" maxlength="16" placeholder="6~16个字符，区分大小写" ></div>
			            <div class="login_user"><span>确认登录密码</span><input name="newPassword"  type="password" placeholder="确认密码" maxlength="16" onblur="rePasswordCheck()" ></div>
		        		<div class="login_user">
				            	<span>短信验证码</span>
				                <div class="yzmbox">
				                    <div class="yzm">
				                   	 <input type="text" name="verifyCode"  onblur="verifyCodeCheck()" value="" placeholder="验证码 " >
				                    </div>
				                    <div class="hqyzm"><input type="button" value="获取验证码" onclick="sendCode(this)"></div>
				                </div>
				        </div>
			        	<div class="login_user"><span>服务码</span><input name="code" type="text" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>" placeholder="服务码" maxlength="6" onblur="codeCheck()" ></div>
		        </div>
		    </div>
		    <div class="box_login">
		    	<p><label for="iAgree"><input type="checkbox"  id="iAgree" name="iAgree" value="单选" checked="checked" >我同意</label>
		    	<a href="<%=controller.getPagingItemURI(request, Mterm.class, TermType.ZCXY.name())%>" target="_blank">《麒麟通宝注册协议》</a>
		    	</p>
		    	<p class="error_tip" id="error_mesg" style=""><%StringHelper.filterHTML(out, errorMessage);%></p>
		    </div>
		    <div class="center_padding">
		    	<div class="login_btn">
		       	  <input type="submit" value="注册">
		        </div>
		    </div>
		    <div class="footer_txt">投资有风险，投入需谨慎</div>
	    </div>
		</form>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	<script type="text/javascript">
	var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/register.js"></script>
</body>
</html>
