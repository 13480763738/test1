package com.jiudian.p2p.front.servlets.p2pdaikuan.syd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.credit.FamilyManage;
import com.jiudian.p2p.front.service.credit.entity.FamilyQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.parser.IntegerParser;


public class UpdateFamilymsg extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		FamilyManage familyManage = serviceSession.getService(FamilyManage.class);
		FamilyQuery query =new FamilyQuery() {
			@Override
			public String getZxrelation() {
				return request.getParameter("zxrelation");
			}
			
			@Override
			public String getZxphone() {
				return request.getParameter("zxphone");
			}
			
			@Override
			public String getZxname() {
				return request.getParameter("zxname");
			}
			
			@Override
			public String getQtrelation() {
				return request.getParameter("qtrelation");
			}
			
			@Override
			public String getQtphone() {
				return request.getParameter("qtphone");
			}
			
			@Override
			public String getQtname() {
				return request.getParameter("qtname");
			}
			
			@Override
			public String getMarriagestatus() {
				return request.getParameter("marriage");
			}
			
//			@Override
//			public String getIsmarrige() {
//				return null;
//			}
			
			@Override
			public String getIschildren() {
				return request.getParameter("children");
			}
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}
		};
		familyManage.update(query);
		if(IntegerParser.parse(request.getParameter("save"))==0){
			sendRedirect(request, response, getController().getURI(request, Familymessage.class));
			getController().prompt(request, response, PromptLevel.ERROR,
					"保存贷款信息成功");
			return;
		}
		sendRedirect(request, response, getController().getURI(request, Companymessage.class));
	}
	
}
