<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "理财体验 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	
<div class="nav_box">
    	<div class="nav">
        	<a href="" class="nav_title">我要理财 &gt;</a>
        	<span>
            	<a href="javascript:void(0)" class="selected" >理财体验</a>
            </span>
        </div>
</div>

<div class="center_box">
    <div class="center_all_border">
    	<div style=" width:1000px; margin:0 auto;">
        	<div style="width: 100%; float: left; margin-top: 15px; margin-bottom: 35px;"><img src="/images/new_images/tylc_tit.jpg"></div>
            <div style=" width:100%; float:left; text-align:center; padding-bottom:46px;"><img src="/images/new_images/tylc_txt.jpg" style="padding-left:40px;"></div>
        </div>
    </div>
    <div class="center_all_border">
    	<div style=" width:1000px; margin:0 auto;">
        	<div style="width: 100%; float: left; margin-top: 35px; margin-bottom: 35px;"><img src="/images/new_images/fyjs_tit.jpg"></div>
            <div style=" width:100%; float:left; padding-bottom:46px;font-size:14px; line-height:36px; color:#737373;">
            	<p><span style="font-size:18px;padding-left:75px;">1．加入费用：</span>a%；加入计划金额的a%，期初额外收取，即加入计划金额为10万元，则另行收取（10万*a%）元作为加入计划费用归麒麟通宝所有。</p>
                <p><span style="font-size:18px;padding-left:75px;">2．服务费用：</span>b%；即计划中投标所得利息收入的b%作为服务费用归麒麟通宝所有。</p>
                <p><span style="font-size:18px;padding-left:75px;">3．退出费用：</span>c%；退出计划时按退出计划金额的c%收取退出费用归麒麟通宝所有。</p>
            </div>
        </div>
    </div>
    <div class="center_all_border">
    	<div style="width:1000px; margin:0 auto;">
        	<div style="width: 100%; float: left; margin-top: 35px; margin-bottom: 35px;"><img src="/images/new_images/lctysm_tit.jpg"></div>
            <div style=" width:925px; margin-left:75px; float:left; padding-bottom:46px;font-size:14px; line-height:36px; color:#515151;">
            	<p style="font-size:18px; color:#186ea7;">产品概述</p>
                <p>理财体验专区是麒麟通宝（www.kylintb.com）推出的，作为平台理财用户体验专用的理财产品，用户利用平台提供的体验金加入理财体验专区产品，便可按期获得该理财产品提供的利息收益。收益方式以发行的当期理财体验产品描述为准。</p>
                <p style="font-size:18px; color:#186ea7;">理财成本</p>
                <p>用户加入理财体验专区用户只需要利用通过平台奖励的体验金便可，不需要额外的加入成本。</p>
                <p style="font-size:18px; color:#186ea7;">理财体验要素</p>
                <p>1、计划金额</p>
                <p>本期理财体验活动可参与的总额度，一旦达到该总额度，体验申请期提前结束。</p>
                <p>2、每人可加入金额上限</p>
                <p>每人加入该期理财体验活动的体验金上限。</p>
                <p>3、加入条件</p>
                <p>加入理财体验活动的最低体验金金额及条件限制。</p>
                <p>4、申请期</p>
                <p>申请加入该理财体验活动的时间区间（如：2014-01-21至2014-01-28）。</p>
                <p>5、加入理财体验活动</p>
                <p>一旦点击申请加入理财体验活动，系统根据活动还差金额进行统计，为用户实时显示计划还差金额数，加入计划是否成功，以用户点击申请后的显示为准，若加入成功，系统会提示用户，例如"恭喜您，加入理财体验活动成功，您此次加入该活动的体验金金额为¥10000.00，您加入该活动的体验金总金额为¥20000.00"。</p>
                <p>6、追加加入</p>
                <p>在申请期内，在理财体验活动开放额度、每人额度上限均符合条件，以及用户剩余体验金足额的情况下可以追加资金进入理财体验活动。</p>
                <p>7、体验金结算</p>
                <p>用户一旦加入理财体验活动，加入金额的体验金立马被扣除，即该金额的体验金失效。</p>
                <p>8、收益处理</p>
                <p>用户一旦加入理财体验活动，平台将按照用户加入该体验活动的体验金金额为用户计算利息收益，收益将按期转入用户在平台的可用资金账户中。</p>
            </div>
        </div>
    </div>
    </div>
    <div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>

</body>
</html>


