package com.jiudian.p2p.front.servlets.m;

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
import com.jiudian.framework.resource.ResourceProvider;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.variables.defines.URLVariable;
import com.jiudian.ucpaas.sender.service.SendManage;
import com.jiudian.util.StringHelper;

public class SendVice extends AbstractFrontServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out=response.getWriter();
		String phone = request.getParameter("phone");
		final ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		
		Envionment envionment = configureProvider.createEnvionment();
		Session session = serviceSession.getSession();
		String senType = "REGISTER"+phone;
		String code = session.getVerifyCode(senType);
		envionment.set("code", code);
		UserManage userManage = serviceSession.getService(UserManage.class);
		if(!StringHelper.isEmpty(phone)){
			if(userManage.isPhone(phone)){
				StringBuilder sb = new StringBuilder();
				sb.append("[{'num':00,'msg':'");
				sb.append("手机号码已存在"+"'}]");
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
		try {
			userManage.updateSend(phone, code);
			SendManage manage =  serviceSession.getService(SendManage.class);
			manage.sendVoice(code, phone, 1);
			StringBuilder sb = new StringBuilder();
			sb.append("[{'num':02,'msg':'");
			sb.append("语音发送成功，请注意接听电话。"+"'}]");
			out.write(sb.toString());
		} catch (Throwable e) {
			StringBuilder sb = new StringBuilder();
			sb.append("[{'num':00,'msg':'");
			sb.append(e.getMessage()+"'}]");
			out.write(sb.toString());
		}finally{
			out.close();
		}
		
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
