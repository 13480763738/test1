package com.jiudian.p2p.front.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.servlet.Controller;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.message.sms.SmsSender;
import com.jiudian.framework.resource.ResourceProvider;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.activity.entity.UserVo;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.variables.defines.MsgVariavle;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.p2p.variables.defines.YzxVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;

public class Sendt extends AbstractFrontServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out=response.getWriter();
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		SmsSender emailSender = serviceSession.getService(SmsSender.class);
		
		UserManage userManage = serviceSession.getService(UserManage.class);
		UserVo vo = userManage.getUser();
		String tem = "";
		final ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
			String senType = type+phone;
			if(!StringHelper.isEmpty(phone)){
				tem = configureProvider.getProperty(MsgVariavle.HFB_CODE);
				if(userManage.getSend(phone)>=10){
					StringBuilder sb = new StringBuilder();
					sb.append("[{'num':01,'msg':'");
					sb.append("该手机今日发送次数已达上限！"+"'}]");
					out.write(sb.toString());
					return;
				}
			}else{
				StringBuilder sb = new StringBuilder();
				sb.append("[{'num':04,'msg':'");
				sb.append("手机号码错误！"+"'}]");
				out.write(sb.toString());
				return;
			}
			Envionment envionment = configureProvider.createEnvionment();
			Session session = serviceSession.getSession();
			String code = session.getVerifyCode(senType);
			envionment.set("name", vo.name);
			envionment.set("sjh", vo.sjh);
			envionment.set("name", vo.name);
			envionment.set("code", code);
			
			userManage.updateSend(phone, code);
			String channel = configureProvider.getProperty(SystemVariable.MSG_CHANNEL);
			int tempId = IntegerParser.parse(configureProvider.getProperty(YzxVariable.CODE));
			emailSender.send(channel,tempId,StringHelper.format(tem, envionment),code,phone);
			
			StringBuilder sb = new StringBuilder();
			sb.append("[{'num':02,'msg':'");
			sb.append("恭喜您，短信发送成功，请您注意查收。"+"'}]");
			out.write(sb.toString());
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		PrintWriter out=response.getWriter();
		StringBuilder sb = new StringBuilder();
		sb.append("[{'num':03,'msg':'");
		sb.append(throwable.getMessage()+"'}]");
		out.write(sb.toString());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					resourceProvider.getResource(ConfigureProvider.class)
							.format(URLVariable.LOGIN));
		} 
		
	}
	
}
