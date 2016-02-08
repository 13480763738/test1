package com.jiudian.p2p.front.servlets.p2pdaikuan.syd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.credit.PropertyMange;
import com.jiudian.p2p.front.service.credit.entity.PropertyQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.parser.IntegerParser;


public class UpdatePropertymsg extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PropertyMange propertyMange = serviceSession.getService(PropertyMange.class);
		
		PropertyQuery query = new PropertyQuery() {
			@Override
			public String getIshouseloan() {
				return request.getParameter("ishouseloan");
			}
			
			@Override
			public String getIshouse() {
				return request.getParameter("ishouse");
			}
			
			@Override
			public String getIscarloan() {
				return request.getParameter("iscarloan");
			}
			
			
			@Override
			public String getIscar() {
				return request.getParameter("iscar");
			}
			
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}

			@Override
			public int getGcnf() {
				return IntegerParser.parse(request.getParameter("gcnf"));
			}

			@Override
			public String getQcpp() {
				return request.getParameter("qcpp");
			}

			@Override
			public String getCphm() {
				return request.getParameter("cphm");
			}
		};
		propertyMange.update(query);
		if(IntegerParser.parse(request.getParameter("save"))==0){
			sendRedirect(request, response, getController().getURI(request, Propertymessage.class));
			getController().prompt(request, response, PromptLevel.ERROR,
					"保存贷款信息成功");
			return;
		}
		sendRedirect(request, response, getController().getURI(request, Authormessage.class));
	}
	
}
