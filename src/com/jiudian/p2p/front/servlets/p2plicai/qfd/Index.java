package com.jiudian.p2p.front.servlets.p2plicai.qfd;

import com.jiudian.framework.http.servlet.annotation.PagingServlet;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;
@PagingServlet(itemServlet = Index.class)
public class Index extends AbstractFinancingServlet{
	private static final long serialVersionUID = 5455206100909928866L;
}
