<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.XcyVo"%>
<%@page import="com.jiudian.p2p.front.service.financing.MzbManage"%>
<html>
<head>
<%
	String _TITLE_ = "巡查员制 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp" %>
<style>
.fl100{ width:100%; float:left; margin-top:40px;}
.titx{ width:100%; float:left; text-align:center; font-size:32px; color:#5a5a5a; line-height:32px;}
.titx span.span{ width:30px; height:30px; background:url(<%=controller.getStaticPath(request)%>/images/new_images/xcy_step.png) left center no-repeat; float:left; margin-top:3px; margin-right:10px;}
.titx p{ display:inline-block;}
.titx p{*display:inline;}
.titx span{ float:left;}
.titx em{ color:#176fa7; font-size:32px;}
.titx span.span.step02{ background-position:-32px 0px;}
.titx span.span.step03{ background-position:-76px 0px;}
.titx span.span.step04{ background-position:-120px 0px;}
.content{ width:100%; float:left; font-size:16px; color:#5a5a5a; line-height:48px; margin-top:20px;}
.tequan{ line-height:24px; background:url(<%=controller.getStaticPath(request)%>/images/new_images/xcy_step2.jpg) right top no-repeat; padding:13px 0 23px;}
.content td{ height:50px; vertical-align:middle; text-align:center; font-size:14px; color:#5a5a5a;}
.content .xcy_tit td{ height:42px; padding-bottom:4px; border-bottom:1px solid #bebebe;}
.content tr:hover td{ background:#f2f2f2;}
.content .xcy_tit:hover td{ background:none;}
.titx a{ background:url(<%=controller.getStaticPath(request)%>/images/new_images/mzb_btn05.png) left top no-repeat; color:#fff; width:102px; height:36px; text-align:center; line-height:36px; font-size:16px; float:left; margin-left:32px;}
</style>
</head>

<%@include file="/WEB-INF/include/header.jsp" %>
<div style="width:100%; height:180px; background:#347fc3 url(<%=controller.getStaticPath(request)%>/images/new_images/xcy_banner.jpg) center top no-repeat;"></div>
<div class="center_box">
   <div class="center">
       <div class="fl100">
       	<div class="titx"><p><span class="span step01"></span><span>什么是<em>巡查员</em></span></p></div>
           <div class="content">
           	<p>巡查员是麒麟通宝为理财人提供的对平台资金100%透明监督的特殊职位。</p>
               <p>理财人一旦成为巡查员终生拥有该称号，并由麒麟通宝颁发"麒麟通宝投资资金100%透明巡查员"聘任书。</p>
               <p>巡查员作为麒麟通宝理财人的代表，一方面，监督平台的资金走向，确保项目和资金安全；另一方面，搜集和整理其他投资人的意见，并及时向平台反馈。</p>
           </div>
       </div>
       <div class="fl100">
       	<div class="titx"><p><span class="span step02"></span><span><em>如何成为</em>巡查员</span></p></div>
           <div class="content">
           	<p style="padding-top:15px; padding-bottom:50px;"><img src="<%=controller.getStaticPath(request)%>/images/new_images/xcy_step.jpg"></p>
           </div>
       </div>
       <div class="fl100">
       	<div class="titx"><p><span class="span step03"></span><span>巡查员<em>特权</em></span></p></div>
           <div class="content">
           	<div class="tequan">
               	<p>1、有权了解公司的所有借款标的资金流出和回款信息（为防止外泄，仅限当面<br/><span style="padding-left:26px;">查看）；</span></p>
                   <p>&nbsp;</p>
                   <p>2、有权在麒麟通宝办公室里临时办公（提供茶点），有权和麒麟通宝员工一起上下班，<br/><span style="padding-left:26px;">了解麒麟通宝；</span></p>
                   <p>&nbsp;</p>
                   <p>3、有权了解公司各项相关流程、规章制度，有权对公司的管理提出建议和意见；</p>
                   <p>&nbsp;</p>
                   <p>4、有权把麒麟通宝的每次活动推荐到自己朋友圈里；</p>
                   <p>&nbsp;</p>
                   <p>5、有权整合自身的资源为麒麟通宝平台宣传；</p>
                   <p>&nbsp;</p>
                   <p>6、有权参加每年的巡查员交流会，与麒麟通宝共商发展大计。</p>
               </div>
           </div>
       </div>
       <div class="fl100">
       	<div class="titx" style="margin-top:50px;"><p><span class="span step04"></span><span>巡查员<em>名单</em></span>
       	<a href="http://www.jiudian.com/forum/forum.php?mod=viewthread&tid=445" target="_blank">马上报名</a></p></div>
           <div class="content" style="padding-bottom:100px;">
            	<table cellspacing="0" border="0" width="100%">
                	<tbody>
                    	<tr class="xcy_tit">
                        	<td width="142">序号</td>
                            <td width="191">用户名</td>
                            <td width="160">姓名</td>
                            <td width="226">手机号</td>
                            <td>受聘时间</td>
                        </tr>
                        <%
                        	MzbManage manage = serviceSession.getService(MzbManage.class);
                        	XcyVo[] list = manage.getXcy();
                        	if(list!=null && list.length>0){
                        		int i=1;
                        		for(XcyVo x : list){
                        			String phonenumber =StringHelper.isEmpty(x.sjh) ? "" : x.sjh.substring(0,3)+"*****"+x.sjh.substring(7,11);
                        %>
                        <tr>
                        	<td width="142"><%=i++ %></td>
                            <td width="191"><%StringHelper.filterHTML(out, StringHelper.truncation(x.yhm,4,"***"));%></td>
                            <td width="160"><%StringHelper.filterHTML(out, StringHelper.truncation(x.name,1,"***"));%></td>
                            <td width="226"><%StringHelper.filterHTML(out, phonenumber);%></td>
                            <td><%=DateTimeParser.format(x.spsj,"yyyy-MM-dd HH:mm") %></td>
                        </tr>
                        	<%}} %>
                    </tbody>
                </table>
            </div>
        </div>
	</div>      
</div>


<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>