package com.jiudian.p2p.front.servlets.p2pdaikuan;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.resource.PromptLevel;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.IntentionType;
import com.jiudian.p2p.front.service.credit.IntentionManage;
import com.jiudian.p2p.front.service.credit.entity.IntentionQuery;
import com.jiudian.util.parser.EnumParser;

public class Dkyx extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		IntentionManage intentionManage = serviceSession.getService(IntentionManage.class);
		IntentionQuery query = new IntentionQuery() {
			@Override
			public String getTime() {
				return request.getParameter("time");
			}
			
			@Override
			public String getPhonenumber() {
				return request.getParameter("phonenumber");
			}
			
			@Override
			public String getName() {
				return request.getParameter("name");
			}
			
			@Override
			public BigDecimal getMoney() {
				BigDecimal m = new BigDecimal(request.getParameter("money"));
				return m;
			}
			
			@Override
			public IntentionType getIntentionType() {
				return EnumParser.parse(IntentionType.class, request.getParameter("type"));
			}
			
			@Override
			public String getDescribe() {
				return request.getParameter("describe");
			}
			
			@Override
			public String getCity() {
				return request.getParameter("xian");
			}
		};
		intentionManage.addIntention(query);
		getController().prompt(request, response, PromptLevel.ERROR,
				"提交成功！我们将尽快与您联系");
		sendRedirect(request, response, getController().getViewURI(request,com.jiudian.p2p.front.servlets.p2pdaikuan.Index.class));
	}
}
