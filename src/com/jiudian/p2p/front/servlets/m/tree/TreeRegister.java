package com.jiudian.p2p.front.servlets.m.tree;

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
import com.jiudian.p2p.front.service.activity.ActivityManage;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.front.service.common.entity.UserInsert;
import com.jiudian.p2p.front.servlets.m.AEStest;
import com.jiudian.p2p.front.servlets.m.AbstractFrontServlet;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;
import com.jiudian.util.parser.IntegerParser;

public class TreeRegister extends AbstractFrontServlet {
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
		
		String phone = request.getParameter("accountName");
		String tree = request.getParameter("tree");
		UserManage userManage = serviceSession.getService(UserManage.class);
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		String verifyCode = request.getParameter("verifyCode");
		authentication.setVerifyCodeType("REGISTER"+phone);
		authentication.setVerifyCode(verifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			forwardView(request, response, TreeRegister.class);
			return;
		}
		final String accountName = request.getParameter("accountName");
		final String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		if (!password.equals(newPassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"两次密码输入不一致!");
			forwardView(request, response, TreeRegister.class);
			return;
		}
		
		if(StringHelper.isEmpty(tree)){
			getController().prompt(request, response, PromptLevel.ERROR,"参数错误!");
			forwardView(request, response, TreeRegister.class);
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
				if(us == null){
					us = UserSourceStatus.SJ;
				}
				return us;
			}

			@Override
			public String getPhone() {
				return request.getParameter("accountName");
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
			
			ActivityManage manage = serviceSession.getService(ActivityManage.class);
			int id =IntegerParser.parse(AEStest.deCrypt(AEStest.parseHexStr2Byte(tree),""));
			manage.getRedPacket(id,userId);
			
			sendRedirect(request, response,getController().getViewURI(request, ShowRedPacket.class)+"?tree="+tree);
			
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
			forwardView(request, response, TreeRegister.class);
		} else if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			forwardView(request, response, TreeRegister.class);
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
