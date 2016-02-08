package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

import com.jiudian.p2p.common.enums.MarriageStatus;
import com.jiudian.p2p.common.enums.RepaymentType;

/**
 * 企业借款意向
 * @author jiudian
 *
 */
public interface QyjkQuery {
	
	/**
	 * 企业名称
	 * @return
	 */
	public abstract String getQymc() throws Throwable;
	/**
	 * 企业地址
	 * @return
	 */
	public abstract String getQydz() throws Throwable;
	/**
	 * 企业联系方式
	 * @return
	 */
	public abstract String getQyxfs() throws Throwable;
	
	/**
	 * 注册资本
	 * @return
	 */
	public abstract BigDecimal getZczb() throws Throwable;
	/**
	 * 实收资本
	 * @return
	 */
	public abstract BigDecimal getSszb() throws Throwable;
	/**
	 * 主营业务
	 * @return
	 */
	public abstract String getZyyw() throws Throwable;
	/**
	 * 营业执照注册号
	 * @return
	 */
	public abstract String getYyzz() throws Throwable;
	/**
	 * 机构代码登记号
	 * @return
	 */
	public abstract String getJgdm() throws Throwable;
	/**
	 * 税务登记证编号
	 * @return
	 */
	public abstract String getSwdj() throws Throwable;
	/**
	 * 法定代表人
	 * @return
	 */
	public abstract String getFrdb() throws Throwable;
	/**
	 * 法人联系方式
	 * @return
	 */
	public abstract String getFrlxfs() throws Throwable;
	/**
	 * 身份证号码
	 * @return
	 */
	public abstract String getSfzhm() throws Throwable;
	/**
	 * 家庭住址
	 * @return
	 */
	public abstract String getJtzz() throws Throwable;
	/**
	 * 婚姻状况
	 * @return
	 */
	public abstract MarriageStatus getHyzk() throws Throwable;
	/**
	 * 借款金额
	 * @return
	 */
	public abstract BigDecimal getJkje() throws Throwable;
	/**
	 * 借款利率
	 * @return
	 */
	public abstract BigDecimal getJkll() throws Throwable;
	/**
	 * 借款期限
	 * @return
	 */
	public abstract String getQx() throws Throwable;
	/**
	 * 借款用途
	 * @return
	 */
	public abstract String getJkyt() throws Throwable;
	/**
	 * 还款方式
	 * @return
	 */
	public abstract RepaymentType getHkfs() throws Throwable;
	/**
	 * 还款来源
	 * @return
	 */
	public abstract String getHkly() throws Throwable;
	
	
}
