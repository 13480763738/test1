package com.jiudian.p2p.front.servlets.password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.message.email.EmailSender;
import com.jiudian.framework.message.sms.SmsSender;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.PasswordManage;
import com.jiudian.p2p.variables.defines.EmailVariavle;
import com.jiudian.p2p.variables.defines.MsgVariavle;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.p2p.variables.defines.YzxVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;

public class Index extends AbstractPasswordServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String verifyCode = request.getParameter("verifyCode");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		Session session = serviceSession.getSession();
		PasswordManage passwordManage = serviceSession
				.getService(PasswordManage.class);
		request.setAttribute("type", type);
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		if ("email".equals(type)) {
			if (StringHelper.isEmpty(email)) {
				request.setAttribute("EMAIL_ERROR", "邮箱地址不能为空");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			authentication.setVerifyCode(verifyCode);
			authentication.setVerifyCodeType(FIND_PASSWORD_EMAIL);
			session.authenticateVerifyCode(authentication);

			int id = passwordManage.emailExist(email);
			if (id <= 0) {
				request.setAttribute("EMAIL_ERROR", "邮箱未被注册");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			EmailSender emailSender = serviceSession
					.getService(EmailSender.class);
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			String tem = configureProvider
					.getProperty(EmailVariavle.FIND_PASSWORD);
			Envionment envionment = configureProvider.createEnvionment();
			session.invalidVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			envionment.set("code", code);
			emailSender.send(0, EmailVariavle.FIND_PASSWORD.getDescription(),
					StringHelper.format(tem, envionment), email);
			session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
			session.invalidVerifyCode(FIND_PASSWORD_EMAIL);
		} else if ("phone".equals(type)) {
			if (StringHelper.isEmpty(phone)) {
				request.setAttribute("PHONE_ERROR", "手机号码不能为空");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			authentication.setVerifyCode(verifyCode);
			authentication.setVerifyCodeType(FIND_PASSWORD_PHONE);
			session.authenticateVerifyCode(authentication);

			int id = passwordManage.phoneExist(phone);
			if (id <= 0) {
				request.setAttribute("PHONE_ERROR", "手机号码未被注册");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			SmsSender smsSender = serviceSession.getService(SmsSender.class);
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);

			String tem = configureProvider
					.getProperty(MsgVariavle.FIND_PASSWORD);
			Envionment envionment = configureProvider.createEnvionment();
			String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			envionment.set("code", code);
			
			String channel = configureProvider.getProperty(SystemVariable.MSG_CHANNEL);
			int tempId = IntegerParser.parse(configureProvider.getProperty(YzxVariable.CODE));
			smsSender.send(channel,tempId,StringHelper.format(tem, envionment),code,phone);
			session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
		} else {
			sendRedirect(request, response,
					getController().getViewURI(request, Index.class));
			return;
		}

		forward(request, response,
				getController().getViewURI(request, Reset.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if(throwable instanceof AuthenticationException){
			String type = request.getParameter("type");
			if("email".equals(type)){
				request.setAttribute("EMAIL_VERIFYCODE_ERROR", "验证码错误");
				forward(request, response,
						getController().getViewURI(request, Index.class));
			}else if("phone".equals(type)){
				request.setAttribute("PHONE_VERIFYCODE_ERROR", "验证码错误");
				forward(request, response,
						getController().getViewURI(request, Index.class));
			}
		}
	}
}
