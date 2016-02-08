package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.jiudian.p2p.common.enums.CompanyStatus;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.common.enums.CreditLevel;
import com.jiudian.p2p.common.enums.CreditStatus;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.Jkflx;
import com.jiudian.p2p.common.enums.OverdueStatus;
import com.jiudian.p2p.common.enums.ProductType;
import com.jiudian.p2p.common.enums.RepaymentPeriod;
import com.jiudian.p2p.common.enums.RepaymentType;
import com.jiudian.p2p.common.enums.RewardType;

/**
 * 借款标信息
 */
public class CreditInfo {

	/**
	 * 借款表ID
	 */
	public int id;
	/**
	 * 标题
	 */
	public String title;
	/**
	 * 借款描述.
	 */
	public String goalDesc;
	/**
	 * 信用等级
	 */
	public CreditLevel creditLevel;
	/**
	 * 贷款金额
	 */
	public BigDecimal amount = new BigDecimal(0);
	/**
	 * 还需金额
	 */
	public BigDecimal remainAmount = new BigDecimal(0);

	/**
	 * 年利率
	 */
	public double rate;

	/**
	 * 进度progress%
	 */
	public int progress;
	/**
	 * 贷款期限 (月)
	 */
	public int term;
	/**
	 * 贷款标状态
	 */
	public CreditStatus status;
	/**
	 * 借款类型
	 */
	public CreditType creditType;
	/**
	 * 还款方式
	 */
	public RepaymentType repaymentType;
	/**
	 * 下一合约还款日
	 * 
	 * @return
	 */
	public Date nextRepayDate;
	/**
	 * 剩余期数
	 * 
	 * @return
	 */
	public int remainTerms;
	/**
	 * 待还本息金额
	 */
	public BigDecimal toRepaymentAmount = new BigDecimal(0);
	/**
	 * 还清时间
	 */
	public Timestamp payedDate;
	/**
	 * 每份金额
	 */
	public BigDecimal perAmount = new BigDecimal(0);
	/**
	 * 借款人登录名
	 * 
	 */
	public String userAccountName;
	/**
	 * 借款人ID
	 */
	public int userId;

	/**
	 * 借款用途
	 */
	public String purpose;

	/**
	 * 月还款本息
	 */
	public BigDecimal yhkAmount = new BigDecimal(0);
	/**
	 * 还款周期
	 */
	public RepaymentPeriod repaymentPeriod;
	/**
	 * 可用余额
	 */
	public BigDecimal kyMoney = new BigDecimal(0);
	/**
	 * 满标时间
	 */
	public Timestamp mbTime;
	/**
	 * 审核时间
	 */
	public Timestamp shTime;
	/**
	 * 筹款结束时间
	 */
	public Timestamp jsTime;
	/**
	 * 发布时间
	 */
	public Timestamp fbTime;
	/**
	 * 是否逾期
	 */
	public OverdueStatus overdueStatus;
	/**
	 * 垫付时间
	 */
	public Timestamp dfTime;
	/**
	 * 借款周期
	 */
	public CreditCycle creditCycle;
	
	/**
	 * 投标限额
	 */
	public BigDecimal tbxe = new BigDecimal(0);
	
	/**
	 * 公司类型
	 */
	public CompanyStatus companyStatus;
	
	/**
	 * 奖励值
	 */
	public String jlz = "";
	
	/**
	 * 奖励类型
	 */
	public RewardType jllx = RewardType.WJL;
	
	/**
	 * 奖励利率
	 */
	public BigDecimal jlll = new BigDecimal(0);
	
	/**
	 * 限时小时
	 */
	public int xsxs = 0;
	
	/**
	 * 限时分钟
	 */
	public int xsfz = 0;
	/**
	 * 公司类型
	 */
	public ProductType productType;
	/**
	 * 借款方类型
	 */
	public Jkflx jkflx;
	 /**
	  * 还款方式
	  */
	public List<Xyhk> hkList;
	
}
