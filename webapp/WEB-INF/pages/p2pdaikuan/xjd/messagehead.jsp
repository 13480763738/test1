<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.*"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.*"%>
<%{
		//必须输入最大值
		double maxsize_a = 32;
		double count_a = 0;
		LmoneyManage lmoneyManage_a = serviceSession.getService(LmoneyManage.class);
		UserBaseManage user_BaseManage = serviceSession.getService(UserBaseManage.class);
		//基本信息
		String errormessage = "";
		String msg="你的基本信息没有填写完整！";
		UserBase base = user_BaseManage.getUsebase();
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
		if(!StringHelper.isEmpty(base.Region)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(base.Postcode)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.SFRZ))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(!StringHelper.isEmpty(base.Cellnumber)){count_a++;}
		//家庭信息
		msg="你的家庭信息没有填写完整！";
		FamilyManage family_Manage = serviceSession.getService(FamilyManage.class);
		Family family = family_Manage.getFamily();
		if(!StringHelper.isEmpty(family.Marriagestatus)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Ischildren)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxname)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxrelation)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Zxphone)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtname)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtrelation)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(family.Qtphone)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		//工作信息
		msg="你的工作信息没有填写完整！";
		WorkManage work_Manage = serviceSession.getService(WorkManage.class);
		Work work = work_Manage.getWork();
		if(!StringHelper.isEmpty(work.Status)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Name)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Post)){count_a++;}
		if(!StringHelper.isEmpty(work.Emil)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.City)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Address)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Type)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Profession)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Scale)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Gznew)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(work.Mmoney)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.GZRZ))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.SRZM))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		if(!StringHelper.isEmpty(work.Cellnumber)){count_a++;}
		//资产信息
		msg="你的资产信息没有填写完整！";
		PropertyMange property_Mange = serviceSession.getService(PropertyMange.class);
		Property property = property_Mange.getProperty();
		if(!StringHelper.isEmpty(property.Ishouse)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Ishouseloan)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Iscar)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		if(!StringHelper.isEmpty(property.Iscarloan)){count_a++;}else{
			if(StringHelper.isEmpty(errormessage)){errormessage=msg;}
		}
		
		if(AttestationState.WYZ.equals(lmoneyManage_a.getAttentiontype(AttestationType.XYBG))){
			if(StringHelper.isEmpty(errormessage)){errormessage="";}
		}
		
		double adouble = (count_a++/maxsize_a)*100;
		
		int a_a = Integer.parseInt(new java.text.DecimalFormat("0").format(adouble));
		controller.prompt(request, response, PromptLevel.ERROR, errormessage);
	%>
<div class="w1002 top_title">
	<span class="fl">信息完整度：</span>
	<div class="ui_plan_progress clearfix fl">
		<div class="progress_bar_bg">
			<div class="progress_bar_con" style="width:<%=a_a%>%;"></div>
		</div>
		<div class="percentage"><%=a_a%>%</div>
	</div>
	<span class="fr">温馨提示：<i class="red">*</i>
		为必填项和必要认证项，所有资料均会严格保密。
	</span>
</div>
<%}%>