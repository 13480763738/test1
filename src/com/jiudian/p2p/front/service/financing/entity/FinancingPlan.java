package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.PlanState;
/**
 * 理财体验列表
 * @author jiudian
 *
 */
public class FinancingPlan implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7664475460511628242L;
	/**
	 * 理财体验id
	 */
	public int id;
	/**
	 * 标题
	 */
	public String planTitle;
	/**
	 * 计划金额
	 */
	public String planMoney;
	/**
	 * 加入人数
	 */
	public int joinCount;
	/**
	 * 人均投标
	 */
	public int avgTender;
	/**
	 * 资金利用率
	 */
	public double moneyUtilization;
	/**
	 * 平均收益率
	 */
	public double avgYield;
	/**
	 * 累计赚取
	 */
	public BigDecimal totleEarn = new BigDecimal(0);
	/**
	 * 发布时间
	 */
	public Timestamp releaseTime;
	
	
	
	/**
	 * 进度proess%
	 */
	public int proess;
	/**
	 * 计划金额
	 */
	public BigDecimal planMoney_wap = new BigDecimal(0);
	
	/**
	 * 预期收益
	 */
	public BigDecimal yqsy = new BigDecimal(0);
	
	/**
	 * 锁定期限
	 */
	public int lockqx;
	
	/**
	 * 计划状态
	 */
	public PlanState planState;
	
	/**
	 * 数据库系统时间
	 */
	public Timestamp currentTime;
	
	/**
	 * 距离发售
	 */
	public Timestamp fromSale;
	
	/**
	 * 剩余金额
	 */
	public BigDecimal syMoney = new BigDecimal(0);
	

}
