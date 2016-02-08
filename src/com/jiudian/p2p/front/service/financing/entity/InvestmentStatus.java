package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 各状态的散标
 * @author jiudian
 *
 */
public class InvestmentStatus implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5950713240533948480L;

	/**
	 * 投标进度(投标中)
	 */
	public BigDecimal toubiaojd = new BigDecimal(0);
	
	/**
	 * 筹标期限(投标中)
	 */
	public String cbqixian;
	
	/**
	 * 剩余金额(投标中)
	 */
	public BigDecimal shengyuje = new BigDecimal(0);
	/**
	 * 剩余份数(投标中)
	 */
	public int shengyufs;
	/**
	 * 审核时间
	 */
	public String  shenheTime;
	/**
	 * 满标时间(已满标)
	 */
	public String manbiaoTime;
	/**
	 * 加入人数(已满标)
	 */
	public int joinPeople;
	/**
	 * 待还本息(还款中)
	 */
	public BigDecimal daihuanbx = new BigDecimal(0);
	/**
	 * 剩余期数(还款中)
	 */
	public int shengyuqs;
	/**
	 * 下个还款日(还款中)
	 */
	public String nexthk;
	/**
	 * 还清时间
	 */
	public String hqTime;
	
	
}
