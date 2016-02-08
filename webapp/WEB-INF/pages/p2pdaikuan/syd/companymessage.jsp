<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index"%>
<%@page import="com.jiudian.p2p.front.service.credit.entity.LmoneyDecide"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.syd.*"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.*"%>
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
	if(StringHelper.isEmpty(lm.isSmrz) || lm.isSmrz.equals(AttestationStatus.WYZ.name())){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=2");
	return ;
		//跳转到实名认证页面
	}
	if(StringHelper.isEmpty(lm.password)){
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=3");
		//跳转到设置体现密码页面
		return;
	}
	id = lm.id;
	if(id==0){
		controller.sendRedirect(request, response, controller.getURI(request, Syd.class));
	}
	CompanyManage manage = serviceSession.getService(CompanyManage.class);
	Company data  = manage.getCompany();
	if(data==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, UpdateCompanymessage.class)%>"
		method="post" class="form1" >
		<input type="hidden" name="save" value="0"/>
		<div class="contain clearfix">
			<div class="w1002 top_title">
				<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">生意贷</a> &gt;
					填写借款申请</span>
			</div>

			<div class="contain_main clearfix">
				<div class="ui_step ui_two"></div>
			</div>

			<%@include file="messagehead.jsp"%>

			<div class="about clearfix">
				<div class="sidebar fl">
					<ul class="barlist">
						<li class="first"></li>
						<li><a
							href="<%=controller.getURI(request, Basemessage.class)%>"><i></i>基本信息</a></li>
						<li ><a
							href="<%=controller.getURI(request, Familymessage.class)%>"><i></i>家庭信息</a></li>
						<li class="on"><a
							href="<%=controller.getURI(request, Companymessage.class)%>"><i></i>公司信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Propertymessage.class)%>"><i></i>资产信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Authormessage.class)%>"><i></i>其他信息</a></li>
					</ul>
				</div>
				<div class="container fr">
					<div class="public_tit">公司信息填写</div>
					<div class="loan_con clearfix">
						<ul>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>职业状态：
								</div>
								<input type="hidden" name="status" value="<%=CompanyStatus.SYQYZ.name()%>">
								<div class="info">
									<%
										if(!StringHelper.isEmpty(data.Status) && data.Status.equals(CompanyStatus.SYQYZ.name())){
									%>
									<%=CompanyStatus.SYQYZ.getName() %>
									<%
										}
									%>											
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司名称：
								</div>
								<div class="info">
									<input name="name"
										value="<%StringHelper.filterHTML(out, data.name);%>"
										type="text" class="put01 required max-length-32" />
									<p tip>不超过32个字</p>
									<p errortip class="" style="display: none"></p>
									<!--立即认证-->
									<p class="clear"></p>
									<%
										AttestationState state = lmoneyManage.getAttentiontype(AttestationType.GSRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico6"></dt>
										<dd>
											<p class="f18">公司认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Companyr','<%=controller.getViewURI(request, Companyr.class)%>','公司认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isattestation) && data.Isattestation.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico6"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">公司认证（必要认证）</p>
											<p>
												<i class="btn btn06">通过</i>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.WTG)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico6"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">公司认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Companyr','<%=controller.getViewURI(request, Companyr.class)%>','公司认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.DSH)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico6"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">公司认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Companyr','<%=controller.getViewURI(request, Companyr.class)%>','公司认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司所在城市：
								</div>
								<input type="hidden" id="shengId" value="<%if(!StringHelper.isEmpty(data.City)){StringHelper.filterHTML(out, data.City.substring(0,2)+"0000");}%>">
								<input type="hidden" id="shiId" value="<%if(!StringHelper.isEmpty(data.City)){StringHelper.filterHTML(out, data.City.substring(0,4)+"00");}%>">
								<input type="hidden" id="xianId" value="<%if(!StringHelper.isEmpty(data.City)){StringHelper.filterHTML(out, data.City);}%>">
								<div class="info">
									<select name="sheng" class="sel01">
									</select> 
									<select name="shi" class="sel01">
									</select>
									<select name="xian" class="sel01 required">
									</select>
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司地址：
								</div>
								<div class="info">
									<input name="address" type="text"
										value="<%StringHelper.filterHTML(out, data.Address);%>"
										class="put01 required max-length-32" />
									<p tip>不超过32个字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司类别：
								</div>
								<div class="info">
									<select name="type" class="sel">
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("国家机关")){%>
											selected="selected" <%}%> value="国家机关">国家机关</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("事业单位")){%>
											selected="selected" <%}%> value="事业单位">事业单位</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("央企（包括下级单位）")){%>
											selected="selected" <%}%> value="央企（包括下级单位）">央企（包括下级单位）</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("地方国资委直属企业")){%>
											selected="selected" <%}%> value="地方国资委直属企业">地方国资委直属企业</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("世界500强（包括合资企业及下级单位）")){%>
											selected="selected" <%}%> value="世界500强（包括合资企业及下级单位）">世界500强（包括合资企业及下级单位）</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("外资企业（包括合资企业）")){%>
											selected="selected" <%}%> value="外资企业（包括合资企业）">外资企业（包括合资企业）</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("一般上市公司（包括国外上市）")){%>
											selected="selected" <%}%> value="一般上市公司（包括国外上市）">一般上市公司（包括国外上市）</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("一般民营企业")){%>
											selected="selected" <%}%> value="一般民营企业">一般民营企业</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.CompanyType.equals("个体经营者")){%>
											selected="selected" <%}%> value="个体经营者">个体经营者</option>
										<option
											<%if(!StringHelper.isEmpty(data.CompanyType) && data.Companyhy.equals("其他")){%>
											selected="selected" <%}%> value="其他">其他</option>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司行业：
								</div>
								<div class="info">
									<select name="Companyhy" class="sel">
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("制造业")){%>
											selected="selected" <%}%> value="制造业">制造业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("IT")){%>
											selected="selected" <%}%> value="IT">IT</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("政府机关")){%>
											selected="selected" <%}%> value="政府机关">政府机关</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("媒体/广告")){%>
											selected="selected" <%}%> value="媒体/广告">媒体/广告</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("零售/批发")){%>
											selected="selected" <%}%> value="零售/批发">零售/批发</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("教育/培训")){%>
											selected="selected" <%}%> value="教育/培训">教育/培训</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("公共事业")){%>
											selected="selected" <%}%> value="公共事业">公共事业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("交通运输业")){%>
											selected="selected" <%}%> value="交通运输业">交通运输业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("房地产业")){%>
											selected="selected" <%}%> value="房地产业">房地产业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("能源业")){%>
											selected="selected" <%}%> value="能源业">能源业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("金融/法律")){%>
											selected="selected" <%}%> value="金融/法律">金融/法律</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("餐饮/旅馆业")){%>
											selected="selected" <%}%> value="餐饮/旅馆业">餐饮/旅馆业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("医疗/卫生/保健")){%>
											selected="selected" <%}%> value="医疗/卫生/保健">医疗/卫生/保健</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("建筑工程")){%>
											selected="selected" <%}%> value="建筑工程">建筑工程</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("农业")){%>
											selected="selected" <%}%> value="农业">农业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("娱乐服务业")){%>
											selected="selected" <%}%> value="娱乐服务业">娱乐服务业</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("体育/艺术")){%>
											selected="selected" <%}%> value="体育/艺术">体育/艺术</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("公益组织")){%>
											selected="selected" <%}%> value="公益组织">公益组织</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companyhy) && data.Companyhy.equals("其他")){%>
											selected="selected" <%}%> value="其他">其他</option>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司规模：
								</div>
								<div class="info">
									<select name="Companygm" class="sel">
										<option
											<%if(!StringHelper.isEmpty(data.Companygm) && data.Companygm.equals("10")){%>
											selected="selected" <%}%> value="10">10人以下</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companygm) && data.Companygm.equals("10-100")){%>
											selected="selected" <%}%> value="10-100">10-100人</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companygm) && data.Companygm.equals("100-500")){%>
											selected="selected" <%}%> value="100-500">100-500人</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companygm) && data.Companygm.equals("500")){%>
											selected="selected" <%}%> value="500">500人以上</option>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>公司经营年限：
								</div>
								<div class="info">
									<select name="Companytime" class="sel">
										<option
											<%if(!StringHelper.isEmpty(data.Companytime) && data.Companytime.equals("1")){%>
											selected="selected" <%}%> value="1">1年（含以下）</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companytime) && data.Companytime.equals("1-3")){%>
											selected="selected" <%}%> value="1-3">1-3年（含）</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companytime) && data.Companytime.equals("3-5")){%>
											selected="selected" <%}%> value="3-5">3-5年（含）</option>
										<option
											<%if(!StringHelper.isEmpty(data.Companytime) && data.Companytime.equals("5")){%>
											selected="selected" <%}%> value="5">5年以上</option>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>月收入：
								</div>
								<div class="info">
									<select name="mmoney" class="sel">
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("1000")){%>
											selected="selected" <%}%> value="1000">1000元以下</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("1001-2000")){%>
											selected="selected" <%}%> value="1001-2000">1001-2000元</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("2000-5000")){%>
											selected="selected" <%}%> value="2000-5000">2000-5000元</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("5000-10000")){%>
											selected="selected" <%}%> value="5000-10000">5000-10000元</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("10000-20000")){%>
											selected="selected" <%}%> value="10000-20000">10000-20000元</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("20000-50000")){%>
											selected="selected" <%}%> value="20000-50000">20000-50000元</option>
										<option
											<%if(!StringHelper.isEmpty(data.Mmoney) && data.Mmoney.equals("50000")){%>
											selected="selected" <%}%> value="50000">50000元以上</option>

									</select>
									<p class="clear"></p>
									<%
										state = lmoneyManage.getAttentiontype(AttestationType.SRZM);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico8"></dt>
										<dd>
											<p class="f18">收入认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.IsMmoney) && data.IsMmoney.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico8"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">收入认证（必要认证）</p>
											<p>
												<i class="btn btn06">通过</i>
											</p>
										</dd>
									</dl>
									<%
										}
									%>

									<%
										if(state.equals(AttestationState.WTG)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico8"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">收入认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.DSH)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico8"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">收入认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Income','<%=controller.getViewURI(request, Income.class)%>','收入认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>职位：
								</div>
								<div class="info">
									<input name="post" type="text"
										value="<%StringHelper.filterHTML(out, data.Companyzy);%>"
										class="put01 required max-length-10" />
									<p tip>不超过10个字</p>
									<p errortip class="" style="display: none"></p>
									<p class="clear"></p>
									<%
										state = lmoneyManage.getAttentiontype(AttestationType.JSZCRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico7"></dt>
										<dd>
											<p class="f18">技术职称认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iscompanyzy) && data.Iscompanyzy.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico7"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">技术职称认证</p>
											<p>
												<i class="btn btn06" >通过</i>
											</p>
										</dd>
									</dl>
									<%
										}
									%>

									<%
										if(state.equals(AttestationState.WTG)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico7"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">技术职称认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.DSH)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico7"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">技术职称认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'JobTile','<%=controller.getViewURI(request, JobTile.class)%>','技术职称认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
								</div>
							</li>
							<li>
								<div class="tit"><i class="red mr5">*</i>公司电话：</div>
								<div class="info">
									<input name="sta" type="text" class="put02 required isint max-length-4"
										value="<%String sta = "";String end= "";if(!StringHelper.isEmpty(data.Call)) {
										if(data.Call.split("-").length>0){
											String s[] = data.Call.split("-");
											sta=s[0];
											end=s[1];}
										}%><%=sta%>" />&nbsp;<span style="float:left;">-&nbsp;</span>&nbsp;&nbsp;<input
										name="end" type="text" value="<%=end%>"
										class="put03 required isint max-length-8" />
									<p tip>必须为数字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit"><i class="red mr5">*</i>工作邮箱：</div>
								<div class="info">
									<input name="emil" type="text"
										value="<%StringHelper.filterHTML(out, data.Emil);%>"
										class="put01 required e-mail" />
									<p tip>输入邮箱地址</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">&nbsp;</div>
								<div class="info">
									<input type="submit" class="btn btn01 fl mr10 sumbitForme"
										value="下一步" fromname="form1" savefromname /> <input type="submit"
										class="btn btn01 fl sumbitForme" fromname="form1" value="保存" />
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>

		</div>

	</form>


	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript">
	function tcc(evn,tid,url,titl) {
		global_art = art.dialog.open(url,{
			id : tid,
			title : titl,
			opacity : 0.1,
			width : 783,
			height : 500,
			lock : true,
			close : function() {
				var iframe = this.iframe.contentWindow;
				var isupload = iframe.document.getElementById('isupload');
				if(isupload == null || "" == isupload || "undefind" == isupload){
					
				}
				if(isupload.value == "1"){
					
					$(evn).parent().parent().before('<dt class="ico14"></dt>');
				}
			}
		}, false);
		
	}
	</script>
</body>
</html>