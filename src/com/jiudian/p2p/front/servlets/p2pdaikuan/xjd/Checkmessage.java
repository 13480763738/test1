package com.jiudian.p2p.front.servlets.p2pdaikuan.xjd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.CreditStatus;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.front.service.credit.LmoneyManage;
import com.jiudian.p2p.front.service.credit.entity.Lmoney;
import com.jiudian.p2p.front.service.credit.entity.LmoneyDecide;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;
import com.jiudian.util.StringHelper;

public class Checkmessage extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		LmoneyManage lmoneyManage = serviceSession
				.getService(LmoneyManage.class);
		LmoneyDecide lm = lmoneyManage.getLmoneyDecide(CreditType.XJD.name());
		int id = lm.id;
		Lmoney l = lmoneyManage.getLmoney(id, CreditType.XJD.name());
		if (l != null && !StringHelper.isEmpty(l.Lstatus)) {
			if (!l.Lstatus.equals(CreditStatus.SQZ.name())) {
				getController().sendRedirect(request, response,
						getController().getViewURI(request, Checkmessage.class));
				return;
			}
		}
		lmoneyManage.update(id, CreditStatus.DSH.name());
		getController().sendRedirect(request, response,
				getController().getViewURI(request, Checkmessage.class));

	}
}
