<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Financing"%>
<html>
<head>
<%
	String _TITLE_ = "P2P理财、网上投资理财100%本息保障 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "p2p理财,理财网站，网络理财，网上理财，网上投资，网络投资，p2p投资理财，网络投资平台，网络投资理财";
String _DESCRIPTION_ = "麒麟通宝P2P理财频道 - 稳健高效的P2P理财平台，为您提供100%本息保证及多样化的网络理财、网上投资方式。";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="nav_box pt30">
 	<div class="nav">
     	<a class="nav_title" style="color:#515151;">网上理财 ></a>
     	<span>
         	<a href="javascript:void(0)" class="selected">产品介绍</a>
         </span>
     </div>
</div>

<div class="center_box">
    	<div class="center">
        	<div class="wylc_box_hf">
                <dl>
                    <dt><img src="<%=controller.getStaticPath(request)%>/images/new_images/wylc_tit01.png" alt="<%=_ALT%>"></dt>
                    <dd>
                    	<%
                    		configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_YXLCJH);
                    	%>
                        <p class="btns_hf"><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.yxlc.Index.class)%>">去加入</a></p>
                    </dd>
                </dl>
                <dl>
                    <dt><img src="<%=controller.getStaticPath(request)%>/images/new_images/wylc_tit02.png" alt="<%=_ALT%>"></dt>
                    <dd>
                    	<%
                    		configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_SBTZ);
                    	%>
                    	<p class="btns_hf"><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class)%>">去投标</a></p>
                    </dd>
                </dl>
                <dl>
                    <dt><img src="<%=controller.getStaticPath(request)%>/images/new_images/wylc_tit03.png" alt="<%=_ALT%>"></dt>
                    <dd>
                    	<%
                    		configureProvider.format(out,HTMLVariable.FINANCIAL_PRODUCTS_ZQZR);
                    	%>
                        <p class="btns_hf"><a href="<%=controller.getURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class)%>">去购买</a></p>
                    </dd>
                </dl>
            </div>
        </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>

</body>
</html>