package com.jiudian.p2p.front.service.financing.query;

import com.jiudian.p2p.common.enums.CreditTerm;
import com.jiudian.p2p.common.enums.InvestType;
import com.jiudian.p2p.common.enums.ProductType;
import com.jiudian.p2p.common.enums.RepaymentType;


public abstract interface InvestQuery {
	/**
	 * 查询借款标类型.
	 * 
	 * @return {@link InvestType}
	 */
	public abstract InvestType[] getType();

	/**
	 * 借款期限
	 * 
	 * @return {@link CreditTerms}
	 */
	public abstract CreditTerm[] getTerm();

	/**
	 * 还款方式
	 * 
	 * @return {@link CreditLevel}
	 */
	public abstract RepaymentType[] getRepay();
	
	/**
	 * 产品类型
	 * @return
	 */
	public abstract ProductType getProductType();
}
