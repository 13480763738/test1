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
<%{
		//必须输入最大值
		double maxsize_a = 31;
		double count_a = 0;
		int acount_a = serviceSession.getSession().getAccountId();	
		UserBaseManage user_BaseManage = serviceSession.getService(UserBaseManage.class);
		LmoneyManage lmoneyManage_a = serviceSession.getService(LmoneyManage.class);
		//基本信息
		UserBase base = user_BaseManage.getUsebase();
		String errormessage = "";
		String msg="你的基本信息没有填写完整！";
		if(!StringHelper.isEmpty(base.Education)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(base.Schooldata!=0){count_a++;}
		if(!StringHelper.isEmpty(base.School)){count_a++;}
		if(!StringHelper.isEmpty(base.Jiguan)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(base.Hkszd)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(base.Region)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(base.Postcode)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.SFRZ))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(!StringHelper.isEmpty(base.Cellnumber)){count_a++;}
// 		if(AttestationState.WYZ.equals(lmoney))
		//家庭信息
		msg="你的家庭信息没有填写完整！";
		FamilyManage family_Manage = serviceSession.getService(FamilyManage.class);
		Family family = family_Manage.getFamily();
		if(!StringHelper.isEmpty(family.Marriagestatus)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Ischildren)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxname)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxrelation)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxphone)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtname)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtrelation)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtphone)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		//公司信息
		msg="你的公司信息没有填写完整！";
		CompanyManage man_age = serviceSession.getService(CompanyManage.class);
		Company company = man_age.getCompany();
		if(!StringHelper.isEmpty(company.name)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.City)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Address)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.CompanyType)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Companyhy)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Companygm)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Companytime)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Mmoney)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(company.Companyzy)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.GSRZ))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.SRZM))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(!StringHelper.isEmpty(company.Call)){count_a++;}
		if(!StringHelper.isEmpty(company.Emil)){count_a++;}
		
		//资产信息
		msg="你的资产信息没有填写完整！";
		PropertyMange property_Mange = serviceSession.getService(PropertyMange.class);
		Property property = property_Mange.getProperty();
		if(!StringHelper.isEmpty(property.Ishouse)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Ishouseloan)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Iscar)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Iscarloan)){count_a++;}
		else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.XYBG))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		
		double adouble = (count_a++/maxsize_a)*100;
		int a = Integer.parseInt(new java.text.DecimalFormat("0").format(adouble));
		
		controller.prompt(request, response, PromptLevel.ERROR, errormessage);
		
%>
<div class="w1002 top_title">
	<span class="fl">信息完整度：</span>
	<div class="ui_plan_progress clearfix fl">
		<div class="progress_bar_bg">
			<div class="progress_bar_con" style="width:<%=a%>%;"></div>
		</div>
		<div class="percentage"><%=a%>%</div>
	</div>
	<span class="fr">温馨提示：<i class="red">*</i>
		为必填项和必要认证项，所有资料均会严格保密。
	</span>
</div>
<%}%>