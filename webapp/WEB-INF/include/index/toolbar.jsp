 <%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.Lcjsq"%>
 	<!--右边浮动框-->
	<div class="g-toolbar">
    <a class="g-toolbar-partner" href="" target="_blank" title=""></a>
    <ul class="g-toolbar-nav">
        <li class="toolbar-item">
            <div class="item-tip-c item-tip-weixin" style="display:block">
                <div class="item-box">
                    <u class="u-code u-g-ft-wx"></u>
                    <div class="item-tip">麒麟通宝理财平台</div>
                </div>
            </div>
            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/wx.png" width="33" height="33" style="padding: 3px 0 0 3px;"/></i>
        </li>
        <li class="toolbar-item" style="display:none">
            <div class="item-tip-c item-tip-app">
                <div class="item-box">
                    <u class="u-code u-g-ft-app"></u>
                    <div class="item-tip">扫码下载APP</div>
                </div>
            </div>
            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/phone.png" width="32" height="33" /></i>
        </li>
       <li class="toolbar-item">
	            <a href="#" title="在线客服" target="_blank">   
	                <div class="item-tip-c item-tip-kefu">
	                    <div class="item-box">
	                        <div class="item-tip" style="height:28px;"><script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODA1NDUzMF8zMzcyNzdfNDAwODA5ODEyMl8"></script></div>
	                    </div>
	                </div>
	                <i class="iconfont"><a href="javascript:;" class="kefu" target="_blank"><img src="<%=controller.getStaticPath(request)%>/images/qq.png" width="32" height="33" /></a></i>
	            </a>
	        </li>
        <li style="visibility: visible;" id="back" class="toolbar-item">
            <div class="item-tip-c item-tip-back">
                <div class="item-box">
                <a href="#top" target="_self" >返回顶部</a>
                </div>
            </div>
            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/top.png" width="32" height="33" /></i>
        </li>
    </ul>
</div>
<!-- <div class="g-toolbar"> -->
<!--     <a class="g-toolbar-partner" href="http://www.ppmoney.com/customer/partner?open_from=floating_window" target="_blank" title=""></a> -->
<!--     <ul class="g-toolbar-nav"> -->
<!-- 	        <li class="toolbar-item"> -->
<!-- 	            <div class="item-tip-c item-tip-weixin"> -->
<!-- 	                <div class="item-box"> -->
<!-- 	                    <u class="u-code u-g-ft-wx"></u> -->
<!-- 	                    <div class="item-tip">麒麟通宝理财平台</div> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<%-- 	            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/wx.png" width="33" height="33" /></i> --%>
<!-- 	        </li> -->
<%-- 	        <li class="toolbar-item">
<%-- 	            <div class="item-tip-c item-tip-app"> --%>
<%-- 	                <div class="item-box"> --%>
<%-- 	                    <u class="u-code u-g-ft-app"></u> --%>
<%-- 	                    <div class="item-tip">扫码下载APP</div> --%>
<%-- 	                </div> --%>
<%-- 	            </div> --%>
<%-- 	            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/phone.png" width="32" height="33" /></i> --%>
<%-- 	        </li> --%> 
<!-- 	        <li class="toolbar-item"> -->
<!-- 	            <a href="#" title="在线客服" target="_blank">    -->
<!-- 	                <div class="item-tip-c item-tip-kefu"> -->
<!-- 	                    <div class="item-box"> -->
<!-- 	                        <div class="item-tip" style="height:28px;"><script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODA1NDUzMF8zMzcyNzdfNDAwODA5ODEyMl8"></script></div> -->
<!-- 	                    </div> -->
<!-- 	                </div> -->
<%-- 	                <i class="iconfont"><a href="javascript:;" class="kefu" target="_blank"><img src="<%=controller.getStaticPath(request)%>/images/qq.png" width="32" height="33" /></a></i> --%>
<!-- 	            </a> -->
<!-- 	        </li> -->
<%-- 	        <li class="toolbar-item">
<%-- 	            <a href="<%configureProvider.format(out,URLVariable.LC_LCJSQ);%>" title="页面检测" target="_blank"> --%>
<%-- 	                <div class="item-tip-c item-tip-checkpage"> --%>
<%-- 	                    <div class="item-box"> --%>
<%-- 	                        <div class="item-tip">理财计算器</div> --%>
<%-- 	                    </div> --%>
<%-- 	                </div> --%>
<%-- 	                <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/jsq.png" width="32" height="33" /></i> --%>
<%-- 	            </a> --%>
<%-- 	        </li> --%> 
<!-- 	        <li style="visibility: visible;" id="back" class="toolbar-item"> -->
<!-- 	            <div class="item-tip-c item-tip-back"> -->
<!-- 	                <div class="item-box"> -->
<!-- 	                    <div class="item-tip">返回顶部</div> -->
<!-- 	                </div> -->
<!-- 	            </div> -->
<%-- 	            <i class="iconfont"><img src="<%=controller.getStaticPath(request)%>/images/top.png" width="32" height="33" /></i> --%>
<!-- 	        </li> -->
<!-- 	    </ul> -->
<!-- </div> -->

