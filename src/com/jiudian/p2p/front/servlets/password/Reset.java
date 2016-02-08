package com.jiudian.p2p.front.servlets.password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.PasswordManage;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;

public class Reset extends AbstractPasswordServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		String code = request.getParameter("code");

		if (StringHelper.isEmpty(password) || password.length() > 16
				|| password.length() < 6) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"密码格式输入有误");
			forward(request, response,
					getController().getViewURI(request, Reset.class));
			return;
		}
		if (!password.equals(repassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"两次输入不符");
			forward(request, response,
					getController().getViewURI(request, Reset.class));
			return;
		}
		Session session = serviceSession.getSession();
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		authentication.setVerifyCode(code);
		authentication.setVerifyCodeType(PASSWORD_VERIFY_CODE_TYPE);
		session.authenticateVerifyCode(authentication);
		int id = IntegerParser.parse(session
				.getAttribute("PASSWORD_ACCOUNT_ID"));
		if (id <= 0) {
			sendRedirect(request, response,
					getController().getViewURI(request, Index.class));
			return;
		}
		PasswordManage passwordManage = serviceSession
				.getService(PasswordManage.class);
		passwordManage.updatePassword(password, id);

		sendRedirect(request, response,
				getController().getViewURI(request, Success.class));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof AuthenticationException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"校验码已过期或输入校验码错误");
			forward(request, response,
					getController().getViewURI(request, Reset.class));
		}
	}

}
