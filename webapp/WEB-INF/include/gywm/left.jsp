<%@page import="com.jiudian.p2p.common.enums.ArticleType"%>
<%@page import="com.jiudian.p2p.front.servlets.gywm.*"%>
<%@page import="com.jiudian.p2p.front.servlets.zxdt.*"%>
	<!--面包绡导航-->
		<div class="sub-nav" sup="Project">
			<div class="sub-nav-inner" style=" border-color: -moz-use-text-color -moz-use-text-color #f3f3f3;">
				<div class="new-center">
					<!--start: Navigation -->
					<div class="navbar navbar-inverse">
						<div class="navbar-inner">
							<ul class="nav">
	            				<li <%if("GYWM".equals(CURRENT_CATEGORY)){ %>class="selected"<%}%>><a href="<%=controller.getViewURI(request, Gsjj.class)%>">关于我们</a>
	                  			<li <%if("ZXDT".equals(CURRENT_CATEGORY)){ %>class="selected"<%}%>><a href="<%=controller.getViewURI(request, Mtbd.class)%>">平台资讯</a>
            <%--     <a href="<%=controller.getViewURI(request, Yjbg.class)%>" <%if("YJBG".equals(CURRENT_CATEGORY)){ %>class="selected"<%}%>>业绩报告</a>
                <a href="<%=controller.getViewURI(request, Wzgg.class)%>" <%if("WZGG".equals(CURRENT_CATEGORY)){ %>class="selected"<%}%>>网站公告</a> --%>
          					 </ul>
        	<%if("GYWM".equals(CURRENT_CATEGORY)){ %>
            <div class="top_menu_hf">
            	<p>
                	<a href="<%=controller.getViewURI(request, Gsjj.class)%>" <%="GSJJ".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.GSJJ.getName() %></em></a>
                	<a href="<%=controller.getViewURI(request, Qyzz.class)%>" <%="QYZZ".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.QYZZ.getName() %></em></a>
                    <a href="<%=controller.getViewURI(request, Gltd.class)%>" <%="GLTD".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.GLTD.getName() %></em></a>
                    <a href="<%=controller.getViewURI(request, Hzjg.class)%>" <%="HZJG".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.HZJG.getName() %></em></a>
                    <a href="<%=controller.getViewURI(request, Zxns.class)%>" <%="ZXNS".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.ZXNS.getName() %></em></a>
                    <a href="<%=controller.getViewURI(request, Lxwm.class)%>" <%="LXWM".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.LXWM.getName() %></em></a>
                    <a href="<%=controller.getViewURI(request, Shzr.class)%>" <%="SHZR".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.SHZR.getName() %></em></a>
                </p>
            </div>
            <%}%>
            <%if("ZXDT".equals(CURRENT_CATEGORY)){ %>
             <div class="top_menu_hf">
            	<p>
                    <a href="<%=controller.getViewURI(request, Wdzs.class)%>" <%="WDZS".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em><%=ArticleType.WDZS.getName() %></em></a>
                	<a href="<%=controller.getViewURI(request, Mtbd.class)%>" <%="MTBD".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em>平台公告</em></a>
                    <%-- <a href="<%=controller.getViewURI(request, Hlwjryj.class)%>" <%="HLWJRYJ".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>
                    <img src="<%=controller.getStaticPath(request)%>/images/hlwjryj_s.jpg" srcimg="<%=controller.getStaticPath(request)%>/images/hlwjryj_s.jpg" selectedimg="<%=controller.getStaticPath(request)%>/images/hlwjryj_b.jpg"></a> --%>
                    <a href="<%=controller.getViewURI(request, Wdhyzx.class)%>" <%="WDHYZX".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><em>行业动态</em></a>
                </p>
            </div>
            <%}%>
            </div>
            </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>