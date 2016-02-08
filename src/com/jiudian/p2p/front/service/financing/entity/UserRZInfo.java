package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.AttestationState;
import com.jiudian.p2p.common.enums.AttestationType;
/**
 * 用户认证信息
 *
 */
public class UserRZInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -140673682173231803L;
	
	/**
	 * 审核项目
	 */
	public AttestationType attestationType;
	/**
	 * 认证状态
	 */
	public AttestationState rzStatus;
	/**
	 * 认证时间
	 */
	public Timestamp rzDate;

}
