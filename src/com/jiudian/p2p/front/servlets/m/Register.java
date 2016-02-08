package com.jiudian.p2p.front.servlets.m;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.SessionManager;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.PasswordAuthentication;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.message.sms.SmsSender;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.UserSourceStatus;
import com.jiudian.p2p.common.enums.UserType;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.front.service.common.entity.UserInsert;
import com.jiudian.p2p.variables.defines.MsgVariavle;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.p2p.variables.defines.YzxVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;
import com.jiudian.util.parser.IntegerParser;

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
							.format(URLVariable.WAP_USER_INDEX));
			return;
		}
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}

		String phone = request.getParameter("phone");
		request.setAttribute("phone", phone);
		request.setAttribute("code", request.getParameter("code"));

		UserManage userManage = serviceSession.getService(UserManage.class);
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		String verifyCode = request.getParameter("verifyCode");
		authentication.setVerifyCodeType("REGISTER" + phone);
		authentication.setVerifyCode(verifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			forwardView(request, response, Register.class);
			return;
		}
		final String accountName = request.getParameter("accountName");
		String p = request.getParameter("password");
		String rePassword = request.getParameter("rePassword");
		final String password;
		final IsPass sgxgmm;
		if (StringHelper.isEmpty(p) && StringHelper.isEmpty(rePassword)) {
			p = accountName.substring(5);
			rePassword = p;
			sgxgmm = IsPass.S;
		} else {
			sgxgmm = IsPass.F;
		}
		password = p;

		if (!p.equals(rePassword)) {
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
				UserSourceStatus us = EnumParser.parse(UserSourceStatus.class,
						request.getParameter("userSourceStatus"));
				if (us == null) {
					us = UserSourceStatus.SJ;
				}
				return us;
			}

			@Override
			public String getPhone() {
				return request.getParameter("phone");
			}

			@Override
			public IsPass getXgmim() {
				return sgxgmm;
			}
		};
		int userId = userManage.addUser(user);
		if (userId > 0) {
			if (sgxgmm.equals(IsPass.S)) {
				final ConfigureProvider configureProvider = ResourceRegister
						.getResourceProvider(getServletContext()).getResource(
								ConfigureProvider.class);
				SmsSender sender = serviceSession.getService(SmsSender.class);
				Envionment envionment = configureProvider.createEnvionment();
				envionment.set("password", p);
				String tem = configureProvider
						.getProperty(MsgVariavle.LOGIN_PSW);
				
				String channel = configureProvider.getProperty(SystemVariable.MSG_CHANNEL);
				int tempId = IntegerParser.parse(configureProvider.getProperty(YzxVariable.LOGIN_PSW));;
				sender.send(channel,tempId,StringHelper.format(tem, envionment),StringHelper.truncation(phone, 7, "****"),phone);
			}
			serviceSession.commit();
			PasswordAuthentication passwordAuthentication = new PasswordAuthentication();
			passwordAuthentication.setAccountName(accountName);
			passwordAuthentication.setPassword(rePassword);
			passwordAuthentication.setVerifyCodeType("abc");
			passwordAuthentication.setVerifyCode(session
					.getVerifyCode(passwordAuthentication.getVerifyCodeType()));

			session.checkIn(request, response, passwordAuthentication);
			request.setAttribute("userId", userId);

			// 2014中秋活动体验金
			userManage.activity_1();

			// 2014巡查员制活动体验金
			userManage.activity_4();

			userManage.activity_5();

			sendRedirect(request, response,
					getResourceProvider().getResource(ConfigureProvider.class)
							.format(URLVariable.WAP_USER_INDEX));

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
