<%@page import="com.jiudian.p2p.front.service.information.entity.Advertisement"%>
<%@page import="com.jiudian.p2p.front.service.information.AdvertisementManage"%>
<%{ 
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	Advertisement[] advertisements = advertisementManage.getAll(Sblx.WAP);
	if (advertisements != null && advertisements.length > 0) {%>
<div class="slider">
	  <ul>
	  <%for(Advertisement advertisement : advertisements){%>
	    <li><a href="<%if(!StringHelper.isEmpty(advertisement.url)){ %><%StringHelper.filterHTML(out, advertisement.url);%><%}else{ %>javascript:void(0)<%}%>" target="_blank"><img src="<%=fileStore.getURL(advertisement.imageCode)%>" alt=""></a><>
	<%} %>
	  </ul>
	</div>
<%}}%>