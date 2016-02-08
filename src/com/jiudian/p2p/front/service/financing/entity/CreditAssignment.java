package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.CompanyStatus;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.common.enums.CreditLevel;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.RewardType;
import com.jiudian.p2p.common.enums.TenderRepayment;

/**
 * 贷款信息
 * @author jiudian
 *
 */
public class CreditAssignment implements Serializable {

	private static final long serialVersionUID = 4000187865062883911L;

	/**
	 * 转出id
	 */
	public int zcId;

	/**
	 * 转让id
	 */
	public int zrId;

	/**
	 * 借款标id
	 */
	public int jkbId;
	
	/**
	 * 转出者ID（投资用户）
	 */
	public int zczId;
	
	/**
	 * 借款者ID（借款用户）
	 */
	public int jkzId;
	
	
	/**
	 * 借款类型
	 */
	public CreditType creditType;
	/**
	 * 标题
	 */
	public String title;
	
	/**
	 * 信用等级
	 */
	public CreditLevel creditLevel;
	
	/**
	 * 年利率
	 */
	public double rate;
	
	/**
	 * 剩余期限
	 */
	public String syqx;

	/**
	 * 借款期限
	 */
	public String jkqx;
	
	/**
	 * 债权价值
	 */
	public BigDecimal zqjz = new BigDecimal(0);
	
	/**
	 * 转让价格
	 */
	public BigDecimal zrjg = new BigDecimal(0);
	
	
	/**
	 * 剩余份数
	 */
	public int syfs;
	
	/**
	 * 借款金额
	 */
	public BigDecimal jkje = new BigDecimal(0);
	
	/**
	 * 进度
	 */
	public BigDecimal jindu = new BigDecimal(0);
	
	/**
	 * 状态
	 */
	public String status;
	
	/**
	 * 还需金额
	 */
	public BigDecimal hxje = new BigDecimal(0);
	/**
	 * 转出者账号
	 */
	public String zczName;
	/**
	 * 下个还款日
	 */
	public Timestamp nexthk;
	/**
	 * 转出份数
	 */
	public int zcfs;
	/**
	 * 还款方式
	 */
	public TenderRepayment hkfs;
	
	/**
	 * 保障方式
	 */
	public String bzfs;
	
	/**
	 * 提前还款费率
	 */
	public BigDecimal tqhkfl = new BigDecimal(0);
	/**
	 * 原始投资金额
	 */
	public BigDecimal ystzje = new BigDecimal(0);
	
	/**
	 * 预计收益
	 */
	public BigDecimal yjsy = new BigDecimal(0);
	/**
	 * 借款描述
	 */
	public String jkDesc;
	/**
	 * 借款用户
	 */
	public String jkyh;
	/**
	 * 可用余额
	 */
	public BigDecimal kyMoney = new BigDecimal(0);
	
	/**
	 * 公司类型
	 */
	public CompanyStatus companyStatus;
	
	/**
	 * 借款用途
	 */
	public String purpose;
	
	/**
	 * 投标奖励类型
	 */
	public RewardType rewardType;
	
	/**
	 * 奖励利率
	 */
	public BigDecimal jllr = new BigDecimal(0);
	
	/**
	 * 借款周期
	 */
	public CreditCycle creditCycle;

}
