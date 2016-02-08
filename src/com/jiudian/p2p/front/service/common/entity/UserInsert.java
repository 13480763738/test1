package com.jiudian.p2p.front.service.common.entity;

import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.UserSourceStatus;
import com.jiudian.p2p.common.enums.UserType;

public abstract interface UserInsert {
	/**
	 * 账号名
	 * 
	 * @return
	 */
	public abstract String getAccountName();

	/**
	 * 密码
	 * 
	 * @return
	 */
	public abstract String getPassword();

	/**
	 * 服务码
	 * 
	 * @return
	 */
	public abstract String getCode();
	
	/**
	 * 手机号码
	 * 
	 * @return
	 */
	public abstract String getPhone();

	/**
	 * 兴趣类型（LC:理财;JK:借款）
	 */
	public abstract UserType getType();
	
	
	public abstract UserSourceStatus getUserSourceStatus(); 
	
	public abstract IsPass getXgmim();
}
