package com.jiudian.p2p.front.service.credit.entity;

import com.jiudian.p2p.common.enums.IsPass;

/**
 * 查询是否能贷款
 * @author jiudian
 *
 */
public class LmoneyDecide {
	
	/**
	 * 是否开通第三方账户平台
	 */
	public String isRegJin;
	/**
	 * 是否实名认证
	 */
	public String isSmrz;
	/**
	 * 是否设定提现密码
	 */
	public String password;
	/**
	 * 手机号
	 */
	public String phoneNumber;
	
	/**
	 * 借款ID 并且借款状态不是LB流标 YJQ已结清
	 */
	public  int id;
	
	/**
	 * 是否拉黑
	 */
	public  IsPass isPass;
	
}
