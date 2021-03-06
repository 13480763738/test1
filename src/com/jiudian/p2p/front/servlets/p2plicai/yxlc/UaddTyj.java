package com.jiudian.p2p.front.servlets.p2plicai.yxlc;

import java.io.IOException;

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
import com.jiudian.p2p.front.service.financing.FinancingPlanManage;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;
import com.jiudian.p2p.variables.defines.URLVariable;

public class UaddTyj extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
		service.addTyj(request.getParameter("tyjnum"));
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		getController().sendRedirect(request, response,  configureProvider.format(URLVariable.USER_TYJ));
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		
		ResourceProvider resourceProvider = getResourceProvider();
		
		getController().prompt(request, response, PromptLevel.ERROR,throwable.getMessage());
		
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					resourceProvider.getResource(ConfigureProvider.class)
							.format(URLVariable.LOGIN));
		} else {
			
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			resourceProvider.log(throwable);
			
			getController().sendRedirect(request, response,  configureProvider.format(URLVariable.USER_INDEX));
			
		}
	}

}
