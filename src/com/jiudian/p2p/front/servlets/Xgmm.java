package com.jiudian.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.jiudian.framework.http.servlet.Controller;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.util.StringHelper;

public class Xgmm extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		if (StringHelper.isEmpty(password)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"密码输不为空!");
			forwardView(request, response, Xgmm.class);
			return;
		}
		
		if (!password.equals(newPassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"两次密码输入不一致!");
			forwardView(request, response, Xgmm.class);
			return;
		}

		UserManage userManage = serviceSession.getService(UserManage.class);
		userManage.updatePassword(UnixCrypt.crypt(password,
				DigestUtils.sha256Hex(password)));

		Controller controller = getController();
		controller.forwardView(request, response, Xgmmcg.class);
	}

}
