<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Bdxq"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet"%>
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.service.financing.query.InvestQuery"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.InvestStatistics"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="http://<%configureProvider.format(out,SystemVariable.SITE_DOMAIN);%>/favicon.ico"> 
<%
String _TITLE_ = "麒麟通宝---中国领先的供应链投融资服务专家。";
String _KEYWORDS_ = "麒麟通宝，旗丰集团，P2P网络借贷，互联网金融，供应链金融，供应链投融资平台，p2p网贷,网贷,网贷平台,p2p网贷平台,投资理财,P2P平台,麒麟通宝P2P网络借贷平台，kylintb.com";
String _DESCRIPTION_ = "麒麟通宝是旗丰集团倾力打造的P2P网贷平台，提供优质项目融资及P2P无忧理财服务，低风险、高收益、100元起投，是国内领先的供应链投融资服务专家。咨询热线：4008098122";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%> 
<meta http-equiv="Cache-Control" content="no-transform " />
<meta name="baidu-site-verification" content="NKKzOEFKOD" />
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" itemprop="description" content="<%=_DESCRIPTION_ %>">
<meta itemprop="name" content="<%=_TITLE_ %>">
<meta itemprop="image" content="http://www.jiudian.com/images/new_images/logo.png">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
 <style>
 .i-t-wx { background-position: -29px 0px;}.wx-qrcode { background-position: 0px -80px; width: 139px; height: 137px;}
 </style>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="m";static final String LEVEL_KEY="l";static final String MULTISELECT_KEY="s";%>
<%
	InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.qyd.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY);
	PagingResult<CreditInfo> result = cnvestmentManage.search(
	new InvestQuery() {
		public InvestType[] getType() {
			String[] values=requestWrapper.getParameterValues(TYPE_KEY);
			if(values==null||values.length==0){
				return null;
			}
			InvestType[] types = new InvestType[values.length];
			for(int i=0;i<values.length;i++){
				types[i] = EnumParser.parse(InvestType.class,values[i]);
			}
			return types;
		}
		public CreditTerm[] getTerm() {
			String[] values=requestWrapper.getParameterValues(TERM_KEY);
			if(values==null||values.length==0){
				return null;
			}
			CreditTerm[] terms = new CreditTerm[values.length];
			for(int i=0;i<values.length;i++){
				terms[i] = EnumParser.parse(CreditTerm.class,values[i]);
			}
			return terms;
		}
		public RepaymentType[] getRepay() {
			String[] values=requestWrapper.getParameterValues(LEVEL_KEY);
			
			if(values==null||values.length==0){
				return null;
			}
			RepaymentType[] levels = new RepaymentType[values.length];
			for(int i=0;i<values.length;i++){
				levels[i] = EnumParser.parse(RepaymentType.class,values[i]);
			}
			return levels;
		}
		public ProductType getProductType() {
			return EnumParser.parse(ProductType.class, ProductType.QYD.name());
		}
	}, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
	});
%>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>    
 <div class="clear"></div> 
 <div class="new-contant mt20 mb20 pb40">
<div class="project-list">
<div class="sub-nav" sup="Project">
    <div class="sub-nav-inner">
        <%@include file="/WEB-INF/include/list_header.jsp" %>
    </div>
</div><!--start: container -->
<div class="wrap filter-wrap" style="margin:0 auto;">
	<div class="white-bg new-center pt20">
    <div class="container filter-container">
        <div class="filter-condition">
            <label>标的类型：</label>
            <ul class="filter-content">
            <%
            	if(parameter.contains(TYPE_KEY)){parameter.remove(TYPE_KEY);
            %>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item">全部</li></a>
            <%
            	}else{
            %>
                 <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item active">全部</li></a>
            <%
            	}
            %>
            <%for(InvestType type:InvestType.values()){if(parameter.contains(TYPE_KEY, type.name())){parameter.remove(TYPE_KEY, type.name());%>
                <li data-href="#" class="filter-item active"><%=type.getName()%></li>
                <li data-href="#"></li>
                <%} else { parameter.set(TYPE_KEY, type.name());%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item "><%=type.getName()%></li></a>
             <%}}%>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="filter-condition">
            <label>借款期限：</label>
           	<ul class="filter-content">
           	<%
           		if(parameter.contains(TERM_KEY)){parameter.remove(TERM_KEY);
           	%>
           	<a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item">全部</li></a>
           	<%
           		}else{
           	%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item active">全部</li></a>
            <%
            	}
            %>
            <%
            	for(CreditTerm term:CreditTerm.values()){if(parameter.contains(TERM_KEY, term.name())){parameter.remove(TERM_KEY, term.name());
            %>
                <li data-href="#" class="filter-item active"><%=term.getName()%></li>
                <li data-href=""></li>
                <%} else { parameter.set(TERM_KEY, term.name());%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item "><%=term.getName()%></li></a>
             <%}}%>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="filter-condition">
            <label>还款方式：</label>
            <ul class="filter-content">
            <%if(parameter.contains(LEVEL_KEY)){parameter.remove(LEVEL_KEY);%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item">全部</li></a>
            <%}else{%>
                 <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item active">全部</li></a>
            <%}%>
            <%for(RepaymentType term:RepaymentType.values()){
            	if(!term.name().equals("DQYCXFQ")){
            	if(parameter.contains(LEVEL_KEY, term.name())){parameter.remove(LEVEL_KEY, term.name());%>
                <li data-href="#" class="filter-item active"><%=term.getName()%></li>
                <li data-href=""></li>
                <%} else { parameter.set(LEVEL_KEY, term.name());%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item "><%=term.getName()%></li></a>
             <%}}}%>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="filter-other"></div>
        </div>

 
<%@include file="/WEB-INF/include/index/toolbar.jsp"%>

<div class="content_part2 container" style=" background:none; height:900px; margin-top:42px;">
     <p class="f18 dark_gray pl20 pb20">旗意贷列表</p>
     <div class="biaodi">
        <div class="blank7"></div>
        <div class="biaodi_list">
        	 <div class="invest after">
        	   <table align="center" cellspacing="0" width="100%">
        	   <tbody>
        	     <tr class="all_bjs">
        	       <td name="tbname3bt"><table align="center" cellspacing="0" width="100%">
        	         <tbody>
        	           <tr class="big_tit" style="color:#666;">
        	             <td width="400" style="color:#666;"><span style="margin-left:-23px;">借款标题</span></td>
        	             <td width="150" style="color:#666;">年化收益率</td>
        	             <td width="150" style="color:#666;">金额</td>
        	             <td width="150" style="color:#666;">期限</td>
        	             <td width="150" style="color:#666;">进度</td>
        	             <td width="170" style="color:#666;" class="end">状态</td>
      	             </tr>
      	             <%
						CreditInfo[] creditInfos=result.getItems();if(creditInfos!=null){int i=1;for (CreditInfo creditInfo : creditInfos) {if (creditInfo == null) {continue;}
					 %>
        	           <tr class="all_bjs">
        	             <td width="400" height="64">
        	               <%if(creditInfo.creditType == CreditType.XYDB){%><p><span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico01<%}%>"></span><span class="ico ico03"></span></p><%}
                           	else if(creditInfo.creditType == CreditType.XJD || creditInfo.creditType == CreditType.SYD ){%><p><span class="ico"></span><span class="ico ico01"></span></p><%}
                           	else if(creditInfo.creditType == CreditType.SDRZ){%><p><span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico01<%}%>"></span><span class="ico ico02"></span></p><%}%>
        	               <a class="title" title="<%StringHelper.filterHTML(out,creditInfo.title);%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>"><%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.title, 13));%></a></td>
        	              <td width="150" height="64"><span class="f14"><%=Formater.formatRate(creditInfo.rate,false)%>%</span> </td>
        	             <td height="64"><span class="f14">￥<%=Formater.formatAmount(creditInfo.amount)%></span></td>
        	             <td width="150" height="64">
        	             <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%>
        	             	<span class="f14"><%=creditInfo.term%>个月</span>
        	             <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%>
        	             	<span class="f14"><%=creditInfo.term%>天</span>
        	             <%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%>
        	             	<span class="f14"><%=creditInfo.term%>秒标</span><%}%>
        	             </td>
        	             <%i++;%>
        	             <td height="64" name="tbname<%=i%>jd"><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=creditInfo.progress%>">
        	             <em><%=creditInfo.progress%>%</em>
        	             </strong></span></div></td>
        	              <%
                              if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
                             %>
                            <script type="text/javascript">
                            	tempendTime<%=i %>= parseInt(<%=creditInfo.fbTime.getTime()-System.currentTimeMillis()%>);
                            	tempname<%=i %> = "tbname<%=i %>";
                            	sclearTime<%=i %> = setInterval(function() {
                            		tempendTime<%=i %> = tempendTime<%=i %> - 1000;
                            		time(tempname<%=i %>,tempendTime<%=i %>,sclearTime<%=i %>);
                            	}, 1000);
                            	
                            </script>
                            <%}%>
                           <td name="tbname<%=i%>" <%if(!(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                               <span class="f18" name="tbname<%=i%>hour">00</span>时
                               <span class="f18" name="tbname<%=i%>minute">00</span>分
                               <span class="f18" name="tbname<%=i%>second">00</span>秒
                           </td>
        	             <%-- <td width="170" height="64" name="tbname<%=i%>bt">
        	             <%if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){ %>
        	             	<span name="tbname<%=i %>span" class="toubiao btn02">敬请期待</span>
        	             <%}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){ %>
        	             	<a href="<%=controller.getPagingItemURI(request, Sbtzxq.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
        	             <%}else if(creditInfo.status==CreditStatus.YMB){ %><a href="javascript:void(0)" class="toubiao2 btn01">已满标</a>
        	             <%}else if(creditInfo.status==CreditStatus.YFK){ %><a href="javascript:void(0)" class="toubiao2 btn01">还款中</a>
        	             <%}else if(creditInfo.status==CreditStatus.YJQ){ %><a href="javascript:void(0)" class="toubiao2 btn01">已结清</a>
						 <%}%>
        	             </td> --%>
        	             <td name="tbname<%=i%>bt" <%if((creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                                <%
                                	if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
                                %>
                                <span name="tbname<%=i%>span" class="toubiao btn02">敬请期待</span>
                                <a  name="tbname<%=i%>a" style="display:none;" href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
                                <%
                                	}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){
                                %><a href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
								<%}else if(creditInfo.status==CreditStatus.YMB){ %><a href="javascript:void(0)" class="toubiao2 btn01">已满标</a>
								<%}else if(creditInfo.status==CreditStatus.YFK){ %><a href="javascript:void(0)" class="toubiao2 btn01">还款中</a>
								<%}else if(creditInfo.status==CreditStatus.YJQ){ %><a href="javascript:void(0)" class="toubiao2 btn01">已结清</a>
								<%}%>
                       </td>
      	             </tr>
      	             <%}}%>
      	           </tbody>
      	         </table>        	
        	   </tbody>
        	   </table>
        	 </div>
             <div class="clear"></div>
             <%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, com.jiudian.p2p.front.servlets.p2plicai.qyd.Index.class),parameter.getQueryString());%>
        </div> 
    </div>
</div>
</div>
</div> 
</div>
</div>
      
 <div class="clear"></div>  
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
 <script type="text/javascript">
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
		
		$("span[name='"+timeid+"hour']").html(hour);
		$("span[name='"+timeid+"minute']").html(minute);
		$("span[name='"+timeid+"second']").html(second);
		if (leftsecond <= 0) {
			$("td[name='"+timeid+"jd']").show();
			$("td[name='"+timeid+"']").hide();
			$("span[name='"+timeid+"span']").hide();
			$("a[name='"+timeid+"a']").show();
			clearInterval(sclearTime);
		}
	}
</script> 
 <script type="text/javascript">window['JZ']={log:function(v){console&&console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('<script src="//static.anquan.org/static/outer/js/aq_auth.js" />'),vsafe=$('<script src="http://static.anquan.org/static/outer/js/aq_auth.js" />');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script><!--微信微博js-->
</body>
</html>
