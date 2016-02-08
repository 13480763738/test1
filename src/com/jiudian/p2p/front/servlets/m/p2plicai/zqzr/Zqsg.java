package com.jiudian.p2p.front.servlets.m.p2plicai.zqzr;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;
/**
 * 债权申购
 * @author Administrator
 *
 */
@PagingServlet(itemServlet = Zqsg.class)
public class Zqsg extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

}
