package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;

/**
 * 免租宝统计
 *
 */
public class MzbtjVo {
	
	/**
	 * 累计加入金额
	 */
	public BigDecimal ljjrje = new BigDecimal("0");
	
	/**
	 * 累计加入人次
	 */
	public int ljjrrc;
	
	/**
	 * 累计免话费人数
	 */
	public int ljmhfrs;
	
	/**
	 * 累计免租金额
	 */
	public BigDecimal ljmzje = new BigDecimal("0");
	
	/**
	 * 累计总收益
	 */
	public BigDecimal ljzsy = new BigDecimal("0");
	
	/**
	 * 预计总收益
	 */
	public BigDecimal yjzsy = new BigDecimal("0");
	
	/**
	 * 已免总金额
	 */
	public BigDecimal ymzje = new BigDecimal("0");
	
	
}
