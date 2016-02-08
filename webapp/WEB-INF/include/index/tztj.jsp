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
	MzbManage manage = serviceSession.getService(MzbManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	PagingResult<MzblistVo> hfbresult = manage.search(new Paging() {
		public int getCurrentPage() {return IntegerParser.parse("1");}public int getSize() {return 1;}
	},ShbType.HFB);
	
	PagingResult<MzblistVo> mabresult = manage.search(new Paging() {
		public int getCurrentPage() {return IntegerParser.parse("1");}public int getSize() {return 1;}
	},ShbType.MZB);
	
	MzblistVo[] hfblist = hfbresult.getItems();
	MzblistVo[] mzblist = mabresult.getItems();
	MzblistVo mzbmvo = null;
	if(mzblist !=null && mzblist.length>0){
		mzbmvo = mzblist[0];
	}
	
	MzblistVo hfbmvo = null;
	if(hfblist !=null && hfblist.length>0){
		hfbmvo = hfblist[0];
	}
	Tjvo tj = manage.getTj();
// 	//平台公告
// 	ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
// 	PagingResult<Article> wdhyzx = articleManage.search(ArticleType.WDHYZX, AbstractFrontServlet.INDEX_PAGING);
// 	PagingResult<Article> mtbd = articleManage.search(ArticleType.MTBD, AbstractFrontServlet.INDEX_PAGING);
	
// 	Article[] wdhyzxs = wdhyzx.getItems();
// 	Article[] mtbds = mtbd.getItems();
// 	int tabCount = 0;
// 	if(wdhyzxs!=null&&wdhyzxs.length>0){
// 		tabCount++;
// 	}
// 	if (mtbds != null&&mtbds.length>0) {
// 		tabCount++;
// 	}
	
		AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
		int userNum = advertisementManage.getUserNum();

%>
<div class="new-contant pt30">
		<!--优势区-->
		<div class="youshi new-center">
			<ul class="header">
				<li>
					成交总额:<span>
					<%
    				double ljcje = tj.ljcje.doubleValue();
    	         	if(ljcje>=1000000000){
				    	%>
				      	   <%=Formater.formatAmount(ljcje/100000000)%>亿元
				      	<%
				      	   	}else if(ljcje>=10000 && ljcje <1000000000){
				      	   %>
				      		<%=Formater.formatAmount(ljcje/10000)%>万元
				      	<%
				      			}else{
				      		%>
				      		<%=Formater.formatAmount(tj.ljcje)%>元
				      	<%
		      			}%>
					</span>
				</li>
				<li>
					用户量:<span><%=userNum %>人</span>
				</li>
				<li>
					为投资人赚取收益:<span>
				<%
        		double fxbyj = tj.fxbyj.doubleValue();
                 	if(fxbyj>=100000000){
        			%>
		      	   <%=Formater.formatAmount(fxbyj/100000000)%>亿元
			      	<%
			      	   	}else if(fxbyj>=10000 && fxbyj <100000000){
			      	   %>
			      		<%=Formater.formatAmount(fxbyj/10000)%>万元
			      	<%
		      			}else{
		      		%>
		      		<%=Formater.formatAmount(tj.fxbyj)%>元
		      		<%
		      			}
		      		%>
					
					</span>
				</li>
<!-- 				<li class="jsq"> -->
<!-- 					<a href="#">收益计算器</a> -->
<!-- 				</li> -->
				<div class="clear"></div>
			</ul>
			<ul class="footer white-bg">
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/youshi1.png" alt="" width="93" height="89" title=""/>
					<p>麒麟通宝</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/youshi2.png" alt="" width="93" height="89" title=""/>
					<p>收益可观</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/youshi3.png" alt="" width="93" height="89" title=""/>
					<p>安全保障</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/youshi4.png" alt="" width="93" height="89" title=""/>
					<p>零门槛</p>
				</li>
				<li>
					<img src="<%=controller.getStaticPath(request)%>/images/youshi5.png" alt="" width="93" height="89" title=""/>
					<p>品牌权威</p>
				</li>
				<div class="clear"></div>
			</ul>
		</div>
		
<%-- 		<%if(tabCount > 0){ %> --%>
<!--      <div class="content_part1_right"> -->
<!--           <div class="news"> -->
<%--                 <h4>平台公告	<a href="<%=controller.getViewURI(request, Mtbd.class)%>">more&gt;</a></h4> --%>
<!--                 <ul> -->
<%--                  <%if (mtbds != null&&mtbds.length>0) {%> --%>
<%--                	<%for (Article article : mtbds) {if (article == null) {continue;}%> --%>
<%--                    <li><a href="<%=controller.getPagingItemURI(request, Mtbd.class,article.id )%>?seo=<%=article.creater%>" target="_blank"><%StringHelper.filterHTML(out, article.title);%></a></li> --%>
<%-- 				<%}}%> --%>
<!--                 </ul> -->
<!--             </div> -->
<!--             <div class="news"> -->
<%--                 <h4>行业动态	<a href="<%=controller.getViewURI(request, Wdhyzx.class)%>">more&gt;</a></h4> --%>
<!--                 <ul> -->
<%--                 <%if (wdhyzxs != null&&wdhyzxs.length>0) {%> --%>
<%--                	<%for (Article article : wdhyzxs) {if (article == null) {continue;}%> --%>
<%--                    <li><a href="<%=controller.getPagingItemURI(request, Wdhyzx.class,article.id )%>?seo=<%=article.creater%>" target="_blank"><%StringHelper.filterHTML(out, article.title);%></a></li> --%>
<%-- 				<%}}%> --%>
<!--                 </ul> -->
<!--             </div> -->
<!--      </div> -->
<%--      <%} %> --%>