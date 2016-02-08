package com.jiudian.p2p.front.servlets.p2pdaikuan.accessory;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.jiudian.framework.http.upload.PartFile;
import com.jiudian.framework.http.upload.UploadFile;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.front.service.credit.AccessoryManage;
import com.jiudian.p2p.front.service.credit.entity.AccessoryQuery;
import com.jiudian.p2p.front.servlets.p2pdaikuan.AbstractCreditServlet;

@MultipartConfig
public class Phone extends AbstractCreditServlet {

	private static final long serialVersionUID = -3655351845904847543L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		final AttestationType type = AttestationType.SJSMRZ;
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
				return null;
			}

			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}

			@Override
			public List<UploadFile> getAccessory() throws Throwable {
				Collection<Part> parts = request.getParts();
				if (parts == null || parts.size() == 0) {
					return null;
				}
				List<UploadFile> files = new ArrayList<>();
				for (Part part : parts) {
					if (part.getContentType() == null) {
						continue;
					}
					files.add(new PartFile(part));
				}
				return files;
			}
		};
		accessoryManage.addAccessory(query);
	}
	
}
