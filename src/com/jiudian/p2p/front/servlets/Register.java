package com.jiudian.p2p.front.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.SessionManager;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.PasswordAuthentication;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.UserSourceStatus;
import com.jiudian.p2p.common.enums.UserType;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.front.service.common.entity.UserInsert;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.util.parser.EnumParser;

public class Register extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Session session = serviceSession.getSession();
		if (session != null && session.isAuthenticated()) {
			sendRedirect(request, response,
					getResourceProvider().getResource(ConfigureProvider.class)
							.format(URLVariable.USER_INDEX));
			return;
		}
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		
		String phone = request.getParameter("phone");
		
		UserManage userManage = serviceSession.getService(UserManage.class);
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		String verifyCode = request.getParameter("verifyCode");
		authentication.setVerifyCodeType("REGISTER"+phone);
		authentication.setVerifyCode(verifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			forwardView(request, response, Register.class);
			return;
		}
		final String accountName = request.getParameter("accountName");
		final String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		if (!password.equals(newPassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"两次密码输入不一致!");
			forwardView(request, response, Register.class);
			return;
		}
		
		UserInsert user = new UserInsert() {

			@Override
			public UserType getType() {
				return EnumParser.parse(UserType.class,
						request.getParameter("type"));
			}

			@Override
			public String getPassword() {
				return password;
			}

			@Override
			public String getCode() {
				return request.getParameter("code");
			}

			@Override
			public String getAccountName() {
				return accountName;
			}

			@Override
			public UserSourceStatus getUserSourceStatus() {
				return EnumParser.parse(UserSourceStatus.class,
						request.getParameter("userSourceStatus"));
			}

			@Override
			public String getPhone() {
				return request.getParameter("phone");
			}
			
			@Override
			public IsPass getXgmim() {
				return IsPass.F;
			}
		};
		int userId = userManage.addUser(user);
		if (userId > 0) {
			serviceSession.commit();
			PasswordAuthentication passwordAuthentication = new PasswordAuthentication();
			passwordAuthentication.setAccountName(accountName);
			passwordAuthentication.setPassword(newPassword);
			passwordAuthentication.setVerifyCodeType("abc");
			passwordAuthentication.setVerifyCode(session
					.getVerifyCode(passwordAuthentication.getVerifyCodeType()));
			
			session.checkIn(request, response, passwordAuthentication);
			request.setAttribute("userId", userId);
			
			
			//2014中秋活动体验金
			userManage.activity_1();
			
			//2014巡查员制活动体验金
			userManage.activity_4();
			
			
			
			userManage.activity_5();
			
			sendRedirect(request, response,
					getResourceProvider().getResource(ConfigureProvider.class)
							.format(URLVariable.USER_INDEX));
			
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable.getMessage());
		if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			forwardView(request, response, Register.class);
		} else if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			forwardView(request, response, Register.class);
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
