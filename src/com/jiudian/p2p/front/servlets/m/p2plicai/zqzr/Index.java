package com.jiudian.p2p.front.servlets.m.p2plicai.zqzr;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;

/**
 * 债权列表
 */
@PagingServlet(itemServlet = Bdxq.class)
public class Index extends AbstractFinancingServlet {

	private static final long serialVersionUID = -7045662909633322157L;

}
