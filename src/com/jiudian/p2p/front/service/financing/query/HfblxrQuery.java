package com.jiudian.p2p.front.service.financing.query;

import java.math.BigDecimal;

/**
 * 话费宝联系人
 *
 */
public abstract interface HfblxrQuery {
	
	public abstract  int id();
	
	public abstract String xm();
	
	public abstract String sjh();
	
	public abstract String yzm();
	
	public abstract BigDecimal myhf();
	
}
