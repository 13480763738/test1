package com.jiudian.p2p.front.servlets.m.p2plicai.wytz;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.m.AbstractFinancingServlet;

/**
 * 马上投标
 */
@PagingServlet(itemServlet = Mstb.class)
public class Mstb extends AbstractFinancingServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	
}
