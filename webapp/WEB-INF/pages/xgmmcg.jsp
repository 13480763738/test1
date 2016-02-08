<%@page import="com.jiudian.p2p.front.servlets.Xgmm"%>
<%@page import="com.jiudian.p2p.front.servlets.Send"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.servlets.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.Register"%>
<%@page import="com.jiudian.p2p.front.servlets.RegisterVerify"%>
<%@page import="com.jiudian.p2p.front.servlets.CheckNameExists" %>
<%if(jiudianSession!=null&&!jiudianSession.isAuthenticated()){controller.sendRedirect(request, response,configureProvider.format(URLVariable.LOGIN));return;} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "修改密码成功 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	<div id="container">    
    <%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
    <div class="register_box_hf">
    	<div class="header_zc">
        	<div class="header">
                <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="logo_zc"><img src="<%=controller.getStaticPath(request)%>/images/new_images/logo.png"></a>
                <span class="mfzc" style="font-size:36px; color:#5a5a5a;">修改密码</span>
            </div>
        </div>
    	<div class="center" style="position:relative;">
        	<div class="register_hf" style="width:100%; margin-top:50px;">
            	<div class="register_top_hf" style="width:100%; text-align:center; height:80px;margin-bottom:90px;">
                	<p class="xgmrma xgcg">密码修改成功</p>
                </div>
                <div class="register_center_hf" style="margin-left:240px; min-height:200px;">
                	<div class="register_content_hf">
                        <dl style="padding-bottom:5px;">
                        	<dt></dt>
                            <dd><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"  class="submit">返回首页</a></dd>
                        </dl>
                    </div>
                </div>
                <div class="register_bottom_hf"></div>
            </div>
        </div>
    </div>
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
