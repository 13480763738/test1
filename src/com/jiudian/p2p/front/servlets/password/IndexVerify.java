package com.jiudian.p2p.front.servlets.password;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.servlets.AbstractFrontServlet;

public class IndexVerify extends AbstractPasswordServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

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
		String t = request.getParameter("t");
		Session session = serviceSession.getSession();
		String verifyCode = null;
		if ("e".equals(t)) {
			session.invalidVerifyCode(FIND_PASSWORD_EMAIL);
			verifyCode = session.getVerifyCode(FIND_PASSWORD_EMAIL);
		} else if ("p".equals(t)) {
			session.invalidVerifyCode(FIND_PASSWORD_PHONE);
			verifyCode = session.getVerifyCode(FIND_PASSWORD_PHONE);
		} else {
			return;
		}
		AbstractFrontServlet.showKaptcha(
				AbstractFrontServlet.COMMON_KAPTCHA_PRODUCER, verifyCode,
				response);
	}

}
