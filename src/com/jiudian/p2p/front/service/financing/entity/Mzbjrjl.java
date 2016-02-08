package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 免租宝加入记录
 *
 */
public class Mzbjrjl {
	
	/**
	 * 免租用户
	 */
	public String mzyh;
	
	/**
	 * 加入金额
	 */
	public BigDecimal jrje = new BigDecimal("0");
	
	/**
	 * 加入时间
	 */
	public Timestamp jrsj;
	
	/**
	 * 免租金额
	 */
	public BigDecimal mzje = new BigDecimal("0");
	

	
}
