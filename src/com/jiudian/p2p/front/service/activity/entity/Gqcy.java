package com.jiudian.p2p.front.service.activity.entity;

import java.math.BigDecimal;

public class Gqcy {
	/**
	 * 用户ID
	 */
	public int id;

	/**
	 *	账号 
	 */
	public String zh;
	
	/**
	 * 累计投资金额
	 */
	public BigDecimal je = new BigDecimal("0");
	
	/**
	 * 排名
	 */
	public int order;
	
}
