<!doctype html>
<html>
<head> 
<meta charset="utf-8">
<title>麒麟通宝_首页</title>
<meta name="keywords" content="">
<meta name="description" content="">
<link type="text/css" href="<%=controller.getStaticPath(request)%>/css/new_index.css" rel="stylesheet" /> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.7.2.min.js" charset="UTF-8"></script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/web.js" charset="UTF-8"></script> 
<!--[if lt IE 9]>
<script type="text/javascript" src="js/html5.js"></script>
<![endif]-->
</head> 
<body>
<div id="container">
	<!--头部-->
    <div id="header_box">
    	<div class="header">
        	<a href="javascript:void(0)" class="logos"><img src="<%=controller.getStaticPath(request)%>/images/new_images/logo.png"></a>
            <div class="header_menu">
            	<div class="header_menutop"><span class="line"></span></div>
            	<ul>
                	<li><a href="javascript:void(0)" class="selected">我要理财</a>
                    	<ul>
                        	<li><a href="javascript:void(0)">理财体验专区</a></li>
                            <li><a href="javascript:void(0)">散标投资列表</a></li>
                            <li><a href="javascript:void(0)">债权转让列表</a></li>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0)">我要借款</a>
                    </li>
                    <li><a href="javascript:void(0)">投资攻略</a></li>
                    <li><a href="javascript:void(0)">关于我们</a>
                    	<ul>
                        	<li><a href="javascript:void(0)">公司简介</a></li>
                            <li><a href="javascript:void(0)">管理团队</a></li>
                            <li><a href="javascript:void(0)">合作机构</a></li>
                            <li><a href="javascript:void(0)">联系我们</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="header_link">
            	<a href="javascript:void(0)">首页</a>
                <a href="javascript:void(0)">站内信(<span>1</span>)</a>
                <a href="javascript:void(0)">我的麒麟通宝</a>
                <a href="javascript:void(0)" class="hotline">热线<em>400-880-5306</em></a>
            </div>
            <!--未登录-->
            <div class="header_login"  style="display:none;">
            	<dl>
                	<dt><span class="left"></span><em></em><span class="right"></span></dt>
                    <dd><a href="javascript:void(0)">马上注册</a></dd>
                    <dd style="left:122px;"><a href="javascript:void(0)">登录</a></dd>
                </dl>
            </div>
            <!--已登录-->
            <div class="header_login after">
            	<a href="javascript:void(0)" class="name"><em>zoey***</em></a>
                <a href="javascript:void(0)" class="userimg"><img src="<%=controller.getStaticPath(request)%>/images/new_images/img01.jpg"><img src="<%=controller.getStaticPath(request)%>/images/new_images/images_bg.png" style="position:absolute; top:0px; left:0px; width:56px; height:56px; padding:0px;"></a>
                <div class="header_login_list">
                	<ul>
                    	<li><a href="javascript:void(0)">充值</a></li>
                        <li><a href="javascript:void(0)" class="bg">提现</a></li>
                        <li><a href="javascript:void(0)">资金管理</a></li>
                        <li><a href="javascript:void(0)">理财管理</a></li>
                        <li><a href="javascript:void(0)" class="bg">借款管理</a></li>
                        <li><a href="javascript:void(0)">安全退出</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div><!--头部_end-->
    <!--首页Banner-->
    <div id="bannerBox">
    	<div id="bannerImg">
        	<ul>
            	<li><a href="javascript:void(0)"><img src="http://www.jiudian.com/fileStore/2/2014/9/22/1298.jpg"></a></li>
                <li><a href="javascript:void(0)"><img src="http://www.jiudian.com/fileStore/2/2014/9/22/1298.jpg"></a></li>
                <li><a href="javascript:void(0)"><img src="http://www.jiudian.com/fileStore/2/2014/9/22/1298.jpg"></a></li>
                <li><a href="javascript:void(0)"><img src="http://www.jiudian.com/fileStore/2/2014/9/22/1298.jpg"></a></li>
            </ul>
        </div>
        <!--banner按钮-->
        <a href="javascript:void(0)" class="leftBtn"></a>
        <a href="javascript:void(0)" class="rightBtn"></a>
        <div id="bannerBtn_box">
        	<div id="bannerBtn">
            	<ul>
                	<li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
    <!--新闻滚动-->
    <div id="topNews_box">
    	<div id="topNews">
        	<span class="ico"><img src="<%=controller.getStaticPath(request)%>/images/new_images/news_ico.gif"></span>
            <div class="topnew_list">
            	<ul>
                	<li><a href="javascript:void(0)">活动"实名认证送千元体验金"活动公告</a><em>系统</em><span>2014-07-11</span></li>
                </ul>
            </div>
            <a href="javascript:void(0)" class="more">更多>></a>
        </div>
    </div>
    
    <!--投资理财-->
    <div class="tzlc_box">
    	<div class="tzlc_center">
        	<div class="tzlc">
                <dl>
                    <dt><a href="javascript:void(0)" class="invest01"></a></dt>
                    <dd><a href="javascript:void(0)">成为理财人，通过主动投标或加入理财体验专区将体验金进行投资体验，可获得预期11%-18%的稳定年化收益</a></dd>
                </dl>
                <dl>
                    <dt><a href="javascript:void(0)" class="invest02"></a></dt>
                    <dd><a href="javascript:void(0)">成为借款人，按照要求完善个人信息，通过发标进行贷款，最快2小时可获得所需资金</a></dd>
                </dl>
                <dl>
                    <dt><a href="javascript:void(0)" class="invest03"></a></dt>
                    <dd><a href="javascript:void(0)">所有投资标的100%适用本息保障计划，如遇贷款人违约，将通过风险备用金有效保障理财人的本息安全</a></dd>
                </dl>
             </div>
        </div>
    </div>
    <!--体验金专区-->
    <div class="financials_box">
    	<div class="financials_center">
        	<div class="financials">
            	<a href="javascript:void(0)" class="go"></a>
            	<div class="title">
                	<a href="javascript:void(0)"><span>第0002期</span></a>
                </div>
                <div class="time"style="display:none;">
                	<em>还有&nbsp;&nbsp;</em><span class="hour">68</span><em>：</em><span class="minute">10</span><em>：</em><span class="second">42</span><em>&nbsp;&nbsp;开始发售</em>
                </div>
                <div class="plan-progress-containers" >
                	<a href="javascript:void(0)"><span class="ui-progressbar-large ui-progressbar-large-45">申请中</span></a>
                </div>
                <div class="plan-progress-containers" style="display:none;"></a>
                	<a href="javascript:void(0)"><span class="ui-progressbar-large">已满额</span></a>
                </div>
                <div class="plan-progress-containers" style="display:none;">
                	<a href="javascript:void(0)"><span class="ui-progressbar-large">已截止</span></a>
                </div>
                <a href="javascript:void(0)" class="get_coin">获取体验金>></a>
                <div class="condition">
                	<table width="100%" border="0">
                    	<tbody>
                        	<tr>
                            	<td>
                                	<i></i>加入条件：<span class="yellow">100.00</span>元
                                </td>
                                <td>
                                	<i></i>加入条件：<span class="yellow">2.000.000.00</span>元
                                </td>
                                <td>
                                	预期收益：<span class="yellow">24.0%</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!--投资列表-->
    <div class="invest_con_box">
    	<div class="invest_con_center">
        	<div class="invest_con_title"><span><img src="<%=controller.getStaticPath(request)%>/images/new_images/title01.png"></span><a href="javascript:void(0)">更多>></a></div>
            <div class="hmd">
            	<div class="hmd_top"></div>
                <div class="hmd_center">
                	<div class="invest">
                    <table width="100%" align="center" cellspacing="0">
                    	<tbody>
                        	<tr class="big_tit">
                            	<td width="275">借款标题</td>
                                <td width="106">信用度</td>
                                <td width="99">年化收益率</td>
                                <td width="178">金额</td>
                                <td width="98">期限</td>
                                <td width="97">进度</td>
                                <td class="end">状态</td>
                            </tr>
                            <tr class="all_bjs">
                            	<td><p><span class="ico"></span><span class="ico ico01"></span></p><a href="javascript:void(0)" class="title">珠宝交易中心政府项目... </a><span class="percent">1%</span></td>
                                <td><span class="level lev_icon01"></span></td>
                                <td><span class="fb">24</span><span class="fs">.0%</span></td>
                                <td><span class="f18">9,000,000.00</span><span class="f12">元</span></td>
                                <td><span class="f18">1</span><span class="f12">个月</span></td>
                                <td><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-43"><em>43%</em></strong></span></div></td>
                                <td><a href="javascript:void(0)" class="toubiao btn01">立即投标</a></td>
                            </tr>
                            <tr class="all_bjs">
                            	<td><p><span class="ico ico03"></span><span class="ico ico01"></span></p><a href="javascript:void(0)" class="title">小型餐饮装修贷</a></td>
                                <td><span class="level lev_icon03"></span></td>
                                <td><span class="fb">18</span><span class="fs">.0%</span></td>
                                <td><span class="f18">60,000.00</span><span class="f12">元</span></td>
                                <td><span class="f18">6</span><span class="f12">个月</span></td>
                                <td><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-100"><em>100%</em></strong></span></div></td>
                                <td><a href="javascript:void(0)" class="toubiao btn02">还款中</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                </div>
                <div class="hmd_bottom"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    
    <!--资讯-->
    <div class="zixun_box">
    	<div class="zixun_center">
        	<div class="zixun_left">
            	<div class="tit"><span><img src="<%=controller.getStaticPath(request)%>/images/new_images/title02.png"></span><a href="javascript:void(0)">更多>></a></div>
                <ul>
                	<li><a href="javascript:void(0)">摈弃P2P担保瓶颈是大势所趋</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">6月网贷行业迎来"小高潮"</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P平台傍上银行忽悠还是增信？</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P网贷"冰火两重天"</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">银监会：P2P应明确做信息中介 需设定门槛</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P客户资金需进行第三方托管</a><span>2014-07-10 </span></li>
                </ul>
            </div>
            <div class="zixun_left right">
            	<div class="tit"><span><img src="<%=controller.getStaticPath(request)%>/images/new_images/title03.png"></span><a href="javascript:void(0)">更多>></a></div>
                <ul>
                	<li><a href="javascript:void(0)">摈弃P2P担保瓶颈是大势所趋</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">6月网贷行业迎来"小高潮"</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P平台傍上银行忽悠还是增信？</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P网贷"冰火两重天"</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">银监会：P2P应明确做信息中介 需设定门槛</a><span>2014-07-10 </span></li>
                    <li><a href="javascript:void(0)">P2P客户资金需进行第三方托管</a><span>2014-07-10 </span></li>
                </ul>
            </div>
        </div>
    </div>
    <!--底部-->
    <div id="footer_box">
    	<div class="footer">
        	<div class="friend_link">
            	<span>友情链接</span>
                <a href="javascript:void(0)">网贷导航</a>
                <a href="javascript:void(0)">网贷百科</a>
                <a href="javascript:void(0)">网贷天眼</a>
                <a href="javascript:void(0)">网贷界</a>
                <a href="javascript:void(0)">网贷经典网</a>
                <a href="javascript:void(0)">网贷财富</a>
                <a href="javascript:void(0)">网贷之家</a>
                <a href="javascript:void(0)">网贷帮手</a>
            </div>
            <div class="footer_link">
            	<div class="footer_link_left">
                	<a href="javascript:void(0)">关于麒麟通宝</a>
                    <a href="javascript:void(0)">安全保障</a>
                    <a href="javascript:void(0)">最新动态</a>
                    <a href="javascript:void(0)">投资攻略</a>
                    <a href="javascript:void(0)">联系我们</a>
                    <a href="javascript:void(0)">网站地图</a>
                </div>
                <div class="footer_link_right">
                	<div class="gzwm">
                    	<span>关注我们：</span>
                        <a href="javascript:void(0)"><span class="foot_item ico_target01"></span></a>
                        <a href="javascript:void(0)"><span class="foot_item ico_target02"></span></a>
                        <a href="javascript:void(0)"><span class="foot_item ico_target03"></span></a>
                    </div>
                    <p>客服热线 (服务时间 9：00-21：00) <br/><span>400-880-5306</span></p>
                </div>
            </div>
            <div class="footer_info">
            	<div class="footer_info_left">
                	<dl>
                    	<dt class="s_item01"></dt>
                        <dd>30倍活期存款收益</dd>
                    </dl>
                    <dl>
                    	<dt class="s_item02"></dt>
                        <dd>100元即可加入</dd>
                    </dl>
                    <dl>
                    	<dt class="s_item03"></dt>
                        <dd>100%本息保障</dd>
                    </dl>
                </div>
                <div class="footer_info_right">
                    <a class="ui_term ui_term03" target="_blank" href="javascript:void(0)"></a>
                    <a target="_blank" class="ui_term ui_term01" href="javascript:void(0)"></a>
                    <a target="_blank" class="ui_term ui_term02" href="javascript:void(0)"></a>
                    <a class="ui_term ui_term04" target="_blank" href=""></a>
                    <a class="ui_term ui_term05" target="_blank" href=""></a> 
                    
                </div>
                <div class="footer_copyright">
                	<p><a href="javascript:void(0)">麒麟通宝</a> | 我的投资银行 Copyright © 2014 jiudian.com All Rights Reserved | 备案号：粤ICP备14060638号</p>
                </div>
            </div>
        </div>
    </div><!--底部_end-->
    
</div>
<!--在线客服-->
<div id="service_onlines"><!--除了首页外，内页的id改为service_onlines-->
	<div class="service_block" style="overflow:hidden;">
    	<span class="tit"><a href="javascript:void(0)" class="kefu"></a>
       
        </span>
        <span class="txt"><a href="javascript:void(0)">客服 <</a>
       
        </span>
        <!--qq客服列表-->
        <!--<div class="qq_onlinebox">
    		<div class="qq_onlinetop"></div>
                <div class="qq_online">
                    <div class="qq_list">
                        <div class="list_bg"></div>
                        <dl>
                            <dt><a href="javascript:void(0)"><img src="images/new_images/service_img.jpg"></a></dt>
                            <dd><a href="javascript:void(0)">客服小王</a></dd>
                        </dl>
                        <dl>
                            <dt><a href="javascript:void(0)"><img src="images/new_images/service_img.jpg"></a></dt>
                            <dd><a href="javascript:void(0)">客服小王</a></dd>
                        </dl>
                        <dl>
                            <dt><a href="javascript:void(0)"><img src="images/new_images/service_img.jpg"></a></dt>
                            <dd><a href="javascript:void(0)">客服小王</a></dd>
                        </dl>
                    </div>
                </div>
        <div class="qq_onlinebottom"></div>
    </div>-->
    </div>
    <div class="service_block">
    	<span class="tit"><a href="javascript:void(0)" class="qq"></a></span>
        <span class="txt"><a href="javascript:void(0)">QQ群</a></span>
    </div>
    <div class="service_block" style="display:none;">
    	<span class="tit"><a href="javascript:void(0)" class="erweima"></a></span>
        <span class="txt"><a href="javascript:void(0)">二维码</a></span>
    </div>
    <div  class="service_block">
    	<span class="tit"><a href="javascript:void(0)" class="weixin"></a></span>
        <span class="txt"><a href="javascript:void(0)">微信</a></span>
        <!--二维码-->
        <div class="erweima_box">
        	<div class="qq_onlinetop"></div>
            <div class="qq_online">
            	<div class="erweima_right">
                	<div class="list_bg"></div>
                    <div class="erweima_target"><img src="<%=controller.getStaticPath(request)%>/images/new_images/sao_target.png"></div>
                	<dl>
                    	<dt><img src="<%=controller.getStaticPath(request)%>/images/new_images/ewcode.jpg"></dt>
                        <dd>扫扫关注麒麟通宝</dd>
                    </dl>
                </div>
            </div>
            <div class="qq_onlinebottom"></div>
        </div>
    </div>
    <div class="service_block" style="border-bottom:none; padding-bottom:0px;">
    	<span class="tit"><a href="javascript:void(0)" class="jsq"></a></span>
        <span class="txt"><a href="javascript:void(0)">计算器</a></span>
    </div>
    <a href="javascript:void(0)" class="returntop"></a>
</div>
<script>
$(function(){
	$("#service_onlines").attr("id","service_online");
	$("#service_online a.returntop").click(function(){
		$("html").animate({scrollTop:0},500);
		$("body").animate({scrollTop:0},500);
		});
	})
	<!--坑爹的QQ客服-->
	$(".service_block:first").hover(function(){
		$(this).find("a").css({"background-position":"-47px 10px","color":"#176fa7"})
		},function(){
			$(this).find("a").removeAttr("style");
			});
</script>

</body>
</html>
