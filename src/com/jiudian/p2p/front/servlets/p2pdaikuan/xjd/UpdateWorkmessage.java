package com.jiudian.p2p.front.servlets.p2pdaikuan.xjd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.credit.WorkManage;
import com.jiudian.p2p.front.service.credit.entity.WorkQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;


public class UpdateWorkmessage extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		WorkManage workManage = serviceSession.getService(WorkManage.class);
		WorkQuery query = new WorkQuery() {
			@Override
			public String getType() {
				return request.getParameter("type");
			}
			
			@Override
			public String getStatus() {
				return request.getParameter("status");
			}
			
			@Override
			public String getScale() {
				return request.getParameter("scale");
			}
			
			@Override
			public String getProfession() {
				return request.getParameter("profession");
			}
			
			@Override
			public String getPost() {
				return request.getParameter("post");
			}
			
			@Override
			public String getName() {
				return request.getParameter("name");
			}
			
			@Override
			public String getMmoney() {
				return request.getParameter("mmoney");
			}
			
			
			@Override
			public String getGznew() {
				return request.getParameter("gznew");
			}
			
			@Override
			public String getEmil() {
				return request.getParameter("emil");
			}
			
			@Override
			public String getCity() {
				return request.getParameter("xian");
			}
			
			@Override
			public String getCellnumber() {
				StringBuffer a = new StringBuffer();
				if(!StringHelper.isEmpty(request.getParameter("sta")) && !StringHelper.isEmpty(request.getParameter("end"))){
					a.append(request.getParameter("sta").toString());
					a.append("-");
					a.append(request.getParameter("end").toString());
				}
				return a.toString();
			}
			
			@Override
			public String getAddress() {
				return request.getParameter("address");
			}
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}
		};
		workManage.update(query);
		
		if(IntegerParser.parse(request.getParameter("save"))==0){
			sendRedirect(request, response, getController().getViewURI(request, Workmessage.class));
			getController().prompt(request, response, PromptLevel.ERROR,
					"保存贷款信息成功");
			return;
		}
		
		sendRedirect(request, response, getController().getURI(request, Propertymessage.class));
	}
	
}
