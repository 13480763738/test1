package com.jiudian.p2p.front.servlets.p2pdaikuan.xjd;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.http.servlet.Controller;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.resource.ResourceProvider;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.CreditStatus;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.front.service.credit.LmoneyManage;
import com.jiudian.p2p.front.service.credit.entity.Lmoney;
import com.jiudian.p2p.front.service.credit.entity.LmoneyDecide;
import com.jiudian.p2p.front.service.credit.entity.LmoneyQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;

public class AddCredit extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		LmoneyManage lmoneyManage = serviceSession.getService(LmoneyManage.class);
		final ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		
		//查询当前用户是否可以新建借款
		LmoneyDecide lm = lmoneyManage.getLmoneyDecide("");
		
		if(IsPass.S.equals(lm.isPass)){
			//拉黑了
			sendRedirect(request, response, getController().getViewURI(request, Index.class)+"?erd=5");
			return ;
		}
		
		if(StringHelper.isEmpty(lm.isRegJin) || lm.isRegJin.equals(IsPass.F.name())){
			//跳转到开通第三方平台页面
			sendRedirect(request, response, configureProvider.format(URLVariable.QLTB_REG_URL));
			return ;
		}
		
		if(lmoneyManage.isyq()){
			//存在逾期不能借款
			sendRedirect(request, response, getController().getURI(request, Index.class)+"?erd=4");
		}
		
		//ID大于0则不能借款
		int oid = lm.id;
		if(oid !=0){
			//通过ID和状态查询，当前ID是否为新建类型，不是则提示以存在不能新建。
			Lmoney l = lmoneyManage.getLmoney(oid, CreditType.XJD.name());
			if(l != null){
				if(oid!=0 && l.id==0){
					sendRedirect(request, response, getController().getURI(request, Index.class)+"?erd=1");
					return ;
				}
				if(!l.Lstatus.equals(CreditStatus.SQZ.name())){
					sendRedirect(request, response, getController().getURI(request, Checkmessage.class));
					return;
				}
				sendRedirect(request, response, getController().getURI(request, Basemessage.class));
				return;
			}
		}
		LmoneyQuery query = new LmoneyQuery() {
			@Override
			public int getZqid() {
				return 0;
			}
			
			@Override
			public String getType() {
				return request.getParameter("getType");
			}
			
			@Override
			public String getTitle() {
				return request.getParameter("title");
			}
			
			@Override
			public BigDecimal getRating() {
				BigDecimal ds = new BigDecimal(request.getParameter("rating"));
				return ds;
			}
			
			@Override
			public String getPeriod() {
				return request.getParameter("hkzq");
			}
			
			@Override
			public BigDecimal getPcai() {
				return null;
			}
			
			@Override
			public BigDecimal getMoney() {
				BigDecimal m = new BigDecimal(request.getParameter("money"));
				return m;
			}
			
			@Override
			public String getLtype() {
				return CreditType.XJD.name();
			}
			
			@Override
			public int getLtime() {
				return  Integer.parseInt(configureProvider.getProperty(SystemVariable.LMONEY_DEADLINE));
			}
			
			@Override
			public String getLstatus() {
				String status = request.getParameter("status");
				if(StringHelper.isEmpty(status)){
					status = CreditStatus.SQZ.name();
				}
				return status;
			}
			
			@Override
			public String getLmuse() {
				return request.getParameter("creditus");
			}
			
			@Override
			public BigDecimal getLmmoney() {
				return null;
			}
			
			@Override
			public int getIsread() {
				int is = IntegerParser.parse(request.getParameter("isread"));
				return is;
			}
			
			@Override
			public int getId() {
				return IntegerParser.parse(request.getParameter("id"));
			}
			
			@Override
			public String getDescribe() {
				return request.getParameter("descride");
			}
			
			@Override
			public int getCtime() {
				int a = Integer.parseInt(request.getParameter("ctime"));
				return a;
			}
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}

			@Override
			public BigDecimal getOnemoney() {
				BigDecimal m = new BigDecimal(configureProvider.getProperty(SystemVariable.AUTO_BIDING_MULT_AMOUNT));
				return m;
			}

			@Override
			public BigDecimal getTbxe() {
				BigDecimal m = new BigDecimal(request.getParameter("tbxe"));
				return m;
			}
		};
		
		if(query.getId() == 0){
			lmoneyManage.addLmoney(query);
		}else{
			lmoneyManage.update(query);
		}
		request.setAttribute("type", query.getLtype());
		//跳转到填写借款信息页面
		sendRedirect(request, response, getController().getViewURI(request, Basemessage.class));
	}
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		getController().prompt(request, response, PromptLevel.ERROR,throwable.getMessage());
		final ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response, configureProvider.format(URLVariable.LOGIN));
		} else {
			getController().forward(request, response, getController().getViewURI(request, Xjd.class));
		}
	}
}
