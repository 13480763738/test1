package com.jiudian.p2p.front;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.servlet.Controller;
import com.jiudian.framework.http.servlet.PackageRewriter;
import com.jiudian.framework.http.servlet.Rewriter;
import com.jiudian.framework.http.session.SessionManager;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.PasswordAuthentication;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.P2PSystemDefine;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.common.UserManage;

public class FrontDefine extends P2PSystemDefine implements FrontConst {

	protected final Rewriter rewriter;

	public FrontDefine() {
		super();
		schemas.put(SessionManager.class, DB_USER_SESSION);
		rewriter = new PackageRewriter("com.jiudian.p2p.front.servlets");
	}

	@Override
	public String getGUID() {
		return "cf6332b0-eb3b-4061-8fc7-1fba9e1a8581";
	}

	@Override
	public int readAccountId(ServiceSession serviceSession, String condition,
			String password) throws AuthenticationException, SQLException {
		UserManage userManage = serviceSession.getService(UserManage.class);
		return userManage.readAccountId(condition, password);
	}

	@Override
	public void writeLog(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession,
			PasswordAuthentication authentication, int accountId) {
		UserManage userManage = serviceSession.getService(UserManage.class);
		Controller controller = serviceSession.getController();
		String ip = controller.getRemoteAddr(request);
		try {
			userManage.log(accountId, ip);
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}

	@Override
	public Rewriter getRewriter() {
		return rewriter;
	}
}
