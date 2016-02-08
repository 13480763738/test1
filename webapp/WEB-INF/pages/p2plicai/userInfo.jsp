<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Bdxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<html>
<head>
<title>用户信息-<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="nav_box">
 	<div class="nav">
     	<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.Index.class)%>" class="nav_title" style="color:#515151;">首页 &gt;</a>
     	<span>
         	<a href="javascript:void(0)" class="selected">用户信息</a>
         </span>
     </div>
 </div>

<div class="center_box">
    	<div class="center">
        	<div class="hmd">
            	<div class="hmd_top"></div>
                <div class="hmd_center">
               	 <%
               	 	int loginId = IntegerParser.parse(request.getParameter("id"));
               	 		      		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
               	 		      		UserInfo userInfo = userInfoManage.search(loginId);
               	 		      		if(userInfo==null){
               	 		      			response.sendError(HttpServletResponse.SC_NOT_FOUND );
               	 		      			return;
               	 		      		}
               	 		      		final int currentPage=IntegerParser.parse(request.getParameter("paging.current"));
               	 		      		PagingResult<CreditInfo> result = userInfoManage.searchCredit(loginId, new Paging() {
               	 		      			public int getCurrentPage() {return currentPage;}
               	 		      			public int getSize() {return 10;}
               	 		      		});
               	 %>
                	
                	<div class="uselist_hf">
                    	<table width="100%" cellspacing="0" border="0">
                        	<tbody>
                            	<tr>
                                	<td width="141" valign="top">
                                    	<div class="user_pic_hf">
                                    	<img src="<%if(StringHelper.isEmpty(userInfo.imgPath)){%><%=controller.getStaticPath(request)%>/images/new_images/user_img.png<%}
                                    	else{%><%=fileStore.getURL(userInfo.imgPath)%><%}%>" class="pic_img" alt="<%=_ALT%>"/>
                                    	<img src="<%=controller.getStaticPath(request)%>/images/new_images/user_bg.png" style="position:absolute; left:0px; top:0px;"></div>
                                        <div class="fs14c73" style="text-align:center; margin-top:10px;">
                                        <%
                                        	StringHelper.truncation(new HTMLFilter(out), userInfo.loginName, 4,"***");
                                        %>
                                        </div>
                                        <div style="text-align:center;*padding-bottom:10px;"><span class="star star0<%=CreditLevel.getLevelId(userInfo.creditLevel)%>"></span></div>
                                    </td>
                                    <td width="235" valign="top">
                                    	  <div class="tit">理财统计</div>
                                          <div><span class="fl" style="width:176px;">持有债权数量（笔）</span><span class="fl"><%=userInfo.cyzqsl%></span></div>
                                          <div ><span class="fl" style="width:176px;">参与理财体验活动（个）</span><span class="fl"><%=userInfo.cylcjhsl%></span></div>
                                    </td>
                                    <td valign="top" style="border:none;">
                                    	  <div class="tit">借款统计</div>
                                          <div>
                                          	<div style="width:235px;"><span class="fl" style="width:160px;">发布借款数量（笔）</span>
                                          	<span class="fl" style="width:57px;"><%=userInfo.fbjksl%></span></div>
                                            <div style="width:229px;"><span class="fl" style="width:140px;">逾期次数（次）</span>
                                            <span class="fl"><%=userInfo.yqcs%></span></div>
                                            </div>
                                          <div >
                                          	<div style="width:235px;"><span class="fl" style="width:160px;">成功借款数量（笔）</span>
                                          	<span class="fl" style="width:57px;"><%=userInfo.cgjksl%></span></div>
                                            <div style="width:229px;"><span class="fl" style="width:140px;">逾期金额（元）</span>
                                            <span class="fl"><%=Formater.formatAmount(userInfo.yqje)%></span></div>
                                          </div>
                                          <div >
                                              <div style="width:235px;"><span class="fl" style="width:160px;">未还清借款数量（笔）</span>
                                              <span class="fl" style="width:57px;"><%=userInfo.whqjksl%></span></div>
                                              <div style="width:229px;"><span class="fl" style="width:140px;">严重逾期笔数（笔）</span>
                                              <span class="fl"><%=userInfo.yzyqcs%></span></div>
                                          </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="hmd_bottom"></div>
            </div>
            <div class="clear"></div>
            <div class="zqzrlb_box_hf" style="margin-top:0px;">
            	<div class="hmd_title"><span><img src="<%=controller.getStaticPath(request)%>/images/new_images/jklb_tit.png"></span></div>
                <div class="hmd">
                	<div class="hmd_top"></div>
                        <div class="hmd_center">
                            <div class="zqzrlb_list_hf">
                            	<table width="100%" align="center" cellspacing="0">
                                	<tbody>
                                    	<tr class="big_tit">
                                        	<td width="215"><span style="padding-left:16px;">借款标题</span></td>
                                            <td width="106">年化收益率</td>
                                            <td width="162">金额</td>
                                            <td width="92">期限</td>
                                            <td width="145">逾期情况</td>
                                            <td width="126">借款时间</td>
                                            <td class="end">状态</td>
                                        </tr>
                                         <%
                                         	CreditInfo[] creditInfos=result.getItems();if(creditInfos!=null){for (CreditInfo creditInfo : creditInfos) {if (creditInfo == null) {continue;}
                                         %>
                                        <tr class="small_tit">
                                        	<td>
                                        	<%
                                        		if(creditInfo.creditType == CreditType.XYDB){
                                        	%>
                                        	<p><span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span>
                                        	<span class="ico ico03"></span></p><%
                                        		}
                                        		                            	else if(creditInfo.creditType == CreditType.XJD || creditInfo.creditType == CreditType.SYD ){
                                        	%><p><span class="ico"></span>
			                            	<span class="ico ico01"></span></p><%
			                            		}
			                            		                            	else if(creditInfo.creditType == CreditType.SDRZ){
			                            	%><p>
			                            	<span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span>
			                            	<span class="ico ico02"></span></p><%
			                            		}
			                            	%>
                                        	<a title="<%=creditInfo.title%>" class="title" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>">
                                        	<%
                                        		StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.title, 7));
                                        	%></a></td>
                                            <td><span class="fb"><%=Formater.formatRate(creditInfo.rate,false)%>%</span></td>
                                            <td>
                                            <%
                                            	if(creditInfo.amount.doubleValue()>=10000){
                                            %>
							            	<span class="fs18c73">
							            	<%=Formater.formatAmount(creditInfo.amount.doubleValue()/10000)%></span><span class="f12">万元</span>
							            	<%
							            		}else{
							            	%>
							            	<span class="fs18c73">
							            	<%=Formater.formatAmount(creditInfo.amount)%><span class="f12">元</span></span>
							            	<%
							            		}
							            	%></td>
                                            <td>
                                            <%
                                            	if(creditInfo.creditCycle.equals(CreditCycle.AYHK)){
                                            %><span class="f18"><%=creditInfo.term%></span>个月<%
                                            	}
                                            %>
                                            <%
                                            	if(creditInfo.creditCycle.equals(CreditCycle.TB)){
                                            %><span class="f18"><%=creditInfo.term%></span>天<%
                                            	}
                                            %>
                                            <%
                                            	if(creditInfo.creditCycle.equals(CreditCycle.MB)){
                                            %>秒标<%
                                            	}
                                            %>
                                            </td>
                                            <td><%=creditInfo.overdueStatus == OverdueStatus.S? "发生过逾期":"未发生过逾期"%></td>
                                            <td><%=DateParser.format(creditInfo.shTime)%></td>
                                            <td class="end">
                                            <%
                                            	if(creditInfo.status == CreditStatus.TBZ){
                                            %>
								            	<a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
								           	<%
								           		}else{
								           	%>
									           	<%
									           		if(creditInfo.status == CreditStatus.YFK) {
									           	%>
									           	<a href="javascript:void(0)" class="toubiao btn02">还款中</a>
									           	<%
									           		}else{
									           	%>
									           	<a href="javascript:void(0)" class="toubiao btn02"><%=creditInfo.status.getName()%></a>
									           	<%
									           		}
									           	%>
								           	<%
								           		}
								           	%>
                                            </td>
                                        </tr>
                                         <%
                                         	}}
                                         %>
                                    </tbody>
                                </table>
                                
                            </div>
                        </div>
                    <div class="hmd_bottom"></div>
                </div>
                <div class="clear"></div>
            	<%
            		AbstractFrontServlet.rendPaging(out, result,controller.getPagingURI(request, com.jiudian.p2p.front.servlets.p2plicai.UserInfo.class),"?id="+Integer.toString(loginId));
            	%>
            </div>
        </div>
    </div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>