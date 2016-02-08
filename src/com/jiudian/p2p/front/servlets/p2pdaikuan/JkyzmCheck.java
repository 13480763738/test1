package com.jiudian.p2p.front.servlets.p2pdaikuan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.service.ServiceSession;

public class JkyzmCheck extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		try{
			Session session = serviceSession.getSession();
			String verifyCode=request.getParameter("verifyCode");
			VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
			authentication.setVerifyCode(verifyCode);
			authentication.setVerifyCodeType(VERIFY_CODE_TYPE_GRJK);
			session.authenticateVerifyCode(authentication);
			response.getWriter().write("ZQ"); 
			response.getWriter().flush();
		}catch (Throwable t) {
			response.getWriter().write("SB");
			response.getWriter().flush();
		}
	}
	
}
