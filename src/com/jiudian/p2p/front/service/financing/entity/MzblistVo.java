package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.MzbStatus;
import com.jiudian.p2p.common.enums.OrganizationType;


/**
 * 免租宝列表
 *
 */
public class MzblistVo {

	/**
	 * 免租宝名称
	 */
	public String mzbmc;
	
	/**
	 * 机构名称
	 */
	public String jgmc;
	
	/**
	 * 机构类型
	 */
	public OrganizationType jglx;
	
	/**
	 * 年利率
	 */
	public BigDecimal nll = new BigDecimal("0");
	
	/**
	 * 免租期限
	 */
	public int mzqx;
	
	/**
	 * 剩余发行金额
	 */
	public BigDecimal syfxje = new BigDecimal("0");
	
	/**
	 * 状态
	 */
	public MzbStatus zt ;
	
	/**
	 * 发售时间
	 */
	public Timestamp fssj;
	
	/**
	 * 发行金额
	 */
	public BigDecimal fxje = new BigDecimal("0");
	
	/**
	 * 最低投资额
	 */
	public BigDecimal zdtze = new BigDecimal("0");
	
	/**
	 * 免租宝ID
	 */
	public int id;
	
}
