package com.jiudian.p2p.front.servlets;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.activity.ActivityManage;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.util.StringHelper;

public class Hqyqm extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out = response.getWriter();
		// 校验对象
		if (!serviceSession.getSession().isAuthenticated()) {
			StringBuilder sb = new StringBuilder();
			sb.append("[{'num':0,'msg':'");
			sb.append("未登录" + "'}]");
			out.write(sb.toString());
			return;
		} else {
			UserManage userManage = serviceSession.getService(UserManage.class);
			ActivityManage actManage = serviceSession
					.getService(ActivityManage.class);
			// 我的服务码
			String yqm = userManage.getYqm();
			int t = actManage.getLottery2014Times();
			int a = actManage.getLottery2014Amt();

			StringBuilder sb = new StringBuilder();
			sb.append("[{'num':1,'msg':'");
			sb.append(yqm
					+ "','name':'"
					+ StringHelper.truncation(
							serviceSession.getService(UserManage.class)
									.getAccountName(), 6) + "','t':'" + t
					+ "','a':'" + a + "'}]");
			out.write(sb.toString());
			return;
		}

	}

}
