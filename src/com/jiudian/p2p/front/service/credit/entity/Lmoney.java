package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

/**
 * 借款信息
 * @author jiudian
 *
 */
public class Lmoney {
	
	/**
	 * 借款ID
	 */
	public int id;
	/**
	 * 用户ID
	 */
	public int acount;
	
	/**
	 * 借款标题
	 */
	public  String title;
	/**
	 * 借款用途
	 */
	public  String lmuse;
	/**
	 * 借款金额 
	 */
	public  BigDecimal money;
	/**
	 * 借款期限代表月份 3、6、9、12、18、24个月
	 */
	public  int ctime;
	/**
	 * 年利率
	 */
	public  BigDecimal rating;
	
	/**
	 * 借款描述
	 */
	public String describe;
	
	/**
	 * 投标状态
	 */
	public String Lstatus;
	
	/**
	 * 每月本息
	 */
	public BigDecimal mmoney;
	/**
	 * 每月交款管理费
	 */
	public BigDecimal gmmoney;
}
