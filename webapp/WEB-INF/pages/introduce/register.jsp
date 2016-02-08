<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.servlets.introduce.Register"%>
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
<LINK REL="SHORTCUT ICON" HREF="http://<%configureProvider.format(out, SystemVariable.SITE_DOMAIN);%>/favicon.ico">
<%
	String _TITLE_ = "注册 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
	String _KEYWORDS_ = "";
	String _DESCRIPTION_ = "";
	
%>
<title><%=_TITLE_ %></title>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/seo.style.css" />
<%@include file="/WEB-INF/include/meta.jsp"%>
</head>
<body>

<%!public static void addCookie(HttpServletResponse response,String name,String value,int maxAge){
	    Cookie cookie = new Cookie(name,value);
	    cookie.setPath("/");
	    if(maxAge>0)  cookie.setMaxAge(maxAge);
	    response.addCookie(cookie);
	}%>
	
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
		String from = request.getParameter("from");	
		if(!StringHelper.isEmpty(from)){
			addCookie(response, "from", from, 30*24*3600);
		}else{
			from = getCookieByName(request, "from");
		}
		
	%>

<div id="container">
	<div class="header_box">
        <div class="header">
        	<a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="logo"><img src="<%=controller.getStaticPath(request)%>/images/r_images/logo.png"></a>
            <p><span class="tel">热线</span>400-880-5306</p>
        </div>
    </div>
        <%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
        <form action="<%=controller.getURI(request, Register.class)%>" method="post" onsubmit="return onSubmit()">
         <input type="hidden" name="userSourceStatus" value="<%=from%>">
        <div class="banner_box">
        	<div class="banner">
                <div id="a" class="register_box">
                	<div class="register_top"></div>
                    <div class="register_center">
                    	<div class="tit"><span>快速注册</span></div>
                        <dl>
                        	<dt><span>*</span>手机号码</dt>
                            <dd>
                            	<div class="inputbox">
                            	<input type="text" name="phone" class="input" onblur="phoneCheck()"></div>
                                <p class="red"></p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>登录密码</dt>
                            <dd>
                            	<div class="inputbox">
                            	<input name="password" maxlength="16"  onblur="passwordCheck()"  type="password" class="input"></div>
                                <p class="red"></p>
                            </dd>
                        </dl>
                        <dl>
                        	<dt><span>*</span>验证码</dt>
                            <dd>
                            	<div class="inputbox01">
                            	<input type="text" name="verifyCode" onblur="verifyCodeCheck()" class="input01">
                            	<input class="get_code_hf" type="button" onclick="sendCode(this)" value="获取验证码">
                            	</div>
                                <p class="red"><%StringHelper.filterHTML(out, errorMessage);%></p>
                            </dd>
                        </dl>
                        <dl  style="height:30px; position:absolute; left:0px; bottom:60px;">
                        	<dt></dt>
                            <dd class="xieyi_hf">
                            	<input type="checkbox" checked="checked" class="m_cb selected" id="iAgree" name="iAgree"><label for="iAgree">我已阅读并同意</label>
                            	<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>" >《麒麟通宝注册协议》</a>
                                <div class="xieyi_bg selected"></div>
                                <p class="gray9"></p>
                            </dd>
                        </dl>
                        <dl style="position:absolute; left:0px; bottom:8px;">
                        	<dt></dt>
                            <dd>
                            	<input type="submit" class="input_btn" value="注&nbsp;&nbsp;&nbsp;册">
                            </dd>
                        </dl>
                    </div>
                    <div class="register_bottom"></div>
                </div>
            </div>
        </div>
        </form>
        <div class="center_box" style="background:#f1f3f5;">
        	<div class="center">
            	<div class="gdd">
                    <dl>
                        <dt>超<span>高</span>收益</dt>
                        <dd>
                        	<span>18%</span>年化收益率<br/>近<span>50<em>倍</em></span>银行活期利息
                        </dd>
                    </dl>
                    <dl style="margin-left:140px;">
                    	<dt>超<span>低</span>风险</dt>
                        <dd>
                        	融资性公司担保<br/><span>5重</span>风险防控体系<br/>全额本息保障
                        </dd>
                    </dl>
                    <dl style="margin-left:140px;">
                    	<dt>超<span>低</span>门槛</dt>
                        <dd><span>100<em>元</em></span>投资<br/>周期灵活<br/>债权转让</dd>
                    </dl>
                    <dl style="width:150px; float:right;">
                    	<dt>理财<span style="font-family:Verdana">O</span>费用</dt>
                        <dd><span><em>免</em></span>充值费<br/><span><em>免</em></span>平台管理费<br/><span><em>免</em></span>担保服务费</dd>
                    </dl>
                </div>
            </div>
        </div>
        <!--理财收益大-->
        <div class="center_box">
        	<div class="center">
            	<img src="<%=controller.getStaticPath(request)%>/images/r_images/img01.jpg" style="padding:40px 0;">
            </div>
        </div>
        
        <div class="center_box">
        	<div class="center">
            	<!--新手指引-->
                <div class="xszy"><img src="<%=controller.getStaticPath(request)%>/images/r_images/img02.jpg"></div>
                <!--项目-->
                 <%
                 		InvestManage investManage = serviceSession.getService(InvestManage.class);
                    	PagingResult<CreditInfo> crePagingResult = investManage.search(null, new Paging() {
                    		public int getCurrentPage() {
                    			return 1;
                    		}
                    		public int getSize() {
                    			return 1;
                    		}});
                 		CreditInfo[] credits = crePagingResult.getItems();if (credits != null && credits.length>0) {
               			int id = credits[0].id;
               			CreditInfo creditInfo = investManage.get(id);
                 %>
                <div class="xm_box">
                	<div class="xm_tit">推荐项目
                	<a class="title" title="<%StringHelper.filterHTML(out, creditInfo.title);%>" href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,creditInfo.id)%>"><%
                      		StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.title, 10));
                      	%></a></div>
                    <div class="xm_content">
                    	<div class="xm_zt"><span>
                    	<%if(creditInfo.status==CreditStatus.TBZ){ %>
                    	融资进行中...
						<%}else if(creditInfo.status==CreditStatus.YMB){ %>已满标
						<%}else if(creditInfo.status==CreditStatus.YFK){ %>还款中
						<%}%></span></div>
                        <div class="xm_left">
                        	<ul>
                            	<li>保障类型: 100%本息保障</li>
                                <li>期限：<%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><%=creditInfo.term%>个月
					       			   <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><%=creditInfo.term%> 天<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>满额即还<%}%>
                                </li>
                                <li>年化收益：<%=Formater.formatRate(creditInfo.rate,false)%>%　</li>
                                <li><em>还款方式：</em><span><%=creditInfo.repaymentType.getName()%></span></li>
                                <li>标的总额：<%=Formater.formatAmount(creditInfo.amount)%>元</li>
                                <li>剩余金额：<%=Formater.formatAmount(creditInfo.remainAmount)%>元</li>
                            </ul>
                        </div>
                        <div class="xm_right">
                        	<div class="xm_txt">
                            	<div class="nhsy"><span><%=Formater.formatRate(creditInfo.rate,false)%></span><em>%</em><br/>年化收益</div>
                                <div class="qx"><%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><span><%=creditInfo.term%></span><em>个月</em>
					       			   <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><span><%=creditInfo.term%></span><em>天</em>
					       			   <%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%><em>满额即还</em><%}%><br/>期限</div>
                                <div class="syje"><span><%=Formater.formatAmount(creditInfo.remainAmount)%></span><em>元</em><br/>剩余金额</div>
                            </div>
                            <div class="xm_details">
                            	<div class="xm_ze"><span>总额：<%=Formater.formatAmount(creditInfo.amount)%><em>元</em></span></div>
                            	<dl>
                                	<dt>投标进度</dt>
                                    <dd>
                                    	<div class="bfb_box">
                                        	<div class="bfb" style="width: <%=creditInfo.progress%>%;"></div>
                                        </div>
                                    </dd>
                                </dl>
                                <div class="xm_bfb"><span style="left:<%=creditInfo.progress%>%;"> <%=creditInfo.progress%>%</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <%} %>
 				<div class="zhuce_btn"><a href="#a">注&nbsp;&nbsp;册</a></div>
            </div>
        </div>
    <div class="footer_box">
        <div class="footer">
        	<div class="footer_logo"><a href="javascript:void(0)"><img src="<%=controller.getStaticPath(request)%>/images/r_images/logo1.png"></a></div>
            <div class="ewm">
            	<span><img src="<%=controller.getStaticPath(request)%>/images/r_images/img03.jpg"></span>
                <span><img src="<%=controller.getStaticPath(request)%>/images/r_images/img04.jpg"></span>
            </div>
            <div class="footer_info">
            	<p>版权所有：麒麟通宝（jiudian.com）版权所有<br/>粤ICP备14060638号<br/>地址：广东省深圳市南山区高新科技园高新中三道7号劲嘉科技大厦21楼</p>
                <div class="footer_info_right">
                    <a class="ui_term ui_term04" target="_blank" href="https://cert.ebs.gov.cn/240034c5-9153-469f-bad7-ac2748363220"></a>
                    <a rel="nofollow" target="_blank" class="ui_term ui_term01" href="http://pinggu.zx110.org/review_url_jiudian.com"></a>
                    <a target="_blank" href="http://webscan.360.cn/index/checkwebsite/url/jiudian.com"><img width="88px" height="33px" border="0" src="http://img.webscan.360.cn/status/pai/hash/08eeb11a559c16846d8229503d2c76cf"></a>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
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
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/_register.js"></script>
<div style="display:none;">
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F43aa9ace2c792b66a11a1fa1cc253f7f' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fee9e5141f7eb536d5b99b9e32d83a01b' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript"> 
var _mvq = _mvq || []; 
_mvq.push(['$setAccount', 'm-29874-0']); 
_mvq.push(['$logConversion']); 
(function() { 
var mvl = document.createElement('script'); 
mvl.type = 'text/javascript'; mvl.async = true; 
mvl.src = ('https:' == document.location.protocol ? 'https://static-ssl.mediav.com/mvl.js' : 'http://static.mediav.com/mvl.js'); 
var s = document.getElementsByTagName('script')[0]; 
s.parentNode.insertBefore(mvl, s); 
})();	
</script>
</div>
</body>
</html>