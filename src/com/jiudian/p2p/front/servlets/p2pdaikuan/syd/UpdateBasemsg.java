package com.jiudian.p2p.front.servlets.p2pdaikuan.syd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.credit.UserBaseManage;
import com.jiudian.p2p.front.service.credit.entity.UserBaseQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.IntegerParser;


public class UpdateBasemsg extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userBaseManage = serviceSession.getService(UserBaseManage.class);
		UserBaseQuery query = new UserBaseQuery() {
			@Override
			public int getSchooldata() {
				return IntegerParser.parse(request.getParameter("scholldata"));
			}
			
			@Override
			public String getSchool() {
				return request.getParameter("school");
			}
			
			@Override
			public String getRegion() {
				return request.getParameter("region");
			}
			
			@Override
			public String getPostcode() {
				return request.getParameter("postcode");
			}
			
			@Override
			public String getJiguan() {
				return request.getParameter("xianjg");
			}
			
			@Override
			public String getHkszd() {
				return request.getParameter("xian");
			}
			
			@Override
			public String getEducation() {
				return request.getParameter("education");
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
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}
		};
		userBaseManage.update(query);
		
		if(IntegerParser.parse(request.getParameter("save"))==0){
			
			sendRedirect(request, response, getController().getViewURI(request, Basemessage.class));
			getController().prompt(request, response, PromptLevel.ERROR,
					"保存贷款信息成功");
			return;
		}
		sendRedirect(request, response, getController().getURI(request, Familymessage.class));
	}

}
