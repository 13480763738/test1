package com.jiudian.p2p.front.servlets.p2pdaikuan.syd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.credit.CompanyManage;
import com.jiudian.p2p.front.service.credit.entity.CompanyQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;


public class UpdateCompanymessage extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		CompanyManage companyManage = serviceSession.getService(CompanyManage.class);
		CompanyQuery query = new CompanyQuery() {
			@Override
			public String getStatus() {
				return request.getParameter("status");
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
			public int getId() {
				return serviceSession.getSession().getAccountId();
			}
			
			@Override
			public String getEmil() {
				return request.getParameter("emil");
			}
			
			@Override
			public String getCompanyzy() {
				return request.getParameter("post");
			}
			
			@Override
			public String getCompanytime() {
				return request.getParameter("Companytime");
			}
			
			@Override
			public String getCompanyhy() {
				return request.getParameter("Companyhy");
			}
			
			@Override
			public String getCompanygm() {
				return request.getParameter("Companygm");
			}
			
			@Override
			public String getCompanyType() {
				return request.getParameter("type");
			}
			
			@Override
			public String getCity() {
				return request.getParameter("xian");
			}
			
			@Override
			public String getCall() {
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
		};
		companyManage.update(query);
		if(IntegerParser.parse(request.getParameter("save"))==0){
			sendRedirect(request, response, getController().getURI(request, Companymessage.class));
			
			getController().prompt(request, response, PromptLevel.ERROR,
					"保存贷款信息成功");
			return;
		}
		sendRedirect(request, response, getController().getURI(request, Propertymessage.class));
	}
	
}
