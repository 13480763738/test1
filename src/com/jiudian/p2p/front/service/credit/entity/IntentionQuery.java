package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

import com.jiudian.p2p.common.enums.IntentionType;

/**
 * 借款意向
 * @author jiudian
 *
 */
public interface IntentionQuery {
	
	/**
	 * 联系人
	 * @return
	 */
	public abstract String getName();
	
	/**
	 * 手机号
	 * @return
	 */
	public abstract String getPhonenumber();
	
	/**
	 * 意向金额
	 * @return
	 */
	public abstract BigDecimal getMoney();
	
	/**
	 * 借款类型
	 * @return
	 */
	public abstract IntentionType getIntentionType();
	
	/**
	 * 所在城市
	 * @return
	 */
	public abstract String getCity();
	
	/**
	 * 借款期限
	 * @return
	 */
	public abstract String getTime();
	
	/**
	 * 借款描述
	 * @return
	 */
	public abstract String getDescribe();
	
	
}
