package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

/**
 * 借款信息
 * @author jiudian
 *
 */
public interface LmoneyQuery {
	
	/**
	 * 借款ID
	 */
	public abstract int getId();
	/**
	 * 用户ID
	 */
	public abstract int getAcount();
	/**
	 * 债权ID
	 */
	public int getZqid();
	
	/**
	 * 借款标题
	 */
	public abstract String getTitle();
	/**
	 * 借款用途
	 */
	public abstract String getLmuse();
	/**
	 * 借款金额 
	 */
	public abstract BigDecimal getMoney();
	/**
	 * 借款期限代表月份 3、6、9、12、18、24个月
	 */
	public abstract int getCtime();
	/**
	 * 年利率
	 */
	public abstract BigDecimal getRating();
	/**
	 * 还款周期 
	 */
	public abstract String getPeriod();
	/**
	 * 还款方式
	 */
	public abstract String getType();
	/**
	 * 筹标期限
	 */
	public abstract int getLtime();
	/**
	 * 每月本息
	 */
	public abstract BigDecimal getPcai();
	/**
	 * 每月借款管理费  费率0.3%
	 */
	public abstract BigDecimal getLmmoney();
	/**
	 * 借款描述
	 */
	public abstract String getDescribe();
	
	/**
	 * 借款类型   （XJD:薪金贷、SYD:生意贷、SDRZ:实地认证、XYDB信用担保）
	 */
	public abstract String getLtype();
	
	/**
	 * 标的状态(SQZ:申请中、DSH:待审核、TBZ:投标中、YMB已满标、YFK已放款(还款中)、YJQ已结清、YDF已垫付、LB流标)
	 */
	public abstract String getLstatus();
	
	/**
	 * 是否阅读协议
	 * @return
	 */
	public abstract int getIsread();
	
	/**
	 * 没分金额
	 * @return
	 */
	public abstract BigDecimal getOnemoney();
	
	/**
	 * 投标限额
	 * @return
	 */
	public abstract BigDecimal getTbxe();
}
