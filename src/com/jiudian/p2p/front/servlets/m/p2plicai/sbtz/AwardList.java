package com.jiudian.p2p.front.servlets.m.p2plicai.sbtz;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.m.AbstractFinancingServlet;

/**
 * 还款记录
 */
@PagingServlet(itemServlet = Bdxq.class)
public class AwardList extends AbstractFinancingServlet {

	private static final long serialVersionUID = 5455206100909928866L;
}
