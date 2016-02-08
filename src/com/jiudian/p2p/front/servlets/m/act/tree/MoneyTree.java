package com.jiudian.p2p.front.servlets.m.act.tree;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.activity.ActivityManage;
import com.jiudian.p2p.front.servlets.m.AbstractFrontServlet;

public class MoneyTree extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			ActivityManage manage = serviceSession.getService(ActivityManage.class);
			boolean flag = manage.getTreeMoney();
			if(flag){
				getController().prompt(request, response, PromptLevel.WARRING,"恭喜您，领到一颗摇钱树，<br/>升级为财神爷,<br/>赶快给你的小伙伴们发红包吧！");
			}
		} catch (Throwable e) {
			getController().prompt(request, response, PromptLevel.ERROR,e.getMessage());
		}
		sendRedirect(request, response, getController().getViewURI(request, MoneyTree.class));
	}
	
}
