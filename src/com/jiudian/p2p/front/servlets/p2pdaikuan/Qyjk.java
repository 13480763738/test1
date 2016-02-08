package com.jiudian.p2p.front.servlets.p2pdaikuan;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.MarriageStatus;
import com.jiudian.p2p.common.enums.RepaymentType;
import com.jiudian.p2p.front.service.credit.IntentionManage;
import com.jiudian.p2p.front.service.credit.entity.QyjkQuery;
import com.jiudian.util.parser.BigDecimalParser;
import com.jiudian.util.parser.EnumParser;

public class Qyjk extends AbstractCreditServlet {

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
		QyjkQuery query = new QyjkQuery() {
			
			@Override
			public String getZyyw() {
				return request.getParameter("zyyw");
			}
			
			@Override
			public BigDecimal getZczb() {
				return BigDecimalParser.parse(request.getParameter("zczb"));
			}
			
			@Override
			public String getYyzz() {
				return request.getParameter("yyzz");
			}
			
			@Override
			public String getSwdj() {
				return request.getParameter("swdj");
			}
			
			@Override
			public BigDecimal getSszb() {
				return BigDecimalParser.parse(request.getParameter("sszb"));
			}
			
			@Override
			public String getSfzhm() {
				return request.getParameter("sfz");
			}
			
			@Override
			public String getQyxfs() {
				return request.getParameter("qylxfs");
			}
			
			@Override
			public String getQymc() {
				return request.getParameter("qymc");
			}
			
			@Override
			public String getQydz() {
				return request.getParameter("qydz");
			}
			
			@Override
			public String getQx() {
				return request.getParameter("ckqx");
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
			public String getJgdm() {
				return request.getParameter("jgdm");
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
			
			@Override
			public String getFrlxfs() {
				return request.getParameter("frlxfs");
			}
			
			@Override
			public String getFrdb() {
				return request.getParameter("frdb");
			}
		};
		
		intentionManage.addQyjk(query);
		getController().prompt(request, response, PromptLevel.ERROR,
				"提交成功！我们将尽快与您联系");
		forwardView(request, response, getClass());
	}
}
