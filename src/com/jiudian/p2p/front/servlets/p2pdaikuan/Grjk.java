package com.jiudian.p2p.front.servlets.p2pdaikuan;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.MarriageStatus;
import com.jiudian.p2p.common.enums.RepaymentType;
import com.jiudian.p2p.front.service.credit.IntentionManage;
import com.jiudian.p2p.front.service.credit.entity.GrjkQuery;
import com.jiudian.util.parser.BigDecimalParser;
import com.jiudian.util.parser.EnumParser;

public class Grjk extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		IntentionManage intentionManage = serviceSession.getService(IntentionManage.class);
		GrjkQuery query = new GrjkQuery() {
			
			@Override
			public String getZy() {
				return request.getParameter("zy");
			}
			
			@Override
			public String getSfzh() {
				return request.getParameter("sfzh");
			}
			
			@Override
			public String getQx() {
				return request.getParameter("ckqx");
			}
			
			@Override
			public String getPoxm() {
				return request.getParameter("poxm");
			}
			
			@Override
			public String getPosfzh() {
				return request.getParameter("posfzh");
			}
			
			@Override
			public String getName() {
				return request.getParameter("jkrxm");
			}
			
			@Override
			public String getLxfs() {
				return request.getParameter("lxfs");
			}
			
			@Override
			public String getJtzz() {
				return request.getParameter("jtzz");
			}
			
			@Override
			public String getJkyt() {
				return request.getParameter("jkyt");
			}
			
			@Override
			public BigDecimal getJkll() {
				return BigDecimalParser.parse(request.getParameter("jkll"));
			}
			
			@Override
			public BigDecimal getJkje() {
				return BigDecimalParser.parse(request.getParameter("jkje"));
			}
			
			@Override
			public MarriageStatus getHyzk() {
				return EnumParser.parse(MarriageStatus.class, request.getParameter("hyzk"));
			}
			
			@Override
			public String getHkly() {
				return request.getParameter("hkly");
			}
			
			@Override
			public RepaymentType getHkfs() {
				return EnumParser.parse(RepaymentType.class, request.getParameter("hkfs"));
			}
		};
		
		intentionManage.addGrjk(query);
		getController().prompt(request, response, PromptLevel.ERROR,
				"提交成功！我们将尽快与您联系");
		forwardView(request, response, getClass());
	}
}
