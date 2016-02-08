package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import com.jiudian.p2p.common.enums.IsPass;

/**
 * 投资账户
 */
public class TenderAccount implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * 优选理财账户资产
	 */
	public BigDecimal yxzc = new BigDecimal(0);
	/**
	 * 优选理财已赚金额
	 */
	public BigDecimal yxyz = new BigDecimal(0);
	/**
	 * 优选理财平均收益率
	 */
	public BigDecimal yxsyl = new BigDecimal(0);
	/**
	 * 优选理财持有量
	 */
	public int yxcyl;

	/**
	 * 散标账户资产
	 */
	public BigDecimal sbzc = new BigDecimal(0);
	/**
	 * 投资成功总本金
	 */
	public BigDecimal tzcgzbj = new BigDecimal(0);
	/**
	 * 散标已赚金额
	 */
	public BigDecimal sbyz = new BigDecimal(0);
	/**
	 * 散标平均收益率
	 */
	public BigDecimal sbsyl = new BigDecimal(0);
	/**
	 * 散标持有量
	 */
	public int sbcyl;
	/**
	 * 已挣总金额
	 */
	public BigDecimal yzzje = new BigDecimal(0);
	
	
	/**
	 * 待收本金金额
	 */
	public BigDecimal sbdsbj = new BigDecimal(0);
	
	/**
	 * 待赚金额
	 */
	public BigDecimal sbdz = new BigDecimal(0);
	
	/**
	 * 可用余额
	 */
	public BigDecimal kyye = new BigDecimal(0);
	
	/**
	 * 是否修改密码
	 */
	public IsPass sfxgmm = IsPass.F;
}
