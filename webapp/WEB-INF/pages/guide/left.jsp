<%@page import="com.jiudian.p2p.common.enums.ArticleType"%>
<%@page import="com.jiudian.p2p.front.servlets.guide.*"%>

<!--面包绡导航-->
		<div class="nav-bar new-center pb20">
        	<a class="tit">帮助中心 ></a>
        	<span>
                <%-- <a href="<%=controller.getViewURI(request, Mcjs.class)%>" <%="MCJS".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.MCJS.getName()%></a> --%>
                <%-- <a href="<%=controller.getViewURI(request, Ptjs.class)%>" <%="PTJS".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.PTJS.getName()%></a> --%>
                <%-- <a href="<%=controller.getViewURI(request, Lxhfy.class)%>" <%="LXHFY".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.LXHFY.getName()%></a> --%>
                <a href="<%=controller.getViewURI(request, Cjwt.class)%>" <%="CJWT".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>常见问题</a>
                <a href="<%=controller.getViewURI(request, Zfsm.class)%>" <%="ZFSM".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>资费说明</a>
<%--                 <a href="<%configureProvider.format(out, URLVariable.GYWM_AQBZ);%>" <%="AQBZ".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>安全保障</a> --%>
                <a href="<%=controller.getViewURI(request, Wyjk.class)%>" <%="WYJK".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.WYJK.getName()%></a>
                <a href="<%=controller.getViewURI(request, Wiki.class)%>" <%="WYLC".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.WYLC.getName()%></a>
                <%-- <a href="<%=controller.getViewURI(requestPtzh.class)%>" <%="WDWZH".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>><%=ArticleType.PTZH.getName()%></a> --%>
               
                <%-- <a href="<%=controller.getViewURI(request, Ywms.class)%>" <%="YWMS".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>业务模式</a> --%>
                <a href="<%=controller.getViewURI(request, Lcbk.class)%>" <%="LCBK".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>理财百科</a>
                <%-- <a href="<%=controller.getViewURI(request, Tzlc.class)%>" <%="TZLC".equals(CURRENT_SUB_CATEGORY)?" class=\"selected\"":"" %>>投资理财</a> --%>
            </span>
            <%if("XSZY".equals(CURRENT_SUB_CATEGORY)){ %>
            <div class="top_menu_hf">
            	<p>
                	<a href="javascript:void(0)" onclick="showtb(3,this);" class="selected" ><em>我要理财</em></a>
                    <a href="javascript:void(0)" onclick="showtb(2,this);"  ><em>我要借款</em></a>
                </p>
            </div>
            <%} %>
        </div>
    <%// 客服页面  controller.getViewURI(request, Zxkf.class)%>