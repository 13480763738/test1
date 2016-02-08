<%@page import="com.jiudian.p2p.common.enums.Sblx"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Advertisement"%>
<%@page import="com.jiudian.p2p.front.service.information.AdvertisementManage"%>
<%{
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	Advertisement[] advertisements = advertisementManage.getAll(Sblx.PC);
	int userNum = advertisementManage.getUserNum();
	if (advertisements != null && advertisements.length > 0) {
%>
<div id="bannerBox" class="mt20">
	<div id="bannerImg" style="margin: 0px auto;">
    	<ul>
		   <%for(Advertisement advertisement : advertisements){%>
				<li>
				<a target="_blank" href="<%if(!StringHelper.isEmpty(advertisement.url)){ %><%StringHelper.filterHTML(out, advertisement.url);%><%}else{ %>javascript:void(0)<%}%>"
				 style="background:url(<%=fileStore.getURL(advertisement.imageCode)%>) center top no-repeat;" title="<%StringHelper.filterHTML(out, advertisement.title);%>">
				</a>
				<%if (jiudianSession == null || !jiudianSession.isAuthenticated()) {%>
				 <div class="reg_box">
                     <div class="reg" style="right: 0px;">
                         <dl class="breg_box">
                            <dt style=" width:280px; text-align:center;"><%=userNum %><b style=" color: #FFF; font-size: 14px; margin-top: 17px; padding-left: 3px; font-weight:normal">人</b></dt>
                         </dl>
                        <dl class="breg_box" style="margin-top:0px;">
                           <dd style=" width:280px; text-align:center;">已加入麒麟通宝网</dd>
                       </dl>
                       <div class="reg_box_bnt clearfloat"><a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="a2" style="height:44px;">免费注册</a> </div>
                       <dl class="breg_box" style="margin-top:25px;">
                           <dd style=" width:280px; text-align:center;"><a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" style="height:44px; padding-top:30px;">已有账号 ? 立即登录</a></dd>
                       </dl>
                  </div>
                </div>
                <%} %>
				</li>
			<%}%>
	  </ul>
    </div>
    <a href="javascript:void(0)" class="leftBtn"></a>
    <a href="javascript:void(0)" class="rightBtn"></a>
    <div id="bannerBtn_box">
    	<div id="bannerBtn">
        	<ul>
        	<%for(Advertisement advertisement : advertisements){%>
        	<li></li>
        	<%} %>
        	</ul>
        </div>
    </div>
</div> 
<%}}%>