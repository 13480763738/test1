<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Sjsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Sfzsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xybgsl"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Lmoney"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<html>
<head>
<%
String _TITLE_ = "薪金贷 - P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	String erd = request.getParameter("erd");
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	
	<div class="nav_box">
    	<div class="nav">
        	<a class="nav_title"  style="color:#515151;">网上贷款 ></a>
        	<span>
            	<a href="<%configureProvider.format(out,URLVariable.CREDIT_XJD);%>" class="selected">薪金贷</a>
                <a href="<%configureProvider.format(out,URLVariable.CREDIT_SYD);%>">生意贷</a>
            </span>
        </div>
    </div>
    <div class="center_box">
        <div class="center_all_border">
            <div class="center">
                <div class="syd_top_hf">
                    <p><img src="<%=controller.getStaticPath(request)%>/images/new_images/xjd.tit.jpg" alt="<%=_ALT%>"><span>( 适用工薪阶层 )</span></p>
                    <a href="<%=controller.getViewURI(request,com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.Xjd.class)%>" class="btn_hf">立即申请</a>
                </div>
            </div>
        </div>
    	<div class="center">
        	<div class="syd_center_hf">
            	<p style="font-size:24px; color:#515151;">申请条件</p>
                <p>&nbsp;</p>
                <p style="padding-left:25px;">•  22-55周岁的中国公民<br/>•  在现单位工作满3个月<br/>•  月收入2000以上</p>
                <p style="font-size:24px; color:#515151; padding-top:30px;">借款方式</p>
                <p>&nbsp;</p>
                <p style="padding-left:35px;">借 款 额 度： 3,000-500,000元<br/>
                借款年利 率： 10%-24% <a href="<%=controller.getViewURI(request, com.jiudian.p2p.front.servlets.p2pdaikuan.Jkjsq.class)%>"  target="_blank" class="lcjsq_ico_hf">借款计算器</a><br/>
                借 款 期 限： 3、6、9、12、15、18、24个月<br/>
                审 核 时 间： 1-3个工作日<br/>
                还 款 方 式： 1、等额本息，每月还款;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、每月还息到期还本<span style="font-size:12px;">（扣首期利息）</span>;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、每月还息到期还本<span style="font-size:12px;">（不扣首期利息）</span>。</p>
                <p style="font-size:24px; color:#515151; padding-top:30px;">费用说明</p>
                <p>&nbsp;</p>
                <p style="padding-left:35px; font-size:16px; font-weight:bold;">成交服务费</p>
                <p style="padding-left:35px;">用户成功借款后按照评定的信用等级会一次性的从所得借款中扣除一定的比例（0%-5%）作为成交服务费，该服务费将进入麒麟通宝 平台的风险备用金账户，专项用于麒麟通宝的本息保障计划。</p>
                <p style="padding-left:35px; padding-top:20px;"><span style="padding-bottom:10px; border-bottom:1px solid #e8e8e8;">信用等级<img src="<%=controller.getStaticPath(request)%>/images/new_images/star_txt.jpg" style="padding-left:50px;" alt="<%=_ALT%>"></span></p>
                <p style="padding-left: 35px; padding-top: 10px;"><span style="padding-left: 27px;">费率</span> 
                <em style="padding-left: 54px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)))%></em>
                <em style="padding-left: 47px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)))%></em>
                <em style="padding-left: 49px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)))%></em>
                <em style="padding-left: 49px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)))%></em>
                <em style="padding-left: 47px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)))%></em>
                <em style="padding-left: 48px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)))%></em>
                <em style="padding-left: 49px;"><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)))%></em>
                </p>
                <p style="padding-left:35px; font-size:16px; font-weight:bold; padding-top:20px;">账户管理费</p>
                <p style="padding-left:35px;">麒麟通宝将按照借款人的借款期限，每月向借款人收取其借款本金的<%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.LMONEY_SUCCESS_RATION)))%>作为借款管理费。</p>
                <p style="text-align:center; padding-top:50px; padding-bottom:100px;"><a href="<%=controller.getViewURI(request,com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.Xjd.class)%>" class="btn_hf">立即申请</a></p>
                <div class="syd_center_right_hf">
                	<p style="font-size:24px; color:#515151;">必要申请材料</p>
                    <p>&nbsp;</p>
                    <p style="padding-left:25px;">•&nbsp;&nbsp;&nbsp;身份证 <a  href="<%=controller.getViewURI(request, Sfzsl.class)%>" target="_blank" style="font-size:12px;  padding-left:10px;">查看示例</a></p>
                    <p style="padding-left:25px;">•&nbsp;&nbsp;&nbsp;个人征信报告<em style="font-size:12px;">（可去当地人民银行打印）</em> <a href="<%=controller.getViewURI(request, Xybgsl.class)%>" target="_blank" style="font-size:12px; padding-left:10px;">查看示例</a></p>
                    <p style="padding-left:25px;">•&nbsp;&nbsp;&nbsp;近3个月工资卡银行流水 <a href="<%=controller.getViewURI(request, Sjsl.class)%>" target="_blank" style="font-size:12px;  padding-left:10px;">查看示例</a></p>
                </div>
            </div>
        </div>
    </div>
    
		<div id="smrz" <%if(StringHelper.isEmpty(erd) || !"2".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('smrz');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">尚未完成<span class="red">实名认证、提现密码设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		<div id="txmm" <%if(StringHelper.isEmpty(erd) || !"3".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('txmm');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">尚未完成<span class="red">实名认证、提现密码设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		
		<div id="yqts" <%if(StringHelper.isEmpty(erd) || !"4".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yqts');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">您存在借款逾期，请先进行还款！</div>
			    </div>
			</div>
		</div>
		
		<div id="lh" <%if(StringHelper.isEmpty(erd) || !"5".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('lh');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">您的账户已被拉黑，有疑问请联系客服！</div>
			    </div>
			</div>
		</div>

		<div id="yycp" <%if(StringHelper.isEmpty(erd) || !"1".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog d_error w510" style="margin: -150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yycp');">
					<a href="javascript:hidebg('yycp');"></a>
				</div>
				<div class="con clearfix">
					<div class="borrowing clearfix"></div>
					<div class="borrowing clearfix">
						<p>您已申请过其他产品，不能再申请此产品！</p>
					</div>
					<div class="clear"></div>
					<div class="dialog_btn">
						<a href="javascript:hidebg('yycp');" class="btn btn05">关闭</a>
					</div>
				</div>
			</div>
		</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	function hrefs(type){
		<%String errytype="";if (jiudianSession == null || !jiudianSession.isAuthenticated()) {
			errytype = "dl";
		}%>
		if("dl" == "<%=errytype%>"){
			location.href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>";
			return false;
		}
		<%if(!"dl".equals(errytype)){
				LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
				int acount = serviceSession.getSession().getAccountId();
				LmoneyDecide lm = lmoneyManage.getLmoneyDecide( CreditType.SYD.name());
				if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
					errytype = "sm";
				}else if(StringHelper.isEmpty(lm.password)  || StringHelper.isEmpty(lm.phoneNumber)){
					errytype = "tx";
				}else if("".equals(errytype)){
					int id = lm.id;
					Lmoney lmoney = new Lmoney();
					if(id !=0){
						Lmoney l = lmoneyManage.getLmoney(id, CreditType.XJD.name());
						if(l != null){
							if(id!=0 && l.id==0){
								errytype = "xcp";		
							}
						}
						Lmoney l2 = lmoneyManage.getLmoney(id, CreditType.SYD.name());
						if(l2 != null){
							if(id!=0 && l2.id==0){
								errytype = "scp";	
							}
						}
					}
				}
				
			}%>
		if("xjd"==type){
			if("dl" == "<%=errytype%>"){
				return false;
			}else if("sm" == "<%=errytype%>"){
				$("#smrz").show();
				return false;
			}else if("tx" == "<%=errytype%>"){
				$("#txmm").show();
				return false;
			}else if("xcp" == "<%=errytype%>"){	
				$("#yycp").show();
				return false;
			}else{
				<%%>
				location.href="<%=controller.getViewURI(request,com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.Xjd.class)%>";
			}
		}
		if("syd"==type){
			if("dl" == "<%=errytype%>"){
				return false;
			}else if("sm" == "<%=errytype%>"){
				$("#smrz").show();
				return false;
			}else if("tx" == "<%=errytype%>"){
				$("#txmm").show();
				return false;
			}else if("scp" == "<%=errytype%>"){	
				$("#yycp").show();
				return false;
			}else{
				location.href="<%=controller.getViewURI(request,com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Syd.class)%>";
				}
			}
		}

		function hidebg(id) {
			$("#" + id).hide();
		}
	</script>
</body>
</html>
