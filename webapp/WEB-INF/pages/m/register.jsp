<%@page import="com.jiudian.p2p.front.servlets.m.CheckNameExists"%>
<%@page import="com.jiudian.p2p.front.servlets.m.SendVice"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Send"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Mterm"%>
<%@page import="com.jiudian.p2p.front.servlets.m.Register"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%@page import="com.jiudian.p2p.front.service.financing.MzbManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Tjvo"%>
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
	 <%
	 MzbManage manage = serviceSession.getService(MzbManage.class);
	 Tjvo tj = manage.getTj();
	 String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
	 <%if (!StringHelper.isEmpty(loginNameExists)) {%>
	 <%errorMessage =  loginNameExists;}%>
	<div id="wrap-all">
		<%@include file="/WEB-INF/include/wap/index/header.jsp"%>

		
		<section>
		<img src="<%=controller.getStaticPath(request) %>/wap/images/zc-banner.png"/>
	</section>
	<section class="register-body" >
		<form action="<%=controller.getURI(request, Register.class)%>" data-ajax="false" method="post" onsubmit="return onSubmit()">
		<input type="hidden" name="userSourceStatus" value="<%=from%>">
			<ul id="registerbody">
				<li>
					<label>*&nbsp用&nbsp;户&nbsp;名:</label>
					  <%if (!StringHelper.isEmpty(loginNameExists)) {%>
						<input name="accountName" placeholder="请输入用户名" type="text" maxlength="18" value="<%StringHelper.filterQuoter(out,request.getParameter("accountName"));%>" onblur="nameCheck()" />
						<p class="red">
							<%StringHelper.filterHTML(out, loginNameExists);%>
						</p>
						<%} else {%>
						<input name="accountName" placeholder="请输入用户名" type="text" class="text" maxlength="18" value="<%StringHelper.filterHTML(out,request.getParameter("accountName"));%>" onblur="nameCheck()" /> 
						<span id="loginNameError"></span> 
						<%}%>
				</li>
				<li>
					<label>*&nbsp密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
					<input name="password"  placeholder="请输入密码" type="password" onblur="passwordCheck()" maxlength="16"/>
						<span id="passwordError"></span> 
				</li>
				<li>
					<label>*&nbsp确&nbsp;&nbsp;&nbsp;&nbsp;认:</label>
					<input name="rePassword" placeholder="请再次输入密码" type="password" maxlength="16" onblur="rePasswordCheck()" /> 
						<span id="rePasswordError"></span> 
				</li>
<!-- 				<li> -->
<!-- 					<label>*&nbsp图&nbsp;形&nbsp;码:</label> -->
<!-- 						<input type="text" placeholder="" name="imgCode" maxlength="6" onblur="imgCodeCheck();"/> -->
<%-- 					<img style="margin-top:20px;margin-left: -65px;" height="60px" width="100px" title="看不清楚?换一张" src="<%=controller.getURI(request, RegisterVerify.class)%>" onclick="this.src='<%=controller.getURI(request, RegisterVerify.class)%>?'+Math.random()" id="_verifyImg"> --%>
<!-- 						<span id="imgCodeError"></span>  -->
<!-- 				</li> -->
				<li>
					<label>*&nbsp手&nbsp;&nbsp;&nbsp;&nbsp;机:</label>
					<input type="text" name="phone" placeholder="请填写手机号码" onblur="phoneCheck()">
	                    <span id="phoneError"></span> 
				</li>
				<li>
					<label>*&nbsp验&nbsp;证&nbsp;码:</label>
						 <input type="text" name="verifyCode" placeholder="请填写验证码" onblur="verifyCodeCheck()" maxlength="6">
                          <span id="verifyCodeError"><%StringHelper.filterHTML(out, errorMessage);%></span> 
							
				</li>
				<li class="yanzhen">
					<input style="padding:0px;" id="_yy" class="" type="button" onclick="sendCode(this)" value="语音验证"/>
                	<input style="padding:0px;" id="_dx" class="" type="button" onclick="sendCode_1(this)" value="短信验证"/>
				</li>
				<li class="yaoqing">
					<label>*&nbsp好友邀请:</label>
					<input type="radio" name="friend" value = "否" checked/><i>否</i>
					<input type="radio" name="friend" value = "是"/><i>是</i>
				</li>
				<li class="hyyz" style="display:none;">
					<input name="code" type="text" placeholder="请输入好友验证码" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>" maxlength="6" onblur="codeCheck()"/>
					<span id="codeError"></span> 
				</li>
				<li class="tk">
					<input type="checkbox" checked="checked" id="iAgree" name="iAgree">已阅读并同意
					<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>">《麒麟通宝注册协议》</a>
					<span id="iAgreeError" style="margin-top:10px"></span> 
				</li>
				<li class="tj">
					<input type="submit" placeholder="立即注册" value="立即注册"/>
				</li>	
			</ul>
		</form>	
	</section>
	<section class="register-footer">
		<ul>
			<li>
				<dl>
					<dt>
						<img src="<%=controller.getStaticPath(request) %>/wap/images/re-tg.png"/>
					</dt>
					<dd>
						<h3>第三方资金托管</h3>
						<p>给您资金银行级别的安全保障</p>
					</dd>
					<div class="clear"></div>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<img src="<%=controller.getStaticPath(request) %>/wap/images/re-jy.png"/>
					</dt>
					<dd>
						<h3>累计交易总额</h3>
						<p>
						<%
    				double ljcje = tj.ljcje.doubleValue();
    	         	if(ljcje>=1000000000){
				    	%>
				      	   <%=Formater.formatAmount(ljcje/100000000)%>亿元
				      	<%
				      	   	}else if(ljcje>=10000 && ljcje <1000000000){
				      	   %>
				      		<%=Formater.formatAmount(ljcje/10000)%>万元
				      	<%
				      			}else{
				      		%>
				      		<%=Formater.formatAmount(tj.ljcje)%>元
				      	<%
		      			}%>
						</p>
					</dd>
					<div class="clear"></div>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<img src="<%=controller.getStaticPath(request) %>/wap/images/re-sy.png"/>
					</dt>
					<dd>
						<h3>已为投资人赚取收益</h3>
						<p>
						<%
        			double fxbyj = tj.fxbyj.doubleValue();
                 	if(fxbyj>=100000000){
        			%>
		      	   <%=Formater.formatAmount(fxbyj/100000000)%>亿元
			      	<%
			      	   	}else if(fxbyj>=10000 && fxbyj <100000000){
			      	   %>
			      		<%=Formater.formatAmount(fxbyj/10000)%>万元
			      	<%
		      			}else{
		      		%>
		      		<%=Formater.formatAmount(tj.fxbyj)%>元
		      		<%
		      			}
		      		%>
						</p>
					</dd>
					<div class="clear"></div>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<img src="<%=controller.getStaticPath(request) %>/wap/images/re-rx.png"/>
					</dt>
					<dd>
						<h3>全国免费客服热线</h3>
						<p>400-8098-122</p>
					</dd>
					<div class="clear"></div>
				</dl>
			</li>
		</ul>
	</section>
		</form>
		
	<%@include file="/WEB-INF/include/wap/script.jsp"%>
		<script>
		$(function(){
			$(".yaoqing").find("input").eq(1).click(function(){
				
				if($(this).attr("checked")){
				
					$(".hyyz").show();
				
				}

			})
			$(".yaoqing").find("input").eq(0).click(function(){
			
				if($(this).attr("checked")){
				
					$(".hyyz").hide();
				}
			})
			var code = $(".hyyz").find("input").eq(0).val();
			if(code!=""){
				$(".yaoqing").find("input").eq(1).attr("checked","checked");
				$(".hyyz").show();
			}else{
				$(".yaoqing").find("input").eq(0).attr("checked","checked");
			}
		});
		var _cUrl = '<%=controller.getURI(request, SendVice.class)%>';
		var _cUrl_1 = '<%=controller.getURI(request, Send.class)%>';
			
		
		</script>
		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/wap/js/register.js"></script>
</body>
</html>
