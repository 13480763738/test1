package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PlanRecode {
	/**
	 * 投资人
	 */
	public String tzrName;
	/**
	 * 投资金额
	 */
	public BigDecimal tzMoney = new BigDecimal(0);
	/**
	 * 投资时间
	 */
	public Timestamp tzTime;
}
