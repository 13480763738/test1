<%@page import="com.jiudian.p2p.common.enums.Sblx"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Advertisement"%>
<%@page import="com.jiudian.p2p.front.service.information.AdvertisementManage"%>
<%{
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	Advertisement[] advertisements = advertisementManage.getAll(Sblx.WAP);
	if (advertisements != null && advertisements.length > 0) {
%>


<div class="box-163css box-163css-arrow">
    <div id="slider2" class="swipe">
      <ul class="piclist">
      <%for(Advertisement advertisement : advertisements){%>
        <li><a  rel="external" href="<%if(!StringHelper.isEmpty(advertisement.url)){ %><%StringHelper.filterHTML(out, advertisement.url);%><%}else{ %>javascript:void(0)<%}%>"><img src="<%=fileStore.getURL(advertisement.imageCode)%>"></a></li>
      <%}%>
      </ul>
    </div>
    <div id="pagenavi2" class="page">
    	<%int i=1; for(Advertisement advertisement : advertisements){%>
        	<a href="javascript:void(0)" <%if(i==1){%> class="active" <%} %>></a>
        <%i++;} %>
    </div>
</div>
<%}}%>


