package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;
/**
 * 理财体验统计
 *
 */
public class FinancingPlanCount  implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8444343751160693853L;

	/**
	 * 累计总金额
	 */
	public BigDecimal totleMoney = new BigDecimal(0);
	
	/**
	 * 资金利用率
	 */
	public double moneyUse;
	
	/**
	 * 为用户累计赚取
	 */
	public BigDecimal userEarnMoney = new BigDecimal(0);
	/**
	 * 加入总人次
	 */
	public long joinCount;
	

}
