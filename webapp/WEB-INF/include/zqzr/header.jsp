

<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Sbtzxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditAssignment"%>
<%@page import="com.jiudian.p2p.common.enums.TermType"%>
<%@page import="com.jiudian.p2p.common.enums.CompanyStatus"%>
<%@page import="com.jiudian.p2p.common.enums.CreditType"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<%@page import="com.jiudian.p2p.front.servlets.Term"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.UserInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.UserInfoManage"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.jiudian.p2p.front.service.financing.CreditAssignmentManage"%>
<%
	CreditAssignmentManage service = serviceSession.getService(CreditAssignmentManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	CreditAssignment caInfo= service.get(id);
	if(caInfo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND );
		return;
	}
	
	int jkbId=caInfo.jkbId;
	BigDecimal tbMoney=new BigDecimal(0);
	int syfs=caInfo.syfs;
	int fs=0;
	BigDecimal zxMoney = new BigDecimal(0);
%>
	<div sup="Project" class="sub-nav">
	    <div class="sub-nav-inner">
	        <%@include file="/WEB-INF/include/list_header.jsp" %>
	    </div>
	</div>
    
    <div class="center">
    	<div class="plan_given_hf">
        	<ul class="plan_given_left">
        		<li>
        		<div class="pr80_hf">
					<span class="spanfs36" style=" height:56px; display:block; width:800px;"><%StringHelper.filterHTML(out, caInfo.title);%></span>     		
				</div>
        		<div class="pr100_hf"><em class="emfs18">¥</em><span class="spanfs36"><%=Formater.formatAmount(caInfo.zrjg)%></span>
            	<br/>转让价格（元/份）</div><div class="pr80_hf"><span class="spanfs36"><%=Formater.formatRate(caInfo.rate,false)%></span>
            	<em class="emfs18">%</em><br/>年利率</div><div class="pr30_hf" style="margin-right:0px;">
            	<%if(CreditCycle.AYHK.equals(caInfo.creditCycle)){%><span class="spanfs36"><%=caInfo.syqx%></span>
            	<em class="emfs18" style="font-family:微软雅黑;">/<%=caInfo.jkqx%>个月</em>
       			   <%}if(CreditCycle.TB.equals(caInfo.creditCycle)){%><span class="spanfs36"><%=caInfo.jkqx%></span>
       			   <em class="emfs18" style="font-family:微软雅黑;">天</em>
       			   <%}if(CreditCycle.MB.equals(caInfo.creditCycle)){%>
				<em class="emfs18" style="font-family:微软雅黑;">满额即还</em><%}%>
				<br/>剩余期限</div></li>
                <li>
                	<div class="list01_hf w119">原借款标</div>
                    <div class="list02_hf w258"><a class="blue" href="<%=controller.getPagingItemURI(request, Sbtzxq.class,jkbId)%>"><%StringHelper.filterHTML(out, caInfo.title);%></a></div>
                    <div class="list01_hf w119">下一还款日</div>
                    <div class="list01_hf"><span><%=Formater.formatDate(caInfo.nexthk) %></span></div>
                </li>
                <li>
                	<div class="list01_hf w119">保障方式</div>
                    <div class="list02_hf w258"><em>
                    <%if(caInfo.creditType== CreditType.XJD || caInfo.creditType == CreditType.SYD){%>本金<%
            		}else if(caInfo.creditType== CreditType.SDRZ || caInfo.creditType == CreditType.XYDB){%>本息 <% } %></em>
                        <span id="span1" class="bg1 allbg" style="background-position: 3px -14px;"></span>
                        <div id="bj1" class="allbj" style="padding-left: 10px; display: none;">
                          <span class="bj_span1" style="margin-left: -9px;"></span>
                          <span class="bj_span2">详情请参见<a style="color:#176fa7;padding:0 5px" href="<%=controller.getPagingItemURI(request, Term.class, TermType.BXBZ.name())%>" target="_blank">本息保障计划</a></span>
                     </div>
            		</div>
                    <div class="list01_hf w119">待收本息</div>
                    <div class="list01_hf"><em class="fl"><%=Formater.formatAmount(caInfo.yjsy.multiply(new BigDecimal(100)).divide(caInfo.ystzje).add(new BigDecimal(100))) %>元/份</em></div>
                </li>
                <li>
                	<div class="list01_hf w119">逾期情况</div>
                    <div class="list02_hf w258">未发生逾期</div>
                    <div class="list01_hf w119">提前还款费率</div>
                    <div class="list01_hf"><%=Double.parseDouble(configureProvider.getProperty(SystemVariable.FANACING_PREPAYMENT_RATES))*100 %>%</div>
                </li>
                <li>
                	<div class="list01_hf w119">还款方式</div>
                    <div class="list02_hf w258"><em class="fl"><%=caInfo.hkfs.getName()%></em>
					<span id="span2" class="bg1 allbg" style="background-position: 3px -14px;"></span>
					<div id="bj2" class="allbj" style="display: none;padding-left:10px;">
							<span class="bj_span1" style="margin-left: -9px;"></span>
							<span class="bj_span2">
								<%if(TenderRepayment.MYHKDQHB2.equals(caInfo.hkfs)){ %>每月还息到期还本，还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时每期还息，最后一期还当期利息和全部本金。<%} %>
								<%if(TenderRepayment.DQYCXFQ.equals(caInfo.hkfs)){ %>到期一次性偿还本金和利息。<%} %>
								<%if(TenderRepayment.XYHK.equals(caInfo.hkfs)){ %>协议还款是平台为保障投资人收益采用的一种还款方式。协议还款是指依据投融资双方按照约定的还款计划进行还款，还款计划详情请查看标的详情。<%} %>
							</span>
						</div>
                    </div>
                <li>
            </ul>
            <div class="plan_given_right_hf zqxq_bg">
            <form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.TB_ZQZR);%>">
	          <input type="hidden" name="zcbId" id="zcbId" value="<%=id%>">
	          <input type="hidden" name="syfs" id="syfs" value="<%=syfs%>">
	          <input type="hidden" name="zrjg" id="zrjg" value="<%=caInfo.zrjg %>">
			  <input type="hidden" name="_zsy" id="_zsy" value="<%=caInfo.yjsy %>">	
			  <input type="hidden" name="_zje" id="_zje" value="<%=caInfo.ystzje%>">          
            
            	<%if(!(jiudianSession==null || !jiudianSession.isAuthenticated())){
					UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
					UserInfo userInfo= userInfoManage.search();
					String isYuqi =  userInfoManage.isYuqi();		
				%>
				<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
          			<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.kyMoney%>">
          			<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
					<input type="hidden" id="zqSucc" name="zqSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQYZR);%>">
				<div class="text01_hf" style="margin-top:83px;">
                	<h4>剩余份数</h4>
                    <p style="padding-top:8px; width:100%; float:left;">
                    <span style="font-size:22px;" class="fl"><%=syfs %></span><span style="font-size:14px; margin-top:8px;" class="fl">份</span></p>				
                    <p style="padding-top:10px; width:100%; float:left;">
                    <span style="font-size:14px;" class="fl">购买总需&nbsp;&nbsp;
                    <em style="font-size:18px;"><%=Formater.formatAmount(caInfo.zrjg.multiply(new BigDecimal(syfs))) %></em>元  </span></p>
                    <p style="padding-top:10px; width:100%; float:left;">
                    <span style="font-size:14px;" class="fl">可用金额&nbsp;&nbsp;
                    <em><%=userInfo.kyMoney==null?0:userInfo.kyMoney %></em>元</span><span class="fr">
                    <a class="cz_href_hf" href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" style="padding-right:10px;">充值</a></span></p>
                    <p style="padding-top:7px; width:100%; float:left; position:relative;">
                    <a class="left_btn" href="javascript:void(0)"></a>
                    <input name="amount" maxlength="10" type="text" class="text_input_hf" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)"  value="1" style="height: 37px;line-height: 37px;width: 167px;float:left; text-align:center;"/>
                    <a class="right_btn" href="javascript:void(0)"></a>
                    <span style="position:absolute; right:12px; top:15px; color:#fff; font-size:14px;">份</span></p>
                    <p style="padding-top:8px; width:100%; float:left;">预计收益<span class="cz_href_hf" id="tbMoney">0</span>元</p>
                    <p style="padding-top:28px; width:100%; float:left; text-align:center;">
                    <input type="button" id="tbButton" class="text_input01_hfs sumbitForme" fromname="form1" value="购&nbsp;&nbsp;买">
                    </p>
                </div>
               <%}else{%>
               <div class="text01_hf" style="margin-top:83px;">
                	<h4>剩余份数</h4>
                    <p style="padding-top:8px; width:100%; float:left;">
                    <span style="font-size:22px;" class="fl"><%=syfs %></span><span style="font-size:14px; margin-top:8px;" class="fl">份</span></p>				
                    <p style="padding-top:10px; width:100%; float:left;">
                    <span style="font-size:14px;" class="fl">购买总需&nbsp;&nbsp;<em style="font-size:18px;"><%=Formater.formatAmount(caInfo.zrjg.multiply(new BigDecimal(syfs))) %></em>元  </span></p>
                    <p style="padding-top:10px; width:100%; float:left;">
                    <span style="font-size:14px;" class="fl">可用金额&nbsp;&nbsp;
                    <a class="cz_href_hf" href="<%=controller.formatLogin(request, configureProvider.format(URLVariable.LOGIN)) %>">登录</a>后可见</span></p>
                    <p style="padding-top:7px; width:100%; float:left; position:relative;">
                   <a class="left_btn" href="javascript:void(0)"></a>
                    <input name="amount" maxlength="10" type="text" class="text_input_hf" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10));changelx(this)" onchange="changelx(this)"  value="1"  style="float:left; height:37px;line-height:37px; text-align:center;"/>
                    <a class="right_btn" href="javascript:void(0)"></a>
                    <span style="position:absolute; right:12px; top:15px; color:#fff; font-size:14px;">份</span></p>
                    <p style="padding-top:8px; width:100%; float:left;">预计收益<span class="cz_href_hf"  id="tbMoney">0</span>元</p>
                    <p style="padding-top:28px; width:100%; float:left; text-align:center;">
                    <a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="text_input01_hfs sumbitForme" style=" color:#fff;">购&nbsp;&nbsp;买</a>
                </div>
                
                <%}%>
             </form>  
            </div>
        </div>
    </div>
  
   
   <div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w510" style="margin:-150px 0 0 -255px; display: none;" >
	<div class="dialog_close fr"><a></a></div>
    <div class="con clearfix">
      <div class="d_succeed fl" style=" float:left;"></div>
      <div class="info fr" style=" float:left; width:88%;">
          <p class="f20 gray33">债权购买确认</p>
          您此次购买份数为<i class="red"><span id="fs"><%=fs%></span></i>份，转让价格<i class="red"><span id="mfjg"><%=caInfo.zrjg%></span></i>元，总需<i class="red"><span id="zxMoney"><%=zxMoney%></span></i>元
          <br/><input type="checkbox" checked="checked" value="1" class="m_cb selected" id="isread" name="isread" style="float:left;"><label style="font-size: 12px; float:left;">我已阅读并同意</label>
         <label for="iAgree" >
          <a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZQZRXY.name()) %>" style="font-size: 12px; float:left;" class="blue" >《债权转让及受让协议》</a>
          </label>
      </div>  
      <div class="clear" ></div>    
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn07">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn08">取 消</a></div> 
    </div>
</div>
