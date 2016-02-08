package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 投标记录
 * @author jiudian
 *
 */
public class TenderRecord implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4144230775162777727L;
	
	/**
	 * 投标人
	 */
	public String tenderName;
	/**
	 * 投标金额
	 */
	public BigDecimal tenderMoney = new BigDecimal(0);
	/**
	 * 投标时间
	 */
	public Timestamp tenderTime;

}
