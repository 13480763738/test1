<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.zqzr.Index"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.*"%>
<%@page import="com.jiudian.p2p.front.service.credit.*"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.xjd.*"%>
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
	LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
	LmoneyDecide lm = lmoneyManage.getLmoneyDecide( CreditType.XJD.name());
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
		controller.sendRedirect(request, response, controller.getURI(request, Xjd.class));
	}
	
	UserBaseManage userBaseManage = serviceSession.getService(UserBaseManage.class);
	UserBase data = userBaseManage.getUsebase();
	if(data==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
	String birthday = getBirthday(data.Idcard);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, UpdateBasemsg.class)%>"
		method="post" class="form1" >
		<input type="hidden" name="save" value="0"/>
		<div class="contain clearfix">
			<div class="w1002 top_title">
				<span class="fl"><a href="#">我要借款</a> &gt; <a href="#">薪金贷</a>
					&gt; 填写借款申请</span>
			</div>

			<!--step-->
			<div class="contain_main clearfix">
				<div class="ui_step ui_two"></div>
			</div>
			<%@include file="messagehead.jsp"%>
			<div class="about clearfix">
				<div class="sidebar fl">
					<ul class="barlist">
						<li class="first"></li>
						<li class="on"><a
							href="<%=controller.getURI(request, Basemessage.class)%>"><i></i>基本信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Familymessage.class)%>"><i></i>家庭信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Workmessage.class)%>"><i></i>工作信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Propertymessage.class)%>"><i></i>资产信息</a></li>
						<li><a
							href="<%=controller.getURI(request, Authormessage.class)%>"><i></i>其他信息</a></li>
					</ul>
				</div>
				<div class="container fr">
					<div class="public_tit">基本信息</div>
					<div class="loan_con clearfix">
						<ul>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>真实姓名：
								</div>
								<div class="info">
									<%
										StringHelper.filterHTML(out, data.Name);
									%>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>身份证号：
								</div>
								<div class="info">
									<p>
										<%
											String idcard = "";if(!StringHelper.isEmpty(data.Idcard)){idcard=data.Idcard.substring(0, 5)+"*************";}
										%><%=idcard%></p>
									<%
										AttestationState state = lmoneyManage.getAttentiontype(AttestationType.SFRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico1"></dt>
										<dd>
											<p class="f18">身份认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
													 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isidcard) && data.Isidcard.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico1"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">身份认证（必要认证）</p>
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
										<dt class="ico1"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">身份认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
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
										<dt class="ico1"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">身份认证（必要认证）</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'idCard','<%=controller.getViewURI(request, IdCard.class)%>','身份认证')"
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
									<i class="red mr5">*</i>手机号码：
								</div>
								<div class="info">
									<p><%if(!StringHelper.isEmpty(data.Phonenumber)){
										StringHelper.filterHTML(out, data.Phonenumber.substring(0, 3)+" **** "+data.Phonenumber.substring(8, 11));
									}else {%>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<%} %></p>
									<%
										state = lmoneyManage.getAttentiontype(AttestationType.SJSMRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico3"></dt>
										<dd>
											<p class="f18">手机实名认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
												 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isphone) && data.Isphone.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico3"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">手机实名认证</p>
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
										<dt class="ico3"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">手机实名认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
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
										<dt class="ico3"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">手机实名认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'phonenumber','<%=controller.getViewURI(request, Phone.class)%>','手机实名认证')"
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
									<i class="red mr5">*</i>性 别：
								</div>
								<div class="info">
									<%
										String sex = "";if(!StringHelper.isEmpty(data.Sex) && data.Sex.equals(Sextype.F.name())){sex=Sextype.F.getName();}
										if(!StringHelper.isEmpty(data.Sex) && data.Sex.equals(Sextype.M.name())){sex=Sextype.M.getName();}
									%>
									<%=sex%>
								</div>
							</li>
							<li>
								<div class="tit">出生日期：</div>
								<div class="info"><%=birthday%></div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr5">*</i>最高学历：
								</div>
								<div class="info">
									<select name="education" class="sel">
										<option <%if(!StringHelper.isEmpty(data.Education) && data.Education.equals("高中或以下")){%>
											selected="selected" <%}%>>高中或以下</option>
										<option <%if(!StringHelper.isEmpty(data.Education) && data.Education.equals("大专")){%>
											selected="selected" <%}%>>大专</option>
										<option <%if(!StringHelper.isEmpty(data.Education) && data.Education.equals("本科")){%>
											selected="selected" <%}%>>本科</option>
										<option <%if(!StringHelper.isEmpty(data.Education) && data.Education.equals("研究生或以上")){%>
											selected="selected" <%}%>>研究生或以上</option>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">入学年份：</div>
								<div class="info">
									<select name="scholldata" class="sel">
										<%
											for(int i=2014;i>=1900;i--){
										%>
										<option <%if(data.Schooldata==i){%> selected="selected" <%}%>
											value="<%=i%>"><%=i%></option>
										<%
											}
										%>
									</select>
								</div>
							</li>
							<li>
								<div class="tit">毕业院校：</div>
								<div class="info">
									<input name="school" type="text" value="<%StringHelper.filterHTML(out, data.School);%>" class="put01 max-length-20" />
									<p tip>不超过20个字</p>
									<p errortip class="" style="display: none"></p>

									<p class="clear"></p>
									<%
										state = lmoneyManage.getAttentiontype(AttestationType.XLRZ);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico2"></dt>
										<dd>
											<p class="f18">学历认证</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
												 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Iseducation) && data.Iseducation.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico2"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">学历认证</p>
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
										<dt class="ico2"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">学历认证</p>
											<p>
											<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
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
										<dt class="ico2"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">学历认证</p>
											<p>
											<a href="javascript:void(-1);" onclick="tcc(this,'Education','<%=controller.getViewURI(request, Education.class)%>','学历认证')"
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
									<i class="red mr5">*</i>籍 贯：
								</div>
								<input type="hidden" id="shengIdjg" value="<%if(!StringHelper.isEmpty(data.Jiguan)){StringHelper.filterHTML(out, data.Jiguan.substring(0,2)+"0000");}%>">
								<input type="hidden" id="shiIdjg" value="<%if(!StringHelper.isEmpty(data.Jiguan)){StringHelper.filterHTML(out, data.Jiguan.substring(0,4)+"00");}%>">
								<input type="hidden" id="xianIdjg" value="<%if(!StringHelper.isEmpty(data.Jiguan)){StringHelper.filterHTML(out, data.Jiguan);}%>">
								<div class="info">
									<select name="shengjg" class="sel01">
									</select> 
									<select name="shijg" class="sel01">
									</select>
									<select name="xianjg" class="sel01 required">
									</select>
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">
									<i class="red mr">*</i>户口所在地：
								</div>
								<input type="hidden" id="shengId" value="<%if(!StringHelper.isEmpty(data.Hkszd)){StringHelper.filterHTML(out, data.Hkszd.substring(0,2)+"0000");}%>">
								<input type="hidden" id="shiId" value="<%if(!StringHelper.isEmpty(data.Hkszd)){StringHelper.filterHTML(out, data.Hkszd.substring(0,4)+"00");}%>">
								<input type="hidden" id="xianId" value="<%if(!StringHelper.isEmpty(data.Hkszd)){StringHelper.filterHTML(out, data.Hkszd);}%>">
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
									<i class="red mr">*</i>居住地址：
								</div>
								<div class="info">
									<input name="region" type="text"
										value="<%StringHelper.filterHTML(out, data.Region);%>"
										class="put01 required max-length-30" />
									<p tip>不超过30个字</p>
									<p errortip class="" style="display: none"></p>
									<p class="clear"></p>
									<%
										state = lmoneyManage.getAttentiontype(AttestationType.JZDZM);
										if(state.equals(AttestationState.WYZ)){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico4"></dt>
										<dd>
											<p class="f18">居住证明</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
												 class="btn btn01" >立即认证</a>
											</p>
										</dd>
									</dl>
									<%
										}
									%>
									<%
										if(state.equals(AttestationState.YYZ) && !StringHelper.isEmpty(data.Isjuzhu) && data.Isjuzhu.equals(AttestationStatus.YYZ.name())){
									%>
									<dl class="yw_jcxx clearfix">
										<dt class="ico4"></dt>
										<dt class="ico13"></dt>
										<dd>
											<p class="f18">居住证明</p>
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
										<dt class="ico4"></dt>
										<dt class="ico15"></dt>
										<dd>
											<p class="f18">居住证明</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
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
										<dt class="ico4"></dt>
										<dt class="ico14"></dt>
										<dd>
											<p class="f18">居住证明</p>
											<p>
												<a href="javascript:void(-1);" onclick="tcc(this,'Address','<%=controller.getViewURI(request, Address.class)%>','居住证明')"
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
									<i class="red">*</i>居住地邮编：
								</div>
								<div class="info">
									<input name="postcode" type="text"
										value="<%StringHelper.filterHTML(out, data.Postcode);%>"
										class="put01 required isint min-length-6 max-length-6" />
									<p tip>须为6位数字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">居住地电话：</div>
								<div class="info">
									<input name="sta" type="text" class="put02 isint max-length-4"
										value="<%String sta = "";String end= "";if(!StringHelper.isEmpty(data.Cellnumber)) {
										if(data.Cellnumber.split("-").length>0){String s[] = data.Cellnumber.split("-");sta=s[0];end=s[1];}
										}%><%=sta%>" />&nbsp;<span style="float:left;">-</span>&nbsp;&nbsp;
										<input name="end" type="text" value="<%=end%>" class="put03 isint max-length-8" />
									<p tip>必须为数字</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</li>
							<li>
								<div class="tit">&nbsp;</div>
								<div class="info">
									<input type="submit" class="btn btn01 fl mr10 sumbitForme"
										value="下一步" fromname="form1" savefromname />
									<input type="submit" class="btn btn01 fl sumbitForme" fromname="form1" value="保存" />
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
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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
					return false;
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