
<%
	String linkurl1 = request.getRequestURL().toString();
%>
		<!--面包绡导航-->
		<div class="nav-bar new-center pb20">
			<span>
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.wytz.Index.class)%>" <%if(linkurl1.indexOf("wytz")>0){%>class="selected"<%} %>>我要投资</a>&gt				
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qfd.Index.class)%>" <%if(linkurl1.indexOf("qfd")>0){%>class="selected"<%} %>>旗房贷</a> 
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qqd.Index.class)%>" <%if(linkurl1.indexOf("qqd")>0){%>class="selected"<%} %>>旗企贷</a>
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qyd.Index.class)%>" <%if(linkurl1.indexOf("qyd")>0){%>class="selected"<%} %>>旗意贷</a>
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qsd.Index.class)%>" <%if(linkurl1.indexOf("qsd")>0){%>class="selected"<%} %>>旗速贷</a>
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qcd.Index.class)%>" <%if(linkurl1.indexOf("qcd")>0){%>class="selected"<%} %>>旗车贷</a>
				<a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class)%>" <%if(linkurl1.indexOf("zqzr")>0){%>class="selected"<%} %>>债权转让</a>         
			</span>
		</div>
  