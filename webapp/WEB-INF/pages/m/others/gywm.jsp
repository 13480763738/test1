<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%
		String _TITLE_ = "关于我们- P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
 <div class="about_us">
        <span>公司简介</span>
        <img src="<%=controller.getStaticPath(request) %>/wap/images/about_us_01.jpg" />
    </div>
    <div class="about_us_wenzi">
        <p>麒麟通宝是由国内供应链服务行业的翘楚——旗丰集团重金打造，致力于为用户
           提供最专业、最安全的互联网借贷服务平台。麒麟通宝专注于风险系数较低的供应链
           融资，辅之以保障系数较高的红本抵押贷、车辆质押贷和保理贷、供应链贷款等产品。
           平台依托集团在供应链服务、小额贷款方面的优势资源及专业团队，全方位保障投资
           人资金的高度安全、灵活流动和稳健收益。平台始终坚持以第三方托管与银行存管相
           结合的方式，确保平台操作规范、运营透明，发展健康。</p>    
    </div>
    <div class="content_us">
        <img src="<%=controller.getStaticPath(request) %>/wap/images/contect_us.png" />
        <p>
      
           客服电话：400-8098-122<br>
           传真：0755-82824433<br>
           客服邮箱：kylintb@firstflag.com.cn<br>
           邮编：518000<br>
           公司地址：深圳市龙岗区白李路26号旗丰数字科技园F栋20楼
        </p>
    </div>

<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</div>
</body>
</html>