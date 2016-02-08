<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet"%>
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Bdxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.query.CreditAssignmentQuery"%>
<%@page import="com.jiudian.util.http.URLParameter"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentManage"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignmentCount"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignment"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Financing"%>
<html>
<head>
<%
	String _TITLE_ = "债权转让 - P2P理财 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/qltbStyle.jsp"%>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="m";static final String LEVEL_KEY="l";static final String MULTISELECT_KEY="s";%>
<%
	CreditAssignmentManage service = serviceSession.getService(CreditAssignmentManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	CreditAssignmentCount total=service.getStatistics();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY);
	PagingResult<CreditAssignment> results = service.getList(
	new CreditAssignmentQuery() {
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
	}, new Paging() {
		public int getCurrentPage() {
	return IntegerParser.parse(requestWrapper.getParameter("paging.current"));
		}
		public int getSize() {
	return 10;
		}
	});
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
 <div class="clear"></div>
  <!--全局-->
<div class="new-contant mt20 mb20 pb40">
<div class="project-list">

<div sup="Project" class="sub-nav">
    <div class="sub-nav-inner">
        <%@include file="/WEB-INF/include/list_header.jsp" %>
    </div>
</div><!--start: container -->
<div style="margin:0 auto;" class="wrap filter-wrap">
	<!--中间-->
	<div class="white-bg new-center pt20">
    <div class="container filter-container">
        <div class="filter-condition">
            <label>标的类型：</label>
            <ul class="filter-content">
            <%if(parameter.contains(TYPE_KEY)){parameter.remove(TYPE_KEY); %>
                <a href="<%=parameter.toString()%>"><li class="filter-item" data-href="#">全部</li></a>
            <%}else{%>
            	<a href="<%=parameter.toString()%>"><li class="filter-item active" data-href="#">全部</li></a>
            <%}%>
            <%for(InvestType type:InvestType.values()){if(parameter.contains(TYPE_KEY, type.name())){parameter.remove(TYPE_KEY, type.name());%>
                <li class="filter-item active" data-href="#"><%=type.getName()%></li>
                <li data-href="#"></li>
            <%} else { parameter.set(TYPE_KEY, type.name());%>
                <a href="<%=parameter.toString()%>"><li class="filter-item " data-href="#"><%=type.getName()%></li></a>
            <%}}%>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="filter-condition">
            <label>借款期限：</label>
            <ul class="filter-content">
            <%if(parameter.contains(TERM_KEY)){parameter.remove(TERM_KEY);%>
                <a href="<%=parameter.toString()%>"><li class="filter-item" data-href="#">全部</li></a>
            <%}else{%>
                <a href="<%=parameter.toString()%>"><li class="filter-item active" data-href="#">全部</li></a>
            <%}%>
            <%for(CreditTerm term:CreditTerm.values()){if(parameter.contains(TERM_KEY, term.name())){parameter.remove(TERM_KEY, term.name());%>
                <li class="filter-item active" data-href="#"><%=term.getName()%></li>
                <li data-href=""></li>
            <%}else { parameter.set(TERM_KEY, term.name()); %>
                <a href="<%=parameter.toString()%>"><li class="filter-item " data-href="#"><%=term.getName()%></li></a>
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

<%@include file="/WEB-INF/include/index/toolbar.jsp"%>

<div style=" background:none; height:700px; margin-top:42px;" class="content_part2 container">
     <p class="f18 dark_gray pl20 pb20">债权转让列表</p>
     <div class="biaodi">
        <div class="blank7"></div>
        <div class="biaodi_list">
        	 <div class="invest after">
        	   <table width="100%" cellspacing="0" align="center">
        	   <tbody>
        	     <tr class="all_bjs">
        	       <td name="tbname3bt"><table width="100%" cellspacing="0" align="center">
        	         <tbody>
        	           <tr style="color:#666;" class="big_tit">
        	             <td width="400" style="color:#666;"><span style="margin-left:-23px;">借款标题</span></td>
        	             <td width="150" style="color:#666;">年化收益率</td>
        	             <td width="150" style="color:#666;">剩余期限</td>
        	             <td width="150" style="color:#666;">债权价值</td>
                         <td width="150" style="color:#666;">转让价格</td>
                         <td width="150" style="color:#666;">剩余份额</td>
        	             <td width="170" class="end" style="color:#666;">状态</td>
      	             </tr>
      	             <%CreditAssignment[] creditAssignments=results.getItems();if(creditAssignments!=null){for (CreditAssignment creditAssignment : creditAssignments) {if (creditAssignment == null) {continue;}%>
        	           <tr class="all_bjs">
        	            <td width="400" height="64" style="border: medium none;">
        	               <%if(creditAssignment.creditType == CreditType.XYDB){%>
        	               <p><span class="ico <%if(creditAssignment.companyStatus!=null && creditAssignment.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico03"></span></p>
						   <%}else if(creditAssignment.creditType == CreditType.XJD || creditAssignment.creditType == CreditType.SYD ){%>
						   <p><span class="ico"></span><span class="ico ico01"></span></p>
						   <%}else if(creditAssignment.creditType == CreditType.SDRZ){%>
						   <p><span class="ico <%if(creditAssignment.companyStatus!=null && creditAssignment.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span>
						   <span class="ico ico02"></span></p><%}%>
				           <a class="title" title="<%=creditAssignment.title%>" href="<%=controller.getPagingItemURI(request,Bdxq.class,creditAssignment.zcId)%>"><%
				           StringHelper.filterHTML(out, StringHelper.truncation(creditAssignment.title, 7));%>
				           </a>
        	             </td>
        	             <td width="150" height="64" style="border: medium none;"><span class="f14"><%=Formater.formatRate(creditAssignment.rate,false)%>%</span> </td>
        	             <td width="150" height="64" style="border: medium none;"><span class="f14"><%=creditAssignment.syqx%>/<%=creditAssignment.jkqx%>个月</span></td>
        	             <td height="64" name="tbname2jd" style="border: medium none;"><span class="f18"><%=creditAssignment.zqjz%></span>元/份</td>
                         <td width="150" style="border: medium none;"><span class="f18"><%=creditAssignment.zrjg%></span>元/份</td>
                         <td width="150" style="border: medium none;"><span class="f18"><%=creditAssignment.syfs%></span>份</td>
        	             <td width="170" height="64" name="tbname2bt" style="border: medium none;">
        	             	<a class="toubiao btn01" href="<%=controller.getPagingItemURI(request,Bdxq.class,creditAssignment.zcId)%>">立即投标</a>
        	             </td>
      	             </tr>
        	         <%}}%>
      	           </tbody>
      	         </table>        	
        	   </td></tr></tbody>
        	   </table>
        	 </div>
             <div class="clear"></div>
             <div class="page_box">
             	<%AbstractFinancingServlet.rendPaging(out, results,controller.getPagingURI(request, com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index.class),parameter.getQueryString()); %>
             </div>
        </div> 
    </div>
</div>
</div>
</div></div>
</div>
<div class="clear"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/qltbScipt.jsp"%>
<script type="text/javascript">
	$(".pcjiang").hover(function(){
		$(this).find("div").show();
		},function(){
			$(this).find("div").hide();
			});
    var box = $(".biaodi h2 span.fl");
    var showCon = $(".biaodi_list");
    var e;
    showCon.find("li:first").find("a").addClass("newgif");
    box.find("a").hover(function () {
        e = $(this).index();
        box.find("a").removeClass("selected");
        $(this).addClass("selected");
		showCon.hide();
        showCon.eq(e).show();
		$(".biaodi h2 span.fr a").hide();
		$(".biaodi h2 span.fr a").eq(e).show();
		showCon.find("li:first").find("a").addClass("newgif");
    });
    
    $(function(){
		 var num=$(".djs_qgz").length;
		 for(i=0;i&lt;num;i++){
			 var percent=parseInt($(".djs_qgz_out").eq(i).find("span").text());
			var Wid=$(".djs_qgz_out").eq(i).width();
			var bg=Math.round(Wid-Wid*percent/100);
			var wid=Math.round(Wid-bg-$(".djs_qgz_out").eq(i).find("span").width()/2-1);
			$(".djs_qgz_out").eq(i).css("background-position",-bg+"px bottom");
			$(".djs_qgz_out").eq(i).find("span").css("left",wid+"px");
			 }
   	});
</script>
<script src="/js/a.js" type="text/javascript"></script>
<script type="text/javascript">window['JZ']={log:function(v){console&amp;&amp;console.log(v);}};seajs.config({base:'/res/',version:'2015051501',alias:{'calendar':'modules/calendar/1.0.0/calendar.js','validate':'modules/validate/1.0.0/validate.js','template':'modules/template/1.0.0/template.js','paging':'modules/paging/1.1.0/paging.js','timer':'modules/timer/1.0.0/timer.js','login':'modules/login/1.0.0/login.js','box':'modules/box/1.0.0/box.js','md5':'modules/md5/1.0.0/md5.js','combobox':'modules/combobox/1.0.0/combobox.js','format':'modules/format/1.0.0/format.js','lazyload':'modules/lazyload/1.0.0/lazyload.js','url':'modules/url/1.0.0/url.js'}});if(location.search.indexOf('debug')!=-1){seajs.config({debug:true});}$(function(){$('[role=tips]').tips();$('*[placeholder]').placeholder();});seajs.use(['modules/async_load/1.0.0/async_load'],function(async_load){});var G_HEAD_TIP_HANDLE=null;$('.js-header-service').on('mouseover',function(e){clearTimeout(G_HEAD_TIP_HANDLE);$('.js-header-service-tip').addClass('fn-hide');$(this).find('.js-header-service-tip').removeClass('fn-hide');}).on('mouseout',function(e){G_HEAD_TIP_HANDLE=setTimeout(function(){$('.js-header-service-tip').addClass('fn-hide');},500);});$(window).load(function(){var safeEle=$('&lt;script src="//static.anquan.org/static/outer/js/aq_auth.js" /&gt;'),vsafe=$('&lt;script src="http://static.anquan.org/static/outer/js/aq_auth.js" /&gt;');$('#hysafe').append(safeEle);$('#vsafe').append(vsafe);});/*201dce229094739199fe8b2d31be0da4*/</script>
</body>
</html>