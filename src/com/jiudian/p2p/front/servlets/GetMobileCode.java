package com.jiudian.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.SessionManager;
import com.jiudian.framework.message.sms.SmsSender;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.variables.defines.MsgVariavle;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.p2p.variables.defines.YzxVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;

public class GetMobileCode extends AbstractFrontServlet {
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
		Session session = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		session.invalidVerifyCode("MOBILECODE");
		int userId = IntegerParser.parse(request.getParameter("userId"));
		String mobile = request.getParameter("mobile");
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		SmsSender sender = serviceSession.getService(SmsSender.class);
		final String verifyCode = session.getVerifyCode("MOBILECODE");
		String template = configureProvider
				.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
		if (template == null) {
			template = "${code},请验证!";
		}
		Envionment envionment = configureProvider.createEnvionment();
		envionment.set("code", verifyCode);
		String channel = configureProvider.getProperty(SystemVariable.MSG_CHANNEL);
		int tempId = IntegerParser.parse(configureProvider.getProperty(YzxVariable.CODE));
		sender.send(channel,tempId,StringHelper.format(template, envionment),verifyCode,mobile);
		request.setAttribute("userId", userId);
		forward(request, response,
				getController().getViewURI(request, Register.class));
	}
}
