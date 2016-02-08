<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.financing.entity.Tjvo"%>
<%@page import="com.jiudian.p2p.front.service.financing.MzbManage"%>
<html lang="en">
<head>
<%
		String _TITLE_ = "安全保障- P2P理财 - "+ configureProvider.getProperty(SystemVariable.SITE_NAME);
		String _KEYWORDS_ = "";
		String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_%></title>
<%@include file="/WEB-INF/include/wap/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_%>">
<meta name="description" content="<%=_DESCRIPTION_%>">
<%@include file="/WEB-INF/include/wap/style.jsp"%>
</head>
<%MzbManage manage = serviceSession.getService(MzbManage.class);
Tjvo tj = manage.getTj();
%>
<body>
<div id="wrap-all">
<%@include file="/WEB-INF/include/wap/index/header.jsp"%>
<%-- <div class="safe">
            <img alt="安全保障" src="<%=controller.getStaticPath(request) %>/wap/images/safe_bg.png" />
        </div>
        <div class="jiaoyitongji">
            <p>累计交易总额:<span>
			<%
    				double ljcje = tj.ljcje.doubleValue();
    	         	if(ljcje>=1000000000){
				    	%>
				      	   <%=Formater.formatAmount(ljcje/100000000)%>亿元
				      	<%
				      	   	}else if(ljcje>=10000 && ljcje <1000000000){
				      	   %>
				      		<%=Formater.formatAmount(ljcje/10000)%>万元
				      	<%
				      			}else{
				      		%>
				      		<%=Formater.formatAmount(tj.ljcje)%>元
				      	<%
		      			}%>
				</span><br/><br/>
				已为投资人赚取收益:<span><%
        		double fxbyj = tj.fxbyj.doubleValue();
                 	if(fxbyj>=100000000){
        			%>
		      	   <%=Formater.formatAmount(fxbyj/100000000)%>亿元
			      	<%
			      	   	}else if(fxbyj>=10000 && fxbyj <100000000){
			      	   %>
			      		<%=Formater.formatAmount(fxbyj/10000)%>万元
			      	<%
		      			}else{
		      		%>
		      		<%=Formater.formatAmount(tj.fxbyj)%>元
		      		<%
		      			}
		      		%></span></p>
        </div>
        <div class="tel"><p>全国免费客服热线:<%configureProvider.format(out, SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></p></div> --%>
<img alt="安全保障" src="<%=controller.getStaticPath(request) %>/wap/images/safe_mobile.png" />
 <%@include file="/WEB-INF/include/wap/index/footer.jsp"%> 
<%@include file="/WEB-INF/include/wap/script.jsp"%>
</div>
</body>
</html>