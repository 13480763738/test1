<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserBlack"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserBlacklistManage"%>
<html>
<head> 
<%
String _TITLE_ = "黑名单 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	UserBlacklistManage service = serviceSession.getService(UserBlacklistManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="sub-nav" sup="Project">
 <div class="sub-nav-inner">
 <div class="container">
    	     <!--start: Navigation -->
         <div class="navbar navbar-inverse">
         <div class="navbar-inner">
            <ul class="nav">
             	<li class="nav_title">我要理财 &gt;</li>
            	<li ><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.yxlc.Index.class)%>">理财体验 &gt;</a></li>
      			<li ><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class)%>">债权转让 &gt;</a></li>
                <li ><a href="javascript:void(0)" class="selected" >还款黑名单</a></li>
             </ul>
        </div>
        </div>
</div>
</div></div>

<div class="center_box">
	<div class="center">
    	<!--黑名单-->
        <div class="hmd_box">
        	<div class="hmd_title"><img src="<%=controller.getStaticPath(request)%>/images/new_images/hmd_tit.png" alt="<%=_ALT%>"></div>
            <div class="hmd">
            	<div class="hmd_top"></div>
            	<div class="hmd_center">
            	<div class="hmd_content">
                	<table width="100%" align="center" cellspacing="0">
                    	<tbody>
                        	<tr class="big_tit">
                            	<td width="25%">头像/用户名</td>
                                <td width="25%"><span>个人资料</span></td>
                                <td width="25%"><span>联系方式</span></td>
                                <td class="end"><span>信用档案</span></td>
                            </tr>
                            
                             <%
				              	PagingResult<UserBlack> result = service.search(new Paging() {public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 3;}});
				                UserBlack[] userBlacklist=result.getItems();if(userBlacklist!=null){for (UserBlack userBlack : userBlacklist) {if (userBlack == null) {continue;}
				                UserInfoManage infoManage = serviceSession.getService(UserInfoManage.class);
				                UserInfo uiInfo =  infoManage.getAgeSex(userBlack.card);
				              %>
                            
                            <tr class="all_bjs">
                            	<td>
                                	<div class="member">
                                        <a href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.UserInfo.class,userBlack.userID)%>" class="name"><img src="<%if(StringHelper.isEmpty(userBlack.imgPath)){%><%=controller.getStaticPath(request)%>/images/tx.jpg<%}else{%><%=fileStore.getURL(userBlack.imgPath)%><%}%>" alt="<%=_ALT%>"><img style="position:absolute; top:0px; left:0px; width:56px; height:56px; padding:0px;" src="<%=controller.getStaticPath(request)%>/images/new_images/images_bg.png" alt="<%=_ALT%>"></a>
                                        <p><a href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.UserInfo.class,userBlack.userID)%>"><%StringHelper.filterHTML(out, userBlack.loginName); %></a></p>
                                    </div>
                                </td>
                                <td valign="top">
                                	<div class="margin20">
                                    	<p>真实姓名：<%StringHelper.filterHTML(out, userBlack.realName); %></p>
                                        <p>性别：<%=uiInfo.sex == 1?"男":"女" %></p>
                                        <p><span>身份证号：</span><em><%StringHelper.filterHTML(out, userBlack.card); %></em></p>
                                        <p>所在地区：<%StringHelper.filterHTML(out, userBlack.city); %></p>
                                    </div>
                                </td>
                                <td valign="top">
                                	<div class="margin20">
                                    	<p>手机号码：<%StringHelper.filterHTML(out, userBlack.telphone); %></p>
                                        <p><span>电子邮箱：</span><em><%StringHelper.filterHTML(out, userBlack.email); %></em></p>
                                        <p class="weibo"><span>微博：</span><em></em></p>
                                    </div>
                                </td>
                                <td valign="top">
                                	<div class="margin20">
                                    	<p><span>逾期收款（次）：</span><em class="price"><%=userBlack.yqCount %></em></p>
                                        <p><span>严重逾期（笔）：</span><em class="price"><%=userBlack.yzyqCount %></em></p>
                                        <p><span>最长逾期（天）：</span><em class="price"><%=userBlack.zcyzyqDay %></em></p>
                                        <p><span>待还金额（元）：</span><em class="price"><%=userBlack.dhMoney %></em></p>
                                    </div>
                                </td>
                            </tr>
                            <%}} %>
                            
                        </tbody>
                    </table>
                </div>
                </div>
                <div class="hmd_bottom"></div>
            </div>
            <div class="clear"></div>
           
            <!--页码-->
            <%
            	AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, com.jiudian.p2p.front.servlets.p2plicai.qyd.Index.class));
            %>
        </div>
        
    </div>
</div>
 <div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>