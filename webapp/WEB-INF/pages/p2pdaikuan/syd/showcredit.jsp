<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Index"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.Syd"%>
<%@page import="com.jiudian.p2p.front.service.credit.LmoneyManage"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Company"%>
<%@page import="com.jiudian.p2p.front.service.credit.CompanyManage"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Property"%>
<%@page import="com.jiudian.p2p.front.service.credit.PropertyMange"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Work"%>
<%@page import="com.jiudian.p2p.front.service.credit.WorkManage"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.Family"%>
<%@page import="com.jiudian.p2p.front.service.credit.FamilyManage"%>
<%@page import="com.jiudian.p2p.front.service.credit.UserBaseManage"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.UserBase"%>
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
<%!public static String getBirthday(String cardID) {
		StringBuffer tempStr = null;
		if (cardID != null && cardID.trim().length() > 0) {
			if (cardID.trim().length() == 15) {
				tempStr = new StringBuffer(cardID.substring(6, 12));
				tempStr.insert(4, '-');
				tempStr.insert(2, '-');
				tempStr.insert(0, "19");
			} else if (cardID.trim().length() == 18) {
				tempStr = new StringBuffer(cardID.substring(6, 14));
				tempStr.insert(6, '-');
				tempStr.insert(4, '-');
			}
		}
		return tempStr.toString();
	}%>
<%
		int id = 0;
		LmoneyManage lmoneyManage = serviceSession
				.getService(LmoneyManage.class);
		LmoneyDecide lm = lmoneyManage.getLmoneyDecide(CreditType.SYD.name());
		if (StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())) {
			controller.sendRedirect(request, response,controller.getViewURI(request, Index.class)+ "?erd=2");
			return;
			//跳转到实名认证页面
		}
		if (StringHelper.isEmpty(lm.password)) {
			controller.sendRedirect(request, response,controller.getViewURI(request, Index.class)+ "?erd=3");
			//跳转到设置体现密码页面
			return;
		}
		id = lm.id;
		if (id == 0) {
			controller.sendRedirect(request, response,
					controller.getURI(request, Syd.class));
		}
	
		UserBaseManage userBaseManage = serviceSession
				.getService(UserBaseManage.class);
		UserBase data = userBaseManage.getUsebase();

		FamilyManage family_Manage = serviceSession
				.getService(FamilyManage.class);
		Family family = family_Manage.getFamily();

		CompanyManage man_age = serviceSession.getService(CompanyManage.class);
		Company company = man_age.getCompany();

		PropertyMange property_Mange = serviceSession
				.getService(PropertyMange.class);
		Property property = property_Mange.getProperty();
		String birthday = getBirthday(data.Idcard);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
		<div class="contain clearfix">
			<div class="w1002 top_title">
				<span class="fl"><a href="#">我要贷款</a> &gt; <a href="#">薪金贷</a> &gt;
					审核 &gt; 借款信息预览</span>
			</div>
			<div class="contain_main clearfix">
				<div class="pub_title">借款信息预览</div>
				<div class="preview clearfix">
					<div class="pt10">申请人：<%StringHelper.filterHTML(out, data.Name);%></div>
					<div class="clearfix">
						<div class="tit">基本信息</div>
						<ul class="info clearfix">
							<li>性别：<%if("M".equals(data.Sex)){%>男<%}else{%>女<%}%></li>
							<li>最高学历：<%StringHelper.filterHTML(out, data.Education);%></li>
							<li>出生日期：<%StringHelper.filterHTML(out, birthday);%></li>
							<li>毕业院校：<%StringHelper.filterHTML(out, data.School);%></li>
							<li id="hkszd"></li>
							<li>身份证号：<%
											String idcard = "";if(!StringHelper.isEmpty(data.Idcard)){idcard=data.Idcard.substring(0, 2)+"*************";}
										%><%=idcard%></li>
							<li id="jzcs"></li>
							<li>居住地邮编：<%StringHelper.filterHTML(out, data.Postcode); %></li>
							<li>居住地电话：<%StringHelper.filterHTML(out, data.Cellnumber); %></li>
							<li>手机号码：<%
											String phpnenumber = data.Phonenumber;if(!StringHelper.isEmpty(phpnenumber)){phpnenumber=phpnenumber.substring(0, 3)+"****"+phpnenumber.substring(phpnenumber.length()-4, phpnenumber.length());}
										%><%StringHelper.filterHTML(out, phpnenumber);%></li>
							<li>居住地址：<%StringHelper.filterHTML(out, data.Region); %></li>
						</ul>
					</div>

					<div class="clearfix">
						<div class="tit clearfix">家庭信息</div>
						<ul class="info">
							<li>婚姻状况：<%if(!StringHelper.isEmpty(family.Marriagestatus) &&  family.Marriagestatus.equals(MarriageStatus.YH.name())){%>已婚 <%}%><%if(StringHelper.isEmpty(family.Marriagestatus) || family.Marriagestatus.equals(MarriageStatus.WH.name())){%>未婚<%}%></li>
							<li>有无子女：<%if(!StringHelper.isEmpty(family.Ischildren) && family.Ischildren.equals(IsHovestatus.Y.name())){%>有<%}%><%if(StringHelper.isEmpty(family.Ischildren) || family.Ischildren.equals(IsHovestatus.W.name())){%>无<%}%></li>
						</ul>
					</div>

					<div class="clearfix">
						<div class="tit clearfix">联系人信息</div>
						<ul class="info_one">
							<p class="f16 gray33">直系亲属</p>
							<li><%StringHelper.filterHTML(out, family.Zxname);%></li>
							<li><%StringHelper.filterHTML(out, family.Zxrelation);%></li>
							<li><%StringHelper.filterHTML(out, family.Zxphone);%></li>
							<p class="f16 gray33">其他联系人</p>
							<li><%StringHelper.filterHTML(out, family.Qtname);%></li>
							<li><%StringHelper.filterHTML(out, family.Qtrelation);%></li>
							<li><%StringHelper.filterHTML(out, family.Qtphone);%></li>
						</ul>
					</div>

					<div class="clearfix">
						<div class="tit">工作信息</div>
						<ul class="info">
							<li>公司名称：<%StringHelper.filterHTML(out, company.name);%></li>
							<li>公司类型：<%StringHelper.filterHTML(out, company.CompanyType);%></li>
							<li>职业状态：工薪阶层</li>
							<li>公司规模：<%String a = company.Companygm;if(a.equals("10")){a="10人以下";}else if(a.equals("500")){a="500人以上";}else{a+="人";}%><%=a%></li>
							<li>职位：<%StringHelper.filterHTML(out, company.Companyzy);%></li>
							<li>公司行业：<%StringHelper.filterHTML(out, company.Companyhy);%></li>
							<li id="gzcs"></li>
							<li>公司电话：<%StringHelper.filterHTML(out, company.Call);%></li>
							<li>公司经营年限：<%String c = company.Companytime;if(c.equals("1")){c="1年以下";}else if(c.equals("5")){c="5年以上";}else{c+="年";}%><%=c%></li>
							<li>公司地址：<%StringHelper.filterHTML(out, company.Address);%></li>
							<li>月收入：<%String b = company.Mmoney;if(b.equals("1000")){b="1000元以下";}else if(b.equals("50000")){b="50000元以上";}else{b+="元";}%><%=b%></li>
							<li>工作邮箱：<%StringHelper.filterHTML(out, company.Emil);%></li>
						</ul>
					</div>

					<div class="clearfix">
						<div class="tit">房产信息</div>
						<ul class="info">
							<li>有无房产：<%String ishouse = property.Ishouse; if(!StringHelper.isEmpty(ishouse) && ishouse.equals(IsHovestatus.Y.name())){%>有<%}%><%if(StringHelper.isEmpty(ishouse) || ishouse.equals(IsHovestatus.W.name())){%>无<%}%></li>
							<li>有无房产：<%String ishouselan = property.Ishouseloan; if(!StringHelper.isEmpty(ishouselan) && ishouselan.equals(IsHovestatus.Y.name())){%>有<%}%><%if(StringHelper.isEmpty(ishouselan) || ishouselan.equals(IsHovestatus.W.name())){%>无<%}%></li>
						</ul>
					</div>

					<div class="clearfix">
						<div class="tit clearfix">车辆信息</div>
						<ul class="info">
							<li>有无汽车：<%String iscar = property.Iscar;if(!StringHelper.isEmpty(iscar) && iscar.equals(IsHovestatus.Y.name())){%>有<%}%><%if(StringHelper.isEmpty(iscar) || iscar.equals(IsHovestatus.W.name())){%>无<%}%></li>
							<li>有无车贷：<%String iscarloan = property.Iscarloan;if(!StringHelper.isEmpty(iscarloan) && iscarloan.equals(IsHovestatus.Y.name())){%>有<%}%><%if(StringHelper.isEmpty(iscarloan) || iscarloan.equals(IsHovestatus.W.name())){%>无<%}%></li>
							
							<li>汽车品牌：<%StringHelper.filterHTML(out, property.qcpp);%></li>
				            <li>购车年份：<%=property.gcnf%></li>
				            <li>车牌号码：<%StringHelper.filterHTML(out, property.cphm);%></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript">
	$("#hkszd").html("户口所在地："+getctName('<%StringHelper.filterHTML(out, data.Hkszd);%>'));
	$("#jzcs").html("籍贯："+getctName('<%StringHelper.filterHTML(out, data.Jiguan);%>'));
	$("#gzcs").html("公司所在城市："+getctName('<%StringHelper.filterHTML(out, company.City);%>'));
	
	</script>
</body>
</html>