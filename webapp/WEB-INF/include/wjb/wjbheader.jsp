<%@page import="com.jiudian.p2p.common.enums.WjbStatus"%>
<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.common.enums.WjbXmxq"%>
<%@page import="com.jiudian.p2p.common.enums.StabilizeCycle"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page
	import="com.jiudian.p2p.front.service.financing.entity.StabilizeVo"%>
<%@page import="com.jiudian.p2p.front.service.financing.StabilizeManage"%>
<%
	StabilizeManage manage = serviceSession
		.getService(StabilizeManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		if (id <= 0) {
	/* controller.sendRedirect(request,response,controller.getViewURI(request,com.jiudian.p2p.front.servlets.p2plicai.wjb.Index.class)); */
	return;
		}
		StabilizeVo stabilizeVo = manage.getHeaderDetail(id);
		WjbXmxq wjbXmxq = null;
		
		Timestamp now = new Timestamp(new Date().getTime());
		String icon = "";
		String ritht_icon = "";
		if(stabilizeVo.status.equals(WjbStatus.YSD)){
	wjbXmxq = WjbXmxq.SYZ;
	icon = "ico05";
	ritht_icon = "df_hf";
		}else if(stabilizeVo.status.equals(WjbStatus.YME)){
	wjbXmxq = WjbXmxq.YME;
	icon = "ico04";
	ritht_icon = "mb_hf";
		}else if(stabilizeVo.status.equals(WjbStatus.YDQ)){
	wjbXmxq = WjbXmxq.YDQ;
	icon = "ico06";
	ritht_icon = "hq_hf";
		}else if(stabilizeVo.status.equals(WjbStatus.YSH)){
	if(stabilizeVo.fbsj.compareTo(now)<=0 && stabilizeVo.ydkssj.compareTo(now)>0){
		wjbXmxq = WjbXmxq.JJYD;
	}else if(stabilizeVo.ydkssj.compareTo(now)<=0 && stabilizeVo.ydjssj.compareTo(now)>0 && stabilizeVo.ydsyje.intValue() > 0){
		wjbXmxq = WjbXmxq.YDZ;
		icon = "ico01";
	}else if(stabilizeVo.ydkssj.compareTo(now)<=0 && stabilizeVo.ydjssj.compareTo(now)>0 && stabilizeVo.ydsyje.intValue() == 0){
		wjbXmxq = WjbXmxq.YDME;
		icon = "ico01";
		ritht_icon = "mb_hf";
	}else if(stabilizeVo.ydjssj.compareTo(now)<=0 && stabilizeVo.zfjzsj.compareTo(now)>0 ){
		wjbXmxq = WjbXmxq.YDJS;
		icon = "ico02";
		ritht_icon = "lb_hf";
	}else if(stabilizeVo.zfjzsj.compareTo(now)<=0 && stabilizeVo.jrkfsj.compareTo(now)>0 ){
		wjbXmxq = WjbXmxq.ZFJZ;
		icon = "ico03";
		ritht_icon = "zfjz_hf";
	}else if(stabilizeVo.jrkfsj.compareTo(now)<=0 && stabilizeVo.sdkssj.compareTo(now)>0 && stabilizeVo.syje.intValue() > 0){
		wjbXmxq = WjbXmxq.KFJR;
		icon = "ico04";
	}else if(stabilizeVo.jrkfsj.compareTo(now)<=0 && stabilizeVo.sdkssj.compareTo(now)>0 && stabilizeVo.syje.intValue() == 0){
		wjbXmxq = WjbXmxq.YME;
		icon = "ico04";
		ritht_icon = "mb_hf";
	}
		}
%>
<%!public static String getDistanceTime(String str1, String str2) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date one;
		Date two;
		long day = 0;
		long hour = 0;
		long min = 0;
		long sec = 0;
		try {
			one = df.parse(str1);
			two = df.parse(str2);
			long time1 = one.getTime();
			long time2 = two.getTime();
			long diff;
			if (time1 < time2) {
				diff = time2 - time1;
			} else {
				diff = time1 - time2;
			}
			day = diff / (24 * 60 * 60 * 1000);
			hour = (diff / (60 * 60 * 1000) - day * 24);
			min = ((diff / (60 * 1000)) - day * 24 * 60 - hour * 60);
			sec = (diff / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return day + "天" + hour + "时" + min + "分";
	}%>
	
	<%!public static String getDistanceTime2(String str1, String str2) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date one;
		Date two;
		long day = 0;
		long hour = 0;
		long min = 0;
		long sec = 0;
		try {
			one = df.parse(str1);
			two = df.parse(str2);
			long time1 = one.getTime();
			long time2 = two.getTime();
			long diff;
			if (time1 < time2) {
				diff = time2 - time1;
			} else {
				diff = time1 - time2;
			}
// 			day = diff / (24 * 60 * 60 * 1000);
			hour = (diff / (60 * 60 * 1000));
			min = ((diff / (60 * 1000)) - hour * 60);
			sec = (diff / 1000 - hour * 60 * 60 - min * 60);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return  hour + "时" + min + "分"+sec+"秒";
	}%>
	
	<%!public static String getDistanceTime3(String str1, String str2) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date one;
		Date two;
		long day = 0;
		long hour = 0;
		long min = 0;
		long sec = 0;
		try {
			one = df.parse(str1);
			two = df.parse(str2);
			long time1 = one.getTime();
			long time2 = two.getTime();
			long diff;
			if (time1 < time2) {
				diff = time2 - time1;
			} else {
				diff = time1 - time2;
			}
			day = diff / (24 * 60 * 60 * 1000);
// 			hour = (diff / (60 * 60 * 1000));
// 			min = ((diff / (60 * 1000)) - hour * 60);
// 			sec = (diff / 1000 - hour * 60 * 60 - min * 60);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return  day + "天";
	}%>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery/jquery-1.8.3.min.js"></script>

<script type="text/javascript">
	function time(timeid,sendTime,sclearTime) {
		var endTime = parseInt(sendTime);
		var leftsecond = parseInt(endTime / 1000);
		var day = Math.floor(leftsecond / (60 * 60 * 24)) < 0 ? 0 : Math
				.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0
				: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math
				.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0
				: Math
						.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600
				- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60
				* 60 - hour * 3600 - minute * 60);
		if (hour < 10) {
			hour = "0" + hour;
		}
		if (minute < 10) {
			minute = "0" + minute;
		}
		if (second < 10) {
			second = "0" + second;
		}
		
		var suffix_name = $("input[name='"+timeid+"suffix']").val();
		$("input[name='"+timeid+"location']").val(day+"天"+hour+"时"+minute+"分"+suffix_name);
		if (leftsecond <= 0) {
			clearInterval(sclearTime);
		}
	}
</script>
<script type="text/javascript">
	function time2(timeid,sendTime,sclearTime) {
		var endTime = parseInt(sendTime);
		var leftsecond = parseInt(endTime / 1000);
		var day = Math.floor(leftsecond / (60 * 60 * 24)) < 0 ? 0 : Math
				.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0
				: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math
				.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0
				: Math
						.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600
				- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60
				* 60 - hour * 3600 - minute * 60);
		hour = hour + day*24;
		if (hour < 10) {
			hour = "0" + hour;
		}
		if (minute < 10) {
			minute = "0" + minute;
		}
		if (second < 10) {
			second = "0" + second;
		}
		
		var suffix_name = $("input[name='"+timeid+"suffix']").val();
		$("input[name='"+timeid+"location']").val(hour+"时"+minute+"分"+second+"秒"+suffix_name);
		if (leftsecond <= 0) {
			clearInterval(sclearTime);
		}
	}
</script>
<div class="center_box">
	<div class="center_all_border nomargin">
    	<div class="pub_title_hf">
        	<p class="pub_tit_left_hf"><span class="wjb_ico"></span><em><%StringHelper.filterHTML(out, stabilizeVo.xmmc);%></em></p>
            <p class="pub_tit_right_hf"><a href="javascript:void(0)" class="wjbxy">稳赚保购买协议范本</a></p>
        </div>
    </div>
</div>
<div class="center">
	<div class="plan_given_hf">
		<ul class="plan_given_left">
			<li><div class="pr100_hf">
					<em class="emfs18">¥</em><span class="spanfs36"><%=Formater.formatAmount(stabilizeVo.jhje)%></span><br />计划总额（元）
				</div>
				<div class="pr80_hf">
					<span class="spanfs36"><%=Formater.formatRate(stabilizeVo.nll, false)%></span><em class="emfs18">%</em><br />年利率
				</div>
				<div class="pr30_hf">
					<span class="spanfs36"><%=stabilizeVo.xmqx %></span>
					<em class="emfs18" style="font-family: 微软雅黑;"><%if(stabilizeVo.xmqxlx.equals(StabilizeCycle.AY)){%>个月<%}else if(stabilizeVo.xmqxlx.equals(StabilizeCycle.AT)){%>天<%}%></em><br />锁定期限
				</div></li>
			<li>
				<div class="list01_hf">保障方式</div>
				<div class="list02_hf" style="width:270px;">
					<em class="wjb_bzfs">小贷回购+保险承保</em>
				</div>
				<div class="list01_hf">还款方式</div>
				<div class="list01_hf" style="margin-right:0px;"><%StringHelper.filterHTML(out, stabilizeVo.hkfs.getName());%></div>
			</li>
			<li>
				<div class="list01_hf">退出日期</div>
				<div class="list02_hf" style="width:270px;">
					<em><%=DateTimeParser.format(stabilizeVo.tcrq, "yyyy年MM月dd日") %></em>
				</div>
				<div class="list01_hf">购买条件</div>
				<div class="list01_hf">
					<span><%=Formater.formatAmount(stabilizeVo.tzzde)%>元</span>
				</div>
			</li>
				<%int jd = 1; %>
				<%if(stabilizeVo.jhje != stabilizeVo.ydsyje){jd = (stabilizeVo.jhje.subtract(stabilizeVo.ydsyje)).divide(stabilizeVo.jhje, 3, BigDecimal.ROUND_DOWN).multiply(new BigDecimal(100)).intValue();}%>
				<%if(wjbXmxq!=null &&(wjbXmxq.equals(WjbXmxq.JJYD) || wjbXmxq.equals(WjbXmxq.YDZ) || wjbXmxq.equals(WjbXmxq.YDJS) || wjbXmxq.equals(WjbXmxq.ZFJZ))){%>
					<li><div class="list01_hf">预定进度</div>
	                	<div class="list02_hf">
	                        <div class="progress_bar_bg_hf">
	                            <div class="progress_bar_con_hf" style="width: <%=jd%>%;"></div>
	                        </div>
	                        <div class="percentage_hf"><%=jd%>%</div>
	                     </div>
	                </li>
				<%} %>
		</ul>
		
		<%if(wjbXmxq!=null &&( wjbXmxq.equals(WjbXmxq.JJYD) || wjbXmxq.equals(WjbXmxq.YDZ) || wjbXmxq.equals(WjbXmxq.KFJR))){%>
		<%if(jiudianSession!=null && jiudianSession.isAuthenticated()){
				UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
				UserInfo userInfo= userInfoManage.search();
				String isYuqi =  userInfoManage.isYuqi();
				int wjbzfs = 0;
		%>
			<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
			<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
			<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.kyMoney%>">
			<input type="hidden" id="status_dq" value="<%=wjbXmxq%>">
			<input type="hidden" id="zdtzr_js" value="<%=stabilizeVo.tzzde.intValue()%>">
			<input type="hidden" id="ydsyje_js" value="<%=stabilizeVo.ydsyje.intValue()%>">
			<input type="hidden" id="syje_js" value="<%=stabilizeVo.syje.intValue()%>">
			<input type="hidden" id="djsx_js" value="<%=stabilizeVo.djsx.intValue()%>">
			<input type="hidden" id="djbl_js" value="<%=stabilizeVo.djbl.doubleValue()%>">
			
			<div class="submission_hf">
				<div class="text01_hf">
					<h4>剩余金额（元）</h4>
					<div class="text_hf" style="margin: 8px 0 0 0;">
						<span style="font-size: 22px;">￥<%if(stabilizeVo.zfjzsj.compareTo(now)>0){%><%=Formater.formatAmount(stabilizeVo.ydsyje) %><%}else{%><%=Formater.formatAmount(stabilizeVo.syje) %><%}%></span>
						<p class="wjb_yfdj">
							应付定金<span id="show_dj">0.00</span>元
						</p>
					</div>
					
					<p style="width: 100%; float: left;">
						<span class="fl" style="font-size: 14px;">可用金额&nbsp;&nbsp;<em
							class="cz_href_hf"><%=Formater.formatAmount(userInfo.kyMoney) %></em>元
						</span><span class="fr"><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>"
							class="cz_href_hf">充值</a></span>
					</p>
					
					<p style="padding-top: 10px; width: 100%; float: left; position: relative;">
						<input type="text" id="amount" name="" class="text_input_hf" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" style="width: 214px; padding: 0 30px 0 10px; text-align: left;">
						<span style="position: absolute; right: 12px; top: 15px; color: #878787; font-size: 14px;">元</span>
					</p>
					
					<%if(wjbXmxq.equals(WjbXmxq.JJYD)){%>
					<p style="padding-top: 25px; width: 100%; float: left; text-align: center;">
						<input name="ydks_time_suffix" type="hidden" value="后开始预定"> 
						<input name="ydks_time_location" type="button" value="<%StringHelper.filterHTML(out, getDistanceTime(DateTimeParser.format(new Date(),"yyyy-MM-dd HH:mm:ss"),DateTimeParser.format(stabilizeVo.ydkssj,"yyyy-MM-dd HH:mm:ss")));%>后开始预定" class="text_input01_hfs btn01">
						<script type="text/javascript">
								ydks_time= parseInt(<%=stabilizeVo.ydkssj.getTime()-System.currentTimeMillis()%>);
                            	tempname = "ydks_time_";
                            	sclearTime_ydks = setInterval(function() {
                            		ydks_time = ydks_time - 1000;
                            		time(tempname,ydks_time,sclearTime_ydks);
                            	}, 1000);
                        </script>
					</p>
					<%}else if(wjbXmxq.equals(WjbXmxq.YDZ)){
						wjbzfs = stabilizeVo.ydsyje.divide(stabilizeVo.tzzde, 0, BigDecimal.ROUND_DOWN).intValue();
					%>
					<input id="msg_name" type="hidden" value="预定"/>
					<p style="padding-top:25px; width:100%; float:left; text-align:center;">
					<input type="button" value="预&nbsp;&nbsp;定" onclick="checkBid()" class="text_input01_hfs"></p>
					<%}else if(wjbXmxq.equals(WjbXmxq.KFJR)){
						
					%>
					<input id="msg_name" type="hidden" value="购买"/>
					<p style="padding-top:25px; width:100%; float:left; text-align:center;">
					<input type="button" value="购&nbsp;&nbsp;买" onclick="checkBid()" class="text_input01_hfs"></p>
					<%}%>
				</div>
	
			</div>
		
		<%}else{ %>
			<div class="submission_hf">
				<div class="text_hf">
					<h4 style="padding-bottom: 2px;">剩余金额（元）</h4>
					<span style="font-size: 22px;">￥<%if(stabilizeVo.zfjzsj.compareTo(now)>0){%><%=Formater.formatAmount(stabilizeVo.ydsyje) %><%}else{%><%=Formater.formatAmount(stabilizeVo.syje) %><%}%></span>
					<p class="wjb_yfdj">
						应付定金<span>0.00</span>元
					</p>
				</div>
				<div class="fs18c73"
					style="float: left; text-align: center; width: 100%; margin-top: 72px;">
					请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>"
						style="color: #186ea7; padding: 0 5px;">登录</a>或<a
						href="<%configureProvider.format(out,URLVariable.REGISTER);%>" style="color: #faaf00; padding: 0 5px;">注册</a>
				</div>
			</div>
		<%} %>
		<%}else{%>
			<%if(jiudianSession!=null && jiudianSession.isAuthenticated()){
				UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
				UserInfo userInfo= userInfoManage.search();
			%>
			<%if(wjbXmxq.equals(WjbXmxq.YDJS) || wjbXmxq.equals(WjbXmxq.ZFJZ)){%>
            <div style="margin-top:-27px; " class="plan_given_right_hf <%=ritht_icon%>">
                <span class="title"><%=wjbXmxq.getName()%></span>
                <p style="padding-top:5px; margin-left:24px; width:250px; line-height:25px;" class="mb_text_hf">
                <span class="fs14c73">剩余金额(元)</span>&nbsp;&nbsp;<span class="fs18c73">￥<%if(stabilizeVo.zfjzsj.compareTo(now)>0){%><%=Formater.formatAmount(stabilizeVo.ydsyje) %><%}else{%><%=Formater.formatAmount(stabilizeVo.syje) %><%}%></span><br/>
                <span class="fl">可用金额&nbsp;&nbsp;<em class="orange"><%=Formater.formatAmount(userInfo.kyMoney) %></em></span>
                <a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blues fr">充值</a></p>
                <p style="width:100%; float:left; text-align:center; padding-top:5px;">
                <input name="ksjr_time_suffix" type="hidden" value="开始加入"> 
				<input name="ksjr_time_location" class="text_input01_hfs btn01" type="button" value="<%StringHelper.filterHTML(out, getDistanceTime2(DateTimeParser.format(new Date(),"yyyy-MM-dd HH:mm:ss"),DateTimeParser.format(stabilizeVo.jrkfsj,"yyyy-MM-dd HH:mm:ss")));%>开始加入">
				
				<script type="text/javascript">
						ksjr_time= parseInt(<%=stabilizeVo.jrkfsj.getTime()-System.currentTimeMillis()%>);
                          	tempname = "ksjr_time_";
                          	sclearTime_ksjr = setInterval(function() {
                          		ksjr_time = ksjr_time - 1000;
                          		time2(tempname,ksjr_time,sclearTime_ksjr);
                          	}, 1000);
                      </script>
                 </p>
            </div>
			<%} %>
            
            <%if(wjbXmxq.equals(WjbXmxq.YDME)){%>
			 <div class="plan_given_right_hf <%=ritht_icon%>" style="margin-top:-20px;">
                <span class="title">预定满额</span>
                <p class="mb_text_hf" style="padding-top:20px;"><span class="fs14c73">满额用时</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span class="fs18c73"><%StringHelper.filterHTML(out, getDistanceTime(DateTimeParser.format(stabilizeVo.ydkssj,"yyyy-MM-dd HH:mm:ss"),DateTimeParser.format(stabilizeVo.ydmeys,"yyyy-MM-dd HH:mm:ss")));%></span><br/><span class="fs14c73">
                	预定人次</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=stabilizeVo.ydrs %>次</span></p>
            </div>
            <%} %>
            <%if( wjbXmxq.equals(WjbXmxq.YME)){%>
            <div class="plan_given_right_hf <%=ritht_icon%>" style="margin-top:-20px;">
                <span class="title">已满额</span>
                <p class="mb_text_hf" style="padding-top:20px;"><span class="fs14c73">满额用时
                </span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%StringHelper.filterHTML(out, getDistanceTime(DateTimeParser.format(stabilizeVo.jrkfsj,"yyyy-MM-dd HH:mm:ss"),DateTimeParser.format(stabilizeVo.meys,"yyyy-MM-dd HH:mm:ss")));%></span><br/>
                <span class="fs14c73">加入人次</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=stabilizeVo.jrrc %>次</span></p>
            </div>
            <%} %>
            
            <%if( wjbXmxq.equals(WjbXmxq.SYZ)){%>
            <div class="plan_given_right_hf <%=ritht_icon%>" style="margin-top:-20px; ">
                <span class="title">收益中</span>
                <p class="mb_text_hf" style="padding-top:20px;"><span class="fs14c73">预期收益总额
                </span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=Formater.formatAmount(stabilizeVo.yqzsy)%>元</span><br/>
                <span class="fs14c73">距离退出还有</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73">
                <%StringHelper.filterHTML(out, getDistanceTime3(DateTimeParser.format(stabilizeVo.sdkssj,"yyyy-MM-dd"),DateTimeParser.format(stabilizeVo.tcrq,"yyyy-MM-dd")));%></span></p>
            </div>
            <%} %>
            <%if( wjbXmxq.equals(WjbXmxq.YDQ)){%>
            <div class="plan_given_right_hf <%=ritht_icon%>" style="margin-top:-20px; ">
                <span class="title">已到期</span>
                <p class="mb_text_hf" style="padding-top:20px;"><span class="fs14c73">退出时间
                </span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=DateTimeParser.format(stabilizeVo.tcrq, "yyyy-MM-dd") %></span><br/>
                <span class="fs14c73">累计收益</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="fs18c73"><%=Formater.formatAmount(stabilizeVo.zsy)%>元</span></p>
            </div>
			<%} %>
			<%}else{ %>
			<div style="margin-top:-27px;" class="plan_given_right_hf <%=ritht_icon%>">
                <span class="title"><%=wjbXmxq.getName()%></span>
                <p style="padding-top:40px; margin-left:24px; width:250px; line-height:25px; font-size:18px; text-align:center;" class="mb_text_hf">
                   	请<a href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>" class="blues" style="padding:0 5px;">登录</a>
                   	或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="orange" style="padding:0 5px;">注册</a></p>
            </div>
			<%} %>
		<%} %>
		
	</div>
	<div class="wjb_img">
		<div class="wjb_imgtit">
			<span>项目进度</span> <a href="javascript:void(0)">如何加入稳赚保</a>
		</div>
		<div class="wjb_imgbg <%=icon%>">
			<p class="wjb_ydks <%if(icon.equals("ico01") || icon.equals("ico02") || icon.equals("ico03") || icon.equals("ico04") || icon.equals("ico05") || icon.equals("ico06") ){%>color5a<%}%>">
				预定开始<br /><%=DateTimeParser.format(stabilizeVo.ydkssj,"yyyy-MM-dd")%><br /><%=DateTimeParser.format(stabilizeVo.ydkssj,"HH:mm")%>
			</p>
			<p class="wjb_ydjs <%if(icon.equals("ico02") || icon.equals("ico03") || icon.equals("ico04") || icon.equals("ico05") || icon.equals("ico06") ){%>color5a<%}%>">
				预定结束<br /><%=DateTimeParser.format(stabilizeVo.ydjssj,"yyyy-MM-dd")%><br /><%=DateTimeParser.format(stabilizeVo.ydjssj,"HH:mm")%>
			</p>
			<p class="wjb_zfjz <%if(icon.equals("ico03") || icon.equals("ico04") || icon.equals("ico05") || icon.equals("ico06") ){%>color5a<%}%>">
				支付截止<br /><%=DateTimeParser.format(stabilizeVo.zfjzsj,"yyyy-MM-dd")%><br /><%=DateTimeParser.format(stabilizeVo.zfjzsj,"HH:mm")%>
			</p>
			<p class="wjb_kfjr <%if(icon.equals("ico04") || icon.equals("ico05") || icon.equals("ico06") ){%>color5a<%}%>">
				开放加入<br /><%=DateTimeParser.format(stabilizeVo.jrkfsj,"yyyy-MM-dd")%><br /><%=DateTimeParser.format(stabilizeVo.jrkfsj,"HH:mm")%>
			</p>
			<p class="wjb_jrsdq <%if(icon.equals("ico05")  || icon.equals("ico06")){%>color5a<%}%>">
				进入锁定期<br /><%=DateTimeParser.format(stabilizeVo.sdkssj,"yyyy-MM-dd")%><br /><%=DateTimeParser.format(stabilizeVo.sdkssj,"HH:mm")%>
			</p>
			<p class="wjb_dqtc <%if(icon.equals("ico06")){%>color5a<%}%>">
				到期退出<br /><%=DateTimeParser.format(stabilizeVo.tcrq,"yyyy年MM月dd日")%><br />
			</p>
		</div>
	</div>
</div>

<div class="popup_bg"  style="display: none;"></div>


