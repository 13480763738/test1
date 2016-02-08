<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.AlsoMoney"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Xgzl"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestInfoManage"%>
<%@include file="/WEB-INF/include/wap/authenticatedSession.jsp"%>
<html lang="en">
<head>
<%
	String _TITLE_ = "散标投资 - P2P理财 - "
				+ configureProvider
						.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
		WAP_TITLE_NAME = "还款记录";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>

<%
	int id = IntegerParser.parse(request.getParameter("id"));
	InvestInfoManage creditManagePayment = serviceSession.getService(InvestInfoManage.class);
	AlsoMoney[] alsoMoneys = creditManagePayment.getAlso(id);
%>
<body>
	<div data-role="page">
		<%@include file="/WEB-INF/include/wap/header.jsp"%>

		<div data-role="content" class="qcontent">
			<div class="hkjl_box">
				<div class="hkjl_tit">
					<span> <a href="javascript:void(0);" class="selected">已还</a> <a href="javascript:void(0);">未还</a>
					</span>
				</div>
				<div class="tbjl_box">
					<ul>
						<li class="tit">
							<div class="tit01">实际还款日期</div>
							<div class="tit02">应还本息(元)</div>
							<div class="tit03">应付罚息(元)</div>
						</li>
					 	<%
							if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {if (alsoMoney == null || alsoMoney.status.equals(RepayStatus.WH)) {continue;}
						%>
						<li>
							<div class="tit01"><%=alsoMoney.sjhkTime==null?"--":DateParser.format(alsoMoney.sjhkTime) %></div>
							<div class="tit02">
								<span><%=alsoMoney.yhbx %></span>
							</div>
							<div class="tit03"><%=alsoMoney.yffx %></div>
						</li>
						<%}}%>
					</ul>
				</div>
				<div class="tbjl_box" style="display: none;">
					<ul>
						<li class="tit">
							<div class="tit01">合约还款日期</div>
							<div class="tit02">应还本息(元)</div>
							<div class="tit03">应付罚息(元)</div>
						</li>
						<%
							if (alsoMoneys != null) {for (AlsoMoney alsoMoney : alsoMoneys) {if (alsoMoney == null || alsoMoney.status.equals(RepayStatus.YH)) {continue;}
						%>
						<li>
							<div class="tit01"><%=DateParser.format(alsoMoney.hyhkrq) %></div>
							<div class="tit02">
								<span><%=alsoMoney.yhbx %></span>
							</div>
							<div class="tit03"><%=alsoMoney.yffx %></div>
						</li>
						<%}}%>
					</ul>
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/include/wap/index/footer.jsp"%>
	</div>

	<%@include file="/WEB-INF/include/wap/script.jsp"%>
	
	<script type="text/javascript">
	$(function(){
		 var box = $(".hkjl_tit");
	    var showCon = $(".tbjl_box");
	    var e;
	    box.find("a").hover(function () {
	        e = $(this).index();
	        box.find("a").removeClass("selected");
	        $(this).addClass("selected");
			showCon.hide();
	        showCon.eq(e).show();
		})
		});
	</script>
</body>
</html>