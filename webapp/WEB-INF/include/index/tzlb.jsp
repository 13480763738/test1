
<%@page import="com.jiudian.p2p.front.servlets.p2plicai.wytz.Bdxq"%>
<%@page import="com.jiudian.p2p.front.service.financing.query.InvestQuery"%>
<%@page import="com.jiudian.p2p.common.enums.PlanState"%>
<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<%@page import="com.jiudian.p2p.common.enums.CreditStatus"%>
<%@page import="com.jiudian.p2p.common.enums.CreditCycle"%>
<%@page import="com.jiudian.p2p.common.enums.RewardType"%>
<%@page import="com.jiudian.p2p.common.enums.CreditLevel"%>
<%@page import="com.jiudian.p2p.common.enums.CompanyStatus"%>
<%@page import="com.jiudian.p2p.common.enums.CreditType"%>
<%@page import="com.jiudian.p2p.front.servlets.xszy.Wylc"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.Rewards"%>
<%@page import="java.util.Date"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.FinancingPlanManage"%>
<%@page import="com.jiudian.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.jiudian.p2p.front.service.financing.entity.CreditInfo"%>
<%@page import="com.jiudian.p2p.front.service.financing.InvestManage"%>
<%{
	InvestManage investManage = serviceSession.getService(InvestManage.class);
%>

<div class="content_part2 container">
<!--      <p class="f18 dark_gray">投资列表</p> -->
     <div class="biaodi">
    	<h2>
        	<span class="fl">
            	<a class="selected" href="javascript:void(0)">投资理财</a>
                <a class="" href="javascript:void(0)"><%StringHelper.filterHTML(out, ProductType.ZQZR.getName()); %></a>
            </span>
        </h2>
        <div class="biaodi_list" style="display: block;">
        	 <div class="invest after">
        	   <table cellspacing="0" align="center" width="100%">
                	<tbody>
                    	<tr class="big_tit">
                          <td width="400" style="color:#666;"><span style="margin-left:-23px;">借款标题</span></td>
        	             <td width="150" style="color:#666;">年化收益率</td>
        	             <td width="150" style="color:#666;">金额</td>
        	             <td width="150" style="color:#666;">期限</td>
        	             <td width="150" style="color:#666;">进度</td>
        	             <td width="170" style="color:#666;" class="end">状态</td>
                       </tr>
                         <%
                         	PagingResult<CreditInfo> crePagingResult = investManage.search(new InvestQuery(){
                         		public InvestType[] getType(){
                         			return null;
                         		}
                         		public CreditTerm[] getTerm(){
                         			return null;
                         		}
                         		public RepaymentType[] getRepay(){
                         			return null;
                         		}
                         		public ProductType getProductType(){
                         			return null;
                         		}
                         	}, new Paging() {public int getCurrentPage() {return 0;}public int getSize() {return 4;}});
                             CreditInfo[] credits = crePagingResult.getItems();
                             if (credits != null) {
                            	 int i=1;
                            	 for (CreditInfo credit : credits) {
                         %>
                            <tr class="all_bjs">
                            	<td>
                            	<%
                            		if(credit.creditType == CreditType.XYDB){
                            	%>
                            	<p><span class="ico <%if(credit.companyStatus!=null && credit.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico03"></span></p>
                            	<%
                            		}else if(credit.creditType == CreditType.XJD || credit.creditType == CreditType.SYD ){
                            	%>
                            	<p><span class="ico "></span><span class="ico ico01"></span></p>
                            	<%
                            		}else if(credit.creditType == CreditType.SDRZ){
                            	%>
                            	<p><span class="ico <%if(credit.companyStatus!=null && credit.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico02"></span></p><%
                            		}
                            	%></span>
                            	<a class="title<%if("春".equals(credit.jlz)){%> chun<%}%>" title="<%StringHelper.filterHTML(out, credit.title);%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,credit.id)%>"><%
                            		StringHelper.filterHTML(out, StringHelper.truncation(credit.title, 13));
                            	%></a>
                            	<%
                            		if(!StringHelper.isEmpty(credit.jlz)&&credit.jlz.indexOf("%")>-1){
                            	%>
                            	<span class="percent"><%=credit.jlz%></span>
                            	<%
                            		}
                            	%>
                            	</td>
                                <td>
                                <span class="f24" style="color: #FF6000;" ><%=Formater.formatRate(credit.rate,false)%></span><span class="f18" style="color: #FF6000;" >%</span>
                                <%
                                	Rewards r = investManage.getRewards(credit.id);
                                                                
                                                                if(r != null){
                                %>
                                <span class="f18"  style="color: #D30203;">+<%=Formater.formatRate(r.jlbl, false)%>%<%
                                	int t=0;
                                                                String jlts = "";
                                                                if(RewardType.XSJ.equals(r.jllx)){
                                                                	t=1;
                                                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。";
                                                                }else if(RewardType.MTC.equals(r.jllx)){
                                                                	t=2;
                                                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内满标，放款后该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.TCJ.equals(r.jllx)){
                                                                	t=3;
                                                                	jlts="筹款开始后第一位投资用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                                                }else if(RewardType.XYJ.equals(r.jllx)){
                                                                	t=4;
                                                                	jlts="放款后，随机抽取该标的幸运投资用户，另享"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.THJ.equals(r.jllx)){
                                                                	t=5;
                                                                	jlts="该标的累计投资额度最高的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。";
                                                                }else if(RewardType.XRJ.equals(r.jllx)){
                                                                	t=6;
                                                                	jlts="首次在平台投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                                                }else if(RewardType.PHJ.equals(r.jllx)){
                                                                	t=7;
                                                                	jlts="放款后，该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.JBJ.equals(r.jllx)){
                                                                	t=8;
                                                                	jlts="若当次投资为您在平台投资的第"+r.xs+"~"+r.fz+"次，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。";
                                                                }
                                %><em class="pcjiang pcjiang0<%=t%>">
                                    <div class="pcjiang_content" style="display:none;">
                                    	<span class="bg"></span>
                                        <div class="pcjiang_txt">
                                        	<div class="pcjiang_txttop"></div>
                                            <div class="pcjiang_con">
                                            	<p><%
                                            		StringHelper.filterHTML(out, jlts);
                                            	%></p>
                                            </div>
                                            <div class="pcjiang_txtbottom"></div>
                                        </div>
                                    </div>
                                    </em>
                                </span>
                                <%
                                	}
                                %>
                                
                                </td>
                                <td>
                                <%
                                	if(credit.amount.doubleValue()>=10000){
                                %><span class="f18"><%=Formater.formatAmount(credit.amount.doubleValue()/10000)%></span><span class="f12">万元</span>
			            		<%
			            			}else{
			            		%><span class="f18"><%=Formater.formatAmount(credit.amount)%></span><span class="f12">元</span><%
			            			}
			            		%>
                                </td>
                                <td>
                                <%
                                	if(CreditCycle.AYHK.equals(credit.creditCycle)){
                                %><span class="f18"><%=credit.term%></span><span class="f12">个月</span> 
					       	    <%
 					       	    	}if(CreditCycle.TB.equals(credit.creditCycle)){
 					       	    %><span class="f18"><%=credit.term%></span><span class="f12">天</span> 
					       		<%
 					       			}if(CreditCycle.MB.equals(credit.creditCycle)){
 					       		%><span class="f18">秒标</span> <%
 	}
 %>
                                </td>
                                <%
                                	i++;
                                %>
                               
                                
                                <td name="tbname<%=i%>jd" ><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=credit.progress%>"><em><%=credit.progress%>%</em></strong></span></div></td>
                                <%
                                	if(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date())){
                                %>
	                            <script type="text/javascript">
	                            	tempendTime<%=i%>= parseInt(<%=credit.fbTime.getTime()-System.currentTimeMillis()%>);
	                            	tempname<%=i%> = "tbname<%=i%>";
	                            	sclearTime<%=i%> = setInterval(function() {
	                            		tempendTime<%=i%> = tempendTime<%=i%> - 1000;
	                            		time(tempname<%=i%>,tempendTime<%=i%>,sclearTime<%=i%>);
	                            	}, 1000);
	                            	
	                            </script>
	                            <%
	                            	}
	                            %>
	                             <td name="tbname<%=i%>" <%if(!(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                                <span class="f18" name="tbname<%=i%>hour">00</span>时
                                <span class="f18" name="tbname<%=i%>minute">00</span>分
                                <span class="f18" name="tbname<%=i%>second">00</span>秒
                                </td>
                                <td name="tbname<%=i%>bt" <%if((credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                                <%
                                	if(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date())){
                                %>
                                <span name="tbname<%=i%>span" class="toubiao btn02">敬请期待</span>
                                <a  name="tbname<%=i%>a" style="display:none;" href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,credit.id)%>" class="toubiao btn01">立即投标</a>
                                <%
                                	}else if(credit.status==CreditStatus.TBZ && !credit.fbTime.after(new Date())){
                                %><a href="<%=controller.getPagingItemURI(request, Bdxq.class,credit.id)%>" class="toubiao btn01">立即投标</a>
								<%}else if(credit.status==CreditStatus.YMB){ %><a href="javascript:void(0)" class="toubiao2 btn01">已满标</a>
								<%}else if(credit.status==CreditStatus.YFK){ %><a href="javascript:void(0)" class="toubiao2 btn01">还款中</a>
								<%}else if(credit.status==CreditStatus.YJQ){ %><a href="javascript:void(0)" class="toubiao2 btn01">已结清</a>
								<%}%>
                                </td>
                            </tr>
                            <%}}%>
                        
                        <%
	                        FinancingPlanManage financingPlanManage = serviceSession.getService(FinancingPlanManage.class);
	                		FinancingPlanInfo planInfo= financingPlanManage.getNewPlan();
	                		if(planInfo!=null)
	                		{
                        %>
                        <%if(planInfo!=null){ %>
                        <tr class="all_bjs">
                        	<td>
                        	<p><span class="ico05"></span></p>
                        	<a href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" title="体验金专区 <%StringHelper.filterHTML(out, planInfo.planTitle);%>" class="title">体验金专区 <%StringHelper.truncation(out, planInfo.planTitle,6);%></a>
                        	</td>
                            <td><span class="f24" style="color: #FF6000;" ><%=Formater.formatRate(planInfo.yqsy.doubleValue())%></span><span class="f18" style="color: #FF6000;" ></span></td>
                            <td><span class="f18">
                            <%if(planInfo.planMoney.doubleValue()>=10000){%><span class="f18"><%=Formater.formatAmount(planInfo.planMoney.doubleValue()/10000)%></span><span class="f12">万元</span>
			            	<%}else{%><span class="f18"><%=Formater.formatAmount(planInfo.planMoney)%></span><span class="f12">元</span><%}%>
                            </td>
                            <td>
                            <span class="f18"><%=planInfo.lockqx %></span><span class="f12">个月</span> 
	       	    			</td>
                            <td name="tyjname" <%if(!(planInfo.planState == PlanState.YFB && planInfo.fromSale.after(planInfo.currentTime))){%>style="display:none;"<%}%>>
                            <span class="f18" name="tyjnamehour">00</span>时
                            <span class="f18" name="tyjnameminute">00</span>分
                            <span class="f18" name="tyjnamesecond">00</span>秒
                            </td>
                            <td name="tyjnamejd" <%if((planInfo.planState == PlanState.YFB && planInfo.fromSale.after(planInfo.currentTime))){%>display:none;<%}%>">
                            <div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=planInfo.proess%>"><em><%=planInfo.proess%>%</em></strong></span></div>
                            </td>
                            <%
                              if(planInfo.planState == PlanState.YFB && planInfo.fromSale.after(planInfo.currentTime)){
                             %>
                            <script type="text/javascript">
                            	tempendTimetyj= parseInt(<%=planInfo.fromSale.getTime()-System.currentTimeMillis()%>);
                            	tempnametyj = "tyjname";
                            	sclearTimetyj = setInterval(function() {
                            		tempendTimetyj = tempendTimetyj - 1000;
                            		time(tempnametyj,tempendTimetyj,sclearTimetyj);
                            	}, 1000);
                            </script>
                            <%} %>
                            <td>
                            	<%
                                if(planInfo.planState == PlanState.YFB && planInfo.fromSale.after(planInfo.currentTime)){
                                %><span name="tyjnamespan" class="toubiao btn02">敬请期待</span>
                                <a name="tyjnamea" style="display:none;" href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" class="toubiao btn01">立即申请</a>
                                <%}else if(planInfo.planState == PlanState.YFB && !planInfo.fromSale.after(planInfo.currentTime)){ %>
                                <a href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" class="toubiao btn01">立即申请</a>
								<%}else if(planInfo.planState==PlanState.YSX){ %><a class="toubiao2 btn01" href="javascript:void(0)">已满额</a>
								<%}else if(planInfo.planState==PlanState.YJZ){ %><a class="toubiao2 btn01" href="javascript:void(0)">已截止</a>
								<%}%>
							</td>
                        </tr>
                        <%} %>
                        <%} %>
                        </tbody>
                </table>
        	 </div>
             <div class="f18 invest_more"  id="tabTzlc" style="cursor:pointer">+查看更多投资理财项目</div>
        </div>
        
        <div class="biaodi_list" style="display: none;">
        	 <div class="invest after">
        	   <table align="center" cellspacing="0" width="100%">
        	   <tbody>
        	     <tr class="all_bjs">
        	       <td name="tbname3bt"><table align="center" cellspacing="0" width="100%">
        	         <tbody>
        	           <tr class="big_tit" style="color:#666;">
        	             <td width="400" style="color:#666;"><span style="margin-left:-23px;">借款标题</span></td>
        	             <td width="150" style="color:#666;">年化收益率</td>
        	             <td width="150" style="color:#666;">金额</td>
        	             <td width="150" style="color:#666;">期限</td>
        	             <td width="150" style="color:#666;">进度</td>
        	             <td width="170" style="color:#666;" class="end">状态</td>
      	             </tr>
        	            <%
                         	PagingResult<CreditInfo> xwdPagingResult = investManage.search(new InvestQuery(){
                         		public InvestType[] getType(){
                         			return null;
                         		}
                         		public CreditTerm[] getTerm(){
                         			return null;
                         		}
                         		public RepaymentType[] getRepay(){
                         			return null;
                         		}
                         		public ProductType getProductType(){
                         			return ProductType.ZQZR;
                         		}
                         	}, AbstractFrontServlet.INDEX_PAGING);
                                                  		CreditInfo[] xwdcredits = xwdPagingResult.getItems();if (xwdcredits != null) {int i=1;for (CreditInfo credit : xwdcredits) {
                         %>
                            <tr class="all_bjs">
                            	<td>
                            	<%
                            		if(credit.creditType == CreditType.XYDB){
                            	%>
                            	<p><span class="ico <%if(credit.companyStatus!=null && credit.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico03"></span></p>
                            	<%
                            		}else if(credit.creditType == CreditType.XJD || credit.creditType == CreditType.SYD ){
                            	%>
                            	<p><span class="ico"></span><span class="ico ico01"></span></p>
                            	<%
                            		}else if(credit.creditType == CreditType.SDRZ){
                            	%>
                            	<p><span class="ico <%if(credit.companyStatus!=null && credit.companyStatus.equals(CompanyStatus.SYQYZ)){%>ico04<%}%>"></span><span class="ico ico02"></span></p><%
                            		}
                            	%></span>
                            	<a class="title<%if("春".equals(credit.jlz)){%> chun<%}%>" title="<%StringHelper.filterHTML(out, credit.title);%>" href="<%=controller.getPagingItemURI(request, Bdxq.class,credit.id)%>"><%
                            		StringHelper.filterHTML(out, StringHelper.truncation(credit.title, 13));
                            	%></a>
                            	<%
                            		if(!StringHelper.isEmpty(credit.jlz)&&credit.jlz.indexOf("%")>-1){
                            	%>
                            	<span class="percent"><%=credit.jlz%></span>
                            	<%
                            		}
                            	%>
                            	</td>
                                <td>
                                <span class="f24" style="color: #FF6000;"><%=Formater.formatRate(credit.rate,false)%></span><span class="f18" style="color: #FF6000;">%</span>
                                <%
                                	Rewards r = investManage.getRewards(credit.id);
                                                                
                                                                if(r != null){
                                %>
                                <span class="f18" style="color: #D30203;">+<%=Formater.formatRate(r.jlbl, false)%>%<%
                                	int t=0;
                                                                String jlts = "";
                                                                if(RewardType.XSJ.equals(r.jllx)){
                                                                	t=1;
                                                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对限定时间内的投标金额）。";
                                                                }else if(RewardType.MTC.equals(r.jllx)){
                                                                	t=2;
                                                                	jlts="筹款开始后"+r.xs+"小时"+r.fz+"分钟内满标，放款后该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.TCJ.equals(r.jllx)){
                                                                	t=3;
                                                                	jlts="筹款开始后第一位投资用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                                                }else if(RewardType.XYJ.equals(r.jllx)){
                                                                	t=4;
                                                                	jlts="放款后，随机抽取该标的幸运投资用户，另享"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.THJ.equals(r.jllx)){
                                                                	t=5;
                                                                	jlts="该标的累计投资额度最高的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对最高累计投标金额，若该金额有多个，则投标时间最早的获得投标奖励）。";
                                                                }else if(RewardType.XRJ.equals(r.jllx)){
                                                                	t=6;
                                                                	jlts="首次在平台投资的用户，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对第一笔投标金额）。";
                                                                }else if(RewardType.PHJ.equals(r.jllx)){
                                                                	t=7;
                                                                	jlts="放款后，该标的所有投资用户另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放。";
                                                                }else if(RewardType.JBJ.equals(r.jllx)){
                                                                	t=8;
                                                                	jlts="若当次投资为您在平台投资的第"+r.xs+"~"+r.fz+"次，放款后另享年化"+Formater.formatRate(r.jlbl, false)+"%投标奖励，奖励由平台分期发放（奖励只针对满足条件的第一笔投标金额）。";
                                                                }
                                %><em class="pcjiang pcjiang0<%=t%>">
                                    <div class="pcjiang_content" style="display:none;">
                                    	<span class="bg"></span>
                                        <div class="pcjiang_txt">
                                        	<div class="pcjiang_txttop"></div>
                                            <div class="pcjiang_con">
                                            	<p><%
                                            		StringHelper.filterHTML(out, jlts);
                                            	%></p>
                                            </div>
                                            <div class="pcjiang_txtbottom"></div>
                                        </div>
                                    </div>
                                    </em>
                                </span>
                                <%
                                	}
                                %>
                                
                                </td>
                                <td>
                                <%
                                	if(credit.amount.doubleValue()>=10000){
                                %><span class="f18"><%=Formater.formatAmount(credit.amount.doubleValue()/10000)%></span><span class="f12">万元</span>
			            		<%
			            			}else{
			            		%><span class="f18"><%=Formater.formatAmount(credit.amount)%></span><span class="f12">元</span><%
			            			}
			            		%>
                                </td>
                                <td>
                                <%
                                	if(CreditCycle.AYHK.equals(credit.creditCycle)){
                                %><span class="f18"><%=credit.term%></span><span class="f12">个月</span> 
					       	    <%
 					       	    	}if(CreditCycle.TB.equals(credit.creditCycle)){
 					       	    %><span class="f18"><%=credit.term%></span><span class="f12">天</span> 
					       		<%
 					       			}if(CreditCycle.MB.equals(credit.creditCycle)){
 					       		%><span class="f18">秒标</span> <%
 	}
 %>
                                </td>
                                <%
                                	i++;
                                %>
                                
                                <td name="tbname<%=i%>jd" ><div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=credit.progress%>"><em><%=credit.progress%>%</em></strong></span></div></td>
                                <%
                                	if(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date())){
                                %>
	                            <script type="text/javascript">
	                            	tempendTime<%=i%>= parseInt(<%=credit.fbTime.getTime()-System.currentTimeMillis()%>);
	                            	tempname<%=i%> = "tbname<%=i%>";
	                            	sclearTime<%=i%> = setInterval(function() {
	                            		tempendTime<%=i%> = tempendTime<%=i%> - 1000;
	                            		time(tempname<%=i%>,tempendTime<%=i%>,sclearTime<%=i%>);
	                            	}, 1000);
	                            	
	                            </script>
	                            <%
	                            	}
	                            %>
	                            <td name="tbname<%=i%>" <%if(!(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date()))){%>style="display:none;"<%}%>>
                                <span class="f18" name="tbname<%=i%>hour">00</span>时
                                <span class="f18" name="tbname<%=i%>minute">00</span>分
                                <span class="f18" name="tbname<%=i%>second">00</span>秒
                                </td>
                                <td name="tbname<%=i%>bt" <%if((credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date()))){%>style="display:none;"<%}%> >
                                <%
                                	if(credit.status==CreditStatus.TBZ && credit.fbTime.after(new Date())){
                                %>
                                <span name="tbname<%=i%>span" class="toubiao btn02">敬请期待</span>
                                <a  name="tbname<%=i%>a" style="display:none;" href="<%=controller.getPagingItemURI(request, com.jiudian.p2p.front.servlets.p2plicai.sbtz.Index.class,credit.id)%>" class="toubiao btn01">立即投标</a>
                                <%
                                	}else if(credit.status==CreditStatus.TBZ && !credit.fbTime.after(new Date())){
                                %><a href="<%=controller.getPagingItemURI(request, Bdxq.class,credit.id)%>" class="toubiao btn01">立即投标</a>
								<%}else if(credit.status==CreditStatus.YMB){ %><a href="javascript:void(0)" class="toubiao2 btn01">已满标</a>
								<%}else if(credit.status==CreditStatus.YFK){ %><a href="javascript:void(0)" class="toubiao2 btn01">还款中</a>
								<%}else if(credit.status==CreditStatus.YJQ){ %><a href="javascript:void(0)" class="toubiao2 btn01">已结清</a>
								<%}%>
                                </td>
                            </tr>
                            <%}}%>
                            
                            <%
	                        FinancingPlanManage zqzrPlanManage = serviceSession.getService(FinancingPlanManage.class);
	                		FinancingPlanInfo zrzrInfo= zqzrPlanManage.getNewPlan();
	                		if(zrzrInfo!=null)
	                		{
                        %>
                        <%if(zrzrInfo!=null){ %>
                        <tr class="all_bjs">
                        	<td style="border: medium none;">
                        	<p><span class="ico05"></span></p>
                        	<a href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" title="体验金专区 <%StringHelper.filterHTML(out, zrzrInfo.planTitle);%>" class="title">体验金专区 <%StringHelper.truncation(out, zrzrInfo.planTitle,6);%></a>
                        	</td>
                            <td style="border: medium none;"><span class="f24" style="color: #FF6000;" ><%=Formater.formatRate(zrzrInfo.yqsy.doubleValue())%></span><span class="f18" style="color: #FF6000;" ></span></td>
                            <td style="border: medium none;"><span class="f18">
                            <%if(zrzrInfo.planMoney.doubleValue()>=10000){%><span class="f18"><%=Formater.formatAmount(zrzrInfo.planMoney.doubleValue()/10000)%></span><span class="f12">万元</span>
			            	<%}else{%><span class="f18"><%=Formater.formatAmount(zrzrInfo.planMoney)%></span><span class="f12">元</span><%}%>
                            </td>
                            <td style="border: medium none;">
                            <span class="f18"><%=zrzrInfo.lockqx %></span><span class="f12">个月</span> 
	       	    			</td>
                            <td name="tyjname" <%if(!(zrzrInfo.planState == PlanState.YFB && zrzrInfo.fromSale.after(zrzrInfo.currentTime))){%>style="display:none;"<%}%>>
                            <span class="f18" name="tyjnamehour">00</span>时
                            <span class="f18" name="tyjnameminute">00</span>分
                            <span class="f18" name="tyjnamesecond">00</span>秒
                            </td>
                            <td name="tyjnamejd" style="border: medium none;<%if((zrzrInfo.planState == PlanState.YFB && zrzrInfo.fromSale.after(zrzrInfo.currentTime))){%>display:none;<%}%>">
                            <div class="pl30"><span class="ui-list-field"><strong class="ui-progressbar-mid ui-progressbar-mid-<%=zrzrInfo.proess%>"><em><%=zrzrInfo.proess%>%</em></strong></span></div>
                            </td>
                            <%
                              if(zrzrInfo.planState == PlanState.YFB && zrzrInfo.fromSale.after(zrzrInfo.currentTime)){
                             %>
                            <script type="text/javascript">
                            	tempendTimetyj= parseInt(<%=zrzrInfo.fromSale.getTime()-System.currentTimeMillis()%>);
                            	tempnametyj = "tyjname";
                            	sclearTimetyj = setInterval(function() {
                            		tempendTimetyj = tempendTimetyj - 1000;
                            		time(tempnametyj,tempendTimetyj,sclearTimetyj);
                            	}, 1000);
                            </script>
                            <%} %>
                            <td style="border: medium none;">
                            	<%
                                if(zrzrInfo.planState == PlanState.YFB && zrzrInfo.fromSale.after(zrzrInfo.currentTime)){
                                %><span name="tyjnamespan" class="toubiao btn02">敬请期待</span>
                                <a name="tyjnamea" style="display:none;" href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" class="toubiao btn01">立即申请</a>
                                <%}else if(zrzrInfo.planState == PlanState.YFB && !zrzrInfo.fromSale.after(zrzrInfo.currentTime)){ %>
                                <a href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>" class="toubiao btn01">立即申请</a>
								<%}else if(zrzrInfo.planState==PlanState.YSX){ %><a href="javascript:void(0)" class="toubiao2 btn01">已满额</a>
								<%}else if(zrzrInfo.planState==PlanState.YJZ){ %><a href="javascript:void(0)" class="toubiao2 btn01">已截止</a>
								<%}%>
							</td>
                        </tr>
                        <%} %>
                        <%} %>
                        
      	           </tbody>
      	         </table>        	
        	   </tbody>
        	   </table>
        	 </div>
        	 <div class="f18 invest_more pb30"  id="tabZqzr" style="cursor:pointer">+查看更多债权转让项目</div>
        </div>
        
  
        
    </div>
</div>
<%}%>
<script type="text/javascript">

	function time(timeid,sendTime,sclearTime) {
		var endTime = parseInt(sendTime);
		var leftsecond = parseInt(endTime / 1000);
		var day = Math.floor(leftsecond / (60 * 60 * 24)) < 0 ? 0 : Math
				.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0
				: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math
				.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0
				: Math
						.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600
				- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60
				* 60 - hour * 3600 - minute * 60);
		hour = hour + day*24;
		if (hour < 10) {
			hour = "0" + hour;
		}
		if (minute < 10) {
			minute = "0" + minute;
		}
		if (second < 10) {
			second = "0" + second;
		}
		
		$("span[name='"+timeid+"hour']").html(hour);
		$("span[name='"+timeid+"minute']").html(minute);
		$("span[name='"+timeid+"second']").html(second);
		if (leftsecond <= 0) {
			$("td[name='"+timeid+"jd']").show();
			$("td[name='"+timeid+"']").hide();
			$("span[name='"+timeid+"span']").hide();
			$("a[name='"+timeid+"a']").show();
			clearInterval(sclearTime);
		}
	}
</script>
