<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Basemessage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Checkmessage"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.AddCredit"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Lmoney"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<%
String _TITLE_ = "P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int id = 0;
	LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
	LmoneyDecide lm = lmoneyManage.getLmoneyDecide( CreditType.SYD.name());
	
	if(IsPass.S.equals(lm.isPass)){
		//拉黑了
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=5");
		return ;
	}
	
	if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
		//跳转到实名认证页面
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=2");
		return ;
	}
	
	if(StringHelper.isEmpty(lm.password) || StringHelper.isEmpty(lm.phoneNumber)){
		//跳转到设置体现密码页面
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=3");
		return;
	}
	
	if(lmoneyManage.isyq()){
		//当前用户存在逾期不能借款
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=4");
		return;
	}
	id = lm.id;
	Lmoney lmoney = new Lmoney();
	if(id !=0){
	Lmoney l = lmoneyManage.getLmoney(id, CreditType.SYD.name());
	if(l != null){
		if(id!=0 && l.id==0){
			controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=1");
			return ;
		}
		if(!l.Lstatus.equals(CreditStatus.SQZ.name())){
			controller.sendRedirect(request, response, controller.getURI(request, Checkmessage.class));
			return;
		}
		lmoney = l;
		controller.sendRedirect(request, response, controller.getURI(request, Basemessage.class));
		return;
	}}
	int money = 0;
	if(lmoney.money != null){
		BigDecimal bid = lmoney.money; 
		money= bid.intValue();
	}
	String errmes = controller.getPrompt(request, response,PromptLevel.ERROR);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, AddCredit.class)%>" class="form1"  method="post">
	<div class="contain clearfix">
		<div class="w1002 top_title">
			<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">生意贷</a> &gt;
				填写借款申请</span>
		</div>
		<input type="hidden" name="ltype"
			value="<%=CreditType.SYD.name()%>">
		<input type="hidden" name="id" value="<%=lmoney.id%>">
		<input type="hidden" name="status" value="<%StringHelper.filterHTML(out, lmoney.Lstatus);%>">
		<div class="contain_main clearfix">
			<div class="ui_step ui_one"></div>
		</div>

		<div class="contain_main clearfix">
			<div class="pub_title">填写借款申请</div>
			<span style="color: red;"><%StringHelper.filterHTML(out, errmes);%></span>
				<div class="loan_con ">
					<ul>
						<li>
							<div class="tit">借款标题：</div>
							<div class="info">
								<input name="title" type="text"
									class="put required max-length-14"
									value="<%StringHelper.filterHTML(out, lmoney.title);%>" />
								<p tip>不超过14个字</p>
								<p errortip class="" style="display: none"></p>
							</div>

						</li>
						<li>
							<div class="tit">借款用途：</div>
							<div class="info">
								<select name="creditus" class="sel">
									<option value="短期周转"
										<%if(StringHelper.isEmpty(lmoney.lmuse) || lmoney.lmuse.equals("短期周转")){%>
										selected="selected" <%}%>>短期周转</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("购房借款")){%>
										selected="selected" <%}%> value="购房借款">购房借款</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("购车借款")){%>
										selected="selected" <%}%> value="购车借款">购车借款</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("装修借款")){%>
										selected="selected" <%}%> value="装修借款">装修借款</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("婚礼筹备")){%>
										selected="selected" <%}%> value="婚礼筹备">婚礼筹备</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("教育培训")){%>
										selected="selected" <%}%> value="教育培训">教育培训</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("投资创业")){%>
										selected="selected" <%}%> value="投资创业">投资创业</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("医疗支出")){%>
										selected="selected" <%}%> value="医疗支出">医疗支出</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("其他借款")){%>
										selected="selected" <%}%> value="其他借款">其他借款</option>
									<option
										<%if(!StringHelper.isEmpty(lmoney.lmuse) && lmoney.lmuse.equals("个人消费")){%>
										selected="selected" <%}%> value="个人消费">个人消费</option>
								</select>
							</div>
						</li>
						<li>
							<div class="tit">借款金额：</div>
							<div class="info">
								<input name="money" type="text"
									class="put01 required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-3000 max-size-500000 jejs"
									value="<%if(money !=0){%><%=money %><%}%>" />元
								<p tip>借款金额范围3000-500000，且为<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%>的倍数</p>
								<p errortip class="" style="display: none"></p>
							</div>
						</li>
						<li>
							<div class="tit">每人投标限额：</div>
							<div class="info">
								<input name="tbxe" type="text" class="put01 required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-0 max-size-500000"
									value="0" />元
								<p tip>默认0元为不限额</p>
								<p errortip class="" style="display: none"></p>
							</div>
						</li>
						<li>
							<div class="tit">借款期限：</div>
							<div class="info">
								<label><input checked="checked" name="hkzq" value="<%=CreditCycle.AYHK.name() %>"  type="radio"/>按月</label>
								<label><input  type="radio" name="hkzq" value="<%=CreditCycle.TB.name() %>" />按天</label>
								<label><input  type="radio" name="hkzq" value="<%=CreditCycle.MB.name() %>" />秒标</label>
								<div class="showtime">
								</div>
								
							</div>
						</li>
						<li>
							<div class="tit">年利率：</div>
							<div class="info">
								<input name="rating" type="text" class="put01 required minf-size-10 maxf-size-24 jejs"  mtest="/^\d+(\d|(\.[0-9]{1}))$/" mtestmsg="只能有一位小数"  value="<%=lmoney.rating==null?"":lmoney.rating.doubleValue()*100 %>"/>%
								<p tip>利率精确到小数点后一位，范围10%-24%之间</p>
								<p errortip class="" style="display: none"></p>
								<p>借款最低利率由您的借款期限确定，一般来说借款利率越高，筹款速度越快。</p>
							</div>
						</li>
						<li>
							<div class="tit">还款方式：</div>
							<div class="info">
								<select name="getType" class="sel jejs">
								</select>
							</div>
						</li>
						<li>
							<div class="tit">筹标期限：</div>
							<div class="info"><%=configureProvider.getProperty(SystemVariable.LMONEY_DEADLINE)%>天
							</div>
						</li>
						<li id="mst2">
							<div class="tit" id="mst"></div>
							<div class="info"><span>¥</span><span style="display: block;" id="ms">0.00</span></div>
						</li>
						<li  id="mjt">
							<div class="tit">每月交借款管理费：</div>
							<div class="info"><span>¥</span><span id="mj">0.00</span></div>
						</li>
						<li>
							<div class="tit">成交服务费：</div>
							<div class="info">借款成功后按照借款金额的一定比例一次性从借款中扣除，实际费用比例参见下表，信用等级以审核最终评定为准。</div>
							<table border="0" cellspacing="0" class="ratetable">
								<tbody>
									<tr>
										<td width="15%">信用等级</td>
										<td>AA</td>
										<td>A</td>
										<td>B</td>
										<td>C</td>
										<td>D</td>
										<td>E</td>
										<td>HR</td>
									</tr>
									<tr>
										<td width="15%">费率</td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)))%></td>
										<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)))%></td>
									</tr>
									<tr>
										<td width="15%">实际费用</td>
										<td id="creaa" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)%>" >00</td>
										<td id="crea" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)%>" >00</td>
										<td id="creb" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)%>" >00</td>
										<td id="crec" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)%>" >00</td>
										<td id="cred" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)%>">00</td>
										<td id="cree" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)%>">00</td>
										<td id="crehr" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)%>">00</td>
									</tr>
								</tbody>
							</table>
						</li>
						<li>
							<div class="tit">借款描述：</div>
							<div class="info">
								<textarea name="descride" cols="" rows=""
									class="area required min-length-20 max-length-500"><%StringHelper.filterHTML(out, lmoney.describe);%></textarea>
								<p tip>输入20-500个字</p>
								<p errortip class="" style="display: none"></p>
								<p class="mt10">
									<input name="isread" checked="checked" type="checkbox" value="1" class="mr10" />我已阅读并同意签署<a class="blue" target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name())%>">《借款协议》</a>
								</p>
							</div>
						</li>
						<li>
							<div class="tit">&nbsp;</div>
							<div class="info">
								<input type="submit" class="btn btn01 sumbitForme" fromname="form1" value="保存并继续" />
							</div>
						</li>
					</ul>
				</div>
		</div>
	</div>
</form>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		$("#mst").html("每月还本息：");
		
		$(".showtime").html(
				'<select name="ctime" class="sel jejs">'+
				'<option selected="selected" value="1">1个月</option>'+
				'<option value="3">3个月</option>'+
				'<option value="6">6个月</option>'+
				'<option value="9">9个月</option>'+
				'<option value="12">12个月</option>'+
				'<option value="18">18个月</option>'+
				'<option value="24">24个月</option>'+
				'</select>'+
				'<p tip></p>'+
				'<p errortip class="" style="display: none"></p>'
				);
				
		 $("select[name='getType']").html(
				'<option value="<%=TenderRepayment.MYHKDQHB2.name() %>" >每月还款到期还本</option>'
			);
		
		$(".jejs").change( function() {
			var $envs = $(".jejs");
			var toal = $envs.eq(0).val();
		  	var money = 100;
		  	var size = toal/money;
		  	//借款期限
		  	var month = $envs.eq(1).val();
		  	//借款年利率
		  	var year = $envs.eq(2).val();
		  	
		  	if(money == ""){
		  		return false;
		  	}
		  	
	  	  var $creaa = $("#creaa");
		  var $crea =  $("#crea");
		  var $creb =  $("#creb");
		  var $crec =  $("#crec");
		  var $cred =  $("#cred");
		  var $cree =  $("#cree");
		  var $crehr =  $("#crehr");
		  $creaa.html((parseInt(money)*parseFloat($creaa.attr("fl"))*size).toFixed(2));
		  $crea.html((parseInt(money)*parseFloat($crea.attr("fl"))*size).toFixed(2));
		  $creb.html((parseInt(money)*parseFloat($creb.attr("fl"))*size).toFixed(2));
		  $crec.html((parseInt(money)*parseFloat($crec.attr("fl"))*size).toFixed(2));
		  $cred.html((parseInt(money)*parseFloat($cred.attr("fl"))*size).toFixed(2));
		  $cree.html((parseInt(money)*parseFloat($cree.attr("fl"))*size).toFixed(2));
		  $crehr.html((parseInt(money)*parseFloat($crehr.attr("fl"))*size).toFixed(2));
		  	
		  	if(money == "" || month == "" || year == ""){
		  		return false;
		  	}
		   var mln = (parseFloat(year)/12/100);
		   //不扣首期利息
		   if(hkfs == "<%=TenderRepayment.MYHKDQHB2.name()%>"){
			   $("#ms").html(parseFloat((parseFloat((mln*money)).toFixed(2))*size).toFixed(2));
		   }
		  
		   
		});
		
		$("select[name='getType']").change(function (){
			if($(this).val() == "<%=TenderRepayment.MYHKDQHB2.name()%>"){
			   $("#mst").html("每月还息：");
			   $("#mjt").hide();
				   
			}
		});
		
		
		$("input[name='hkzq']").change(function (){
			if($(this).val() == "<%=CreditCycle.AYHK.name()%>"){
				$(".showtime").html(
						'<select name="ctime" class="sel jejs">'+
						'<option selected="selected" value="1">1个月</option>'+
						'<option value="3">3个月</option>'+
						'<option value="6">6个月</option>'+
						'<option value="9">9个月</option>'+
						'<option value="12">12个月</option>'+
						'<option value="18">18个月</option>'+
						'<option value="24">24个月</option>'+
						'</select>'+
						'<p tip></p>'+
						'<p errortip class="" style="display: none"></p>'
				);
				$("select[name='getType']").html(
					'<option value="<%=TenderRepayment.MYHKDQHB2.name() %>" >每月还款到期还本</option>'
				);
				
				$("#mst2").show();
				$("#mjt").show();
				
			}
			if($(this).val() == "<%=CreditCycle.TB.name()%>"){
				$(".showtime").html(
						'<input name="ctime" type="text" style="float:left;" class="put01 required isint min-size-1" value="" /><span>天</span>'+
						'<p tip></p>'+
						'<p errortip class="" style="display: none"></p>'
				);
				$("select[name='getType']").html(
						'<option value="<%=TenderRepayment.DQYCXFQ.name() %>" selected="selected">到期一次性付清</option>'
					);
				$("#mst2").hide();
				$("#mjt").hide();
			}
			if($(this).val() == "<%=CreditCycle.MB.name()%>"){
				$(".showtime").html(
						'<select name="ctime" class="sel jejs">'+
						'<option selected="selected" value="1">0天</option>'+
						'</select>'+
						'<p tip></p>'+
						'<p errortip class="" style="display: none"></p>'
						);
				$("select[name='getType']").html(
						'<option value="<%=TenderRepayment.DQYCXFQ.name() %>" selected="selected">到期一次性付清</option>'
					);
				$("#mst2").hide();
				$("#mjt").hide();
			}
		});
	</script>
</body>
</html>