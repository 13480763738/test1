package com.jiudian.p2p.front.servlets.m.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.front.servlets.m.AbstractFrontServlet;
import com.jiudian.util.StringHelper;

public class IdeaFeedback extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		String idea = request.getParameter("idea");
		String lxfs = request.getParameter("lxfs");
		try {
			if(StringHelper.isEmpty(idea)){
				getController().prompt(request, response, PromptLevel.ERROR,"不能为空");
			}else{
				if(idea.length()>190){
					getController().prompt(request, response, PromptLevel.ERROR,"超过字数限制");
				}
				else if(!StringHelper.isEmpty(idea)){
					UserManage userManage = serviceSession.getService(UserManage.class);
					userManage.addIdea(idea,lxfs);
					getController().prompt(request, response, PromptLevel.INFO,"感谢您的宝贵意见，您的建议是我们发展的动力！");
				}
			}
		} catch (Exception e) {
			getController().prompt(request, response, PromptLevel.ERROR,e.getMessage());
		}
		forward(request, response, getController().getViewURI(request, IdeaFeedback.class));
	}
	
}
