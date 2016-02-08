package com.jiudian.p2p.front.servlets.p2pdaikuan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.SessionManager;
import com.jiudian.framework.service.ServiceSession;
public class Jkverify extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;


	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Session session = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		session.invalidVerifyCode(VERIFY_CODE_TYPE_GRJK);
		final String verifyCode = session.getVerifyCode(VERIFY_CODE_TYPE_GRJK);
		showKaptcha(COMMON_KAPTCHA_PRODUCER, verifyCode, response);
	}
}
