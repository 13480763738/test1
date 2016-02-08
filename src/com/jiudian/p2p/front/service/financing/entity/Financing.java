package com.jiudian.p2p.front.service.financing.entity;

import java.io.Serializable;
/**
 * 
 *
 */

public class Financing implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6032018358186413840L;

	/**
	 * 自增ID
	 */
	public int id;
	
	/**
	 * 理财类型(YXLC:理财体验;SBTZ:散标投资;ZQZR:债权转让)
	 */
	public String financingType;
	
	/**
	 * 理财描述
	 */
	public String financingDesc;
	
	/**
	 * 理财功能显示顺序
	 */
	public int order;
	
	/**
	 * 是否添加计算器S是;F否;
	 */
	public String isCala;
	
	/**
	 * 理财功能和约束
	 */
	public String financingLimit;

}
