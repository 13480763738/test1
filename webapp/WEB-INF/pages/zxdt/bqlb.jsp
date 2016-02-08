<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.TjzxVo"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.TitleWz"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
int id = IntegerParser.parse(request.getParameter("id"));
ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
String titlename = articleManage.getTitlename(id);
String _TITLE_ = "麒麟通宝 - "+titlename == null ? "" : titlename+" - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%CURRENT_CATEGORY = "ZXDT";CURRENT_SUB_CATEGORY = "HLWJRYJs";%>
	<%@include file="/WEB-INF/include/gywm/left.jsp"%>
	
	<div class="center_box">
    	<div class="center">
    		<div class="new_list_box_hf">
    			<div class="new_list_tit_hf"><%StringHelper.filterHTML(out, titlename);%></div>
                <div class="new_list_hf" style="width:700px;">
                	<ul>
			        	<%
							final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
							PagingResult<Article> results = articleManage.search(id, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 12;}});
							Article[] articles = results.getItems();
							if (articles != null && articles.length > 0) {
								for (Article article : articles) {
									Class clzz = null;
									if(article.type.equals(ArticleType.HLWJRYJ)){
										clzz = Hlwjryj.class;
									}else if(article.type.equals(ArticleType.WDHYZX)){
										clzz = Wdhyzx.class;
									}else if(article.type.equals(ArticleType.WDZS)){
										clzz = Wdzs.class;
									}
						%>
			            <li><a target="_blank" href="<%=controller.getPagingItemURI(request, clzz,article.id)%>?seo=<%=article.creater%>">
			            
			            <%StringHelper.filterHTML(out, article.title); %></a><span><%=Formater.formatDate(article.publishTime)%></span></li>
			            <%}}%>
            		</ul>
            		
            		<%Bqlb.rendPaging(out, results,controller.getPagingURI(request, Bqlb.class),"?id="+id); %>	
       	 		</div>
       	 		
       	 		<div class="new_list_right">
                    <div class="rmbq">
                    	<h2>热门标签</h2>
                        <ul>
                        <%
                        	TitleWz[] titlewzlist = articleManage.getTitle(); 
                        	if(titlewzlist != null && titlewzlist.length >0){
                        		for(TitleWz t : titlewzlist){
                        %>
                        	<li><a href="<%=controller.getViewForwardURI(request, Bqlb.class)%>?id=<%=t.id %>"><%StringHelper.filterHTML(out, t.name);%>（<%=t.wzs %>）</a></li>
                        <%
                        		}
                        	}
                        %>
                        	
                        </ul>
                    </div>
                    <div class="tjzx">
                    	<h2>
                        	<a href="javascript:void(0)" class="selected">最新</a>
                        	<a href="javascript:void(0)" >推荐</a>
                        </h2>
                        <div class="tjzx_list">
                            <ul>
                            	 <%
                            	 TjzxVo[] tjlist = articleManage.getTj(); 
		                        	if(tjlist != null && tjlist.length >0){
		                        		for(TjzxVo t : tjlist){
		                         %>
	                                <%if(t.type.equals(ArticleType.HLWJRYJ)){ %>
		                                <li>
	                               		 <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Hlwjryj.class,t.id)%>?seo=<%=t.author%>">
				            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
				            			</li>
	                                <%} %>
	                                <%if(t.type.equals(ArticleType.WDHYZX)){ %>
		                                <li>
		                                <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Wdhyzx.class,t.id)%>?seo=<%=t.author%>">
					            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
					            		</li>
	                                <%} %>
	                                <%if(t.type.equals(ArticleType.WDZS)){ %>
		                                <li>
		                                <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Wdzs.class,t.id)%>?seo=<%=t.author%>">
					            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
				            			</li>
	                                <%}%>
		                         <%
		                        		}
		                        	}
		                         %>
                            </ul>
                        </div>
                        <div class="tjzx_list" style="display:none;">
                            <ul>
                            	 <%
                            	 TjzxVo[] zxlist = articleManage.getXz(); 
		                        	if(zxlist != null && zxlist.length >0){
		                        		for(TjzxVo t : zxlist){
		                         %>
	                                <%if(t.type.equals(ArticleType.HLWJRYJ)){ %>
		                                <li>
	                               		 <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Hlwjryj.class,t.id)%>?seo=<%=t.author%>">
				            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
				            			</li>
	                                <%} %>
	                                <%if(t.type.equals(ArticleType.WDHYZX)){ %>
		                                <li>
		                                <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Wdhyzx.class,t.id)%>?seo=<%=t.author%>">
					            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
					            		</li>
	                                <%} %>
	                                <%if(t.type.equals(ArticleType.WDZS)){ %>
		                                <li>
		                                <a target="_blank" title="<%StringHelper.filterHTML(out, t.name); %>" href="<%=controller.getPagingItemURI(request, Wdzs.class,t.id)%>?seo=<%=t.author%>">
					            			<%StringHelper.truncation(out, t.name, 13);%></a><span><%=DateTimeParser.format(t.time,"MM-dd")%></span>
				            			</li>
	                                <%}%>
		                         <%
		                        		}
		                        	}
		                         %>
                            </ul>
                        </div>
                    </div>
                </div>
           </div>     
        </div>
 </div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
		$(".pcjiang").hover(function(){
			$(this).find("div").show();
			},function(){
				$(this).find("div").hide();
				});
	    var box = $(".biaodi h2 span.fl");
	    var showCon = $(".biaodi_list");
	    var e;
	    showCon.find("li:first").find("a").addClass("newgif");
	    box.find("a").hover(function () {
	        e = $(this).index();
	        box.find("a").removeClass("selected");
	        $(this).addClass("selected");
			showCon.hide();
	        showCon.eq(e).show();
			$(".biaodi h2 span.fr a").hide();
			$(".biaodi h2 span.fr a").eq(e).show();
			showCon.find("li:first").find("a").addClass("newgif");
	    });
	    
	    $(function(){
			 var num=$(".djs_qgz").length;
			 for(i=0;i<num;i++){
				 var percent=parseInt($(".djs_qgz_out").eq(i).find("span").text());
				var Wid=$(".djs_qgz_out").eq(i).width();
				var bg=Math.round(Wid-Wid*percent/100);
				var wid=Math.round(Wid-bg-$(".djs_qgz_out").eq(i).find("span").width()/2-1);
				$(".djs_qgz_out").eq(i).css("background-position",-bg+"px bottom");
				$(".djs_qgz_out").eq(i).find("span").css("left",wid+"px");
				 }
	   	});
	</script>           
	<script type="text/javascript" src="js/a.js"></script><!--微信微博js-->
	 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->
	
</body>
</html>