package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.ExperienceGoldStatus;

/**
 * 体验金
 * @author jiudian
 *
 */
public class ExperiencePlan {
	
	/**
	 * 期号
	 */
	public int qh;
	/**
	 * 体验券号
	 */
	public String experienceNum;
	
	/**
	 * 体验金额
	 */
	public BigDecimal amount;
	
	/**
	 * 体验券开始日期
	 */
	public Date starTime;
	
	/**
	 * 体验券结束日期
	 */
	public Date endTime;
	
	/**
	 * 领取时间
	 */
	public Timestamp getTime;
	
	/**
	 * 使用时间
	 */
	public Timestamp useTime;
	
	/**
	 * 状态
	 */
	public ExperienceGoldStatus experienceGoldStatus;
}
