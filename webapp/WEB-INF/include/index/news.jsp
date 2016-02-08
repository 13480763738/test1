<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<%@page import="com.jiudian.p2p.common.enums.ShbType"%>
<%@page import="com.jiudian.p2p.common.enums.WjbStatus"%>
<%@page import="com.jiudian.p2p.common.enums.WjbXmxq"%>
<%@page import="com.jiudian.p2p.common.enums.MzbStatus"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.StabilizeVo"%>
<%@page import="com.jiudian.p2p.front.service.financing.StabilizeManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Tjvo"%>
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.MzblistVo"%>
<%@page import="com.jiudian.p2p.front.service.financing.MzbManage"%>
<%@page import="com.jiudian.p2p.common.enums.ArticleType"%>
<%@page import="com.jiudian.p2p.front.servlets.zxdt.Wdzs"%>
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.servlets.zxdt.Mtbd"%>
<%@page import="com.jiudian.p2p.front.servlets.zxdt.Hlwjryj"%>
<%@page import="com.jiudian.p2p.front.servlets.zxdt.Wdhyzx"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<%@page import="com.jiudian.p2p.front.service.information.AdvertisementManage"%>
<%
	//平台公告
	ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
	PagingResult<Article> wdhyzx = articleManage.search(ArticleType.WDHYZX, AbstractFrontServlet.INDEX_PAGING);
	PagingResult<Article> mtbd = articleManage.search(ArticleType.MTBD, AbstractFrontServlet.INDEX_PAGING);
	PagingResult<Article> wdzs = articleManage.search(ArticleType.WDZS, AbstractFrontServlet.INDEX_PAGING);
	Article[] wdhyzxs = wdhyzx.getItems();
	Article[] mtbds = mtbd.getItems();
	Article[] wdzss = wdzs.getItems();
	int tabCount = 0;
	if(wdhyzxs!=null&&wdhyzxs.length>0){
		tabCount++;
	}
	if (mtbds != null&&mtbds.length>0) {
		tabCount++;
	}
	if (wdzss != null&&wdzss.length>0) {
		tabCount++;
	}
%>
		<div class="new-news new-center mt30 white-bg">
			<ul class="ul1">
				<li class="news-li">
					<div class="header">
						<a target="_blank" href="<%=controller.getViewURI(request, Wdzs.class)%>" class="fr">更多&gt&gt</a>
						<h2 class="fl">媒体报道</h2>
						<div class="clear"></div>
					</div>
					<ul class="first">
					<%if (wdzss != null&&wdzss.length>0) {%>
					<%for (int i=0;i<wdzss.length;i++) {Article article =wdzss[i]; if (article == null) {continue;} if(i>1){break;}%>
						<li class="one">
							<dl>
								<dt class="fl">
									<a href="">
										<img src="<%=fileStore.getURL(article.imageCode)%>" alt="" width="78" height="78"/>
									</a>
								</dt>
								<dd class="fl">
									<h3>
										<a target="_blank" href="<%=controller.getPagingItemURI(request, Wdzs.class,article.id )%>?seo=<%=article.creater%>">
										 <%if(article.title.length()>20)
		                	   				StringHelper.filterHTML(out, article.title.substring(0, 20)+"...");
		                    				else{StringHelper.filterHTML(out, article.title);}%>
										</a>
										<span><%=DateParser.format(article.publishTime)%></span>
									</h3>
									<p>
										 <%if(article.summary!=null&&article.summary.length()>60)
		                	   				StringHelper.filterHTML(out, article.summary.substring(0, 60)+"...");
		                    				else{StringHelper.filterHTML(out, article.summary);}%>
									</p>
								</dd>								<div class="clear"></div>
							</dl>
						</li>
						<%}}%>
					</ul>
				</li>
				<li class="news-li news-li1">
					<div class="header">
						<a target="_blank" href="<%=controller.getViewURI(request, Mtbd.class)%>" class="fr">更多&gt&gt</a>
						<h2 class="fl">平台公告</h2>
						<div class="clear"></div>
					</div>
					<ul class="two">
					<%if (mtbds != null&&mtbds.length>0) {%>
							<%for (Article article : mtbds) {if (article == null) {continue;}%>
                  			 <li><a target="_blank" href="<%=controller.getPagingItemURI(request, Mtbd.class,article.id )%>?seo=<%=article.creater%>" target="_blank">
                  			  <%if(article.title.length()>17)
		                	   StringHelper.filterHTML(out, article.title.substring(0, 17));
		                    else{StringHelper.filterHTML(out, article.title);}%></a></li>                
						<%}}%>
					</ul>
				</li>
				<li class="news-li news-li1" style="margin-right:0;">
					<div class="header">
						<a target="_blank" href="<%=controller.getViewURI(request, Wdhyzx.class)%>" class="fr">更多&gt&gt</a>
						<h2 class="fl">行业动态</h2>
						<div class="clear"></div>
					</div>
					<ul class="two">
					 <%if (wdhyzxs != null&&wdhyzxs.length>0) {%>
		               	<%for (Article article : wdhyzxs) {if (article == null) {continue;}%>
		                   <li><a target="_blank" href="<%=controller.getPagingItemURI(request, Wdhyzx.class,article.id )%>?seo=<%=article.creater%>" target="_blank">
		                   <%if(article.title.length()>17)
		                	   StringHelper.filterHTML(out, article.title.substring(0, 17));
		                    else{StringHelper.filterHTML(out, article.title);}%></a></li>                
						<%}}%>
					</ul>
				</li>
				<div class="clear"></div>
			</ul>
		</div>