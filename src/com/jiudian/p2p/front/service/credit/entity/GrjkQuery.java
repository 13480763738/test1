package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

import com.jiudian.p2p.common.enums.MarriageStatus;
import com.jiudian.p2p.common.enums.RepaymentType;

/**
 * 个人借款意向
 * @author jiudian
 *
 */
public interface GrjkQuery {
	
	/**
	 * 借款人姓名
	 * @return
	 */
	public abstract String getName()throws Throwable;
	/**
	 * 借款人身份证号
	 * @return
	 */
	public abstract String getSfzh()throws Throwable;
	/**
	 * 住址
	 * @return
	 */
	public abstract String getJtzz()throws Throwable;
	/**
	 * 联系方式
	 * @return
	 */
	public abstract String getLxfs()throws Throwable;
	/**
	 * 职业
	 * @return
	 */
	public abstract String getZy()throws Throwable;
	/**
	 * 婚姻状况
	 * @return
	 */
	public abstract MarriageStatus getHyzk()throws Throwable;
	/**
	 * 配偶姓名
	 * @return
	 */
	public abstract String getPoxm()throws Throwable;
	/**
	 * 配偶身份证号
	 * @return
	 */
	public abstract String getPosfzh()throws Throwable;
	/**
	 * 借款金额
	 * @return
	 */
	public abstract BigDecimal getJkje()throws Throwable;
	/**
	 * 借款期限
	 * @return
	 */
	public abstract String getQx()throws Throwable;
	/**
	 * 借款利率
	 * @return
	 */
	public abstract BigDecimal getJkll()throws Throwable;
	/**
	 * 借款用途
	 * @return
	 */
	public abstract String getJkyt()throws Throwable;
	/**
	 * 还款方式
	 * @return
	 */
	public abstract RepaymentType getHkfs()throws Throwable;
	/**
	 * 还款来源
	 * @return
	 */
	public abstract String getHkly()throws Throwable;
	
	
}
