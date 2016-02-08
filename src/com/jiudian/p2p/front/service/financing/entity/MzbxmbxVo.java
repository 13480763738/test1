package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 免租宝项目表现
 *
 */
public class MzbxmbxVo {
	
	/**
	 * 免租用户
	 */
	public String mzyh;
	
	/**
	 * 	已免租金额
	 */
	public BigDecimal ymzje = new BigDecimal("0");
	
	/**
	 * 已免租期数
	 */
	public int ymzqs;
	
	/**
	 * 免租截止日期
	 */
	public Timestamp mzjzrq;
	
	/**
	 * 预计总收益
	 */
	public BigDecimal yjzsy;
	
}
