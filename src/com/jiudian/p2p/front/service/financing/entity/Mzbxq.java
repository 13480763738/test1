package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.MzbStatus;

/**
 * 免租宝详情
 *
 */
public class Mzbxq {
	/**
	 * 免租宝名称
	 */
	public String mzbmc;
	
	/**
	 * 项目计划金额
	 */
	public BigDecimal xmjhje = new BigDecimal("0");
	
	/**
	 * 年利率
	 */
	public BigDecimal nll = new BigDecimal("0");
	
	/**
	 * 担保机构
	 */
	public String dbjg;
	
	
	/**
	 * 项目状态
	 */
	public MzbStatus xmzt;
	
	/**
	 * 发行时间
	 */
	public Timestamp fxsj;
	
	/**
	 * 满额时间
	 */
	public Timestamp mesj;
	
	/**
	 * 锁定期限
	 */
	public int sdqx;
	
	/**
	 * 最低加入额
	 */
	public BigDecimal zdjre = new BigDecimal("0");
	
	/**
	 * 剩余金额
	 */
	public BigDecimal syje = new BigDecimal("0");
	
	/***
	 * 筹款期限
	 */
	public int ckqx;
	
	/**
	 * 借款人ID
	 */
	public int jkrid;
	
	
}
