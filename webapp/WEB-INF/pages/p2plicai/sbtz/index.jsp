<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Rewards"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.sbtz.Bdxq"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.InvestStatistics"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%@page import="com.jiudian.p2p.front.service.financing.query.InvestQuery"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<html>
<head>
<%
String _TITLE_ = "散标投资 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "麒麟通宝，旗丰集团，P2P网络借贷，互联网金融，供应链金融，供应链投融资平台，p2p网贷,网贷,网贷平台,p2p网贷平台,投资理财,P2P平台,麒麟通宝P2P网络借贷平台，kylintb.com";
String _DESCRIPTION_ = "麒麟通宝是旗丰集团倾力打造的P2P网贷平台，提供优质项目融资及P2P无忧理财服务，低风险、高收益、100元起投，是国内领先的供应链投融资服务专家。咨询热线：4008098122";

%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="m";static final String LEVEL_KEY="l";static final String MULTISELECT_KEY="s";%>
<%
	InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	InvestStatistics total=cnvestmentManage.getStatistics();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY);
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
	return types;}
		public RepaymentType[] getRepay() {
	/* String[] values=requestWrapper.getParameterValues(TERM_KEY);
	if(values==null||values.length==0){
		return null;
	}
	CreditTerms[] terms = new RepaymentType[values.length];
	for(int i=0;i<values.length;i++){
		terms[i] = EnumParser.parse(CreditTerms.class,values[i]);
	}
	return terms; */
	return null;
	}
		 public ProductType getProductType() {
	/* String[] values=requestWrapper.getParameterValues(LEVEL_KEY);
	
	if(values==null||values.length==0){
		return null;
	}
	CreditLevel[] levels = new CreditLevel[values.length];
	for(int i=0;i<values.length;i++){
		levels[i] = EnumParser.parse(CreditLevel.class,values[i]);
	}
	return levels; */
	return null;
	} 
		 public CreditTerm[] getTerm(){
			 return null;
		 }
	}, new Paging() {
		public int getCurrentPage() {return IntegerParser.parse(requestWrapper.getParameter("paging.current"));}public int getSize() {return 10;}
	});
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
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

<%--  <div class="nav_box">
    	<div class="nav">
        	<%@include file="/WEB-INF/include/list_header.jsp" %>
        </div>
</div> --%> 

<div class="sub-nav" sup="Project">
 <div class="sub-nav-inner">
 <div class="container">
    	     <!--start: Navigation -->
         <div class="navbar navbar-inverse">
         <div class="navbar-inner">
             <ul class="nav">
             	<li class="nav_title">我要理财 &gt;</li>
            	<li ><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.yxlc.Index.class)%>">理财体验 </a></li>
      			<li ><a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class)%>">债权转让 </a></li>
                <li ><a href="javascript:void(0)" >还款黑名单</a></li>
             </ul>
        </div>
        </div>
</div>
</div></div>

<div class="center_box">
    	<div class="center">
            <%-- <div class="sxtzxm_box_hf">
                        <div class="sxtzxm_hf">
                            <div class="sxtzxm_top_hf">
                            	<span>筛选投资项目</span>
                            	<%
                            		if(multiSelect){parameter.remove(MULTISELECT_KEY);
                            	%>
                                <a href="<%=parameter.toString()%>" class="choose_hf on"><span class="choose_leftbg_hf"></span><span>多选</span><span class="choose_rightbg_hf"></span></a>
                                <%
                                	}else {parameter.set(MULTISELECT_KEY,"1");
                                %>
                                <a href="<%=parameter.toString()%>" class="choose_hf"><span class="choose_leftbg_hf"></span><span>多选</span><span class="choose_rightbg_hf"></span></a>
                                <%
                                	}
                                %>
                                <p><em>新手指引&gt;&gt;</em>
                                <a href="<%=configureProvider.format(URLVariable.XSZY_MCJS_SB_XYDJ)%>">什么是信用等级？</a>
                                <em>-</em><a href="<%=configureProvider.format(URLVariable.XSZY_MCJS_SB_XYRZB)%>">什么是信用认证标？</a>
                                <em>-</em><a href="<%=configureProvider.format(URLVariable.XSZY_MCJS_SB_SDRZB)%>">什么是实地认证标？</a>
                                <em>-</em><a href="<%=configureProvider.format(URLVariable.XSZY_MCJS_SB_JGDBB)%>">什么是机构担保标？</a></p>
                            </div>
                            <dl>
                                <dt>标的类型</dt>
                                <%
                                	if(parameter.contains(TYPE_KEY)){parameter.remove(TYPE_KEY);
                                %>
						         <dd><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	}else{
						         %>
						         <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	}
						         %>
						         
                                 <%
						                                          	for(InvestType type:InvestType.values()){if(parameter.contains(TYPE_KEY, type.name())){parameter.remove(TYPE_KEY, type.name());
						                                          %>
                                 <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span><%=type.getName()%></span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	} else { parameter.set(TYPE_KEY, type.name());
						         %>
						         <dd><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span><%=type.getName()%></span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	}}
						         %>
                            </dl>
                            <dl>
                                <dt>借款期限</dt>
                                
                                <%
                                                                	if(parameter.contains(TERM_KEY)){parameter.remove(TERM_KEY);
                                                                %>
						         <dd><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	}else {
						         %>
						         <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%
						         	}
						         %> 
                                
                                
                                <%
                                                                                                 	for(CreditTerms term:CreditTerms.values()){if(parameter.contains(TERM_KEY, term.name())){parameter.remove(TERM_KEY, term.name());
                                                                                                 %>
                                <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span class="font"><%=term.getName()%></span><span class="choose_rightbg_hf"></span></a></dd>
						         <dd ><a href=""></a></dd>
						         <%} else { parameter.set(TERM_KEY, term.name());%>
						        <dd><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span class="font"><%=term.getName()%></span><span class="choose_rightbg_hf"></span></a></dd>
						         <%}}%>
                            </dl>
                             <dl>
                                <dt>认证等级</dt>
                                
                                <%if(parameter.contains(LEVEL_KEY)){parameter.remove(LEVEL_KEY);%>
                                <dd><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%}else {%>
						         <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span>不限</span><span class="choose_rightbg_hf"></span></a></dd>
						         <%}%>
                                
                                <%for(CreditLevel level:CreditLevel.values()){if(parameter.contains(LEVEL_KEY, level.name())){parameter.remove(LEVEL_KEY, level.name());%>
                                <dd class="on"><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span class="star star0<%=CreditLevel.getLevelId(level)%>"></span><span class="choose_rightbg_hf"></span></a></dd>
						         <%} else { parameter.set(LEVEL_KEY, level.name());%>
						         <dd ><a href="<%=parameter.toString()%>"><span class="choose_leftbg_hf"></span><span class="star star0<%=CreditLevel.getLevelId(level)%>"></span><span class="choose_rightbg_hf"></span></a></dd>
						         <%}}%>
                            </dl>
                </div>
                <div class="clear"></div>
             </div> --%>
             
             <div class="wrap filter-wrap" style="margin:0 auto;">
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
            <%for(RepaymentType term:RepaymentType.values()){if(parameter.contains(LEVEL_KEY, term.name())){parameter.remove(LEVEL_KEY, term.name());%>
                <li data-href="#" class="filter-item active"><%=term.getName()%></li>
                <li data-href=""></li>
                <%} else { parameter.set(LEVEL_KEY, term.name());%>
                <a href="<%=parameter.toString()%>"><li data-href="#" class="filter-item "><%=term.getName()%></li></a>
             <%}}%>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="filter-other"></div>
        </div>
</div>
             
            
            <div class="zqzrlb_box_hf">
            	<%-- <div class="hmd_title"><span><img src="<%=controller.getStaticPath(request)%>/images/new_images/sbtz_tit.png" alt="<%=_ALT%>"></span><a target="_blank" href="<%=controller.getURI(request, com.jiudian.p2p.front.servlets.p2pdaikuan.Lcjsq.class)%>" class="lcjsq_link_hf">理财计算器</a>
            	<p>累计成交总金额<%if(total.totleMoney.doubleValue()>=1000000000){%>
        	   <em><%=Formater.formatAmount(total.totleMoney.doubleValue()/100000000)%></em>亿元
        	<%}else if(total.totleMoney.doubleValue()>=10000 && total.totleMoney.doubleValue() <1000000000){%>
        		<em><%=Formater.formatAmount(total.totleMoney.doubleValue()/10000)%></em>万元
        	<%}else{%>
        		<em><%=Formater.formatAmount(total.totleMoney)%></em>元
        	<%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;累计成交总笔数
        	<em><%=total.totleCount%></em>笔&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为用户累计赚取
        	<%
	           if(total.userEarnMoney.doubleValue()>=100000000){%>
	        	   <em><%=Formater.formatAmount(total.userEarnMoney.doubleValue()/100000000)%></em>亿元
	        	<%}else if(total.userEarnMoney.doubleValue()>=10000 && total.userEarnMoney.doubleValue() <100000000){%>
	        		<em><%=Formater.formatAmount(total.userEarnMoney.doubleValue()/10000)%></em>万元
	        	<%}else{%>
	        		<em><%=Formater.formatAmount(total.userEarnMoney)%></em>元
	        	<%}%></p></div> --%>
                <div class="invest after" style=" margin-top:10px;margin-bottom:50px;">
                	<table cellspacing="0" align="center" width="100%">
                    	<tbody>
                        	<tr class="big_tit">
                                <td width="400"><span style="margin-left:-23px;">借款标题</span></td>
                                <td width="150">年化收益率</td>
                                <td width="150">金额</td>
                                <td width="150">期限</td>
                                <td width="150">进度</td>
                                <td class="170">状态</td>
                            </tr>
                             <%
								           	CreditInfo[] creditInfos=result.getItems();if(creditInfos!=null){int i=1;for (CreditInfo creditInfo : creditInfos) {if (creditInfo == null) {continue;}
								         %>
                            <tr class="all_bjs">
                                        <td>
                                        <%if(creditInfo.creditType == CreditType.XYDB){%><p><span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico03"></span></p><%}
                           	else if(creditInfo.creditType == CreditType.XJD || creditInfo.creditType == CreditType.SYD ){%><p><span class="ico"></span><span class="ico ico01"></span></p><%}
                           	else if(creditInfo.creditType == CreditType.SDRZ){%><p><span class="ico <%if(creditInfo.companyStatus!=null && creditInfo.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico02"></span></p><%}%>
                           	<a class="title" title="<%=creditInfo.title%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,creditInfo.id)%>"><%
                           		StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.title, 13));
                           	%></a>
                                        </td>
                                       <%--  <td><span class="level lev_icon0<%=CreditLevel.getLevelId(creditInfo.creditLevel)%>"></span></td> --%>
                                        <td>
                                        <span class="fb"><%=Formater.formatRate(creditInfo.rate,false)%></span><span class="fs">%</span>
                                        
                                        <% 
                                Rewards r = cnvestmentManage.getRewards(creditInfo.id);
                                
                                if(r != null){
                                %>
                                <span class="pcjiang_add">+<%=Formater.formatRate(r.jlbl, false)%>%<%
                                int t=0;
                                String jlts = "";
                                if(RewardType.XSJ.equals(r.jllx)){
                                	t=1;
                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。";
                                }else if(RewardType.MTC.equals(r.jllx)){
                                	t=2;
                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内满标，放款后该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                }else if(RewardType.TCJ.equals(r.jllx)){
                                	t=3;
                                	jlts="筹款开始后第一位投资用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                }else if(RewardType.XYJ.equals(r.jllx)){
                                	t=4;
                                	jlts="放款后，随机抽取该标的幸运投资用户，另享"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                }else if(RewardType.THJ.equals(r.jllx)){
                                	t=5;
                                	jlts="该标的累计投资额度最高的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。";
                                }else if(RewardType.XRJ.equals(r.jllx)){
                                	t=6;
                                	jlts="首次在平台投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                }else if(RewardType.PHJ.equals(r.jllx)){
                                	t=7;
                                	jlts="放款后，该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                }else if(RewardType.JBJ.equals(r.jllx)){
                                	t=8;
                                	jlts="若当次投资为您在平台投资的第"+r.xs+"~"+r.fz+"次，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。";
                                }
                                %><em class="pcjiang pcjiang0<%=t%>">
                                    <div class="pcjiang_content" style="display:none;">
                                    	<span class="bg"></span>
                                        <div class="pcjiang_txt">
                                        	<div class="pcjiang_txttop"></div>
                                            <div class="pcjiang_con">
                                            	<p><%StringHelper.filterHTML(out, jlts);%></p>
                                            </div>
                                            <div class="pcjiang_txtbottom"></div>
                                        </div>
                                    </div>
                                    </em>
                                </span>
                                <%} %>
                                        
                                        </td>
                                        <td><%
                                        if(creditInfo.amount.doubleValue()>=10000){%><span class="f18"><%=creditInfo.amount.doubleValue()/10000%></span>
			            	<span class="f12">万元</span>
			            	<%}else{%><span class="f18"><%=Formater.formatAmount(creditInfo.amount)%></span><span class="f12">元</span><%}%>
                                        </td>
                                        <td>
                                        <%if(CreditCycle.AYHK.equals(creditInfo.creditCycle)){%><span class="f18"><%=creditInfo.term%></span><span class="f12">个月</span> 
				       	    <%}if(CreditCycle.TB.equals(creditInfo.creditCycle)){%><span class="f18"><%=creditInfo.term%></span><span class="f12">天</span> 
				       		<%}if(CreditCycle.MB.equals(creditInfo.creditCycle)){%><span class="f12">秒标</span> <%}%>
                                        </td>
                                        
                                         <%i++;%>
                               <td name="tbname<%=i %>" <%if(!(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                               <span name="tbname<%=i %>hour">00</span>时
                                <span name="tbname<%=i %>minute">00</span>分
                                <span name="tbname<%=i %>second">00</span>秒
                               </td>
                               
                               <td name="tbname<%=i %>jd" <%if((creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date()))){%>style="display:none;"<%}%> ><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=creditInfo.progress%>"><em><%=creditInfo.progress%>%</em></strong></span></div></td>
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
                            <%} %>
                             <td name="tbname<%=i %>bt">
                                <%
                                if(creditInfo.status==CreditStatus.TBZ && creditInfo.fbTime.after(new Date())){
                                %>
                                <span name="tbname<%=i %>span" class="toubiao btn02">敬请期待</span>
                                <a  name="tbname<%=i %>a" style="display:none;" href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
                                <%}else if(creditInfo.status==CreditStatus.TBZ && !creditInfo.fbTime.after(new Date())){ 
                                %><a href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,creditInfo.id)%>" class="toubiao btn01">立即投标</a>
								<%}else if(creditInfo.status==CreditStatus.YMB){ %><span class="toubiao2 btn01">已满标</span>
								<%}else if(creditInfo.status==CreditStatus.YFK){ %><span class="toubiao2 btn01">还款中</span>
								<%}%>
                                </td>
                             
                           </tr>
                            <%}}%>
                            </tbody>
                    </table>
                </div>
                <div class="clear"></div>
             <%AbstractFinancingServlet.rendPaging(out, result,controller.getPagingURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class),parameter.getQueryString());%>
            </div>
	</div>
</div>

<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript">
	$(".pcjiang").hover(function(){
		$(this).find("div").show();
		},function(){
			$(this).find("div").hide();
			});
    var box = $(".zixun_box h2 span.fl");
    var showCon = $(".zixun_list");
    var e;
    box.find("a").click(function () {
        e = $(this).index();
        box.find("a").removeClass("selected");
        $(this).addClass("selected");
		showCon.hide();
        showCon.eq(e).show();
		$(".zixun_box h2 span.fr a").hide();
		$(".zixun_box h2 span.fr a").eq(e).show();;
    });
</script>
</body>
</html>