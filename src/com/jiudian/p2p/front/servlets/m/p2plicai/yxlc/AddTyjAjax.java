package com.jiudian.p2p.front.servlets.m.p2plicai.yxlc;

import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.financing.FinancingPlanManage;
import com.jiudian.p2p.front.servlets.m.AbstractFinancingServlet;
import com.jiudian.util.StringHelper;

public class AddTyjAjax extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out=response.getWriter();
		BigDecimal je = new BigDecimal(0);
		String msg = "";
		StringBuilder sb = new StringBuilder();
		if (!serviceSession.getSession().isAuthenticated()) {
			sb.append("[{'num':0,'msg':'");
			sb.append("未登录" + "'}]");
			out.write(sb.toString());
			return;
		}
		try {
			FinancingPlanManage service = serviceSession.getService(FinancingPlanManage.class);
			je = service.addTyj(request.getParameter("tyjnum"));
		} catch (Throwable e) {
			msg = e.getMessage();
		}
		
		if(StringHelper.isEmpty(msg)){
			sb.append("[{'num':1,'msg':'");
			sb.append(je.toString()+"'}]");
		}else{
			sb.append("[{'num':0,'msg':'");
			sb.append(msg+"'}]");
		}
		
		out.print(sb.toString());
	}
	
}
