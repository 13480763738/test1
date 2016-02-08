package com.jiudian.p2p.front.servlets.p2plicai.sbtz;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;

/**
 * 散标列表
 */
@PagingServlet(itemServlet = Bdxq.class)
public class Index extends AbstractFinancingServlet {

	private static final long serialVersionUID = 5455206100909928866L;
}
