package com.jiudian.p2p.front.servlets.p2pdaikuan.accessory;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.http.upload.UploadFile;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.front.service.credit.AccessoryManage;
import com.jiudian.p2p.front.service.credit.entity.AccessoryQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;

/**
 * 微博认证
 * @author jiudian
 *
 */
public class Microblog extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		final AttestationType type = AttestationType.WBRZ;
		AccessoryManage accessoryManage = serviceSession
				.getService(AccessoryManage.class);
		final int id = accessoryManage.getId( type.name());
		AccessoryQuery query = new AccessoryQuery() {
			@Override
			public String getType() {
				return type.name();
			}

			@Override
			public int getId() {
				return id;
			}

			@Override
			public String getCount() {
				return request.getParameter("count");
			}

			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}

			@Override
			public List<UploadFile> getAccessory() throws Throwable {
				return null;
			}
		};
		accessoryManage.addAccessory(query);
		request.setAttribute("close", "close");
		getController().forwardView(request, response, Microblog.class);
	}
	
}
